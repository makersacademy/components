# Developer Guide

This is a guide to doing new things, or changing existing things, within the style guide framework.

### Help! I need a new component

**Before you go forward, check this list. Have you:**

- Sketched the component you need, _including how it will work on mobile_?
- Checked that there are _definitely no other components you could use_?
- Figured out whether you need a **atom**, an **group**, or a **template**?

##### 1. Sketch Component

![Sketches for Media Component](guide-img/sketches.jpg)

When sketching a component, try to use other components that exist. For example, say you need a two-up Radio Button list/Title and header. Since it's going to be placed directly on a page, it should be a _template_. We already have a **two-up block** template, so we'll add another _module_ ('public interface') to that.

This module will have an **input block** group in one side, and a **title block** group in the other.

We'll fill this template with existing group components where possible. Pick the appropriate group modules: for the **input block**, choose a 'list' module, and for the **title block**, choose the 'center' module. If the modules you need don't exist, you will need to create new groups, made up of atoms.

Here's a sketch for the Radio List/Title template:

![Sketch for Radio List/Title Component](guide-img/sketches-2.jpg)

##### 2. Add the Component to the HTML samples

Find the appropriate sample file, and add HTML for your new module under the `.example` section. Give it a name.

When adding HTML, try to use `Block__Element--Modifier` syntax. For our new Radio List/Title Component, we would need to add the following to the `two-up-block.html` file within the `templates` folder:

```html
<!-- the name of the new component -->
<span class="label">Two-up Radio List/Title</span>
<!-- the template itself -->
<div class="two-up-block">
  <!-- two-up blocks always contain two __sections -->
  <section class="two-up-block__section">
    <!-- the radio list group -->
    <div class="input-block input-block--list">
      <!-- the radio list's 'input--radio' atoms -->
      <input class="input input--radio" type="radio" name="capture-radio" value="Radio 1..." />
      <input class="input input--radio" type="radio" name="capture-radio" value="Radio 2..." />
      <input class="input input--radio" type="radio" name="capture-radio" value="Radio 3..." />
    </div>
  </section>
  <section class="two-up-block__section">
    <!-- the title block group -->
    <div class="title-block">
      <!-- the title block's 'title' atom -->
      <h1 class="title title-block__title">
        Title
      </h1>
      <!-- the title block's 'body' atom -->
      <p class="body title-block__body">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, vero, repudiandae, vitae quibusdam eius iure.
      </p>
    </div>
  </section>
</div>
```

Now, whenever we want to reuse a Two-up Radio List/Title module, we can just drop this in to our page.

##### 3. Add the Component CSS to the Sass files

Care has been taken to ensure that you won't have to write much CSS, but you might have to (especially if you're dropping an group into a template in a way that hasn't been done before).

1. Find the correct `scss` file - in our case, the `templates/_two-up-block.scss` file.
2. Add any styling required. There are a few types of styling, which are separated:
  - Structural styles, like `padding` and `clearfix`, which determine the _inner structure_ of a component;
  - Thematic styles, like `color` and `border`, which determine the 'look' of a component;
  - Child layout styles, which determine how children are arranged within the component, and
  - Mobile styles, which determine how the component reacts to screen size changes.
3. Refactor where possible to use Sass mixins for thematic styling.

**IMPORTANT RULE OF THUMB**: if you find yourself nesting child styles deeper than one level, extract the child to its own BEM class. For example:

```scss
.two-up-block {
  //
  // styles for two-up block
  //

  /* --- child layout --- */
  .input-block {
    // we're only one level deep here, so styling is OK
    padding: 1em;
    .input--radio {
      // this is bad: we're reaching 'through' too many components.
      font-size: 1.2em; // :(
    }
  }
}
```

Should become:

```scss
.two-up-block {
  //
  // styles for two-up-block
  //
}

.two-up-block__input-block {
  padding: 1em;
  .input--radio {
    // this is OK: we're only one level deep
    font-size: 1.2em; // :)
  }
}
```

We do this mainly to avoid issues of specificity, but also to keep our CSS as maintainable as possible.

**YOU DO NOT NEED TO RELIGIOUSLY BEM-IZE EVERY SINGLE COMPONENT YOU CREATE.**

##### 4. Make a new release

You've updated the CSS, so you need to create a release. Fortunately there is a rake task for this, so you just need `rake publish` which will create a new tag (you'll need to add a tag following the [semantic versioning convention](http://semver.org/)), update bower, and update the [main docs](http://makersacademy.github.io/style_guide/) hosted on GitHub pages.

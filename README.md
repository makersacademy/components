# Makers Academy Components

[![forthebadge](http://forthebadge.com/images/badges/powered-by-electricity.svg)](https://www.google.co.uk/search?q=electricity&source=lnms&tbm=isch&sa=X&ei=zmk6VdqmC--P7AbrsoHgCA&ved=0CAcQ_AUoAQ&biw=1440&bih=805#imgrc=_)

All the HTML components, CSS styles, and JavaScript interactions to build new things for Makers Academy. 

### Quick Links

* If you're looking for documentation on the different templates/components available, go to [the main page](http://makersacademy.github.io/style_guide)
* If you want to know how to build a new component, you'll need the [developer guide](developer-guide.md)
* If you want an overview of what this guide is all about, read on below!

### What's the rationale for these components?

Any given interface (including e.g. email or print interfaces) can be constructed from components.

Components can have huge numbers of different layouts, thematic variations, and so on. Only some of these variations are available to be used inside other components, or within pages. These 'public interfaces' are called _modules_. There is a hierarchy to modules:

- **Atoms** are the most basic modules. They exist to perform a single function. For example, the [Call to Action](http://makersacademy.github.io/style_guide/visual_guide/atoms/cta/). Multiple Atoms can be combined to create Groups.
- **Groups** are intermediate modules. These are collections of atoms in abstract, but often useful, combinations. For example, the [Call to Action Block](http://makersacademy.github.io/style_guide/visual_guide/groups/cta-block/). Multiple groups can be combined to create templates.
- **Templates** are high-level modules. These are collections of groups (and sometimes other templates) in a 'fill in the blanks' format, and are designed to be placed straight in to pages. They are generally full-pagewidth, and are designed to maintain a vertical (downwards) flow. You should use Templates to build new pages. There are few templates by design: this keeps styling consistent and on-brand.

#### Some rules
- Templates can have fixed heights, all other patterns cannot.
- Layout (such as height and alignment) is set by the 'parent' module. For example, the CTA atom is laid out by the CTA block group. The CTA block group's layout is determined by parent templates, such as the Three-up block.

```ruby
# Layout direction
Templates -- lay out --> Groups -- lay out --> Atom
```

### What's the HTML like?

Semantic HTML is used where appropriate. For example, `<section>` is used to delineate content within a container. `<div>` is used too, when content is more general-purpose. The real focus has been on creating a descriptive **class structure**.

HTML classes are structured using a [Block-Element-Modifier (BEM)](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) syntax. For example, the Title Block module looks like this:

```html
<div class="title-block title-block--left">
  <h1 class="title title-block__title">
    Title
  </h1>
  <p class="body title-block__body">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, vero, repudiandae.
  </p>
</div>
```

Thus, a `.title-block` class can have modifiers - in this case, aligning its contents to the left with the `--left` class modifier - and elements within it can be specifically styled - in this case, the `.title` [Title atom](http://makersacademy.github.io/style_guide/visual_guide/atoms/title/) can be addressed with the `.title-block__title` class, and the `.body` [Body atom](http://makersacademy.github.io/style_guide/visual_guide/atoms/body/) can be addressed with the `.title-block__body` class. This class naming helps to avoid issues of Specificity when certain combinations are especially common, by avoiding the use of CSS inheritance selectors.

> CSS inheritance selectors are not to be totally avoided - for example, templates can sometimes set specific `display` properties for their child atoms. In general, though, this should be refactored out to avoid selector chains.

This style of doing the HTML is extremely amenable to a conventional template structure for views server-side, such as the follow partials:

```erb
<%= render partial: "atoms/cta-block", locals: {
  { :text => "Apply now", :link => apply_path },
  { :text => "See more", :link => clients_path }
}, as: :ctas } %>
```

And in the cta-block.erb file:

```erb
<% ctas.each do | cta | %>
    <%= render partial: "atoms/cta", locals: {
      :text => cta.fetch(:text, "Untitled"),
      :link => cta.fetch(:link, "#")
    } %>
<% end %>
```

If this style guide is installed as a gem and set-up properly, these partials can then be accessed from whatever website you're working from. You can see a full summary of all available partials from the [main site documentation](http://makersacademy.github.io/style_guide/).

### What's the CSS like?

Since we're using BEM syntax, the CSS is quite legible. It is also highly amenable to component-izing. In this example repository, a CSS structure is suggested: Sass files are arranged in the same way as HTML partials.

Each class in the SCSS source files separates the concerns of:

1. _structure_, which is the internal properties of that component alone,
2. _theming_, which is the presentational aspect of a components, and
3. _child layout_, which is the arrangement of child components within the class.

Components are designed to stand alone, so _structure_ and _child layout_ are rarely abstracted. However, _theming_ is highly abstracted. Almost all theming can occur via mixins, which are `include`d inside CSS classes. Almost all mixins should take as their argument a Sass variable. This way, the entire site can be 're-skinned' from the suggested _variables.scss file (layout is broadly unaffected). For example, the animation mixin (declared in [_mixins.scss](https://github.com/makersacademy/style_guide/blob/master/source/sass/_mixins.scss):

```scss
@mixin transition($transition) {
  -webkit-transition: $transition;
  transition: $transition;
}
```

is only included in classes with one of three `$transition` variables, declared in [_variables.scss](https://github.com/makersacademy/style_guide/blob/master/source/sass/_variables.scss):

```scss
$transition-standard: all 0.3s ease-in-out;
$transition-faster: all 0.2s ease-in-out;
$transition-slower: all 0.4s ease-in-out;
```

> There is an argument to further separate concerns further, by introducing `--full`, `--small`, `--backgrounded`, `--background-imaged` as classes. This would make setting common structural heights easier in the short-term. Thoughts are appreciated!

### What's the UX like?

Much focus has been given to the **funnel** aspect of the site UX. That is, maximising the number of visitors who proceed from visit (funnel stage 1) to application (funnel stage 2) and to acceptance (funnel stage 3). To that end, visitors have one 'path' they can take, in two different (and complementary) ways:

1. 'Horizontally', i.e. 'across' pages of content, and
2. 'Vertically', i.e. 'down' a single page of content.

The three main tactics we have used to achieve this are:

1. Affordance for vertical movement: more content is always available to read by scrolling down, encouraging the engaged user to do so (with minimal interaction required),
2. A clear Call to Action structure: one to move 'horizontally', and one at the end of a 'vertical' path (which grants access to funnel stage 2), and
3. Minimal content unless the current page is explicitly to deal with that content (elsewise, a brief précis of content and a horizontal call to action _to that page_ is provided).

### What's the Design like?

To achieve the main UX aims, Design:

1. Makes use of the Golden Section (1:1.618) for affordance (blocks are always less than 100% screen height on desktops), and occasionally for aesthetic,
2. Makes use of two, and only two, call to action styles for clear site-wide navigation and vertical movement encouragement, and
3. Makes use of typographic styles and vertical rhythm to keep the aesthetic clean and minimal (:construction:).

### How do I contribute?

1. Try to obey the style guides set out in this README and elsewhere in the repo: if you want to break a guide, do so with good reason
2. If you need to make a new component, read [this](developer-guide.md)
3. Submit a PR for revision by the Makers Academy team.

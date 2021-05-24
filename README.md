# PharoEDA Common

This repository contains classes shared among PharoEDA components.

## Motivation

Some classes and traits are used by several PharoEDA components. They don't belong to any particular one.

## Design

A catalog of domain-agnostic classes and traits.

## Usage

Load it with Metacello:

```smalltalk
Metacello new repository: 'github://osoco/pharo-eda-common:main'; baseline: #PharoEDACommon; load
```

Use the classes in your code.

## Work in progress

- Move EDA-Traits from PharoEDA.

## Credits

- Background of the Pharo image by <a href="https://pixabay.com/users/alexas_fotos-686414/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=3223941">Hier und jetzt endet leider meine Reise auf Pixabay aber</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=3223941">Pixabay</a>.

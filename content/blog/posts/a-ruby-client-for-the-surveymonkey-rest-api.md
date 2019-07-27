---
type: post
title: "A Ruby client for the SurveyMonkey REST API"
date: 2015-05-04 21:02:39 -0400
comments: true
categories: work programming ruby
---
So, if you've had an email account for more than a few minutes, you've probably at some point been prompted to fill out a survey hosted by [SurveyMonkey](http://www.surveymonkey.com).  They're a ubiquitous online survey service.

As it so happens, they offer a [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer) enabling customers to access their survey data programmatically. Their API is hosted by [Mashery](http://www.mashery.com/), which is some sort of API service provider; I hadn't realized that this was a thing, but it makes perfect sense now that I think about it; you get a consistent API style, you get someone else managing your public-facing API endpoints, seems like a fine idea.

We use SurveyMonkey at work to implement our user surveys, and so of course we will want to pull statistics about these surveys into our analytics system.  To this end, I have written and published a Ruby client library for the SurveyMonkey API.  World, meet [surveymonkey](https://rubygems.org/gems/surveymonkey) ([GitHub](https://github.com/hakamadare/rubygem-surveymonkey))!

I hope this will be of some use to anyone besides me; I couldn't find another Ruby API client, so I figured that writing my own would be a decent programming exercise.

Pull requests are gratefully accepted!

P.S. Yes, I realize that to be a _real_ Ruby Gem, the library should really be called "cattywompus" or "moscow_mule" or "velvet_underground" [or](https://rubygems.org/gems/gherkin) [some](https://rubygems.org/gems/hpricot) [such](https://rubygems.org/gems/rainbows); I promise my next one will have a sufficiently [preposterous](https://rubygems.org/gems/typhoeus) name :)

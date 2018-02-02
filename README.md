## Black Thursday

Find the [project spec here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).

## Project Overview
### Learning Goals

* Use tests to drive both the design and implementation of code
* Decompose a large application into components
* Use test fixtures instead of actual data when testing
* Connect related objects together through references
* Learn an agile approach to building software

### Setup
```
git clone https://github.com/Maxscores/black_thursday.git
cd black_thursday
bundle
```
To Run Test Suite: `rake`

### Spec Harness

This project was assessed with the help of a [spec harness](https://github.com/turingschool/black_thursday_spec_harness). The `README.md` file includes instructions for setup and usage.

#### Installation
Make sure you're at the same level as the black_thursday project:

    <my_code_directory>
    |
    |\
    | \black_thursday/
    |
    |\
    | \black_thursday_spec_harness/
    |

```
git clone https://github.com/Maxscores/black_thursday_spec_harness
cd black_thursday_spec_harness
bundle
```
To Run Test Suite: `bundle exec rake spec`
*NOTE* All Tests of Iteration 4 should be failing. We chose to do Iteration 5 instead.

<Copyright (C) 2018 Hermann Detz>

<This software may be modified and distributed under the terms>
<of the MIT license.  See the LICENSE file for details.>

# jupyternb

This gem provides useful functions to generate Jupyter Notebooks,
(formerly IPython Notebooks), from Ruby scripts.

## Setup

Add the gem to your Gemfile:

    gem 'jupyternb', :path => "path-to/jupyternb"

Update your gem list:

    $ bundle install

## Usage

Currently, the only functionality is to generate .ipynb files. 
A simple example is given in the following:

```ruby
module JupyterNB

# Create a Jupyter Notebook Generator
# The parameter defines the kernel used. Present options are :ruby, :julia or :python3.
gen = Generator.new(:ruby)

# Add some content cells (either multi-line strings or arrays of strings)
gen.add_cell("markdown", "", "", "# Test header\nsome text\n## Second Header\nmore text")
gen.add_cell("code", "", "", ["puts \"Hello World!\"","# Do something useful here"])

# Simply print the output to the terminal
puts gen.generate

end
```

## Version History
### 0.1.2
Suppport for Julia

### 0.1.1
Detecting python3 executable3 before calling it

### 0.1.0
Add capability to generate notebooks with different kernels
Support for Ruby and Python3

### 0.0.1
Initial commit


## Feedback & Contributions

1. Fork it ( http://github.com/hermanndetz/middleman-gnuplot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


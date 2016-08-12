# data-bag-faker

Creates a fake data bag item from environment variables.

The intention of this cookbook is to be used in integration tests for cookbooks where data must be stored in a data bag in order to properly converge/verify, but where that data shouldn't be committed to the cookbook repo. An example would be live IAM credentials for a cookbook that interacts with Amazon S3.

The basics of this cookbook (along with the name) have been borrowed from a test cookbook in the SumoLogic/sumologic-collector-chef-cookbook repo ([link](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/tree/master/test/fixtures/cookbooks/data-bag-faker)).

## How to use

To use this recipe, include it in your `.kitchen.yml` run_list, before any other recipes:

    run_list:
      - recipe[data-bag-faker]

Then, add the required target_data_bag and target_data_bag_item attributes:

    attributes:
      data-bag-faker:
        target_data_bag: my-cookbooks-data-bag
        target_data_bag_item: dbi-name

In your test fixtures, create a data bag item JSON file at `{data_bag_path}/my-cookbooks-data-bag/dbi-name.json` with variable replacements prepared:

    {
      "id": "dbi-name",
      "variable_1": "<@variable_1@>",
      "variable_2": "<@variable_2@>"
    }

Specify the variable replacements in the attributes:

    attributes:
      data-bag-faker:
        variables:
          variable_1: <%= ENV['variable_1'] %>
          variable_2: <%= ENV['variable_2'] %>

Make sure that in your runtime environment, the environment variables have been set:

    $ export variable_1=hello; export variable_2=world

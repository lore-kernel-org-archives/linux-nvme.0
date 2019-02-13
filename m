From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 13 Feb 2019 10:11:14 -0800
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
In-Reply-To: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <1550081474.19311.62.camel@acm.org>

On Wed, 2019-02-06@05:21 +0000, Chaitanya Kulkarni wrote:
> For storage track, we would like to propose a session dedicated to blktests. It is a great
> opportunity for the storage developers to gather and have a discussion about:-
> 
> 1. Current status of the blktests framework.
> 2. Any new/missing features that we want to add in the blktests.
> 3. Any new kernel features that could be used to make testing easier?
> E.g. Implementing new features in the null_blk.c in order to have device
> independent complete test coverage. (e.g. adding discard command for null_blk or any
> other specific REQ_OP). Discussion about having any new tracepoint events in the block layer.
> 4. Any new test cases/categories which are lacking in the blktests framework.

Hi Chaitanya,

Thanks for having proposed this topic. I'd like to add a fifth item to the
agenda, namely blktests maintainership. The following could e.g. be discussed:
- How many maintainers should the blktests project have? A single maintainer
  or also one or more co-maintainers?
- Is it acceptable that patches get accepted in the blktests repository that
  break the continuous integration tests? If so, why do we even have continuous
  integration tests? See also "[PATCH] Unbreak the continuous integration build"
  (https://marc.info/?l=linux-block&m=154990323618159).
- How long should it take before a blktests maintainer provides feedback on
  blktests patches and pull requests? Is it considered acceptable that it takes
  more than four weeks to process a pull request that is in perfect shape? See
  e.g. https://github.com/osandov/blktests/pull/44.

Bart.

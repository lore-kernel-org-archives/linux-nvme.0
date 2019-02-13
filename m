From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 13 Feb 2019 10:54:04 -0800
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
In-Reply-To: <20190213184331.GA9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <1550081474.19311.62.camel@acm.org> <20190213184331.GA9819@vader>
Message-ID: <1550084044.19311.73.camel@acm.org>

On Wed, 2019-02-13@10:43 -0800, Omar Sandoval wrote:
> On Wed, Feb 13, 2019@10:11:14AM -0800, Bart Van Assche wrote:
> > - Is it acceptable that patches get accepted in the blktests repository that
> >   break the continuous integration tests? If so, why do we even have continuous
> >   integration tests? See also "[PATCH] Unbreak the continuous integration build"
> >   (https://marc.info/?l=linux-block&m=154990323618159).
> 
> To be honest, I've never used travis, so I don't even know where to find
> the results. https://travis-ci.org/osandov/blktests doesn't point to
> anything. Can we add a build status badge to the README like other
> projects have?

Hi Omar,

What is a build status badge? Anyway, enabling Travis CI is easy:
* Navigate to https://travis-ci.org/ and click on "Sign in with github".
* In the left column, click on "+" (Add New Repository).
* For the blktests repository, enable continuous integration. This will cause a
  continuous integration test to be started after every git push and also every
  time a pull request is submitted. The rdma-core project uses Travis CI not only
  to compile-test pull requests but also to verify whether new code in pull
  requests passes building with sparse. This is useful for the rdma-core project
  since a lot of endianness conversions happen in that code and sparse can
  verify whether these conversions have been annotated correctly. See also
  https://github.com/linux-rdma/rdma-core.

Bart.

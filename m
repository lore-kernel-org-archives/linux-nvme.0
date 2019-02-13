From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 13 Feb 2019 12:56:51 -0800
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
In-Reply-To: <20190213195658.GB9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <1550081474.19311.62.camel@acm.org> <20190213184331.GA9819@vader>
 <1550084044.19311.73.camel@acm.org> <20190213195658.GB9819@vader>
Message-ID: <1550091411.31902.45.camel@acm.org>

On Wed, 2019-02-13@11:56 -0800, Omar Sandoval wrote:
> On Wed, Feb 13, 2019@10:54:04AM -0800, Bart Van Assche wrote:
> > What is a build status badge?
> 
> I just added it, see
> https://github.com/osandov/blktests/commit/a61aa7fcce0bad9094b0e7646f3a8299c30afa6a
> 
> Anyway, enabling Travis CI is easy:
> > * Navigate to https://travis-ci.org/ and click on "Sign in with github".
> > * In the left column, click on "+" (Add New Repository).
> > * For the blktests repository, enable continuous integration. This will cause a
> >   continuous integration test to be started after every git push and also every
> >   time a pull request is submitted. The rdma-core project uses Travis CI not only
> >   to compile-test pull requests but also to verify whether new code in pull
> >   requests passes building with sparse. This is useful for the rdma-core project
> >   since a lot of endianness conversions happen in that code and sparse can
> >   verify whether these conversions have been annotated correctly. See also
> >   https://github.com/linux-rdma/rdma-core.
> 
> Thanks, I got it set up now.

Thanks!

Bart.

From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 16 Nov 2016 11:43:30 -0800
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <20161116183522.GB10050@localhost.localdomain>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
 <20161116183522.GB10050@localhost.localdomain>
Message-ID: <1479325410.31236.0.camel@linux.intel.com>

On Wed, 2016-11-16@13:35 -0500, Keith Busch wrote:
> On Wed, Nov 16, 2016@09:58:28AM -0800, Christoph Hellwig wrote:
> > 
> > Stephen, Keith:
> > 
> > any comments on this test suite???I'd really like to see this going
> > somewhere, as it would make my life a lot easier.
> 
> This is awesome. Just a few comments on the documenation.
> 
> If we can get the README to list all the dependencies to run, it'd
> make it easier on people like me who start with pretty bare-bones
> Linux
> installations. Getting the environment ready required I run:
> 
> ?$ pip install nose nose2 pep8 flake8
> 
> The README also references a 'doc' folder, but it appears to be
> missing
> from the commit.
> 
> Otherwise, I like this alot. I can apply it immediately if there's no
> objection, and we can add more documentation as follow on commits.

No objections, enable Christoph now, address the doc issues in follow-
on patches :-)

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

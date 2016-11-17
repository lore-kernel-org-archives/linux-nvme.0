From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Nov 2016 11:05:11 -0500
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
 <20161116183522.GB10050@localhost.localdomain>
 <1479325410.31236.0.camel@linux.intel.com>
 <20161116213733.GE10050@localhost.localdomain>
 <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>
Message-ID: <20161117160511.GH10050@localhost.localdomain>

On Thu, Nov 17, 2016@02:36:49PM +0200, Sagi Grimberg wrote:
> 
> > > No objections, enable Christoph now, address the doc issues in follow-
> > > on patches :-)
> > 
> > Alrighty, it's applied.
> 
> Now make deb is running tests :(
> 
> Usually when building a package we don't want to run tests
> that require nvme devices. So until we can classify to tests
> that have requirements to not run unless some env variables
> are set we need:

Okay, I see. Thanks for the update, I've applied the fix with
Christoph's review.

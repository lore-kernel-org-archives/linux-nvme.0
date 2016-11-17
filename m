From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 04:40:15 -0800
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
 <20161116183522.GB10050@localhost.localdomain>
 <1479325410.31236.0.camel@linux.intel.com>
 <20161116213733.GE10050@localhost.localdomain>
 <257502b9-3373-c6aa-cbf4-a0a276d2dd59@grimberg.me>
Message-ID: <20161117124015.GA7215@infradead.org>

On Thu, Nov 17, 2016@02:36:49PM +0200, Sagi Grimberg wrote:
> Usually when building a package we don't want to run tests
> that require nvme devices. So until we can classify to tests
> that have requirements to not run unless some env variables
> are set we need:

All of them will require a device, so I guess we should add your
patch.  I hadn't even notice that the deb build process would pick
this up automatically..

Reviewed-by: Christoph Hellwig <hch at lst.de>

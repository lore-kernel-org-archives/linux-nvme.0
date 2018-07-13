From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 12:47:12 -0600
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
Message-ID: <20180713184712.GA19419@localhost.localdomain>

On Fri, Jul 13, 2018@03:52:38PM +0000, Bart Van Assche wrote:
> No. What I'm saying is that a behavior change has been introduced in the block
> layer that was not documented in the patch description. 

Did you read the changelog?

> I think that behavior change even can trigger a kernel crash.

I think we are past acknowledging issues exist with timeouts.

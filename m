From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 13 Jul 2018 23:03:18 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180713184712.GA19419@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
Message-ID: <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>

On Fri, 2018-07-13@12:47 -0600, Keith Busch wrote:
> On Fri, Jul 13, 2018@03:52:38PM +0000, Bart Van Assche wrote:
> > I think that behavior change even can trigger a kernel crash.
> 
> I think we are past acknowledging issues exist with timeouts.

Hello Keith,

How do you want to go forward from here? Do you prefer the approach of the
patch I had posted (https://www.spinics.net/lists/linux-block/msg26489.html), 
Jianchao's approach (https://marc.info/?l=linux-block&m=152950093831738) or
perhaps yet another approach? Note: I think Jianchao's patch is a good start
but also that it needs further improvement.

Thanks,

Bart.

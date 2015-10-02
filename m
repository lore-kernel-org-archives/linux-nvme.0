From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 16:53:34 +0000 (UTC)
Subject: [PATCH 3/4] nvme: split pci specific functionality out of core
 code
In-Reply-To: <1443803984.2801.7.camel@linux.intel.com>
References: <1443493257.3449.15.camel@linux.intel.com>
 <560D2D26.5000703@dev.mellanox.co.il>
 <1443717338.2803.58.camel@linux.intel.com>
 <20151002131529.GA27956@infradead.org>
 <1443803984.2801.7.camel@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1510021652330.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, J Freyensee wrote:
> On Fri, 2015-10-02@06:15 -0700, Christoph Hellwig wrote:
>> Your mail line wraps the patches, which make them impossible to
>> apply.
>
> I took a separate clone of Jen's tree and applied the patches
> successfully before emailing so I'm not sure exactly why they were not
> applying.  But I'll look into this.

No doubt the patch was in good format before mailing, but your mailer
must have mangled it.

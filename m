From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Aug 2017 12:38:03 -0400
Subject: [PATCH 1/2] nvme: Fix nvme reset command timeout handling
In-Reply-To: <20170810085716.GA23246@lst.de>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
 <20170728075834.GC4043@linux-x5ow.site>
 <20170810083827.GB22739@lst.de>
 <20170810084818.GM4841@linux-x5ow.site>
 <20170810085716.GA23246@lst.de>
Message-ID: <20170810163803.GB14634@localhost.localdomain>

On Thu, Aug 10, 2017@10:57:16AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 10, 2017@10:48:18AM +0200, Johannes Thumshirn wrote:
> > On Thu, Aug 10, 2017@10:38:27AM +0200, Christoph Hellwig wrote:
> > > Agreed.
> > > 
> > > We probably should get this series into 4.13, so other comments would
> > > be welcome.
> > 
> > So with my proposed change I'm fine with it, so 
> > Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> > IFF the change is made. 
> 
> Given that you're awake now: can you resend a full patch with your
> proposed changes included so that it can be tested when the Americans
> get up? :)

I'm back in America now! A typhoon caused some trouble for Pacific air
travel, and I lost 1.5 days as a result. Back to normalcy, and thank
you for resending the fixed up patch. :)

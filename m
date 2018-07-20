From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 20 Jul 2018 08:05:27 -0600
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>
Message-ID: <20180720140527.GA4093@localhost.localdomain>

On Fri, Jul 20, 2018@08:52:58AM +0200, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018@03:26:18PM -0600, Keith Busch wrote:
> > The scsi block layer requires requests claimed be the error handling be
> > completed by the error handler. A previous commit allowed completions
> > to proceed for blk-mq, breaking that assumption.
> 
> Ahm the first sentence is a bit hard to parse, sorry.
> Did you mean something like:
> 
> "The scsi block later requires requests claimed by the error handling
> to be completed by the error handler"?

Ugh, sorry. Yes, you are correct on the intended phrasing.

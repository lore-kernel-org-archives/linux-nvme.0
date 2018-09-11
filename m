From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 11 Sep 2018 00:17:09 -0700
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <9fab9189-19ba-e81b-83bc-8c7c0c764763@broadcom.com>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <20180905195652.GA2560@infradead.org>
 <9fab9189-19ba-e81b-83bc-8c7c0c764763@broadcom.com>
Message-ID: <20180911071709.GA8376@infradead.org>

On Wed, Sep 05, 2018@01:12:29PM -0700, James Smart wrote:
> The patch is good - but did bring out an error in lpfc.? So we're hosed
> either way:? w/o it - we have fc transport using a pointer after free
> corrupting whatever it is; w/ it lpfc doesn't clean up so the controller
> hangs.
> 
> I guess I would prefer to pick up the fix and I'll work on getting lpfc
> fixed.

I'll merge it for 4.20 for now due to the issue of uncovering another
bug.  If you have a got reason for it to got into 4.19 instead let me
know and I can still move it around.

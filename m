From: james.smart@broadcom.com (James Smart)
Date: Wed, 5 Sep 2018 13:12:29 -0700
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <20180905195652.GA2560@infradead.org>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <20180905195652.GA2560@infradead.org>
Message-ID: <9fab9189-19ba-e81b-83bc-8c7c0c764763@broadcom.com>

The patch is good - but did bring out an error in lpfc.? So we're hosed 
either way:? w/o it - we have fc transport using a pointer after free 
corrupting whatever it is; w/ it lpfc doesn't clean up so the controller 
hangs.

I guess I would prefer to pick up the fix and I'll work on getting lpfc 
fixed.

-- james



On 9/5/2018 12:56 PM, Christoph Hellwig wrote:
> Ewan, James: what is the conclusion on this patch?   The discussion
> seems to have faded.

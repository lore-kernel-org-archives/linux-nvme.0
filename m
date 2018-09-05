From: jsmart2021@gmail.com (James Smart)
Date: Wed, 5 Sep 2018 13:40:42 -0700
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <1536179041.8172.49.camel@localhost.localdomain>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <20180905195652.GA2560@infradead.org>
 <1536179041.8172.49.camel@localhost.localdomain>
Message-ID: <4788aa25-5852-7041-7cd2-9a5b950153ca@gmail.com>

On 9/5/2018 1:24 PM, Ewan D. Milne wrote:
> On Wed, 2018-09-05@12:56 -0700, Christoph Hellwig wrote:
>> Ewan, James: what is the conclusion on this patch?   The discussion
>> seems to have faded.
> 
> I think where we left it was that I found a case where the patch
> exposed a problem that James thought needed a fix in the lpfc driver.
> 
> The basic problem with the tree right now is that "nvmetcli clear"
> frees the nvmet_port object but nvmet_fc_tgtport still points to the
> freed memory.  So, if a subsequent connect request comes in, we
> reference the freed memory.  I normally run with slub_debug=FZPU, so I
> get a crash right away.  Otherwise you might never notice (but our
> QE people have seen odd behavior, which sent me looking...)
> 
> With James' v2 patch, he addresses the problem, however now there is
> a different one, which is that if the target is not configured, and
> a connect request comes in, we hang on the initiator side.
> 
> This is all with the NVMe/FC soft target.
> 
> -Ewan

I have no problems with the nvme soft target, but my soft target did 
have the fcloop fix for dropped LS requests, which Christoph pulled in a 
few days ago.

-- james

From: m@bjorling.me (Matias Bjorling)
Date: Fri, 15 Aug 2014 12:09:47 +0200
Subject: [PATCH v11] NVMe: Convert to blk-mq
In-Reply-To: <alpine.LRH.2.03.1408141651300.14603@AMR>
References: <1406365643-27020-1-git-send-email-m@bjorling.me>
 <1406365643-27020-2-git-send-email-m@bjorling.me>
 <CAOu_J6mW-2e2Jgm+khodLPah_-RZrD599SmSH+Mszd0AjterrQ@mail.gmail.com>
 <alpine.LRH.2.03.1408131519590.14603@AMR> <53EC7273.5060303@bjorling.me>
 <53ECD125.3080701@fb.com> <alpine.LRH.2.03.1408141651300.14603@AMR>
Message-ID: <53EDDC6B.40007@bjorling.me>

On 08/15/2014 01:09 AM, Keith Busch wrote:
>
> The allocation and freeing of blk-mq parts seems a bit asymmetrical
> to me. The 'tags' belong to the tagset, but any request_queue using
> that tagset may free the tags. I looked to separate the tag allocation
> concerns, but that's more time than I have, so this is my quick-fix
> driver patch, forcing tag access through the hw_ctx.
>

I moved nvmeq->hctx->tags into nvmeq->tags in the last version. I missed 
the free's in blk_mq_map_swqueue. Good catch.

The previous method might have another problem. If there's two 
namespaces, sharing tag set. The hctx_init fn could be called with 
different hctx for an nvmeq, leading to false tag sharing between nvme 
queues.

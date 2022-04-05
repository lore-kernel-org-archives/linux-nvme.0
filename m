Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F02C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuMx8kC3FCPzL84viJyvjBkdFoJxysZuafQQlc3MPok=; b=MygC18ms+kdRkRuOydO3AJT+DX
	+k4xL/sKo4wTm0GIJpONNFvp3Zq32y1re9AQAyD6q94kJWynu7mexijRTBe1RNBokIGWpsFumy5Gl
	gRxKC6j0lb/d65MKWDw1oU0d5HXheJA7xFsNcm7mrK8aQ6hmZCPnGPdB7UayWI3goR70QVr3f8F2y
	AsG9QBAjzuFL+buYQp5D19quv2KEklM/Cz8DKzGu5NAZn/fOj1YKoV6p+2jZmUuXVJXp9V4gOC1U1
	8l9aqL+D4hFtFgHCJA2ozPmCHcZUs6rUGEWtpI3taCS1KoD3lkChUksyq40MjX8PNEHBetAtpVRbx
	Y63E9fRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbnod-002BPQ-1C; Tue, 05 Apr 2022 18:22:07 +0000
Received: from out1.migadu.com ([91.121.223.63])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbnoZ-002BOX-Ni
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 18:22:05 +0000
Message-ID: <3e96e81f-8650-800a-ba35-1e89c7e82e43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649182917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuMx8kC3FCPzL84viJyvjBkdFoJxysZuafQQlc3MPok=;
 b=kZ5RO+bfBrfi8iLtrzZS5rDBYBGBkLhNbG83KzF/8KUZ+BM19zDfdlJIZkMSzEr4MEMeug
 OqugCNnINFGevPWjzf6HOydNGS9WMk7xqKSx7mYFtf9SkOEWccX7LMep+CwWhZuzw6vXTy
 rFXbImNvtkwIowgCxpVnTbFXNUydWmg=
Date: Tue, 5 Apr 2022 12:21:54 -0600
MIME-Version: 1.0
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
 <YkveT9/oBMoykEsy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <YkveT9/oBMoykEsy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_112204_465426_916DA411 
X-CRM114-Status: GOOD (  21.78  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 4/5/2022 12:14 AM, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 02:30:12PM -0600, Keith Busch wrote:
>>> Eg, nvme0: blah blah command set not supported
>>
>> The new print in the completion handler is pretty generic. I don't think it can
>> readily tell the difference from a harmless error. Maybe pr_err is too high?
>>
>> Or maybe since enough people have been concerned about *this* specific
>> identify, maybe it should be restricted to 2.0 devices where it's mandatory. I
>> was reluctant to do that at first since the initial device I tested was 1.4,
>> but it was a prototype and we should be fine without the non-mdts limits
>> anyway.
> 
> What SCSI does is to add RQF_QUIET to all internal passthrough commands,
> and then skips printing the SCSI specific error messages in addition
> if that flag is set.
> 
> This would be the nvme version of that:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7e07dd69262a7..9346cd4cf5820 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -366,7 +366,8 @@ static inline void nvme_end_req(struct request *req)
>  {
>  	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>  
> -	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
> +		     !(req->rq_flags & RQF_QUIET)))
>  		nvme_log_error(req);
>  	nvme_end_req_zoned(req);
>  	nvme_trace_bio_complete(req);
> @@ -648,6 +649,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>  	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  
>  	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> +	req->rq_flags |= RQF_QUIET;
>  	if (req->mq_hctx->type == HCTX_TYPE_POLL)
>  		req->cmd_flags |= REQ_POLLED;
>  	nvme_clear_nvme_request(req);


That's good too.
How about this so it's limited to debug loglevels:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f204c6f78b5b..871ad2421284 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -303,9 +303,10 @@ static void nvme_log_error(struct request *req)
 {
        struct nvme_ns *ns = req->q->queuedata;
        struct nvme_request *nr = nvme_req(req);
+       int level = req->rq_flags & RQF_QUIET ? KERN_DEBUG : KERN_ERR;

        if (ns) {
-               pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+               printk_ratelimited(level "%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
                       ns->disk ? ns->disk->disk_name : "?",
                       nvme_get_opcode_str(nr->cmd->common.opcode),
                       nr->cmd->common.opcode,
@@ -319,7 +320,7 @@ static void nvme_log_error(struct request *req)
                return;
        }

-       pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
+       printk_ratelimited(level "%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
                           dev_name(nr->ctrl->device),
                           nvme_get_admin_opcode_str(nr->cmd->common.opcode),
                           nr->cmd->common.opcode,
@@ -651,6 +652,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
        cmd->common.flags &= ~NVME_CMD_SGL_ALL;

        req->cmd_flags |= REQ_FAILFAST_DRIVER;
+       req->rq_flags |= RQF_QUIET;
        if (req->mq_hctx->type == HCTX_TYPE_POLL)
                req->cmd_flags |= REQ_POLLED;
        nvme_clear_nvme_request(req);


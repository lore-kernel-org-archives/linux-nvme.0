Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0BC07E9B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 16:14:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D0761376
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 16:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D0761376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hG9eOL9hpVajiJG9D+EsabrxlZp0ScicIZxV7SWGz5I=; b=Pv/c1IJQvhLWFWblVd5wD7FNg+
	uDaNxz0WRi/WOiezcKuz32QijbmKoOoHeCheIzI/PrtLI8ADP9l3zk8h88Q5b9OOgdQgVqLyf204g
	TcQmTacotvsEmGMdUCKooEcWy3bBGRzpjJU3nq0rHKXqDmGYtozwvVtlXCQSKQo4Bc4xpssa5Pcqe
	pvKFFrxxYdu12YDOdd+A/KfiFKxv1yQ4Ctlvp92lxoDaXMugGvSQg8zUhShcGgU+WdP2uNtPmzvSH
	0PPZbwsAdofwfC3tyuF1JrpBcZYGgb453U0wdnXxgYXQOcJAwu4a9treqZLriZYB8zsri8NDtKL/a
	IBMSaJiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1t8r-0026Sb-3g; Fri, 09 Jul 2021 16:14:17 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1t8o-0026S5-KI
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 16:14:16 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 p4-20020a17090a9304b029016f3020d867so6327508pjo.3
 for <linux-nvme@lists.infradead.org>; Fri, 09 Jul 2021 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R+fTBIjY21MCLp7RRYBt/oOcJr+pa44IXLNh6vt+W88=;
 b=jNpk4RaiHKPM0nDWx6YT3nhvD8zW2WxUFbPX7MxM3PSAScAljHLnNFbmb9Z8/8o2eM
 tclvrIphO4LtI+ujEPU7CJArUV2Ty1MX3fm4g/XIl64+zBVePRnJCsWnzXLX+wTfN8mQ
 fGbwUKfP6Hr+EW6i1jPAy9kW0sVJp5bwmRQMvpBSy+3EqL3BsGbDrtsSfmZhSWwbhylh
 ABzTLCshTGEDaIDq4qU9g7D5y5EYwI0tzFlEOcUWgSuyH6w5PlWwzGXeL4Ej9Z7w5XvI
 dbYKbPVVXyLQ3aPijKmiPduYkyGvYfuXec5j21EZ3HRkwaizzQwWH50fbN9X6H87cXwX
 vRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R+fTBIjY21MCLp7RRYBt/oOcJr+pa44IXLNh6vt+W88=;
 b=bD+SiT4CLGzxiLakijbbOsxepPNLFUgm7En+g4pcvoof9l9GV+SxqvDCQxjFd9N5ig
 327tnrTZjdlqEAhBx4NJHZhkWa9poP/vuXfRnnR/9J6PoJ96Zr4UMTqA9R4+344gHwPu
 x8B/GYlA/w+3faaK5ntBrmnDhZlSML1k+u1cSK6yoED0GKXYras6Zs6Lk54/h/QMLdkK
 boAzDfQ+CBN95I1iR7hSi0vBOr+tsQSnOrVY89HdhWbsTSelMWBbSwaaBqQNZQHLU4TY
 XuT2KChpHorFcJNyCblRWG1g8mGW0JApnPN3w8KrXERUFzVmK/LDfRbs9Mc5d0RrLhjx
 OWvQ==
X-Gm-Message-State: AOAM531fDr1TJ5tNpWg7L6gltQPQ0RPmwsCkxYIXvSO0AyoY4ZfAZelT
 /UNlsnK7SAfeVoko66sQ+00=
X-Google-Smtp-Source: ABdhPJxcp7ZWGofRijkIhy6mURZftr8wF+UXk2UeqVNXi3BysBn/JUwRsrRqGUeYLwwTqx73BVqkFw==
X-Received: by 2002:a17:902:9f93:b029:104:9bae:f56a with SMTP id
 g19-20020a1709029f93b02901049baef56amr31745641plq.75.1625847253480; 
 Fri, 09 Jul 2021 09:14:13 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id i8sm9556861pjh.36.2021.07.09.09.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jul 2021 09:14:13 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <cd630e81-68c9-c62d-de73-8b0ae33c2cfe@gmail.com>
Date: Fri, 9 Jul 2021 09:14:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-6-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_091414_727612_1F65A80C 
X-CRM114-Status: GOOD (  24.87  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/8/2021 2:27 AM, Daniel Wagner wrote:
> nvme_wait_freeze_timeout() in nvme_fc_recreate_io_queues() needs to be
> paired with a nvme_start_freeze(). Without freezing first we will always
> timeout in nvme_wait_freeze_timeout().
> 
> Note there is a similiar fix for RDMA 9f98772ba307 ("nvme-rdma: fix
> controller reset hang during traffic") which happens to follow the PCI
> strategy how to handle resetting the queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8e1fc3796735..a38b01485939 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3249,6 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   		nvme_fc_xmt_ls_rsp(disls);
>   
>   	if (ctrl->ctrl.tagset) {
> +		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_fc_delete_hw_io_queues(ctrl);
>   		nvme_fc_free_io_queues(ctrl);
>   	}
> 

Thanks for the note. that definitely helped follow what is being 
attempted. I also agree with Hannes that the comment from the rdma patch 
should also be present to understand what's going on.

Looking at the patch - this is not done in the same place or manner as 
rdma. Freezing and stoppage is prior to cancelling and that doesn't 
correspond where this was added (this is after all cancellations). We 
also seem to be missing a nvme_sync_io_queues() call in the sequence as 
well. So I believe there's more work to be done on this patch.  I'll see 
what I can do.

We really need to see about a common layer for transports. So much we do 
is similar. We were ok at the start, but we've drifted apart over time 
and the requirements to the core layer aren't propogating to all transports.

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

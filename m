Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DE9C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 20:52:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A07A206C0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TgIzPRhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FEYvZXjQQ2hxZ0cM74tJl6Fo0xFR81WfKmImr3D3FOM=; b=TgIzPRhYVuRrcWWPc/IyckMS/
	FssBzpRGPMy/YGKctDF6vkRwsk3o9qv2tJAcAFepfzHD/kj4/3rTFqWqy8IpOKvIoxdVI0LRxxL6p
	4zNel/OEQ2bgLrl8Hth7cuvswCIOvfHxw3mDbvNTw6RY9YSOory8ogmsW1yNdntwczz2U+uvN2zzX
	8znQsa+bZAQPj+0sx3OX1w4F0qC3KZ0eSBRLQeut5pjZ2lyTM24sph8TFCCkgfTF79rllR06MbSWt
	biBklpL+7Q1E2sQAOh/Nd7/12Gzi65w+bjmNZQNbzUi1f7kZaZm2BvLx4LHtYQQ3Vj1TD3lmKQ5DT
	JLM4I8tiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCqn3-0006ui-4C; Mon, 31 Aug 2020 20:52:33 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCqmy-0006u1-O6
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 20:52:29 +0000
Received: by mail-wm1-f65.google.com with SMTP id c19so769707wmd.1
 for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2020 13:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ILYOV0YY9f7JFvRp1dt3JCW268UZ80xOVcco0zeCX20=;
 b=qp0QGj4hQiV/fiXtZULPSfln4j4sPoc9cPoaNsSNGApwLodoJ0mTAY83ebGpyfmsvD
 Gknfgr4iToWXCZiSJysNYTbWj0JXSfHu9lH6Ks07IDytxUERnIRQb2j187Tx6QiYeBws
 fcuigiBJlhQv1RiTIcDmyU4QAvu77p+bpyTL5V5TwMfkcz7+cIJiAbpg4efp23+XkYgD
 qQgxqwxiM80P63oMNBncXdd0B/sz630nAJ7XoAA/0RRdykhw9xWI14BApZRED9oswDMj
 kfeHHsT5HKGQle+go9ek72gr51S3Fm9MM8CQLUyAMyOCvBfL83BL464B6yTMnzEe8pb4
 iC3w==
X-Gm-Message-State: AOAM532/U+eJma9ZJETKfvmw1exnoz8lcfKXzIZuiQNhzzVd0FGMIVwe
 g75ey55taphZjnr40e9dfUmfoBkrIgXpgQ==
X-Google-Smtp-Source: ABdhPJw94DavXCP+MJ0D+yfjoVX7oorKk7SYejm4oG3eQTG/2WPCzgI3xXzqfkuFsQXhJWrtGJ0/gg==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr1007839wms.165.1598907145514; 
 Mon, 31 Aug 2020 13:52:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1?
 ([2601:647:4802:9070:70b6:3990:a389:c0d1])
 by smtp.gmail.com with ESMTPSA id h5sm14333169wrc.45.2020.08.31.13.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 13:52:24 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: flush async events before freeing qe
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
References: <1598899458-15153-1-git-send-email-dmilburn@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <875bfa87-ae62-8f88-105e-ca480a3528eb@grimberg.me>
Date: Mon, 31 Aug 2020 13:52:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598899458-15153-1-git-send-email-dmilburn@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_165228_810778_90E6E7F8 
X-CRM114-Status: GOOD (  18.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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


> Flush async event workqueue in case async event has been
> queued up before freeing qe and setting ctrl->async_event_sqe.data
> to NULL. Otherwise, we can get into a state were nvme_rdma_submit_
> async_event() runs with sqe->data set to NULL leading to crash.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>   drivers/nvme/host/rdma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8e5ffe2f117d..76f117462d5b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -835,6 +835,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
>   	}
>   	if (ctrl->async_event_sqe.data) {
> +		flush_work(&ctrl->ctrl.async_event_work);
>   		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
>   				sizeof(struct nvme_command), DMA_TO_DEVICE);
>   		ctrl->async_event_sqe.data = NULL;

Why not cancel the work?

I also think that we will want to have this in nvme-core, not
specifically to nvme-rdma?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

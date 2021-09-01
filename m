Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA55C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9773060BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9773060BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kw283qN+OrAZpNsijJ53+eUHz+f9VaBHWw+UvKNQtYc=; b=hEWiguN/mtGAj49vTKv1KvHJId
	0AI55eqIlSIYrIKxaHf73KbeXXmxMUfgKAVcsxny/+O2Lfk7f+N7C3v3XpSElfgWlJRtXbDajKvPJ
	Uv4h1EtGzGREQiyC/qkn8m2jBxsnT+2Co+s/b3euNOe7LqKxrqgjfMB/CgaR7v2TlMuD6MM5Wl1EL
	bnOsHj9rM5n7ZtTxSjwJGgaApeffgISu1wAMrqwKl/cLe3HVI4Djtq87nzrUVEuO5ZnWsxAd1geRb
	FrDKYKdd5U+OP7MWg199A9RDrzdB5i5/fNq1+scr8nsg2xQR2VPbfWUtfsnqoGh6vcWKmeWoQSKTi
	45ItMfHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRfk-006JHc-H0; Wed, 01 Sep 2021 14:57:04 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRfe-006JGy-8i
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:56:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id g18so4936289wrc.11
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 07:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9XHjm03Yw1aAUE6MHhyyVxPPCpsNRsqItKPAOUVUZXU=;
 b=KQLvDFGOXHrKbARLRHLhU5ACWdignBGBNtZxq9jrul5HgQEcOX9fLONA3uQDfTFo6j
 aP8LutskkZAxs1otduSrf9CT1g/fGinzv8kqldGZ9JntsVdkwvhSP5Lw8ix+vyZICJO8
 l54JD3VCu0nACbITyuOJepam3FaR4MuVHibRF89FZ7s8wZNl28B+doeKIuh5z8l9VB9F
 ZlcbXKfasoFtEzmfAlpmrxo7aLCEuIeOTDHS48jd119XHWAn2XqufXAQPpGatqTW6qlh
 1Zw87E0jHB59fqNzAel1wp1q9FHqfMuFOzyMNZ42fE/yFOgEJuKtl9gFYIkuaKHkXfoK
 feqg==
X-Gm-Message-State: AOAM532/Vh/fbkW1zV2ICCNNJ4kpi3cMLiesauN0cy79Bf9skTJf1YOu
 oaHghImSWJXO2ecxlNTp0W0poZUuOog=
X-Google-Smtp-Source: ABdhPJyNhClmKiqU5WKLko9+af1vRQVLNvzSiSdD+7ZKbnIzonmUwLAflD73JcemXljC51I2zsdDNg==
X-Received: by 2002:a5d:6707:: with SMTP id o7mr39231019wru.307.1630508216759; 
 Wed, 01 Sep 2021 07:56:56 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id 129sm5485218wmz.26.2021.09.01.07.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 07:56:56 -0700 (PDT)
Subject: Re: [bug report] nvme-tcp: add NVMe over TCP host driver
To: Dan Carpenter <dan.carpenter@oracle.com>, sagi@lightbitslabs.com
Cc: linux-nvme@lists.infradead.org
References: <20210824131638.GA5558@kili>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dc6d8f82-9729-16f8-bce8-1a81174a30e6@grimberg.me>
Date: Wed, 1 Sep 2021 17:56:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824131638.GA5558@kili>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_075658_378878_D3DD95B0 
X-CRM114-Status: GOOD (  20.38  )
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



On 8/24/21 4:16 PM, Dan Carpenter wrote:
> Hello Sagi Grimberg,
> 
> The patch 3f2304f8c6d6: "nvme-tcp: add NVMe over TCP host driver"
> from Dec 3, 2018, leads to the following
> Smatch static checker warning:
> 
> 	drivers/nvme/host/multipath.c:101 nvme_kick_requeue_lists()
> 	warn: sleeping in atomic context
> 
> drivers/nvme/host/multipath.c
>      97 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>      98 {
>      99		struct nvme_ns *ns;
>      100
> --> 101 	down_read(&ctrl->namespaces_rwsem);
>      102 	list_for_each_entry(ns, &ctrl->namespaces, list) {
>      103 		if (ns->head->disk)
>      104 			kblockd_schedule_work(&ns->head->requeue_work);
>      105 	}
>      106 	up_read(&ctrl->namespaces_rwsem);
>      107 }
> 
> This is a new Smatch warning I'm working on and it's sort of
> overwhelming because it has generates too many warnings and they're
> complicated to analyze and report.  I'm trying to send these
> automatically generated call trees to see if it will help.
> 
> nvme_fc_unregister_remoteport() <- disables preempt
> -> nvme_fc_ctrl_connectivity_loss()
>     -> nvme_reset_ctrl()
> nvme_fc_ctrl_connectivity_loss() <duplicate>
> nvme_fc_unregister_remoteport() <- disables preempt <duplicate>
> nvme_fc_exit_module() <- disables preempt
> -> nvme_fc_cleanup_for_unload()
>     -> nvme_fc_delete_controllers() <- disables preempt
>        -> nvme_delete_ctrl()
> nvme_tcp_state_change() <- disables preempt
> -> nvme_tcp_error_recovery()
>           -> nvme_change_ctrl_state()
>              -> nvme_kick_requeue_lists()
> 
> 
> I looked at the last call tree and it seems like potentially a real bug.
> 
> nvme_tcp_state_change() <- disables preempt
> -> nvme_tcp_error_recovery()
>           -> nvme_change_ctrl_state()
>              -> nvme_kick_requeue_lists()

That is a correct analysis. However from this flow, it is impossible to
step into the condition that triggers nvme_kick_requeue_lists because we
call nvme_change_ctrl_state with state NVME_CTRL_RESETTING from
nvme_tcp_error_recovery which means that the new state cannot be
NVME_CTRL_LIVE as the state will either transition to the desired state 
or fail and be unchanged.

I wander what action should we take here? make the effort to defer the
call to a workqueue context? or we can safely ignore it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

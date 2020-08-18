Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5201C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 20:54:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1C52063A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 20:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QJ9UaPHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1C52063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D+ICW70h1Met3s2yLEnzXvlDkGwy4K9OA5QlCYtJsu0=; b=QJ9UaPHucTm+qdx/trvGzNzw2
	B0Hd00H+XHxMkqiy7bmZaDezM86TvmifmfORBEBw1relTQC0Tr8ulJha+9qpYMV3t4HnYz1e6JLtt
	Ow+1VhAWzIx83pDQcN0OAYEPifFcCE0y9zAKd4/NLRD3Knt05EGccrUP6PCZT1LevDIO3EwwpfxeA
	qd9IkfvvjZER6Jzy1G5uKV0YnJmCUXiBx/QnjbVJ/zz1VuKlPq7DL9TAz7liYmhrUIpmKRTDKNDHD
	BiCd5cPoT+Ei9ui1OiC7PZ/XHX48NbuidTI3vm1lV9B2i9Xp4EYFHgpRnnCNVA8FfluDJFvhJSGyZ
	uQFTF7yeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k88ct-0005b4-Mo; Tue, 18 Aug 2020 20:54:35 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k88cq-0005aO-DX
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 20:54:34 +0000
Received: by mail-wr1-f65.google.com with SMTP id y3so19525531wrl.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 13:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5bWbgIqUylBQhVq8Tq8nEVPTSRbIRqriQ84fNJvCf2c=;
 b=IsvyJ6CoRwLbQvCtC75bHYYhdIuEv7uKtusMdl7NOGOGiiN8al79WOcM+1ZCXeJJcu
 Gyo9JZmYWqfvKoXuYoQtMNpAM0Cfy2D5jZKISjo1IAWQOJxPzNwTUt7rN+Yh5DS7nIVb
 sQNrdh+YMVg7VeD5v2qKKzabsLGGZzfVeqEJAOtrfm1aOUsww9PX2+ZAPIRTSMQayMtw
 JBpwE8pQdNc0W5LpzHqgf5Uwz4ITtAFmWcte4dFuBX4EV4fsABnHtnTdD889kyZ96kP5
 42UOg9yVLTpc9+VdMdRdBp3Po2+tdcqbT8MoIF6PMJ+pluirRbgAELpHaPT1vatJwMBp
 xXhQ==
X-Gm-Message-State: AOAM531O+q3DydMWMXRv5+XO1/rWsEBwEUzoiw8lubYoxxpXef02Ww5h
 j9j2pD6Y/5bwVp6cj/qNDrDM29JLMw3WTA==
X-Google-Smtp-Source: ABdhPJz9joLUNSJl4QDOBzLhujiki/AwSuc3iGQ4A/4VHKQAQVHmmROZ1ndd5ajva1jNfMip/Sm19Q==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr22367574wrw.148.1597784070246; 
 Tue, 18 Aug 2020 13:54:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id v67sm1469264wma.46.2020.08.18.13.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 13:54:29 -0700 (PDT)
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
To: Christoph Hellwig <hch@lst.de>, amit.engel@dell.com
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
Date: Tue, 18 Aug 2020 13:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818162731.GC27196@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_165432_483290_9B1B042A 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> We want to avoid starting the keep-alive timer with a zero timeout value
> 
> So looking at the spec:
> 
> "This field specifies the timeout value for the Keep Alive feature in
> milliseconds. The controller rounds up the value specified to the granularity
> indicated in the KAS
> field in the Identify Controller data structure. If cleared to 0h, then the
> Keep Alive Timer is disabled."
> 
> we should not just set a random high timeout but just disable the
> keep alive entirely.

It is already disabled, not sure I understand the patch:

--
static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
{
         if (unlikely(ctrl->kato == 0))
                 return;

         queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
}
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

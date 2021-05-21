Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731ABC4707F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:15:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69661402
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69661402
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vy76RtEJaLnr8WVa72iebshJvtDpwqom0LTsRUTeNsU=; b=h7AmEM+Tus6/ouH8le0ULy86B7
	BuGZNYoNsnkiJIjcozIojM+vQRmzf1jyK4t13Qsnjv5JWHCioeSZoH+QU49OM9dJGRRWidpo3Ih3X
	CUIOEdUze66VTZjPvpJ2un8FUehjDb81hm4mLikpyVHRoooZUXQf9MIHOMuXlLB+T9iBnkTDqZIut
	kMSr3riZDWREWZdJ8e4wj6NN2VIlTOhf0VD8tD06rKJd4nFuM83pwkkLV58yLnTcWSWSVxdZJXkZf
	AXTzNBiNfOvlhw6KIql9ZrKr3uNgfcXe06eDXCGoCtQ2Tq1ki3ac2TKFOc8tJ3fusM4cG2F0BPHxC
	ii2u2iOQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDQf-001D2y-LO; Fri, 21 May 2021 22:15:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDQc-001D2Y-D2
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=w+BCs0/fYIVtbt+M2LFvBfQJLxg/d+0gZQ+CgKy81c0=; b=Yut7RsvD7FWzSFLgyCAa4DJ1ZT
 0OjkzQJYg/ogxeDXtTH10IwLsdSgA/a97cO1wfqxL127zUKj/xLkC21OJpzybjvPCUcDz1caFx5kU
 S8JcoBHCwtJaX5+Giqu06/Ag2M2MWq0BM0+CP0MlGYA1/MvZnLFhmaiRRpTLfe+UNy7xIjQRNVGQp
 jGJj2BFJ0jqH9KZFbKcS3Kd5/lT41L73HsIVNNHbSokofFbKjKHOBDr/nVEiLa4xGTKZ7xlbgdbet
 EVATPFb793zf6OoABNX3IYrBcYk9YWFEAOP7VGrAq2i7XAwOJR9jUlkrxG1Grvroo00zIuUEbR+Ij
 T2twsMUQ==;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDQZ-00HSc9-Ux
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:15:33 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso8178262wmm.3
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w+BCs0/fYIVtbt+M2LFvBfQJLxg/d+0gZQ+CgKy81c0=;
 b=hZbMlYQ61cApAmq8QvlnCGHPT6Bo9A8Aa63T0pcboEkS6AxaN73rW/922SKdGJJEjJ
 85tWiLbsJB/XUWmzO30FWewXcnOYN3WkDrHbK+NMZSug+E7HKc4B1QMv/xgb+Z+pt1w0
 DgrGmSMijAyjqTVFxHN2x0hp8ea6g42sGIGWXAph7QoFXAVhCF1JjDUJ37Fg9zUJX8VJ
 aNIWRRKOh0HWh2oYEjRTlxwluuXSC4GozhJbtYxPk6ekmrBwKWM5o4JAMkDA3IcJVydY
 LhkDvEmdfSPiNSbI2DwudqBT6tRS0PPPRMpPB/qLx6j7j1ryBPtdBr4GpCDhsSd/FeA1
 7Odw==
X-Gm-Message-State: AOAM532IIA71xzSFSNtS6drQLFgfwcrbYU0T90wMfPTVnSQh7egFQDYp
 BSj/82Wc+cO8uUCPkRDuibQ=
X-Google-Smtp-Source: ABdhPJxnEEk1A1pKneck8t0V0D4p7ycvKQwi0UA9grP02aA3lSh+SbHz4NecmT0KUa/P4uzaIXljbg==
X-Received: by 2002:a1c:dd08:: with SMTP id u8mr10869808wmg.62.1621635330755; 
 Fri, 21 May 2021 15:15:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id e26sm740916wmh.39.2021.05.21.15.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:15:30 -0700 (PDT)
Subject: Re: [RFC PATCH v5 02/27] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-3-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d3e57423-24ba-7402-9783-da9e24482376@grimberg.me>
Date: Fri, 21 May 2021 15:15:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-3-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_151532_032364_7B3DD02A 
X-CRM114-Status: GOOD (  14.29  )
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


> From: Arie Gershberg <agershberg@marvell.com>
> 
> Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS definitions
> to header file, so it can be used by the different HW devices.
> 
> NVMeTCP offload devices might have different limitations of the
> allowed options, for example, a device that does not support all the
> queue types. With tcp and rdma, only the nvme-tcp and nvme-rdma layers
> handle those attributes and the HW devices do not create any limitations
> for the allowed options.
> 
> An alternative design could be to add separate fields in nvme_tcp_ofld_ops
> such as max_hw_sectors and max_segments that we already have in this
> series.

Seems harmless...
Acked-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

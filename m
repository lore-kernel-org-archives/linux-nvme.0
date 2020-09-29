Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B937C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2A92075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFTv67ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2A92075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LPOT6DC0gwS3Kxc0NUcmZoFiu8AAKewA8oWWoHeC/eI=; b=rFTv67gaKQ86FVUUNJGLqDtK7
	fmDh0WC2o+y0uZ7czMHmvyxZDPBod6kojNwm4tkZmBEEFl7ybZkJM2Xq1a0gzkC7j3rVvGzU18vzg
	zM1YdVNfYm23dsd/mZbxn11GdTINApGDlpPFMS+ZWV7BgPsF611ULZKCVDBaT85rIpySSFLqVnDnv
	Vd1uN5BHJoihFyQF1/JKnruiHPXXomADCfWOT4BspwhzvApeBX1A8NdWXyNt93c7xO3jBqCaXdZ+d
	SIPlc+zjm36ukeI8FjZ+mSEQX2qyAKk3gcs/tbH5X1kt0/j/hbOtmS7oQqyxdcrEY4fanoLR7XSgC
	b/JqJ7cog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBAe-0006sk-Kz; Tue, 29 Sep 2020 08:39:36 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBAb-0006ra-Ac
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:39:33 +0000
Received: by mail-pg1-f196.google.com with SMTP id t14so3261831pgl.10
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O6iJdbYJA4U3EGfHchhBs1nVdyQYoqyjbRVMJFY4/og=;
 b=n1yyBAKGJu9WFdhvLfNvdY951k5NXtKAoGchEf5k9iAhBRrrN2anevEQmlqQlJQ+zO
 rI1neiH7V9i06HRj9mbtEpql45DnBm4T3vNPWPZQxF6q7ldVaFsUdFLQLTyFjuXrIX3R
 +Gyx7edeIWgaoq5R2nYUDGdkYXPfdsLtsMnDPyOc8OtLzmq92/9Wr534Y2ELIWfhcUwS
 3NjtedEwQMFXlG5ne89WfHrMqab/RO3mR1JRkNiJ83y2/wERX+9ASQEBcFAKMN3OER3m
 D4EmkSqMcv+Vswr5Pq27iDmLqob+Yh+RWcwjyzMNM8jWiZ5T+fgUeyeBXfVJiOyphrbW
 9zZA==
X-Gm-Message-State: AOAM531PN8A1t1/7m5oKDxc9XEOSYROAuxbslPb+DOsYkR7q5/axwi5h
 5TkPo4Hg0TdB++iwsbktMsg=
X-Google-Smtp-Source: ABdhPJzB8wscv1u67bvMMMRQQwT/mPMOQq/Fj24UqQmKnZys6UGIlXNd6QzPxJsjIDdEMxGylTh/jw==
X-Received: by 2002:a17:902:a70e:b029:d1:9be4:b49c with SMTP id
 w14-20020a170902a70eb02900d19be4b49cmr3453900plq.20.1601368772467; 
 Tue, 29 Sep 2020 01:39:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id h9sm3949198pgk.52.2020.09.29.01.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:39:31 -0700 (PDT)
Subject: Re: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19d74cf6-cc55-e7aa-ab01-e8561ef23be2@grimberg.me>
Date: Tue, 29 Sep 2020 01:39:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-9-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043933_380368_1A43C88E 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Check if the namespace actually exists as the very first thing and don't
> bother with any extra work if not.  This should speed up and simplify
> the sequential scanning for NVMe 1.0 devices.

What exactly is this speeding up? Its just a few assignments+allocations

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

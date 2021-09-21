Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 22:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D40D61156
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 22:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D40D61156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GT/fQcTX/bOR8fW5fK9W3vBWPB1q6L9PDzEUpIRmqFs=; b=N/I8+UcQFypi3bs/Klx5X0kEd4
	X8jCC0ePVP40twUFFGKJWbBvFgAF08SvkCMuz8OGavOpE2x4ZDBiDwvUSOIUp1fkVKqhjHMtM/XSJ
	NHPcOIfqLqowvJ8tFPjdbtZaLJ5UAQbIAis4PzZktTj1OQHPhswmN9xzeaePYeMp+pHSBrZj0yhva
	O6O+798mlR7xqc0uHa8gCzmq1DzYP9/snyziJ51g+WUREIbFomWXSIee089hzYc82JKBhd3acYT15
	iO3ZLPxlg+5WlcSYbE95f0KNyjtSbNd2yMLgFfhQpz/czkTdzsqun/HURsyPk4CfhWwxJuEdq3GFJ
	zktkBtrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSocy-006CCf-6l; Tue, 21 Sep 2021 22:52:40 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSocu-006CC3-RP
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 22:52:38 +0000
Received: by mail-wr1-f48.google.com with SMTP id u15so1192326wru.6
 for <linux-nvme@lists.infradead.org>; Tue, 21 Sep 2021 15:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5vXzozD2pGXYra2DocOMhxodDedz59xM54eWj4XXmzY=;
 b=zOeNGsjNKyOwgApDDRjzGzirlmvcWIk0J0X3QZymCyS2+OXlGkmKnlGlyjR6lsGwl/
 79sPZCX2yNYihULZJInB2qVyo2iKLR2dgN5Y+dN5bE4q3fYFlGg5yiBdVK+GuMRZILoT
 mgfSP7clKMGPdDPo36z6y/BPlOQmWJZSEZsO1qvYyfC8jgi+2rAHHzKbnCheo3QmtGAt
 1Hp7t4XJqDURzpIQ8FCyVZVViPYKb4+SdC8AOk6lsDBg5am/+JplxJ7FKI/KUzJivn7k
 Y6CehlpGbb0XdKfHQLBU6SoF8NGIdFXp31zUaF6f5rp3FZevADc89Vm4ettgJb7G0epF
 ZQmw==
X-Gm-Message-State: AOAM533kbAAv2wiQ6Oxc2aVqNL8GAppWvgV9IfY7rBmbBoxyXxceT9PP
 0QZqTSKDUWlttP0cZ/1VR8ZpGqJk/Nw=
X-Google-Smtp-Source: ABdhPJz2m8Hj3kMF3I9nCurU58svS4UV+ByuIG1VWApEde/Ononv8ebLyTvXBlept2hkYGNerpjFGg==
X-Received: by 2002:a05:600c:4fce:: with SMTP id
 o14mr419281wmq.181.1632264755335; 
 Tue, 21 Sep 2021 15:52:35 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id k18sm336380wrh.68.2021.09.21.15.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Sep 2021 15:52:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, chaitanyak@nvidia.com
Cc: israelr@nvidia.com, mruijter@primelogic.nl, oren@nvidia.com,
 nitzanc@nvidia.com
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
Date: Wed, 22 Sep 2021 01:52:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921190445.6974-3-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_155236_939408_AEB83D34 
X-CRM114-Status: GOOD (  11.92  )
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


> Limit the maximal queue size for RDMA controllers. Today, the target
> reports a limit of 1024 and this limit isn't valid for some of the RDMA
> based controllers. For now, limit RDMA transport to 128 entries (the
> default queue depth configured for Linux NVMeoF host fabric drivers).
> Future general solution should use RDMA/core API to calculate this size
> according to device capabilities and number of WRs needed per NVMe IO
> request.

What is preventing you from doing that today? You have the device,
can't you check attr.max_qp_wr?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

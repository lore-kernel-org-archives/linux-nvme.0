Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:27:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC24123406
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC24123406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i1H+t1WJ7BmR+3NnL0O+GaccvyscN2CmE2wqa1ang6U=; b=Uky3cbwUdoSwEm5C0DV/9GPZn
	3+ceLpGwgn6RNcMKm1ujKb/IBFkGwJiLoPPeOry/F79gyfWLwz085KafE1Lpk8YWzPeqJ8K/p8W7y
	AKIqkRvWEuwh4qm+NAxeteJKPPZGZM4pT2XalZ5oSUjWbEduNJyRNLlsChPQcszIdq5Aspq1/byzf
	jh1vaz9ocHjkFvvKNBw6uI1hdTUmReNpsnMg3S8E8QULPXq9Xo3ECuvtR7ePHNxlHYu4zAwZ0/HXu
	gAdqVoRbO6vxvj8tw6SseuMwtbSzuZD4DL/ectUq0VGvtDSgq9aZEK04zu3mOXGJW4QwpuQRUP59s
	leTw0HwvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrQ6-0006Ki-Lj; Thu, 14 Jan 2021 01:27:26 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrQ4-0006KL-7p
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:27:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id n16so4596090wmc.0
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 17:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4wqRrQDMqpx+zERSu2u4Ej1vEpfmwbS23jyI8NIX9c=;
 b=JjReJs4eXwuIDBA+aOOYom36btQF4DyFJXR+0nJiBOci5TeydAXpyHMSdoNDytM5dC
 TNCqjUmxfwu0AJouvmy6tvt48eX+BfUdIcsSmTCTHoni7UlQV+CekV42Q885CSsbAMv3
 vd5WMOPAFz+bc+/CyNlDHUnedCTeWOzF5YJrCfZlhSBvXYMCPXy7JX13WbCSFzM4hZl3
 CXnXtpbLa1Um0vu9ChSXVJ5RW5JrdeedtxE4TX8Vdx20ZftzXGTDjls5kDBNExRHqK1z
 SQyMV67QWozCvBlly18G+PL5rCYoliOIIn8qqHlW4jiXQobA3V1aIjQ77iHtdc25Mu5F
 gSbQ==
X-Gm-Message-State: AOAM533NtMNOjeBX6o1ryPrHWq+nrmFJnHmAmhddr+nrNwiR17CBCIql
 vw9Wt/qgVhqUmNZaEhNxTQc=
X-Google-Smtp-Source: ABdhPJw5XViKYvOG6U3VmMSM7YrcwXpi9bp2OpEwMO4JjmkNSGC4jiz0FLlH1sDZ+4ZUvAc16lUc3g==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr1530111wmb.43.1610587643046;
 Wed, 13 Jan 2021 17:27:23 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id u3sm7664075wre.54.2021.01.13.17.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 17:27:22 -0800 (PST)
Subject: Re: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
Date: Wed, 13 Jan 2021 17:27:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207210649.19194-1-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_202724_597875_85EBACB8 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 benishay@nvidia.com, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Boris, sorry for some delays on my end...

I saw some long discussions on this set with David, what is
the status here?

I'll take some more look into the patches, but if you
addressed the feedback from the last iteration I don't
expect major issues with this patch set (at least from
nvme-tcp side).

> Changes since RFC v1:
> =========================================
> * Split mlx5 driver patches to several commits
> * Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
>    init/teardown to the start/stop functions.

I'm assuming that you tested controller resets and network hiccups
during traffic right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

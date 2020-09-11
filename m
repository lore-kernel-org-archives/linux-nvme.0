Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25722C43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 22:07:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA74321D7E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C77IN8T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA74321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ouUxNqefHkKuuukllzW0LU64/TMfrqSjWAKwOV1KnHk=; b=C77IN8T0MY1UFHnOapuAqohLj
	n5Cjtmm319VF4fuR+XxLQuCH8AopJLA9TFSird7Za+ORqvSORypLVQNfpiAHN7vd6wy2bSlZanuNq
	nPGjn7XBbD9/tV/pOf/3BdfRM8rz93NLbiWKgGbCfpmHyn2BJArcuXZlvG31CxCvkcmgUPaagSJWn
	AOSdcX7ukGJFOKFr1k38nYIfmP1z6UNga4vRy0tnoKxpcSZ7rt5287UTzx098i6wq4pNZili2Ll69
	SapwhNsJ+dmUEqli/hv6+ewv6LGNklCExSvUeIjXjGly6zdaiKo017hx1dcCFfWCvBnzC2M4XxFeb
	mcpo80v7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGrC6-0007KT-C5; Fri, 11 Sep 2020 22:06:58 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGrC2-0007Jk-Uf
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 22:06:56 +0000
Received: by mail-pl1-f193.google.com with SMTP id k13so1515404plk.3
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 15:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FdmMNyAonF4gHCAUD7aZDErsUQgpThiEFy+6SYFOg5E=;
 b=hUOyiF+GfNAE9OLNsj19QaYKDTGaRqkzemeE4i2TpH1JHRe50BQvZLHMhZauahw530
 EyehrcrOpyh+PtyBCjkiK3UI5M00AGiuw3wJt/YUgMmnkF+Q33liH55xgYU4Ud5/njSv
 XDYYvEu16AmlnoOM6+yEGYAOM2VH0QC0ENJR/Lp2JGx/Bly2DZpcP/L/m+i7Art/UolN
 Q69+N8BzpDzkPGI2MKsB7YDJpSkAIYxC95HR1aZ/DmTBkIwdFx0zZGND02WbnSxtxEZ+
 TppkyPcjTKjUlIT6hEn+Tj/1xRUvh04ZE49RZnvITFVtOerGtcEv2W0V89uPM0q2Ye7m
 Hyyw==
X-Gm-Message-State: AOAM53349ln8b36716/+46JL7C2DY6byqxiwpmFfoVh1VGsIsIGtc6af
 4bpz1592DXHwlT0ZPHV6WWI=
X-Google-Smtp-Source: ABdhPJyzSPnwtMRA8FWO9K4YZUe5KuRc/fFUvcvbDDEORy47OfSx8jhsoj/N8hm3EzmB7VLUhelv5w==
X-Received: by 2002:a17:902:b193:: with SMTP id
 s19mr4009400plr.125.1599862006859; 
 Fri, 11 Sep 2020 15:06:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc?
 ([2601:647:4802:9070:4428:73d8:a159:7fcc])
 by smtp.gmail.com with ESMTPSA id gb17sm2748890pjb.15.2020.09.11.15.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 15:06:46 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
Message-ID: <7af726d8-b469-d36c-7be7-252b3bbace54@grimberg.me>
Date: Fri, 11 Sep 2020 15:06:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_180655_002775_F3F64C99 
X-CRM114-Status: GOOD (  18.02  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
> 
> Changes from v6:
> - fix _nvme_discover wrong use of subsysnqn that is never passed
> - move shellcheck fixes to the correct patches (not fix in subsequent patches)
> Changes from v5:
> - fix shellcheck errors
> Changes from v4:
> - removed extra paranthesis
> - load either rdma_rxe or siw for rdma transport tests
> Changes from v3:
> - remove unload_module from tests/srp/rc
> - fixed test run cmd
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3

Omar, anything left on your end to take this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

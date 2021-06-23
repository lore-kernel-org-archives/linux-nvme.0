Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC2C48BC2
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:38:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0111611AC
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0111611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OblPSWdrSNF4ekCrOkJtV+7CiE245w8iDFIH3850OFU=; b=lstJ02N4Hd/0hMBiCtOo+UEsmU
	VP/avxjh5ycMtpcgvFIDiNhwZrHfhrIcCa6iYxXMyWY0P3Mht+6D+JULfsN3mLGpNf1vj2E5DbVqI
	oC/HFIq7kzzIt/KP96dwNoatqK4pBhbUpqsxL1opALkj1OlTwmWxFDfCFvcF30y1qg/Idg/Gprekz
	rya0HQuOMIyXrpuWeoxUtFugRY0d9PtYgOhWAGCuBQFrC7nwtqAT1iPDeY4jYYvgEwtlobJsjY5YY
	jNsYOXrXNFlhWEzOjC9knUK96XcG92H1kCbwlXd5KI/Cjyt4gdon9icfIRXFKnHakoGC4JFdDOaun
	4qKLoUEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwAZz-00C1OV-EQ; Wed, 23 Jun 2021 21:38:39 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwAZw-00C1NI-2k
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 21:38:37 +0000
Received: by mail-wr1-f41.google.com with SMTP id b3so4228023wrm.6
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 14:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h8WD/wJJJw3Csb2+gzeNqx8ue9uWz1YaA4y6k46KWKw=;
 b=sMcjfuMfZVghIeGOpngaEOwJvkrZxCLpphqEyv3sbFZ2q9EFtqkk9r1Ge9JFb53L64
 hAPsL15MHVJIWYt6BKpQTKxdycSnyIPM4e0t5OOLTiwjHm8vXSftQdd85z0cOqWUi/eC
 JiAa8C9PWvsyU7m6exZ81jXv1CNSkrAGBAFwBk4ECz+BRZ0wu+8j6jZcRyC3D+as8wO/
 ATSLWr5K6clM/YvThYlaE5m/o4RA5kSSHyF0kSogmuVbUlnrspU0F4mZ+OUbfgdbBn82
 YbzeAS32A6iu/dALVjjcANGq01tacxh4UA//BX5lD7+M5WpvDyiwjz7gWfjxEb2kCXBP
 3O0w==
X-Gm-Message-State: AOAM533No3Tau8LIB22CJodgMt2UK/WH4pZk6z8Hk6Lkcx2UrYK8+Drn
 6JOs29qma9lsDAnySjeH+QheOEvXEOk=
X-Google-Smtp-Source: ABdhPJxBN9koSoiyHkfofa/esJaH3eNJRSkemFYqOGTxeyXLNCPsF0niw1/lkAS1cZHMNzukbxFPdQ==
X-Received: by 2002:adf:fe47:: with SMTP id m7mr229847wrs.368.1624484314503;
 Wed, 23 Jun 2021 14:38:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7?
 ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
 by smtp.gmail.com with ESMTPSA id h6sm7151114wmc.40.2021.06.23.14.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 14:38:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
Date: Wed, 23 Jun 2021 14:38:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623143250.82445-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_143836_191885_2EBD7F58 
X-CRM114-Status: GOOD (  10.57  )
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


> Hi all,
> 
> commit f25f8ef70ce2 ("nvme-fc: short-circuit reconnect retries")
> allowed the fc transport to honour the DNR bit during reconnect
> retries, allowing to speed up error recovery.

How does this speed up error recovery?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

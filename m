Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3438C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8144820748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOOUBArF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8144820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8WSfGGz0Z6kpm4x6vZ/WSjiV39kNRxKAZ748J9ED5oE=; b=XOOUBArFZo1+3K2msQgTeWHcU
	jLTMRZ2kaUq57YQClIuPih1p1PoioPBj75VHYsLB7Vv0rzBjFEtRHwIxhtx+afMbSUUikHd9JtAqA
	ebQ6qeAU3UNlljd9ef8NxMRrbCJoL+hvmZw4pSyOsuneEG6P6TqWJA/WobwNaizOfRHks9r7ANPz5
	9VZFt0xjOT3umNfLdbD3PIKljYz//93tkWHCTx1yJgErkhYKmth6pLogKLx3qFxbm7e2u6pSjy+Jz
	sht1XGSH/dUfYx7PKTkuO3B615dH7wopKafjIMIQN8mM7chWypfrMBhfSZdo4k8F1KvQ4hIgXpcKe
	/8z5bj0+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45HW-0004qi-An; Fri, 07 Aug 2020 16:31:46 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45HR-0004pF-Lv
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:31:43 +0000
Received: by mail-pf1-f173.google.com with SMTP id s26so1271417pfm.4
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 09:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M97ArB83FSiwZV5zDIQ7MH1gQAqzsHRUmiuLeQhDSLA=;
 b=dZV/nRn+quB2z2W7KnekXr0B6rS6EH4BVOJtreROL1QPZUpA3PfFk16zktrknksnPj
 /kL4WC23XOLjqxCYftSHVBb6TkxMBQ9bs0EzdiUeZQwU7JXLkDLAvnq/w+VrQ6AWX8b6
 0ARAxQ2b9EjcBZ9VqWRX1gEueMwLQSqQbVz91P5dmR/7PEUeivfBkKzye7Idv5A9ROEo
 GQTCu9g2uof7NGNpsiH9hBJwDGP4BVL+zqxwFDR4UWn42UJIshi9CDg27/mkedmfWsY2
 BqP2WyqQKvDZgYWHxP0P8tFa3SN2Knd9u17KAZrGm1afrql6Fgz73TntE5AECSlctiRq
 uyqw==
X-Gm-Message-State: AOAM532h9IYEy/s/OBfeVrISeRw5rdmUtlARt2KPOr8i+C5J1UPSdyYn
 kmeETV90Cf1Omyi+vpPfhCI=
X-Google-Smtp-Source: ABdhPJz3eBxPnHbvNDbCTZoL99MZifDyF2Isb1ngVLKFimB+CzB6UQS7xqBvKWiprug6IRlPC+9u6A==
X-Received: by 2002:a62:3303:: with SMTP id z3mr14574813pfz.252.1596817900382; 
 Fri, 07 Aug 2020 09:31:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id p127sm13298125pfb.17.2020.08.07.09.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 09:31:39 -0700 (PDT)
Subject: Re: [PATCH] nvme: skip noiob for zoned devices
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200807162907.4155487-1-kbusch@kernel.org>
 <20200807163100.GA4155602@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <03feeeb5-caa1-9888-45c8-408b99cc3444@grimberg.me>
Date: Fri, 7 Aug 2020 09:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807163100.GA4155602@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123141_827828_60808D15 
X-CRM114-Status: GOOD (  10.55  )
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


>> -	if (iob)
>> +	if (iob && blk_queue_is_zoned(ns->queue))
> 
> Err, that should have been !blk_queue_is_zoned(). Resending...

I'll fix it up...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

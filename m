Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D361BC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:47:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933A964F03
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933A964F03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GCpxZFUgJRXYcdvQDvxIr50qLy1fsyTkACv3TnOHXBA=; b=qGa4ysSMegnB9ZRscu4gNaJIc
	IFJI+EjSonwjSsi2vgsgc757ZVNCYP7+HsCKlWdIeo143q0ktH+M5WiB7d80NUkPmZ96JjurZjDbE
	FaJfQTES+7ZI2XQCdJ410WdGzvnPqiq5hWS1HxNxvV6kHGqEK1204gOkYLZWueRfG5jqQ9tWtr2+8
	dN+exp3GQDYfxR2Jaxk3mpw80sj+TCUilPnO7S7GNCzGQPKmaPQosfD8jKFKS4sWduQ21nMO03q29
	Mgnm5ipVcV1AhFT9EY0MmZYJc5P+ANxWnJEswA+mleON5SE7hwvyn4FaRbhxFAeuwHrg2zGTbGQNX
	Myy1CnKqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF2w6-00067N-0L; Wed, 24 Feb 2021 22:47:14 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF2w4-00066X-69
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 22:47:12 +0000
Received: by mail-wr1-f53.google.com with SMTP id w11so3388251wrr.10
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 14:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U8Sgc3RSIFUmV+B5ccYNyT1iscwb4pGhsKqcGez3iEk=;
 b=WxUpmlH/la26ywY3OyrOaSgA3W9IwsTrHPgqqpWoSEQ4P3ukKuxjp5EeR06Tr5Ivje
 vFoO6X3/740DIi05WLjY5Nfg8Nwlh8YxfJ/Bywvwva5pKtarBz4D/YPOPwLH6QBRPUOX
 y7T4iKLVCNhVGwmG3xR2WIVpe15HMelFts779qrzi8vQrmBJVzEmXJSqs7dQXBrsAJLW
 9qvPD1MLxE/potkdOtiw2klyc1mxLbYyIRRVyGdyfNEnhmWor+IGIQyYo0Hoh57B+LdZ
 Wy9u6Wfj5ytyIPo+35itSJ+CAcf+PNJjRMDOuWm+kBc1nCDSxUNxG2Mu5q2Krh/p/GPh
 c2nA==
X-Gm-Message-State: AOAM532nTopl0MCFFGnka3fUHrW/wp2fOh3a0Bhy4NTtCnAOaUBSh0ct
 xMmdWCyY5vAZM6UcLAVw9xo1A00/Keg=
X-Google-Smtp-Source: ABdhPJypZ1Wo9+jv+p3fvedYrMhd9x/XWmjNMEWB+7RVk8bKQcnYKaXev//fIiukXNYC3pvSKDDzIw==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr297015wrr.104.1614206830664;
 Wed, 24 Feb 2021 14:47:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db58:8280:1bcd:2501?
 ([2601:647:4802:9070:db58:8280:1bcd:2501])
 by smtp.gmail.com with ESMTPSA id g11sm4861646wmk.32.2021.02.24.14.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Feb 2021 14:47:10 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme: add 'fail_if_no_path' sysfs attribute
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <303e7252-cb51-d6e2-eb4c-ad70fb3528a3@grimberg.me>
Date: Wed, 24 Feb 2021 14:47:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223115922.104369-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_174712_286071_47B7CC03 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/23/21 3:59 AM, Hannes Reinecke wrote:
> In some setups like RAID or cluster we need to return an I/O error
> once all paths are unavailable to allow the upper layers to start
> their own error recovery (like redirecting I/O to other mirrors).
> This patch adds a sysfs attribute 'fail_if_no_path' to allow the
> admin to enable that behaviour instead of the current 'queue until
> a path becomes available' policy.

Doesn't the same happen today if all the controllers are set with
fail_io_fast_tmo=0? nvme_available_path will return false if all
the paths have NVME_CTRL_FAILFAST_EXPIRED set.

I think that fail_io_fast_tmo should be settable via sysfs and I
think I requested that during the various submission iterations...

I'm not sure this should be controlled on the individual namespace level...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

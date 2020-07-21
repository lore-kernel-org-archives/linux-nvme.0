Return-Path: <SRS0=MSYC=BA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91359C433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 17:20:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C187207DD
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcTUowDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C187207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tUMS4T+rIOeeTmUYnyL3FtKVa8QIQWoQ4qVeHhzH4YQ=; b=YcTUowDGunsje4G/XM/kNqE4o
	X6gaMZCGWB+QccT80+kBAqQ4fvpRFV9JXnjA3RygheUDCvFiQ5cX4Uu/2tbwKsDTqvlHb24dzCjst
	u6QWm3qE23cibRnADlYdyb/8egoPiDvUoEnLloDznDlIfNpQ+ntyyoiRfP4W9HNdB9uq4Q24U+1Qm
	Nl4hicj4dT9FEyU9wogThA4mqPIvDvxxRnaRZN5HeZ6HkvlqjJg1pYq0smXnK+9wUYvv19GE7LbhK
	phbmMISr8YZjkWjfu7rpodJAscWsBMd4QZzWEvgSGZ3w2cN8fZCQx9Ju5pAjrJObfmvZqudIcvXmS
	loBORTgQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxvvv-0001xl-6d; Tue, 21 Jul 2020 17:20:03 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxvvt-0001wx-KP
 for linux-nvme@lists.infradead.org; Tue, 21 Jul 2020 17:20:02 +0000
Received: by mail-pl1-f196.google.com with SMTP id 72so10546861ple.0
 for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2020 10:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zUTyD/ITNsuN1/WtpTQMRSFOnlHMru6uzVIamm/NO5A=;
 b=r0/GoGvbedRV9qzwxGjGvtCYJ+iWCJu03DUsLVKoo/9AxWcjx6dY+Dw/X0daQ+6Sq9
 Uh/OfZ7ON5LyLjh0o9x8ye7jW9A5f1cbifapCu7RPC5gVPD+PXRpG9apDY9ag3TInf2D
 PIEj8tY2Vva7U4FVE947SnUbo+t1a2occLtN9ngHF63NXrAE6ZfXwSGQ2VDMCqyh2vyh
 n4unflJV3279UKo+9KCaDH13opzOP49nbwRcguhSc0YVTXffAi/m6XxpqpV9gojd+bGs
 3f6qlp9VIfGmkuoM/Sc75RzK0ZrV3v7FRbLYZxfT/fgq5U2o2j1wL2mjJVQ0lllMkgrx
 bm1w==
X-Gm-Message-State: AOAM533prVfkvm8IDywfnkf6G/lnOrs8KVK0ykMAXQGR/Von3Mmwbhsg
 bCImX35y/aWnoA+7LvSK1AFXUFH5
X-Google-Smtp-Source: ABdhPJz9QUYuFyO7dnstNV9KCDR+qDraK296h1dsWOnaS8V1/tcLOZYKUd36S44yfpzINHLfTIuoXw==
X-Received: by 2002:a17:90a:b38b:: with SMTP id
 e11mr5993542pjr.120.1595352000158; 
 Tue, 21 Jul 2020 10:20:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2022:491d:da4b:4d8e?
 ([2601:647:4802:9070:2022:491d:da4b:4d8e])
 by smtp.gmail.com with ESMTPSA id n2sm18542323pgv.37.2020.07.21.10.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 10:19:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix logic for
 non-optimized paths
To: Hannes Reinecke <hare@suse.de>, mwilck@suse.com,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <20200716195929.28399-1-mwilck@suse.com>
 <fcda06a3-ac59-60dc-7200-ce22b9c216bf@grimberg.me>
 <b2e59b6e-e71a-a9d8-c768-a4a052449cf6@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c51e7fa1-2e89-e5e1-6962-bc16470afd59@grimberg.me>
Date: Tue, 21 Jul 2020 10:19:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b2e59b6e-e71a-a9d8-c768-a4a052449cf6@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200721_132001_694632_E436529A 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: marting@netapp.com, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Handle the special case where we have exactly one optimized path,
>>> which we should keep using in this case. Also, use the next
>>> non-optimized path, not the last one.
>>
>> Not sure I understand, does this patch also use nonopt paths if we
>> have a single opt path?
> 
> Indeed, the latter change should be removed from this patch.

Why should we even do this? we have a clear indication from the
controller on ns access. If we have a optimized path we should never
select any non-optimized path.

What if a non-optimized path has a 50x higher access latency? it's just
wrong to use this path...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

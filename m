Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40E2C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:58:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00D120825
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKo571wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00D120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BRKBtAo2i0DgkiCnmiGUpBlL7vtX66lUAMoQZhxMwTo=; b=EKo571wEnDNYjGCvy+jZOhpgI
	je80tkMLkgJWjwvqm+z94ZEm4vfB2F+oUehtccCwekz6NNv8lLtQae2OuP2BCMEbg2fga8pTJoLaa
	Vgln1iMEiJ2sBtxU6ycKMcNUtVTL8OXiGUwgjTMbkWuYm5QltebWklkpqC7Hw/O6zIbGDadY8yccl
	jbH7kCDMVL/BteAjQ1u1kULM/MCHq7N8/wX12nPgY8asIlmlUx16aQLedmbKqfC6nRqBveklvcvF+
	Vb7mENgGPAcyB+tVLnyfVY3KF42pviGSL5zMF9qZ/Nm2zK9O6vrt7d08CxI5y8C8WV93EnMaTxpVb
	MbcLsx58Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyNgn-0001C9-9k; Wed, 22 Jul 2020 22:58:17 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyNgl-0001Bg-Rv
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 22:58:16 +0000
Received: by mail-wm1-f65.google.com with SMTP id c80so3318422wme.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 15:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wcKEf1fb2GJBmJb9D0A98NXtRxc8KX/LWJCjNZiGYRw=;
 b=oH5D7Ii8l9wu+2tWbi1GHQ3wzn2cV/VOM8YwyGCHaMzNVyMmAQosJO8DinM675T8H9
 pACX+CxJQLyNbQfdJIMAPXMaRNaYx4Rca6laCq/wOJaT3v96yXMMe7RBTBQvhzGM59O+
 1TvxX68tnT/HwZJPUygSISI42Fs1qb/s/YXwMkRlw3rXNad23ge3NEpKS9KWYG9PfyYZ
 XNXGE1jnbwvUB/LBFWLoZUuwLJd4LI1FV+TdIRBh2cVMtbwoF1sjfr2uGt0Fy1zPPsm/
 GiItkVRrZsd7tbxbHyRovxPcAXo8UuljNpcA+oc5PMwBVF1KGaJ7UjLPRxFWSlmhQFtg
 3Itw==
X-Gm-Message-State: AOAM531p2OxhSLRGGN3Q5Og1/2hVIChBBZKs5kIpMnH9+4IjvB/se3V2
 Le8rzwuKnBsaVkhz/DYN2DaVWzX+
X-Google-Smtp-Source: ABdhPJzg0lml4yvLaNz0G5tnR7rRSo6qTsdlHX6i0Ma5J1usWhT4KaLwJ5BDZPDshRLPt2g2FPPU0g==
X-Received: by 2002:a05:600c:21cb:: with SMTP id
 x11mr1429538wmj.141.1595458694308; 
 Wed, 22 Jul 2020 15:58:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100?
 ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id o4sm1113455wmc.13.2020.07.22.15.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 15:58:13 -0700 (PDT)
Subject: Re: [PATCH v2 rfc 1/3] nvme: split nvme_remove_namespaces
To: Christoph Hellwig <hch@lst.de>
References: <20200705075935.506535-1-sagi@grimberg.me>
 <20200705075935.506535-2-sagi@grimberg.me> <20200708151752.GA26154@lst.de>
 <c7c6c2da-8408-72e7-84ce-bf4f7a886ca6@grimberg.me>
 <20200714110635.GG16178@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5872f16c-c1c8-d041-8813-1c09c34bf909@grimberg.me>
Date: Wed, 22 Jul 2020 15:58:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714110635.GG16178@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_185815_961798_89053DDA 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> I find the split rather confusing.  So I looked into alternatives
>>> and found that the state change should just be a no-op for the PCIe
>>> reset case.
>>
>> Looks like the original version, but the only thing that bothers me
>> is that in the reset handler, if we failed to setup any I/O queues,
>> we'll put the state in DELETING_NOIO while it's not deleting, I think
>> that the point of allowing this is to have the device still up for the
>> user to analyze and debug it.
> 
> Based on the state machine we can't really move from that state to
> DELETING_NOIO as indicated in the comment I added, can we?

You're right. Let me prepare a patch

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

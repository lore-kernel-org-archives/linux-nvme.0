Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57044C2B9F4
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 00:59:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2B761075
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 00:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2B761075
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tUvpkVnsz9nzt3fTdbKvUtHXhxcvQuUYTsqLHGgdO0=; b=Ph8UHYnAfYTT5Lc2i7SlN/Uq8e
	xDdiA78TRcYoJAHLNM32wlLEksTM4DeyRreqKWhTuttxypQhnmynlKtN6PFvbEDL19ATXgigmyohL
	BnCQxUlB2+PMTI7+gWLzn8nYSefCky2yOQUpJ5LNd76xssK7z8mkEc7KRxWFmFozGLd1/s8wKbfQ3
	+hWpLhsYty1n3+Iq+xwd6G4y76kJ6F0gY8yc5L4SWPSxOYRJtMDmBqNPj5xzMSI6FkqBVNOFOtJ5y
	IiTCPii0Zsk3URvNR+JTJWs9O0Imi5dqTiF2Tr0OhO2REmUaWECuXPcVPBGxsV0MGFjWE8Yz1zu/8
	jXblR60w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvrF2-008uC1-F2; Wed, 23 Jun 2021 00:59:44 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvrEx-008uBI-OA
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 00:59:42 +0000
Received: by mail-pf1-x42a.google.com with SMTP id u18so907735pfk.11
 for <linux-nvme@lists.infradead.org>; Tue, 22 Jun 2021 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AH96stUSbODLTW9grsc/9TVDsIYwIE0NsVtoP7t2G98=;
 b=h8baUazVhodFRQwv9lEgvDoBCDCS1/wyrLz0OkuK7LieSpx2zkH4dgcyYYa9ir78OU
 Ob+B0Wn9WwwHpO2xhmxgP5Gd9Q2M5edH9N1EspsuUbdd64EBfdBtKn1+uIPeoc0MH9xt
 q9UqaFQPJyiOeZutpo38vWNh9TC/sx7ozNgUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AH96stUSbODLTW9grsc/9TVDsIYwIE0NsVtoP7t2G98=;
 b=OoImz7BbPiC3owopy9zsYMgqOl2sa2bCOk9jT4WuVnMg76NVzVUL4nFHZoWHQHSOob
 CEW6pTx+ZsKEY6YHTGNf2dZPJDMZ2FPQdhtjpH5u5ZHSOAc+1aoGlYRc9gUa/MC5TXLV
 6QuxVW9+qxPLE2GO99xKxfgZiruIivqJ7XGI3uYMt2lV0qyWoXSBseUHJP0ka2+XjWRZ
 rN3FzmOJr0f05aKRP8L7+zN8wHOydiqd+n+cAm3RIWVSM36s0NcZNj8jFsehsO77/Hk9
 ROWYUWRICJ5lXEwylCOdv5JPcoTF/0wYqc+u6k1/0RCqYGLdNTNV9blISXu/yH4yU43r
 UbbQ==
X-Gm-Message-State: AOAM530ARr0ikdKh/NbABjS0tSY03Z/34uJaE5kvCtQkFesoOFbDkbD1
 eaVurZN6IkOPVigiaCWsE1jdxQ==
X-Google-Smtp-Source: ABdhPJzFRXMkVwgiHYNIUSqp/43XbQKr3JgtY0WiBXoZcmQ+CYaJd4cNVvIzmgg8+vNODalBN6vU6g==
X-Received: by 2002:a63:d213:: with SMTP id a19mr1326994pgg.28.1624409977173; 
 Tue, 22 Jun 2021 17:59:37 -0700 (PDT)
Received: from [10.231.212.116] ([192.30.189.3])
 by smtp.gmail.com with ESMTPSA id q27sm458562pfg.63.2021.06.22.17.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 17:59:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
 <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
From: Casey Chen <cachen@purestorage.com>
Message-ID: <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
Date: Tue, 22 Jun 2021 17:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_175939_967063_0C548C34 
X-CRM114-Status: GOOD (  19.96  )
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

On 6/22/21 8:06 AM, Keith Busch wrote:
> On Mon, Jun 21, 2021 at 05:27:09PM -0700, Casey Chen wrote:
>> +	/*
>> +	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
>> +	 * from set to unset. If there is a window to it is truely freed,
>> +	 * pci_free_irq_vectors() jumping into this window will crash.
>> +	 * And take lock to avoid racing with pci_free_irq_vectors() in
>> +	 * nvme_dev_disable() path.
>> +	 */
>> +	mutex_lock(&dev->shutdown_lock)
> Sorry, I wasn't clear in previous review. All of the shutdown_locks
> taken after initialization need to by mutex_trylock()'s. If you have to
> wait to get the lock, the device is not going to be suitable for
> continuing initialization after the lock is available.
>
> And looking at this again, if trylock is successful, I think you need to
> verify controller state is suitable for continuing the initialization.
I assume you mean all the mutex_lock() except the one in 
nvme_dev_disable(), right ? I agree with replacing all mutex_lock() with 
mutex_trylock() except the one in nvme_dev_disable(). But I doubt about 
checking controller state after lock being acquired. Two reasons:

1. What state can use to check ? Suppose there is a state set on 
surprise removal, what if the state check happen before it is set while 
surprise removal is on its way ?

2. Even we don't check controller state after acquiring lock, the 
initialization still fail fairly soon if surprise removal happens. We 
don't sacrifice any performance.

Casey


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

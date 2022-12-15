Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD5DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qNDRfDUc5B5dOE0UJY7Uqm8EjHLoVo8OnG0ay7lnNC0=; b=pAI91w1cu3iTn/
	kOdkHNzlMO2Dh9OPehJFbECkE32ax3fi7e10xBiVwFI86PbGWjsJ2YBBrXrIGC+Gx2kiQvxNRb+TA
	UeCctqlIOmUcUk2n40w+oo0RWfqmyW4sfxQ/iMKLvsnN5wV4vcMXTagqej2uIEeq+Zn9oJeBr4jBu
	PucZ4GFXQqtuiSaNzai3j0/FKuQuYN+ES46VDkoKyIae3NvttOGnlvtoPGMWKG4tTkERDA+qH1Kei
	jOw/cKpdCkpDDh4NjYOCvp70BpzXpNLb+7ODH1XoIEWHyMx2BiSeeak/fSFZXSe9Q0QXOw8P+1ebv
	2Dx0vBPiz4YVcK0aLbrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5kKy-008813-DB; Thu, 15 Dec 2022 09:15:32 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5kKw-0087xB-6n
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 09:15:31 +0000
Received: by mail-pg1-x529.google.com with SMTP id f3so3767294pgc.2
        for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qNDRfDUc5B5dOE0UJY7Uqm8EjHLoVo8OnG0ay7lnNC0=;
        b=YduEfpt4Nx5zKEqsZl3r6+Y87PPxsdzL+G9xLRgpf8ZtNwjXWsA2E9rDv6iAEnZglR
         fvohdEkSLrKuPqWUkQgG3guEUAS3zu/B111sGr/b8CzIZeJdYZxRRRC4OHEm00gWAbEQ
         wYmfWkPafe1SMo8TzAoAspTnMejgGFY/vstqmNmVqgy+GqtJoBRSCPRbHh2XenSrUjNL
         xKXcTul+TWC84E2Sp+yWhUewK+4D1y4sQiYsyPK9PpQ6gnUm7ROTBVBJ29EIYYJbLDk6
         VjjGsUAf45CuZD6YJ+BkjTNx8szxnJTq0Ql1UrBCYhak+InqLHqCCh9aE8LGkybyiZsg
         ZTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNDRfDUc5B5dOE0UJY7Uqm8EjHLoVo8OnG0ay7lnNC0=;
        b=llD+EePh9zip8Anq2bUQH0m3m+58HrIwbddFjoNT108pDvTknTgF/rDlcqs/LJsWfh
         o52lyY/PQE+9q2oFCueanTH+qy2mEM+RZwustl2UyoqAubeFKbmzqHqdlY11T+JGEmOp
         aioHNmPizDdwNlh6/58b860LDVowjYs/Q4RqVCJL9NO1Dd1i8bO2RUoH+Za/VsMBXqB6
         Y2VgmA5zbV10o7bcZ+PfHxZDDUvX8M3FnGUYy+DCiLtk6tB7Fs49I5g/KUyWXN2z1UU4
         /a7/rSiSV85MngJbmcCwkdZsTTtBiCWFFjziIrRmUoDmBpWtRi7/n/mbEIyjNBf+gUs5
         6E6g==
X-Gm-Message-State: ANoB5pnkoLfqGdBCbfWgv0FwBnfCW3IWC9f6o+ZHwmXw6rcKhB+RO9gr
	RJCQgGkfbKUC4EBFYNrISVQ=
X-Google-Smtp-Source: AA0mqf6i4MRN4ivlIxnxDNXX/OjQhT9ptIkxoaLrRIulo6BUy5Eh5+fcLTtVPg55mcSZXI6jEKqR6w==
X-Received: by 2002:a05:6a00:4390:b0:576:81a:4da2 with SMTP id bt16-20020a056a00439000b00576081a4da2mr35796213pfb.20.1671095727478;
        Thu, 15 Dec 2022 01:15:27 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id k4-20020a628404000000b00576d4c45a22sm1254772pfd.147.2022.12.15.01.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:15:27 -0800 (PST)
Message-ID: <073b3c26-8246-d585-86bb-eb87339e5c6f@gmail.com>
Date: Thu, 15 Dec 2022 18:15:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, jfhart085@gmail.com
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <20221215090941.GA5062@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_011530_283617_42D18477 
X-CRM114-Status: GOOD (  14.52  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/15/22 6:09 PM, Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 06:07:32PM +0900, J. Hart wrote:
>> My apologies....I am not sure what is meant by "stay DMAs".  Is there
>> something I can look for here ?
> 
> I mean stray, sorry.  There isn't really anything you can look for.
> Either it really is a device problem, in which case the IOMMU should
> catch it.  Or it is a kernel problem somewhere, in which case
> CONFIG_KASAN would catch.  So maybe enable that as well, but it will
> slow down the kernel a LOT.

Understood...  I will enable the following and do the test right away :

CONFIG_NVME_VERBOSE_ERRORS
CONFIG_INTEL_IOMMU
CONFIG_INTEL_IOMMU_DEFAULT

J. Hart


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E62FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eSAZNwrioyWP+UR9yyaMFD7JpZ37HjCWD71pct7eL0s=; b=fZ8Lj/B03/4Ln8jWoQuTxkoRux
	gqT+iNifJZ9imsQ3k/xpirUHBxCqJIsx8A9PSTtS2au2tr3va1VN3kXWd3S4o0g9Kj81QZyHnMPyu
	ApPK2UZ1LLweONdKwBiL3jpeh8RJjeuV0XFM8f7KeVsrBhzHF529AZKUHYH4DP8jjV8xGXli/BUcC
	58Y9t+4grtfWL7kZQY3I3cm5tjfUFWrxzkh4nBhHhi3+muLrbmcI6ctURc8maMredicBqmentZquQ
	5TK4UKGSv10w/9B65adiATnsJK4mFvD27OQBCJlqiRlCy+3YcovFI1KTd/Hmr2CDfor5dHIJTSPPj
	ftw7HTmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms1mG-004ySw-Ot; Tue, 30 Nov 2021 11:58:28 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms1mD-004yPD-7I
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 11:58:27 +0000
Received: from [192.168.0.2] (ip5f5aeac2.dynamic.kabel-deutschland.de
 [95.90.234.194])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C59D61E5FE00;
 Tue, 30 Nov 2021 12:58:11 +0100 (CET)
Message-ID: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
Date: Tue, 30 Nov 2021 12:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: linux-raid@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-accelerators@lists.ozlabs.org, 
 linux-nvme@lists.infradead.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_035825_465298_6E439859 
X-CRM114-Status: GOOD (  11.55  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Dear Linux folks,


I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 
card and software to use the card for RAID calculations.

> GRAID SupremeRAID works by installing a virtual NVMe controller onto
> the operating system and integrating a PCIe device into the system
> equipped with a high-performance AI processor to handle all RAID
> operations of the virtual NVMe controller

According to the review *GRAID SupremeRAID SR-1000 Review* [2] it 
performs quite well. I couldn’t find any driver files online.

Now I am wondering, why a graphics card seems to help so much. What 
operations are there, modern CPUs cannot keep up with?

If GPUs are that much better, are people already working on a FLOSS 
solution for the Linux kernel, so people can “just” plug in a graphics 
card to increase the speed?

Does the Linux kernel already have an API to offload calculations to 
accelerator cards, so it’s basically plug and play (with AMD graphics 
cards for example using HSA/KFD)? Entropy sources, like the ChaosKey 
[3], work like that. If not, would the implementation go under `lib/raid6`?


Kind regards,

Paul


[1]: 
https://www.graidtech.com/post/graid-reveals-the-next-generation-of-enterprise-data-protection-nvme-ssds
[2]: https://www.storagereview.com/review/graid-supremeraid-sr-1000-review
[3]: https://altusmetrum.org/ChaosKey/


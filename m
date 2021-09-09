Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:02:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A08861101
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A08861101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sr5uZ/8BFQFMHMTNpsvK4bJ9XCJBhtqK1+8IJ0WIl7E=; b=URK+AFdFx5o2GaBbnXvSQKjHz8
	isxqRwbX5vVIs8Sy7ZCuaAJU2WarHLzhltmU3NxtNK9aDTklqRW6axyyrqmircks/kC3jfaqW7Wsa
	C83cb1wXjFzWkF4qaANAKYtzTx/w5q7fbON1DUrZnlSZIQo7O+YwNSfU2bS1CEaSLrxacAiA6ARxK
	kidp0VjnoHw1mxD6/miKlm6RfZ2aoIYITu1yRm6l0yHqY1PZsd/HXz8IRLxdAk/8hVdBFmK7AhmTA
	GKUYeqirNs1B0sMNbZtDapwSrAC8batpxf+S33qHuKwRpLEMrQVe5u8LZkfuXu73L1cBQ93uqM1j7
	ZGdbBXng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOF0P-008WL1-0Y; Thu, 09 Sep 2021 08:01:57 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOF0L-008WK1-VN
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 08:01:55 +0000
Received: by mail-ed1-f54.google.com with SMTP id 9so1435411edx.11
 for <linux-nvme@lists.infradead.org>; Thu, 09 Sep 2021 01:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pxniV/MCbL+TaosaTUyfIk9UPkHwQWCyVmyp9DfrHEI=;
 b=MGMHoPj2wzYGwxytpOCT3kSLiXlCmMeDrkSm/vUQ87HB+dGPk3fWigJ92tubQeerav
 lTJ8mRxmHk05m5J4T5kX7aruwIPhDksJEXLzhwAxNbm5lggs8HseTsK/GiPMjIBbbss6
 3Fv/0tleDNsRerGzuuHHih2jVYSBi/utySj+w6lovAB7VxbrCghUUFFR+f/gqREyPFON
 vHQWZXKYBX6reBiVs2a72Eawl47HopZe1J1w26sLstNIkOi2TBPZz6qJPEOOmPUt/IHL
 1FXhmKRgwJj/MGY16xktVy8LJg4xR8ttwU7orLLQRn490sAKQC2ADqkTYd3r0rlbp1zw
 EFCQ==
X-Gm-Message-State: AOAM533ZdmE3VEx7TSfOEQEqgaGnLBUoLJB5mDwZPvJe3Ty0xBdiYody
 dLmYsJiBfWUA1WdXFBh5Jy4uygLNmbo=
X-Google-Smtp-Source: ABdhPJxzyq+1KP69gHSGu0a+Zt1l6N3IXZ6N+nLTkOPDilcJk+Gt+sl3x2Bc4lATkzWhhv2YfG32KA==
X-Received: by 2002:a50:cb8b:: with SMTP id k11mr1860359edi.256.1631174511885; 
 Thu, 09 Sep 2021 01:01:51 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id i6sm478052ejd.57.2021.09.09.01.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 01:01:51 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
Cc: Samuel Jones <sjones@kalrayinc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
Message-ID: <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
Date: Thu, 9 Sep 2021 11:01:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_010154_068556_ECD89C1D 
X-CRM114-Status: GOOD (  11.97  )
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


>>> Sam, can you run some more extensive I/O testing with this (different
>>> patterns of r/w and block sizes)? Also Keith, can you ask the WD folks
>>> to also take it for a spin?
>>
>> Sure, I'll request this patch for their next test cycle.
> 
> Great.

Keith, can you send a proper patch with a Fixes: tag and a descriptive
title so this can go to stable.

And let's wait for Sam to do some more extensive testing. Ideally we can
also hear from the WD folks that this doesn't cause any regressions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

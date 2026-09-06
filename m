Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F8BC79F85
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YP1h4y/PRnardglovAMz5SsMYiFLto5iI85c6XOqdAE=; b=zwoRuycA3KrFl7pefAZqp7HneL
	9m8VslPO/rEccW/IiGNJMBklpf0uk5A5H5S3GmICm+xH+0XAKXahU7uPpPL0fKj9MdkviFOFzt8aq
	r/YpqVZWfChx3wCca4Yete8m6sqUR0bu0gJxOeo3AXWqwgX44r0Av53Zh86u28nr5PcMlQBe1C2Gl
	E2mlP3nz0XJv6ez6Xw4z1pgJu5xlj2kpmmAZ7mzorBDSorpGzJVdKsbUvwUaZ078iGJrJ6IBKJN67
	1cC3Hv2C8qE+QfC6KrcBOZAYwefdwkfEwPd06rU7jGon5A7Z/rAVS/WkQ1flvM7U08/a2zeJSJ5c8
	3EDsia9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30Rj-00000004VIb-3v55;
	Sun, 06 Sep 2026 00:09:19 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30Rh-00000004VIE-3moy
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:09:18 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso20033295e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788653356; x=1789258156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YP1h4y/PRnardglovAMz5SsMYiFLto5iI85c6XOqdAE=;
        b=Efe0939ahL064dp36IM36ia3uIRIfld0c/XlVdNl8G13MNGRlPOUNlR+tn8ZTpYaGp
         Rl9/81WeyJzKy2CFIXAn5sHXiM1WlofsDqqdB7bxfftVtkezukywpLlkqKSPyq+aDhoa
         RL5ts/p4GnrNDVm+vImFg+MB7SVVXKi4DDQiG9vD9oCgBGkYkaPIUyhzfHXFSakHuyLf
         /stkfiI5bWyxsgD3c4ZDOoCKRxfsvKArR48TbtJWeJ7diHsmAGpZee0qIFk6YnmHtVe0
         MUh5hn5cES5AJ4TkA/MpLo/xr0xVz3muIRRAXHEV3KB6XgsKlEVnSSBSaGVqduRoidyg
         lIQQ==
X-Gm-Message-State: AFuF++lwuRaGj3N0j/L5YB1tVtiHsJMOpNkCIpLnhD1mBuKhbUz3TLD+
	YWIHsUDTvd2cW8OnXSV2sejzDeCoQkAi7bDxp966fGJ5+uePNtF9ou9y
X-Gm-Gg: AYBFou35jxzl+j9k2R1nchAWdRXOH7TbNHBgJyMXnq6axxo/K+x0D5EDS4/b/aBdd6i
	M4yJG5vyPkME51EcSoQxFi7T0dFR7aQXjQaE43DU+i7VT6seK3qoxYCDNJ4IllCY8HUm6FJbs/t
	jEXog7MYzFNO0n8VOI+hwJMFArOB+EVvxW5raCDNBSsRPJpPCNST0J/hIGaWfmgD36+gIm0zXl4
	Qnh4ssW62mOG5KpJ1OwzsxCFI60Q99Oku2zCgA8SIVnv20SpEY0E4mAv4g2x8xp7AVfdzMdD+i1
	OqcZ/btpH3mSk8L3QCdCCd4ThQPD2iOSXtc8jNuorLm5magNTMygALmuTwMSJE698bu4Qdl0509
	j6tXizCZl/0n/hkeGiYVn6G6izcV981bwVHvBlhH2hztCrYunVvhCG2gwdzyslD5BAoT6D6XlML
	bAm16YsRv/aamvrmIEC5OZxzjw4M+Q+ZX1qP9LfyTTFTpwEpoNx9xpOT2IGuvDMKAopCHJifCx8
	P6B+tVB6KS/VUA/99WsnQ==
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr165210135e9.11.1788653355982;
        Sat, 05 Sep 2026 17:09:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm251955455e9.5.2026.09.05.17.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:09:15 -0700 (PDT)
Message-ID: <f6fc10fd-4e45-4127-b43f-51e66e15f347@grimberg.me>
Date: Sun, 6 Sep 2026 03:09:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme: add per request retry timer
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-4-sagi@grimberg.me> <20260902134156.GC21649@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902134156.GC21649@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_170917_950873_16A0E618 
X-CRM114-Status: GOOD (  11.49  )
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



On 02/09/2026 16:41, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 11:48:59AM +0300, Sagi Grimberg wrote:
>> The existing command retry mechanism adds a request to retry
>> to a retry list and modifies a request-queue (controller) wide
>> dealyed queue timer.
>>
>> The issue is that the existing requests in this queue may wait
>> for longer periods of time as more requests are completed with
>> a retry crd level.
>>
>> Instead, add a per-request timer that will allow different
>> requests retry in a way that is independent of other requests.
> This blows every nvme_request.  I think we'd only need a per-CRD
> level retry list and timer, can't we do that instead?

I can't see how, because we'd be modifying the timer potentially 
indefinitely while
requests are pending....

I understand that this bloats the nvme_request, however this is not 
accessed in the hot path.


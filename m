Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B562C624DB
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4f/wqsEFkXo6lNZQCovPmC1mk05/C/5bZs0p3Kb9bo=; b=wSpqYioKeWqCFAhDXSfYMNwN0z
	89N/aP+zm997O5TshjENRO22hUnN8vlbGNI9CdblUFzsgsAyRBH2aQ95glTXJk8+CvHX+sdKi5/LE
	Ic8Z3l4YTmYCmaEkDoJUQfrnbT3dhngBuAxsEVpu7Q+8+uSb7TH5ueVamwOANlJbOocHz03o1FPrZ
	K5gQAJlkQjdMAHKe3HCmA8YZKUQBjIytNokByutYXlHIbRqb8uAYPpvtQKBJsSb65EtrVnzMZ93Rd
	qhGUit007D7bHMFrhMMkpQiu7+0tyVT5xqMLZG/DREhFlz8ltEtlq1CQ/z8yYi7kAklIsdPStIA6t
	2RI3McVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30QL-00000004VDx-2ywU;
	Sun, 06 Sep 2026 00:07:53 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30QI-00000004VDd-2FQG
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:07:51 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so745725e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788653268; x=1789258068;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4f/wqsEFkXo6lNZQCovPmC1mk05/C/5bZs0p3Kb9bo=;
        b=OJp/bZZYNSz1oM51fACefu39rcCXTlNS6xDYIQ/pum0QB7fjJ8LFC9YEjS1sgOVJ7A
         EBf0EM72PhLiKWNT2FXCaFElNB4r1J4P+/tBIbybKHYw5aAGRBi1thOfiaKk0Q6KsHWz
         MZvl5pkz3hoWfCnme/epkBhr/7W8ha8NJTsfBwo4ducHM2cEy3kJq9cMO338PiJpHAQm
         nSS+WBomOkAnqtO+4xBKSf3jH4xnbY7qnve93p6b3df3E++KgRpp5B28FP5a4aEGjHpb
         y/pKdfRfdXjmYcHKAyq62eTOFWmhXi5UcCEYWriWVFfATXyhGz3wim6M5llvmx0mVQqN
         HojQ==
X-Gm-Message-State: AFuF++k0YaWVp9s7K1alA5ObWh9i908GoJVJvPHPxZkocmzyJ+4VR1wb
	gcUz6AsSB0H0JsInlukrZqwq6z98i7+pQ6g+I+6jOYFVmmXIND6gM1XJ
X-Gm-Gg: AYBFou3Rqa9qfK5jdAZJvX5A3vkf/mfylFqKQ2eeQ+pWa8EnyzMr9B4CEWe4XOD7rlc
	1ioCEGj1xOGb+61y9fMB9KIeifB2wJnxlRYRmb2JR28aQCDNa1pT14+qHfjMZdtuBuMj85/0ern
	yxBHRbyYLD+YrFpB+EK8asmoRGNOjV4wo1bm2ORljfBD+Qmd5zwSjde0c0BZMOzJMDfSFLGbEeK
	xA4JGkP6pxrT3p7GE1mgE9QxugZeSdqTSel8jDP/RWIiNfcHSpPCZCzavtefoCrjxCiYG3uRPxE
	KCS7bnR/5dzYG6GECHKLF6+o9/5E5KkSy+4fsBEhPx7hC5tbpRqr7ZFYrO8HRHhE8reblrxZyk/
	4CIceele/IzE9+XaTmo2pKg5VWFhFzSHlVmu+qYu/C22sJcX4Zz7k4AVuUeLJY8WG2WtYP8M3Dv
	39QNq7MZ6nitZ1OJdlig5J6j2klwtHScyZGVu+SxexDXPXWvQd8IpcM0B0SIU+qKxVppuGeEWsq
	NlcEQs0etAb27lgBmDPkKLx7q2XBDvu
X-Received: by 2002:a05:600d:6451:10b0:49c:fa21:1c8c with SMTP id 5b1f17b1804b1-49cfa211d1amr86753735e9.33.1788653268386;
        Sat, 05 Sep 2026 17:07:48 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm615709365e9.0.2026.09.05.17.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:07:47 -0700 (PDT)
Message-ID: <ab00425d-40cc-4a38-b9d1-a20617abe2b9@grimberg.me>
Date: Sun, 6 Sep 2026 03:07:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme: add nvme_crd_msecs helper
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-3-sagi@grimberg.me> <20260902134056.GB21649@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902134056.GB21649@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_170750_589121_83A8AFB6 
X-CRM114-Status: GOOD (  12.25  )
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



On 02/09/2026 16:40, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 11:48:58AM +0300, Sagi Grimberg wrote:
>> Hide the details of extracting the crd value. We'll need it from other
>> call-sites.
> Even without users splitting it out really helps readability..
>
>> +	/* The mask and shift result must be <= 3 */
> While this is copied from the previous version I have no idea what it is
> supposed to mean.

I can remove it


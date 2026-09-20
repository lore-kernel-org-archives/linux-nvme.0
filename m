Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6366CC982D7
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4GFj4J8ypslj10TH25kaGDQ7udCjMYsFwXga2RcQ4o=; b=mK+w7JQ6IK9DeUUGDeOrP6tDDn
	v+XkFZmoJQCSWcewDVqgaX8G8h4Q9KVT/9FUtHBZhOT8f8UyIa8xU4VfVMxEUvVwwozhwintZn2AR
	o4tyelCjPFLD+hYOuAe40cu9uy65a65yJS+LXBB3c+VPG+9BbxpwdRf1LS9pYUDS+H0gflH/V3P8k
	xyApX5YqSe54IM3ya83WA/rWOF5PKb9QmJROo71Zcbpn2rrdmDx+OmMvfBmIUB2XWx0Bj986jXVjx
	TFB6cWSwklVE8cgX1fuutJ1tjTTkBijt1tICHSdxhq15YMcDATtFOmLbHpsCSWNoREmxst7DvpbDY
	bZnpDZAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x86o8-0000000GkLj-0YEj;
	Sun, 20 Sep 2026 01:57:32 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x86o4-0000000GkLB-3NAP
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 01:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789869443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T4GFj4J8ypslj10TH25kaGDQ7udCjMYsFwXga2RcQ4o=;
	b=EXAS3bVtUMFz3jXafihKCDq8bIYdoNmgBx/18/D8GlIBtnpx4Fs7nZIh9tIHL0a9xL4Fom1ZZRewR4zubhSx55E915tZiIqbySYvI13M19oqPRE6NV0/YMG/T+5qB7GIXiO1bkMoCYfhvk2X4fPDPeqkcgzwJACxx9XNoLXRjcw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBEfzJH_1789869438;
Received: from 30.178.84.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBEfzJH_1789869438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 09:57:19 +0800
Message-ID: <21195e00-8c7a-4c7c-b79c-011908c32179@linux.alibaba.com>
Date: Sun, 20 Sep 2026 09:57:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: return Invalid Field for invalid NSIDs in Set
 Features 82h
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20260918033932.3864965-1-kanie@linux.alibaba.com>
 <20260918033932.3864965-2-kanie@linux.alibaba.com>
 <20260918120511.GA16425@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260918120511.GA16425@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_185729_332620_B0AFCC86 
X-CRM114-Status: GOOD (  10.91  )
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



在 2026/9/18 20:05, Christoph Hellwig 写道:
> On Fri, Sep 18, 2026 at 11:39:31AM +0800, Guixin Liu wrote:
>> -		if (status)
>> +		if (status) {
>> +			/* 82h is Invalid Field for invalid NSIDs, not Invalid NS */
> Overly long line, but I don't this comment is very helpful as-is anyway.
> For one mentioning the value while the code uses symbolic names is
> confusing, but otherwise it also doesn't really say why we care.
> IMHO we can just drop it?
Yeah, sure, removed in v2.
>
>> +			if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
> no need for the braces.
Sure.
>
>> +				status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> Another overly long line.  Easily fixed by just directly returning:
>
> 				return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
Changed in v2, and also in patch2, thanks.

Best Regards,
Guixin Liu



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE7C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cv3vtLdUS09kTNNnBs4MuLKd62tQgNwM4cvWFitH2jw=; b=vK1zuhuQdC6gSBMHxwmhW7Vziq
	mFmtAAh6nQk94oQOgclM+1GHGveqj+pg4vaNgfFs9Q3714/191Qf9uHdqzwYoCwAvrlfiz8y8IHrA
	SieYrNbwyBYbmi1fueS1vpTDNCY7jzwobEp8QULQ9MHRJ1I2MKPLVkoIw/CpQ8hudeXHmZ4HgbKwf
	4fYFSvrRmngNSg74pdBQPGwkRj6N+FVWRTEpB5RM/h+/57hfduqHhjeTxMCa23/jZuHMxuoUekNtw
	KmWl6uOAoV8pW4dt525kd+yTTjSj4W3vVnfcArrSbh/7hEnIUdCfMxehyygjvhGJPlCJ9VxBsWOYj
	/7g+1Lpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxyT-00000009gMG-3ebS;
	Fri, 31 May 2024 08:50:57 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxyP-00000009gIE-3rZR
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 08:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717145445; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Cv3vtLdUS09kTNNnBs4MuLKd62tQgNwM4cvWFitH2jw=;
	b=N1JHt+FEjYZaqGUcSmRgkep3UNUK+Zk9UpypxdxGVvsOMBJQ1jcETUBNYTOTrYZNLwAWOL+l/M00al9RNDnb/trm5q2wtDzlwoAHQHBFVSVoin9MogdLnElDm3mFLpyeZ7p/2v5j1pSoG2KLMtVRreCzrRT/K/KnfTxMhlkkkjM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7ZLlu6_1717145441;
Received: from U-4C66YGPR-1953.local(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7ZLlu6_1717145441)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 16:50:43 +0800
Date: Fri, 31 May 2024 16:50:41 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2] nvme: fix nvme_pr_* status code parsing
Message-ID: <ZlmPYZM9_mFypfhD@U-4C66YGPR-1953.local>
References: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
 <20240531081650.GA19765@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531081650.GA19765@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_015054_441071_D133D012 
X-CRM114-Status: GOOD (  10.86  )
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

On Fri, May 31, 2024 at 10:16:50AM +0200, Christoph Hellwig wrote:
> On Thu, May 30, 2024 at 02:16:46PM +0800, Weiwen Hu wrote:
> > +	switch (nvme_sc & 0x7ff) {
> 
> Can you use the opportunity to add a NVME_SC_MASK symbolic
> name for the magic 0x7ff?  We should have done this earlier
> with already 5 occurrences, but better now than never.

I've already sent this in the previous patch:
[PATCH 2/3] nvme: fix status magic numbers

I chose the name NVME_SCT_SC_MASK to match the NVMe spec better


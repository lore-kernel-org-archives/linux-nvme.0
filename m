Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4012C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 06:17:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AAB20786
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 06:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W6AfrPL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AAB20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qL4idRFJ+T7gwrXy96rjjf1wDS/uN0MNzxITcKk6q/g=; b=W6AfrPL/FgwpmlXSOBC/7F+21r
	AX25A6aLtBN3SqmDm9Q+UFxvIeGaeTLfjXbwkkZgYigleRslkKElx/1vm2E5kl51btfg+TRqgmHs/
	ObD0db7LOutVLxxj/XhW0JXk2Npb0IvxYMmT97cZ5DXfqFT2vdczMzB9VW9r0pSbVfyhVvZg1ZueY
	QNd7fY8Hr1zP+uXobvgMFyFd/hK4cBXSFuKHgCAR5YOfeWUg1rEaUCq1a7vHKKKHTp+YYR6v+aYGF
	9W8r5s+w2qu4OhQ8qSzkiPVL8RlU7HdZeiZkShRNHSAelegeO0pJ3aPmcTBbXpinVt4m1ahf42Jcg
	NICnm/Uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jt3Of-0002J8-Qb; Wed, 08 Jul 2020 06:17:34 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jt3Oa-0002Hf-K3
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 06:17:31 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U25UIeZ_1594189040; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U25UIeZ_1594189040) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 08 Jul 2020 14:17:20 +0800
Date: Wed, 8 Jul 2020 14:17:20 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: use standard block status symbolic names to
 check return value
Message-ID: <20200708061720.GB69823@VM20190228-100.tbsite.net>
References: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
 <20200708050900.GA3831@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708050900.GA3831@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_021729_623211_4BBB5DC9 
X-CRM114-Status: GOOD (  13.21  )
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 08, 2020 at 07:09:00AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 10:18:01AM +0800, Baolin Wang wrote:
> > It's better to use the same symbol as the return to check return value,
> > and will always work in the unlikely event that the defines are reordered.
> > 
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> I'm really not sure this is worth it.  When designing the blk_status_t
> type keeping 0 as was a deliberate design decision.

OK. But there are some places use the BLK_STS_OK to validate, and some
places not in this driver, so I think we should keep code consistent?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E429C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQ8Ojma+yInShcILYo+mLtzhqnSh9bMS9txCFbqe7Rc=; b=RTlIUEgOvgyxJu1Hs71r6i8Ngm
	0pdMST16Gh4aFEznMQnOESX8WGO3RmH19ArBka8piOc13dCTbQnP2txcUxiasXulLAOHocO+4n5qd
	srfwv+z52fwDMnAIhnJ2z7iHH2KfULbk2urVX+pjde1qDwHXb0Xga/mK2DFx69X7W1vbAZn/dU0FR
	v1asHstEoPg9hbnEIKxeuU0iWSC+l2uDpCiQ8JBNzJ0vkS1Krmm6IlW5APjRM983i6AVhYr+n23bI
	IFFVsxfAyWslTf0H9rSJ+IFU23T4U76ux8V5mSrji28fODPH0Fnh1A7n8GAttD+jeaZEHiZLiIAJb
	ufTRds1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nadX2-008pgY-Id; Sat, 02 Apr 2022 13:11:08 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nadWr-008pe4-7W; Sat, 02 Apr 2022 13:10:58 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 330645C010D;
 Sat,  2 Apr 2022 09:10:56 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=uQ8Ojma+yInShcILYo+mLtzhqnSh9b
 MS9txCFbqe7Rc=; b=Rx5AiT285BmD1NR36x2quZ4Ky5uw+aXPrUGeGyuyrDbZ39
 +e5MovBblY6YxBESEc/SCOB6CnzI0H0J90R7jF9gqGbRpu6o9mm49ua5cALpaUh2
 kWaacSt25ocKa6j4a4UVQruq1AwCnSxBD82X3wseqIhzG28iTjMcCLkNbvcQwp0Q
 dqQuXOpOtkvfMkyPWGAntmZEvDy9uXXCRGLMtefF5cgmj0LvB/SUQ5RMx2u96Q+A
 GywHPDtrYTHEVTbvfBB9WhdlzpnRNtxul7oK+3bSZRof/JFGEwBAGAYPO/D5RURT
 jhWpYPnmElgCs131EyFzKi8MV+/0ih/fYewQRYzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uQ8Ojma+yInShcILY
 o+mLtzhqnSh9bMS9txCFbqe7Rc=; b=DaHEwqIsdFgckFEc4sCL/Or4XueRC6gxn
 dVUvg1XIqmUZ+IyeTF4lZfREgZWi17+XK7O1on5FGWeg8PeCXAW9w4WDYRq1Pg5J
 SKsiUPmPrRKgI05z/ws7vJ5ybxX47DtlVik2JmaUeLeQRlyiFL85ECmqhO8hf+O0
 u/Uumfl+D1WbAmvFd7CQigfp4HaJnqfrqIhTwoWLhxDK7wFo6K4voHp8AWpbtvvl
 mSnfXXsev8lxDj8H3aCg6ialNx5118+9ov0mFboVuw7/GvusoFxTZ4kyrxR72BqK
 zmijXvFtNaaRjwKIcxIG52mGAztePeaNYepF/5KuSQgr42Azm2H8A==
X-ME-Sender: <xms:X0tIYvrG13BUSK4hwe3b_ZI8h2EViVGgvOcNzsFka7OEgafNOCYkNA>
 <xme:X0tIYppwEmso6_-_BQdcInOq2mnXAn_NYhOQxiB-bU4Z1oy9vbr9_hifLSvk1MzTV
 qZwa33LB4XZaXmfS44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgieefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:X0tIYsOlXHn_Xrx1iu-WHxRG2mghS1-75TzsPPe0lkylO7GyLyt8Jg>
 <xmx:X0tIYi4yBxgV9poVLrsmT6AKQroVAJQb-FJUA-CoRUXfCRi576mIcA>
 <xmx:X0tIYu510RQjuDBzFjI2HXcnzyTARyLHsVI4EGxqFdyIFCCCzqU0Eg>
 <xmx:YEtIYrxfWSxCPA1pw8FlUdD8AV2DP-ie6vxMmHuFSAArD803Rd7JRw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9E07027404A0; Sat,  2 Apr 2022 09:10:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <96fcc1ec-888a-4ff2-a41b-8cc352d4f2b1@www.fastmail.com>
In-Reply-To: <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
Date: Sat, 02 Apr 2022 15:10:34 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_061057_388056_A0ED21A8 
X-CRM114-Status: GOOD (  14.50  )
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

On Mon, Mar 21, 2022, at 18:01, Keith Busch wrote:
> On Mon, Mar 21, 2022 at 05:50:46PM +0100, Sven Peter wrote:
>> +static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>> +			       struct io_comp_batch *iob)
>> +{
>> +	bool found = false;
>> +
>> +	while (apple_nvme_cqe_pending(q)) {
>> +		found = true;
>> +
>> +		/*
>> +		 * load-load control dependency between phase and the rest of
>> +		 * the cqe requires a full read memory barrier
>> +		 */
>> +		dma_rmb();
>> +		apple_nvme_handle_cqe(q, iob, q->cq_head);
>> +		apple_nvme_update_cq_head(q);
>> +	}
>> +
>> +	if (found)
>> +		writel_relaxed(q->cq_head, q->cq_db);
>
> Doesn't a relaxed write mean that a subsequent write can bypass the previous?
> If so, that sounds like it can corrupt the cq head.

No, writel_relaxed just means there's no synchronization barrier for writes to
normal memory and that those could bypass the store to device memory and only
become visible later.
The underlying memory (q->cq_db) is still mapped as Device-nGnRnE which prevents
reordering of writes to the same endpoint such that the N-th CQ update is still
guaranteed to be visible to the device before the N+1-th CQ update.

I'll either add a comment why it's okay to use _relaxed here or just use writel
instead since there doesn't seem to be any performance difference.



Sven


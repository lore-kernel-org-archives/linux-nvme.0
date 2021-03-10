Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34106C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:00:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21A964FB3
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21A964FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BTqp/qGDZuEqSdXGQjvqBkAUpBG4cNwsseBn+QwqZtM=; b=mEMlapC+QARWzUbH+2rZy4/+C
	Ner5A/N0RsP6LWFGbAwOCi8XRcDAP5tUw6pxIQV5OtQ51p3qY+upqluSKu0mf2g+SzFFH3lvAOZ9w
	B4XmO1UNjNBd7gsuC2X6GVWXmUZV4ZWW/WiA1Np/8ocqpMnTt28rZSu8FalrnKz7KlmJA2JuedK02
	Glx82aJA4dxhal9vVpB9qQ1lVeP4ak9V6LUvz3xbSY/Vyp10EW323JZd1YtKz17w/esbayx0TzTPh
	C92HEg0ttsE6IHRrCC+NQ+Bw1SoTHpHN/lkMYTk1EE2bXcJn2/SknjmFliCueqIUOuun8D1Oyp0qu
	TVA9CyJQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lK50a-007dxY-77; Wed, 10 Mar 2021 20:00:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lK50U-007dxD-96
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 20:00:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D34964FB3;
 Wed, 10 Mar 2021 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615406432;
 bh=pVgQV4hgVAutwj1GryhZ9nxWErZLYiahMjlWWHBGa4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c/5yve2vuxSJ9sf+pnPtdB8dNt8V91hiJIZOyG8lICUzUa8ivNp0nsSPZPx7Swimq
 9nTVe34G11TZluYs8zWG2jK51uwTkjWT1lS3A7fPjOy6F01X2hxQngSFXe6na83eMh
 l9ax8htkr+0viTrdSkd2RTZeZr/w24U9ygHa8ubpKLJoEbtxMvgsUaW0bJV7pYyW6r
 nPz02aNgmdK3GYFfrFhA+5O6wvgnukYOr570eB1FvCArw2aFkIMQ/0IqSZ52zK50xY
 prW3NBiRWFRaVXhiO0lMI3yhC0hBqrlbhG61uzGh6SIV1+LNeRBE9B978+zrkcnDmu
 ARTRFU683c6Lw==
Date: Wed, 10 Mar 2021 12:00:30 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310134110.GA13063@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_200034_550173_C5AEDD74 
X-CRM114-Status: GOOD (  11.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> > Can you try this patch instead?
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
> 
> Actually, please try the patch below instead, it looks like our existing
> logic messes up the units:

This seems like a good opportunity to incorporate TP4040 for non-MDTS
command limits. I sent a proposal here

  http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html

And it defaults to your suggestion if the controller doesn't implement
the capability.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

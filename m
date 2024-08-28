Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2802C54E93
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHJJNtLGi09bnfsgHmNFjhdxvbLAnk7lz+tuyz0TCRw=; b=4JI0xPqAlQNTANxfH+6hZn7S8W
	FkiVyF03hjgXj9O9GXtFPpdmeJ/Pdq/9lHrnuc8Upuvd7/zdgQO39STNwdO7WXwJ/mD7gvIL1xNr3
	23yCqmp2yZJCpYJBYh+bzX4p8Ua5VzstBmbv8LOB8raAks1mrTQ3C4O7BuPSfVv5p0eqVkGeNZfuN
	XQD8tAoMr1WG9OXTYsGwH/xj6OF5snZtd8eIF/sUXlUlSUbikVylYsXbBedobGA5b/oQAZkMlWBwb
	0WLtt0WyoeiNmrTgZ7wFqBZ4TlFcJwXpOOKuHlWk3oLP1esIatJZCtE4qGUx80T7Mvyyw/1BDynCg
	NS+TgXBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjFvV-0000000ExMJ-3UuP;
	Wed, 28 Aug 2024 10:29:21 +0000
Received: from mout-p-101.mailbox.org ([80.241.56.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjFuE-0000000Ex2b-3LEa
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 10:28:05 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wv0wr6X8lz9tHb;
	Wed, 28 Aug 2024 12:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724840876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHJJNtLGi09bnfsgHmNFjhdxvbLAnk7lz+tuyz0TCRw=;
	b=tJvJH7YEoN2ul4yhYxdAEQSykAoV8j03onoaVRaxus5rozfftSQHSlddDvsX+CbZYLlKNX
	YI4FoDGEyi+sG+QCybXxZTUdvgaAmv9tXc7BwRYfwllc9AtGPJFE8iZANKX0rZ1mwmr1iX
	fqP0obbff/3u9P+tDu9XhbnbN9pR5R1ptOSUijCiFst5RNF5vUN6zjR5Ha7HyFnwx5Rxxx
	hdYJ7+xsfhTGpV8lk78388El/ci0AT3l/tNrf1xS7/amboN4/E7kMo3vrH0mBxZoCdZ9G9
	D9vECapuaq0r8pIhJ9P40w/soo98OvofBLyk56kwWN4XW9j1qTF9zWgaaVg4xg==
Date: Wed, 28 Aug 2024 10:27:53 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM173X
Message-ID: <20240828102753.msxe2owymg42zwqp@quentin>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
 <20230321132604.GA14120@lst.de>
 <20230414051259.GA11464@lst.de>
 <CGME20230427074641eucas1p185bb564521b6c01366293d20970fdfe2@eucas1p1.samsung.com>
 <20230427073752.3e3spo2vgfxdfcv2@localhost>
 <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
X-Rspamd-Queue-Id: 4Wv0wr6X8lz9tHb
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_032803_032779_1D0D659A 
X-CRM114-Status: GOOD (  16.48  )
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

On Tue, Aug 27, 2024 at 07:08:15PM +0000, Saeed Mirzamohammadi wrote:
> Hi Pankaj/Samsung team,
> 
> Sorry for pulling up an old thread. Has this been fixed in the firmware? If not, we could fix this issue with quirk for now until it’s resolved on the firmware side.

Hi Saeed,
  As I said before, this was specifically requested by the customer. I
  would highly encourage you to get in touch with the firmware team in
  Samsung.

  So I still don't think this should go as a generic quirk.

<snip>

> >> Did this go anywhere?
> > We had a discussion about this internally with our firmware team, and it
> > looks like these firmware were given to specific customers based on
> > mutual agreement. They are already in discussion with our firmware team
> > regarding this.
> > 
> > I don't think this should go into as a generic quirk in Linux for these
> > models.
> 

-- 
Pankaj Raghav


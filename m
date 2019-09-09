Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A79C4360D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:36:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062312067B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KzEhuyYm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1g871uDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062312067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62ZBJMDZdx9yRUeqp5jmnzH5KkmhCP0K+B7vNKFaWw8=; b=KzEhuyYmtndwDn
	sgqNu/CgAXDceXmgUD1cglnsM9F84FY5XgznDKUDoQOWISspwFZtY0I2DzedlJRoPzZ6IeJsTke84
	IVFDvqbLRM5DhzE6ejzA4BtWgaay/XrxvCq6JHNSKoElnaYuXGMAKgbXfWcpCmOi+kvekUgoZEEY3
	0rDoTbLOOwo1gXsVz1+94uQU2canvd4SPMbw845F74jxmELwRyp9nYb8ONERaPaIl/Jc5WituvrXL
	2F9MAi1ea4AK1sfWDNFNrZBPsQc7JPYJgYBBm0y6UwCPJxcLCBx1XeBdUEb1rSQsmdjl76S1NvpCb
	pmlHjJF9P5ixyZTVA6vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i79XF-0002sj-Td; Mon, 09 Sep 2019 02:36:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i79XD-0002sC-LH
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 02:36:08 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20FFE2067B;
 Mon,  9 Sep 2019 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567996564;
 bh=M/1TbTP9mfOo3u50WkONGsi+kXptt+utDG37rlbXPAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1g871uDgcV/OZzDuwcu3tBLqjoHt9jNWbx/Zg3cNq9IdK02GlCbSwxxvlv3KgQVEF
 Dy+U4c+UP0sjbM/J/yKT2taiMTAsQXGwyQJ6yOZqp5DBcuDmXiSzAx3WCBGkOovufD
 6K6ZNzkiGmWMRUahUx605/Jo4twjP9v9ZZAgnA2s=
Date: Sun, 8 Sep 2019 20:36:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
Message-ID: <20190909023601.GA6772@keith-busch>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <1567956405-5585-2-git-send-email-maxg@mellanox.com>
 <yq1ftl6i4xx.fsf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1ftl6i4xx.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_193607_749991_7A2C17EC 
X-CRM114-Status: UNSURE (   7.31  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, keith.busch@intel.com,
 shlomin@mellanox.com, Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 08, 2019 at 10:22:50PM -0400, Martin K. Petersen wrote:
> 
> Max,
> 
> > Only type 1 and type 2 have a reference tag by definition.
> 
> DIX Type 0 needs remapping so this assertion is not correct.

At least for nvme, type 0 means you have meta data but not for protection
information, so remapping the place the where reference tag exists for
other PI types corrupts the metadata.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

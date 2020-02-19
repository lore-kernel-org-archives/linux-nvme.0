Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5BC34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAE120578
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dL/yQpfn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xuz6qxh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAE120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lk9L+rIpjDRYMbzCug9JRUCXq8lV6AB2zW/bKWcCBw8=; b=dL/yQpfnkQPPNo
	cGyTAUQZTTu2xrtmsRk248JpY70kmGrHTmkgemotIYoK82HCztHEPFA6ohJlHT0cCSvmTqYtXsOFr
	Omde2xhuzylE4doPgKLzJ5dIoFVG2X4TqVmCOReMlYV+W/aeOaMMJ5S2amJSv4C10aymeRXUwTzWC
	q/rtLrJxZl91RUvt5kA/YTokavDR5kAusN+MbHIl8C2/teWS3ql8MXuIxRevJQ0+nmtn0aXzuJhze
	L+5jU4uoimPokhRoIR3PvKwtgi1ULt4o28uZvZyYhWHacBGcW/P1kAkDLy/nuqheBOF2bfHfAvhmj
	P+m4+TqRnRg6BNdLf+SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4SRi-0000Qq-OJ; Wed, 19 Feb 2020 16:43:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4SRg-0000QN-4Q
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 16:43:33 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8564320578;
 Wed, 19 Feb 2020 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582130611;
 bh=wr0yFW67QtQyzf2hUSMh0CQ6vwfW7NMo5cW68Q/gVLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xuz6qxh6rtrbZsObx0exXYpbNyHPbNe9O3zrYsZDkYh4Glqd+QtqVWh2Bu2YcvOg1
 94KaeVqP8FY9KeIeH2icDGfuR2Bak5fn0Bh18uoRJwempIcKSOu2EluysGkkxsgfFE
 PIDf3dg1lamRXEtjBth5Yl7tfYt+Efev3gRA0Fso=
Date: Thu, 20 Feb 2020 01:43:26 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3] nvme: code cleanup nvme_identify_ns_desc()
Message-ID: <20200219164326.GA28509@redsun51.ssa.fujisawa.hgst.com>
References: <20200219161431.5025-1-chaitanya.kulkarni@wdc.com>
 <20200219162253.GB19584@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219162253.GB19584@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_084332_194083_DD06E71E 
X-CRM114-Status: UNSURE (   7.21  )
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
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

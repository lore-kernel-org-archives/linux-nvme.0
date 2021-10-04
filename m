Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2827C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 09:42:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9B16124B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 09:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF9B16124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0DPw+FoM5xnyjbomX9fupGaW7Oce6ZRkWY8GnOnl5yU=; b=l3AqVcxnXkA17z
	8nn1oRQl+LIyDUTXtoLeQ8FaFEyJoCMLui/gHq5BM4+XD+ix40JsDp1oIOvQIrhEq1/t74un7miKm
	GYKaXTbpP3MzEvM6o8NDckuiw/O/bMShJKUZcyHbRg/IpAEuOptsRtxDpL1IpbBKXmEt7eXnR0yhz
	KDVOnGznu07dDITJjhdFqv0sBu16Qh/gLoXB8mtxqwJC361OxPw9mIJ+EMV9teMxl3DUWk5hh1yGy
	Uup2ZSGfKjj1fQLzestnAFK/9/akSanQ3ORoIadMFQtcyu6hrtTzP/BzxEJb4ALVhPcqMfh0utiJY
	xIksn/kKpF8R7YHRN2FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXKUT-005oXR-3Q; Mon, 04 Oct 2021 09:42:33 +0000
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXKUQ-005oWc-4D
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 09:42:31 +0000
Received: from movement by movementarian.org with local (Exim 4.94)
 (envelope-from <levon@movementarian.org>)
 id 1mXKUO-0002A7-Ug; Mon, 04 Oct 2021 09:42:28 +0000
Date: Mon, 4 Oct 2021 09:42:28 +0000
From: John Levon <levon@movementarian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <YVrMhJGFMHa2DUHs@li1368-133.members.linode.com>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427235243.2268765-2-kbusch@kernel.org>
X-Url: http://www.movementarian.org/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_024230_196795_4C1C94B3 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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

On Mon, Apr 27, 2020 at 04:52:42PM -0700, Keith Busch wrote:

> And when this feature is in use, the specification requires all queue
> updates use this mechanism, so don't don't treat the admin queue
> differently.

Also came across this patch of yours. We were wondering why Linux isn't spec
compliant for the admin queues. But this would cause implementation difficulties
for a controller, right? Currently we presume that the admin queue's shadow
doorbells aren't valid, so always look at BAR0 location. It's unclear what we'd
do if this change were made in Linux, presuming we need to support older Linux
versions. Some hack that observes a non-zero shadow value and presumes the
admin queue is using shadow doorbells?

Thoughts?

thanks
john

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB7DC3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB58521739
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UjeVkI6K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2EXy8eYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB58521739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ObvYRuYl6Qfhj5GSyYLyS6/ClzPx2M0LW1UyDRXEYsE=; b=UjeVkI6KyxRhuX
	yPLu6ndPvUE6n2Oipm1sMyzFRXrPAVcTIXjP6/pWa0EcqNkKYiVGZGr9L11ZGlF5kjMnAAIz4YxTG
	Pu0ys00mnX1uGpr94DnuRV02HMW6jYn+MdMsxPlfWfheOkcEnCzwIztBzpbvc34DQlb8o2LpMA00B
	Pp9xjVg+/nj/e1qAxGsvTIOUNgnfDB4PdK9o2PG43GMP/Quu6TOas52HuQH+fgI2X8en/+QvjgZPY
	smMwaagrF9qbMJ0tzSCSoaqOZ2jiio3zzCfte5wFcdGyO0IlqN6Y3Rsyjyj7izfigPQTvRMI7A4X2
	mSOHux6+Ygr6oA3pFCng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8tRB-0001de-Ec; Mon, 02 Mar 2020 22:21:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8tR8-0001d3-Pj
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 22:21:19 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B5EC21739;
 Mon,  2 Mar 2020 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583187677;
 bh=GCgxYgerdCLp757cW6Ikc9Eitq/2B4t1HYw8pxaM6uM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2EXy8eYL3rEd74Jt3vvyGoMYZdTTzWK7kCOGAux9qua0PM5PoN/hv+/d/aWfJfQ4I
 K4B1o8ylbVG9mL4ELNQVEP7vO9GDj4cY+9C4kXkqw1nyi3B2CXEaZHlGZmdXIaQjN4
 eQLTFqnJObjI6qisxDb5sMp/r3MGOQopt+n5FiBs=
Date: Mon, 2 Mar 2020 14:21:15 -0800
From: Keith Busch <kbusch@kernel.org>
To: Rupesh Girase <rgirase@redhat.com>
Subject: Re: [PATCH v2] nvme: log additional message for controller status
Message-ID: <20200302222115.GB2393@dhcp-10-100-145-180.wdl.wdc.com>
References: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_142118_859999_E942CB71 
X-CRM114-Status: UNSURE (   7.57  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 27, 2020 at 10:15:26PM +0530, Rupesh Girase wrote:
> Log the controller status to know more about issue if it 
> lies within kernel nvme subsytem or controller is unhealthy.
> 
> Signed-off-by: Rupesh Girase <rgirase@redhat.com>

Applied with the reviews for 5.7, thank you.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

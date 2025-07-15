Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D46FC83F22
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qtreW2LyKC2Dhd3SemW57yZOP8ajlnN3h8EIcdfTXcU=; b=fG2txEeZ0bdLYyQSQ1h2IzppGn
	2+dm4XQHOuQxiSmSv0t2oAsV43EYxHaGobQv+A1XsCPgwj3ECCk08XD18p4MIG5cYW/sit2mChKtw
	CT3Ah2W9aBTBE3CNUuRjfy9hsSsjHMrDSKdqifK3amJFNqxcw05reNIXaq4kukyaKy+8dtS+Dffl4
	Yk8POULhip9g30cwaDlyFAmOpLOC41yjXo3/+nmZQvGaYevwUbX5VBGNkgNv/1f3qVDkTpwDK71HN
	NlAhnIHxqyRkZ7ZGlPrdTpkP3j/euM54yExQR4ixCGvuYwd+eirTpbd7xvNNCEjjqAhTKeP2yCeN+
	T63t9pKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubiNg-00000005j28-31c2;
	Tue, 15 Jul 2025 16:19:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubgoB-00000005PNJ-02ol
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 14:39:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A864843BA5;
	Tue, 15 Jul 2025 14:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EADBC4CEE3;
	Tue, 15 Jul 2025 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590342;
	bh=3O74ivTc0i0opeuSiZOTE1Lzi5hHTRWxf6PDv7DUa54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7/wf4DzMTyvi47Pp7zjEOq8DT3EQoVbaSa4C5vo7Iww8NSseYX3TV9ILjJpwDO30
	 H9CxlWY2Uyv00Tg7AJ9kZzpd4PkrFqceVs0fL8R/2WejZAHtwd/veCEoKOtrAc4JXM
	 rcAZo6gwe8TXcDiFD9wSvIuA7pvs7VONAIpgefDFrTwtgpCr2Yp2INYBc64hcYbjJS
	 uEAyizv2QNlMTOlhTim9q/JM3kwboOB6gdII67T+lgQh4Jo6mGUoF77hL9mh6lM+DY
	 S2nWeXvD5YoiTXWsWOimCDpmZ4XlRb97jNl+bXEmEeI2IH3YsGEvYZz/xP8IMxfali
	 pR2bBIPQzH/kg==
Date: Tue, 15 Jul 2025 08:39:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Number of data and admin queues in use
Message-ID: <aHZoBO9cPcRGIDwH@kbusch-mbp>
References: <aHW1qUJksE5Okflb@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHW1qUJksE5Okflb@glanzmann.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_073903_070493_6B4B387C 
X-CRM114-Status: GOOD (  10.13  )
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

On Tue, Jul 15, 2025 at 03:58:01AM +0200, Thomas Glanzmann wrote:
> I one heard that the Linux kernel allocates one queue per processor (core or
> hyperthread). I can see that using /proc/interrupts but only on physical
> devices, but not on NVME/TCP systems.

For PCI, the driver automatically handles the queue and interrupt setup,
and cpu assignment.

For TCP (and all fabrics transports), you have to specificy how many
connections you want to make ("nr_io_queues=X") when you're setting up
your initial fabrics connection.

If you want to see what you've ended up with, you can consult the
namespaces' sysfs entries:

How many IO queues are there:

  # ls -1 /sys/block/nvme0n1/mq/ | wc -l
  64

How large is each IO queue:

  # cat /sys/block/nvme0n1/queue/nr_requests
  1023


Return-Path: <SRS0=GEgN=O7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F3EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 18:01:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA39060C4A
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 18:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA39060C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IO5SbQcSdPYtoBqJJ96THw6tVNVjTksfzg0ehcbDirA=; b=cv7DXpeVo5CKuj
	lwuJxnyWGFHwTg1L7wZJcrmD6cQw6vXgRKNlxI8L1+WRqARzFta6omtMFgqBkX2801hJikXcQSkBM
	baGeyU9hL2StOOS8AvKXi7JMCkHHyA3fuuREjqnOun7VdFboj5odlSOJ7ABNIA1JsiM/7dXtbJLKH
	YmhrDIr2g6ko3srdBrUzoVYoKjvnPkPcgtYiGjrzicuESJzRWrkJzmx2BOQ8Aa51O/lBwxN3cQrDD
	SzWRQ+HkAvjpZgUbhaPcuIAyDs+PEhvOz7qob1SXvXtOlihD7bITwX50Qw4JLq6jbRbBUMOo3z+pL
	VLES3K7xQw+jZIihvbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZzbl-00AJvC-W4; Mon, 11 Oct 2021 18:01:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZzbh-00AJty-Hq
 for linux-nvme@lists.infradead.org; Mon, 11 Oct 2021 18:01:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 316A860C41;
 Mon, 11 Oct 2021 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633975260;
 bh=4/+YntBNV5/w3ng5djSjZdGKqSo18/DR2D/M+OvZxno=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KS0q01UBnmpOLoXLA0HdFSarXsWoI3XTIupotWA9HE9ynY/7z5eQp5li5vgGI7RAE
 pAWMZStlUlbRKv3hODPICLUjyraLVOiwBEO1o1ZlFNXsKV21v396K72uuBG4lcmDNa
 B3e6bt7AB4O9xKBvXeK6tMCGzXs1s2NxpDA1iUGBWXIumg/YP8Bt4GF4pifCf2br0C
 +rSsXh2THIl0Zoi0HDtL1+hmiaIwZaS50HO1IFG7GgbD/D3Ssxk7vw9qGy/I3/Oz1e
 6N4uoCxs6ayE2lKLwRkx8y8a9DlyhVQHbcrvcxSIu486EgF2VH21bqdMaVtfa+yRkX
 Be9MVCSH7dqOQ==
Date: Mon, 11 Oct 2021 11:00:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
 <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211011_110101_634240_26C9D3AE 
X-CRM114-Status: GOOD (  16.35  )
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

On Mon, Oct 11, 2021 at 03:08:15PM +0200, Paul Menzel wrote:
> Am 17.08.21 um 19:02 schrieb Keith Busch:
> > 
> > In the section for "Identify Controller Data Structure" (section
> > 5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:
> > 
> >    "Support for this field is mandatory if the controller supports revision
> >    1.2.1 or later"
> > 
> > The driver does confirm the controller's reported revision meets this
> > requirement before emitting the warning.
> 
> The Dell support came back to me, and said, that Hynix refuses to publish a
> fixed firmware unless I show them a use case, where I need that field.
> 
> Can somebody think of a use case, 

Spec compliance certification. UNH test 1.1 case 2, for example.

> and why this field was made mandatory in
> the specification?

A dependable way to uniquely identify a specific device is generally
useful. The NVMe TWG determined the previous methods were inadequate.

The linux kernel will continue to use the device without this capability
since the low level driver doesn't need it to interact with a
controller, but the driver will warn about the non-compliance in case
host software is relying on this field.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

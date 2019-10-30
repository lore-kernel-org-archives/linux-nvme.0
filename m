Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88004CA9EAE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:53:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8F120874
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RtRU4j27";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6X+5fgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e0zSE+gf2gbkeVwOq8MHi9wHkaTaZ/l36OSbA8lDXAY=; b=RtRU4j273xNmNZ
	Xn3Bk0yrc6LWhsv3HqIf9VMFI6+jnsqHPVF0Tt0eJFBPqhc4dvXkTl6h9zvEHGDndjug0vCzwP2Zn
	f6bj7dmA0T35QhcOiCjy5DAT5uIbxCVHiwIOPW/TiDpkyYHQRO6FUhbAJ42DOHMLlLR0VDIdkiXkf
	bGx7ZqfFi9hD7dnVWOndjfkcOc3bFpGlvOSRCeQmzxvS2mFFwmXc0dSqGHvKDQwIm9xOqTek0aVuT
	Z8uQYmXpC/rs83QVWL0AohomwB7nkmVCNqUkJ7oCxZiRJu0hPStUYpNctHDLklAiDDYTUCmTflY4d
	QjilgnYg6I9kzCMCfiZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPcF0-000858-7B; Wed, 30 Oct 2019 00:53:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPcEx-00084Y-Aw
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 00:53:36 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A898320862;
 Wed, 30 Oct 2019 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572396815;
 bh=CiN8+uBGBBbTGDNsi2Hq3KM6FLtlK9d7Wva0KwIc9AE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f6X+5fgpK5x5cJvSZ6A3HfkeIYsIcBMFlK4k1FonoDO9lwlgatFeb/YO50HwKQmVm
 jrAvuv3CwkdD2EaURvLvWNkF9SyJZwUc0j+9XJkNAdje7SEH/dVmF7w0FUcO3mKiVv
 pZXTiaQxmaw+BxhX3CIAZkdPj5V3mvHWxRnyL7S0=
Date: Wed, 30 Oct 2019 09:53:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
References: <20191029223214.18889-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_175335_400822_8E12D7FB 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 29, 2019 at 03:32:14PM -0700, Guenter Roeck wrote:
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
> =

> At the same time, it would be desirable to use NVME temperature informati=
on
> for thermal control.
> =

> This patch adds support to read NVME temperatures from the kernel using t=
he
> hwmon API and adds temperature zones for NVME drives. The thermal subsyst=
em
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.
> =

> Example output from the "sensors" command:
> =

> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C)
> Sensor 1:     +39.0=B0C
> Sensor 2:     +41.0=B0C
> =

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This looks fine to me, but I'll wait a few more days to see if there are
any additional comments..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

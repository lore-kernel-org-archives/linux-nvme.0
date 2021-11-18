Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 15:30:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D1613D3
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 15:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F3D1613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=av0KMYw7+QjXj0ZFaOtYbMpzY/bkEf6Ms3KExmgHy3I=; b=0sRLXxkgVUJRmy6VYNn2ldAo+8
	8snmL1I04Lr9FA+DlhlukAkeUxEDcw7XK++zXDt/o7ZdyD4AxPoVYo1DjQB1P68RiuAd9XrcoSuEQ
	fPkXAl5i2mpzDuCgeQE8G8sIph8AFUcIZ+VBKwHxr48K65wCesQwjiu7rjUcBbCoUZsBO/P5nTR3U
	nrgJC9DaQ14Y6aH+EdOVNp9XNDDWbcY1paT201UI950ZslbsZy7LhTRZlHtBxFBHMSeQkdOihKUpJ
	6OqXoeoxvMNUBHHQyPU/4df7d9oUObqTS6syneTMsRU6ISa8yqWLTiIEOWtsa47PCEngDU6VgdxVL
	CLfsaWAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnjMk-008H9E-Lh; Thu, 18 Nov 2021 15:30:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnjMh-008H8a-MT
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 15:30:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C676126A;
 Thu, 18 Nov 2021 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637249419;
 bh=MoUcfMedRf56Nc4HWmwmKpqf6mXbpveed5lL5Sf8dSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SWHuGRuQkKN4xeK+KLY56evVxcMXzMys96Xq/Crw4Bejn8SNRs0CAVCA+a4WeXeae
 c8Vdh9OqV+k8ituEWgDb7P+g18UAZn3p85mItXWQvd4BIWvWjs4jSJkde77mKmFDds
 RsvItkTFmsym8aW/iTvY6VQZi/1Upj54xelnlLztOXB07l/619O9ZTMzU2ThiDWkRO
 Enx6b4mWn23pmdG2Jq84rnIhNPkmpWEKyG4A5zaLe0MA65EVsHiE6zdQ0QalJ4J04v
 igN+Tbykr/8RZCW6XONGZh7LjZy6Al6o9Tnma3TW4yphKJ3Et/lHRvTB27GQH+gBRg
 tWcLSFeNpBAUQ==
Date: Thu, 18 Nov 2021 07:30:16 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Sysfs paths to NVME devices
Message-ID: <20211118153016.GA3296638@dhcp-10-100-145-180.wdc.com>
References: <3c725e5deaabaaf145f48f2f6fcfdae9f6d41e2e.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c725e5deaabaaf145f48f2f6fcfdae9f6d41e2e.camel@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_073019_785362_DB96A61B 
X-CRM114-Status: GOOD (  28.24  )
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

On Thu, Nov 18, 2021 at 03:28:26PM +0100, Jean Delvare wrote:
> Hi all,
> 
> I have a few questions related to the sysfs paths to NVME devices. We
> have a dracut module using udevadm on block devices (under
> /sys/dev/block) to figure out which drivers should be included in the
> initrd, and noticed that it does not always work for NVME devices. Upon
> investigation, it was discovered that the link in /sys/dev/block leads
> to either a physical NVME device (e.g.
> /sys/devices/pci0000:00/0000:00:06.0/nvme/nvme0/nvme0n1) or a virtual
> NVME device (e.g. /sys/devices/virtual/nvme-subsystem/nvme-
> subsys0/nvme0n1). The latter case is problematic because virtual NVME
> devices do not have a driver attached to them.
> 
> First of all I would like to understand what is the deciding factor
> inside the kernel to go for virtual devices or physical devices. At
> first I thought it was related to CONFIG_NVME_MULTIPATH, but in fact
> all our systems have that option enabled, still some have virtual
> devices and others have physical devices.

If you're using nvme native multipathing, and your namespace reports
that it is multipath capable (ID_NS.NMIC), then the driver will set up
the virtual device for the visible block device.

If your namespace isn't multipath capable, you will only get the
physical device. That's just for pci, though; fabrics targets always
link to a virtual nvme subsystem device.

In the case you have a multipath namespace, the driver will also create
"hidden" block devices for each controller path that it found. As an
exampe, if you have multipath nvme /sys/block/nvme0n1, there should be a
/sys/block/nvme0c0n1, which should link to a physical device in sysfs
for pci.
 
> Secondly, I would like to know if there's a chance to have a consistent
> behavior where the paths would be the same on all systems, so that
> user-space only has to deal with one naming scheme instead of two. It
> would be nice not to have to deal with exceptions in dracut and udev.
> 
> Lastly, in the case of virtual NVME device paths (which I suspect can't
> be avoided in multipath scenarios), could you suggest a reliable way to
> figure out which drivers are being used? Multipath existed before NVME
> so I suppose there's a way to do it already, maybe the NVME subsystem
> needs to be adjusted to do it the same way other subsystems (SCSI) do
> it?
> 
> Thanks for any insight on this topic,
> -- 
> Jean Delvare
> SUSE L3 Support
> 


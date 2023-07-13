Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC25C001DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQh6VVGs4fIvBpyuUlwWUmTgLml1MLgCYvaf1XfFjbM=; b=ijicmeCM0Uz/8Qn53wFyQGS2H+
	Ll6635Rc+I7YICvE7YZNUYmbvqrolMHWrVbzKMQPJKAbEwrf0D6nekNOy0KkxDsNqlcD/aheZF3EW
	5liziWKhFTfWDj2pgOYEhFXnhjjg2FElbHJQAXAyqouT+Ze+4n4cws9slBlvvQrPGeRhucJt7QA8T
	Cd7Ux0T+r3agPX4dadO3S904gEVFbO5VSu870qrEk4XJr8/XQlKLTyLWjBASZMZOkFTKuSEoMNawa
	0zHvWXS61uZgM32p4W9oyTKvpuJ19AKBIW8n6NaTf8WhqLbYTFPS3dI+caST+GnUdsWGCRKHCfza8
	qkRtS/5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJxic-003dPf-12;
	Thu, 13 Jul 2023 14:54:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJxiZ-003dPE-3D
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 14:54:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7848F61542;
	Thu, 13 Jul 2023 14:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E56C433C7;
	Thu, 13 Jul 2023 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689260094;
	bh=/se2ZrAbXIx9YD+HOJyQE6rM5/qOWMeCY9j7vyAKGp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFA6hMJuIfNybZIRcizWyvAYIMR1oBnXgnyo0VLbuoohk7hl2u+vkKZL5QrCgUKrq
	 2Soqg8EtfidtX4rdjAd5PdMQYVka1LFRysjwIMzpCBbBfYHEfmB/cEAGEoKFubOSbD
	 +Fk+i7QLBDJjRQ5BCFmX1uhTIYNz7J/T7AXW/tpadKnXYqCcRAaD0nuiPNTD0NLQGB
	 MLiKksRqfQOlIfyJO3e9iSj2EVTx6DmZPAPDY6/Fg7zBtlSAbc1B1zivJlFRdfZzDU
	 uDEdXG7StDtflUoxZLZppLsVDjYQTzTamFN5a/YzdcKxcLzcjNIkUCk3OF2Jeuv25W
	 FgMZY81FFTDMg==
Date: Thu, 13 Jul 2023 08:54:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
Message-ID: <ZLAQPKOApKCg1LDu@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230713133859epcas5p2b0de1a117d69f54f2d1dcf027f73afef@epcas5p2.samsung.com>
 <20230713133042.3981-1-hch@lst.de>
 <20230713140156.GA2143@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713140156.GA2143@green245>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_075456_096209_900F62E9 
X-CRM114-Status: GOOD (  15.75  )
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

On Thu, Jul 13, 2023 at 07:32:06PM +0530, Kanchan Joshi wrote:
> On Thu, Jul 13, 2023 at 03:30:42PM +0200, Christoph Hellwig wrote:
> > While duplicate IDs are still very harmful, including the potential to easily
> > see changing devices in /dev/disk/by-id, it turn out they are extremely
> > common for cheap end user NVMe devices.
> > 
> > Relax our check for them for so that it doesn't reject the probe on
> > single-ported PCIe devices, but prints a big warning instead.  In doubt
> > we'd still like to see quirk entries to disable the potential for
> > changing supposed stable device identifier links, but this will at least
> > allow users how have two (or more) of these devices to use them without
> > having to manually add a new PCI ID entry with the quirk through sysfs or
> > by patching the kernel.
> 
> Should this go for backport? For the commit 2079f41ec6ffa.

Is it sufficient if I just append "Cc: stable..." to the commit message?


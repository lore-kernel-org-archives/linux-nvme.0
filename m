Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BE5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 02:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tbT7iyA3jfv+fid5nFbkWuwGX3hqOX56lr2qhbte544=; b=aqayZs0fgYu2/M8EwH7AQ5c9sI
	dNR02UuR6cEb6g9G9YsKUo49UUskyGm8A0dZJ7ZT2SLSY2zJYdytZFclEC1G2NcMiXtuLWVo/5nIi
	ZTCuTjmKou//kWm9Hg27rgjWIuwEb3E81mBq21ogcJKqEQsXcVc5UMYNphw5SHA7f98EW+1b+d4NR
	nS6JM3RbjpR4sm3O9I4CdgE/vTQlISYblhoeGyO3RIRtcDWcAoyk3ZlT2iOxpNTyX90CrJc6quVIO
	Elu675EWLiWiOR8SPs1xtB/jWzOj91LBFJ1lmAJtffic9LY9KqMJ5OyWeFv1ANgJQWY1b1ixJ4GX0
	PBaXoSLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGtfJ-008rw6-2B; Mon, 07 Feb 2022 02:22:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGtfF-008rvi-S6
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 02:22:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B483D6133A;
 Mon,  7 Feb 2022 02:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A969EC340E9;
 Mon,  7 Feb 2022 02:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644200520;
 bh=P/1DK9hNzHSfloO6s6XthcBx9shGANCoA9v3AaRZcow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ChGYpds1hIUHiKRJrXgE+Z/n/aBdRDORuYDuHQBBNL3J2ga+Hvvws/pDCHh6LDTFD
 YQGvPQiN6+Ispq565cgh5g0dged7lvbhXn79r2Xandv5n5ewOGrphPFuPRjpxWdiRZ
 kGt6SI2z9qmKHbB+72UZeOZbX3zY27yrpH89nU3eq8WS+f6TvPC2aX7U1GcKlxaNzT
 uT54yHKciO/Pc9yJI0Wxu8BjeqZWqGwP/4YBoomhFs1SKhLfFGJOjhGfyZHEXLxXHR
 ObcBRv0IdMi2vuDcYz51md9orHKM/UQkytbcqVFgcMLpR2gHKJ3NxuOQ+eTFhvj5kL
 oefdWqSHIu8IA==
Date: Sun, 6 Feb 2022 18:21:57 -0800
From: Keith Busch <kbusch@kernel.org>
To: Warren Chartier <icebalm@icebalm.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
Message-ID: <20220207022157.GA634225@dhcp-10-100-145-180.wdc.com>
References: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_182201_993684_397CE30D 
X-CRM114-Status: GOOD (  11.02  )
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

On Sun, Feb 06, 2022 at 03:02:54PM -0500, Warren Chartier wrote:
> Summary: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in Linux 
> 
> Full Description: 
> XPG Gammix S70 Blade 1TB PCIe Gen 4.0 NVMe drive is detected by the Linux kernel however when block operations are performed on it these errors are generated: 
> 
> [ 3.958786] nvme 0000:0e:00.0: invalid VPD tag 0xff (size 65535) at offset 7 
> [ 71.726420] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff 

An all f's response generally indicates we can't communicate with the
end point on this link. The description here usually means there's some
platform incompatibility with the automated power settings.

Try adding kernel parameter 'pcie_aspm=off'. If that doesn't work,
add kernel parameter 'nvme_core.default_ps_max_latency_us=0'.


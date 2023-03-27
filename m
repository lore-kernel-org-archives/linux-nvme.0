Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59DEC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uCORVEBcxfS9kbHQPDT/wpVui7y0WCR6O5eV6WP7iv4=; b=W5I9UAjUnLD5z3WYHWoXREo3R1
	8QD9pSXbc1ca1t9peXPgBdJN10GTKcV0HqIVWM8mkrgfpTM2U6f+QOyIP4Mzsadgr/LDWY6uDtbM+
	xxMySBr08Um4LnFln4EzRsFNqKl4QJ4+Uv/DYSzTCnkyOeM3X16u6OKpddFwfBjkRCRWdgtnE0+yf
	KGJp6ebAQWdR/wUVCRxyt9sVa5FSp2KV3gqd0/acTErwJBqm2yi/PBqNQKBlYIwgDAomlHEBac66P
	sUP9qCoFLWSdWvvPRJU4gTur4bphD9ERUZHJDBIqlLGjfTumJv9giN6UJfV77cUPJE4Uug8bcw2n0
	gfxYvsuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgnvG-00BKnM-2e;
	Mon, 27 Mar 2023 14:34:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgnvA-00BKmU-39
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 14:34:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 60EBF612F1;
	Mon, 27 Mar 2023 14:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99578C433EF;
	Mon, 27 Mar 2023 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679927640;
	bh=tVniDDAOenqVrDXFcessUJ0xDBAw+ON6dKY2idpzqT0=;
	h=Date:From:To:Cc:Subject:From;
	b=eMEKXd2LEibmha39DLEmVCWe4W201u3s/G5893MLKOzKvYiAoo2GLdAhoFcXM0fDx
	 XO5zz79KulDjibvm4V112I2ZprQC74ciFABr0w1s6WMsQfWuV8N710T9RCGYN1IMT0
	 WshartXEha1AV5YzF1Breu9HaPZJpBcLYOk9IRh4UuYA8BGACox8uy729LM6jB9E42
	 ybZsntMnIdxZEjmijiHw2/A1OEAAJApR32VUWR0bHVJ/34BdfV6Aky2sji3c47P9IU
	 Ns67oZvby+xpJtJxdgZ1A+jPMfYIhLeX7FJPDTj1yQeViZ9vJUouvj/ZBt8bcBOhmE
	 Gpenn2aZenpTA==
Date: Mon, 27 Mar 2023 09:33:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lukas Wunner <lukas@wunner.de>
Cc: Aleksander Trofimowicz <alex@n90.eu>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Message-ID: <20230327143359.GA2834753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_073405_077872_198035E6 
X-CRM114-Status: GOOD (  10.50  )
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

Forwarding to NVMe folks, lists for visibility.

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=217251
...

Created attachment 304031
  --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
the tracing of nvme_pci_enable() during re-insertion

Hi,

There is a JHL7540-based device that may host a NVMe device. After the first
insertion a nvme drive is properly discovered and handled by the relevant
modules. Once disconnected any further attempts are not successful. The device
is visible on a PCI bus, but nvme_pci_enable() ends up calling
pci_disable_device() every time; the runtime PM status of the device is
"suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
device from being power managed ("on" -> /sys/devices/../power/control)
combined with device removal and pci rescan changes nothing. A host reboot
restores the initial state.

I would appreciate any suggestions how to debug it further.


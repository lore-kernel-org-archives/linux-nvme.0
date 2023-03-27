Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9829FC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=deJgujfaRoB644lILTjlVzIuAihhn8YDNl8DUxYKRW4=; b=hI67FkcZeGheT+3bB9GEbyxGe8
	D4GUxmcv8IqZVRyqX4XVA6hvmzU2qxiocze5sslRYXcnrk0/mkA5U9WXCL73TShXjeUssZCUH9V1m
	wxBHmgcKvE6INiF+Zs0Fjzj2kwCWksfCXpQhgiFINP2OlkTI33+2vK4nP87bm+3gDIZOsHLDxbrJo
	c/qMB1OvvrNulqcvZ5UeKJXK6g1tDQ8wROR+0x7PIPk9FZa4IOWmeAp+k2aHAT+p6n95ubo8raZHz
	NunIXAytIMnbVfjSGwzMPUdn7wi9JLabZ9eCtV22Zxn/ZSenmNyYcZQU9ZoKCgR9IdH8sGMWpvKGV
	GGRZN5mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgpYn-00BgvW-01;
	Mon, 27 Mar 2023 16:19:05 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgpYk-00BguI-06
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 16:19:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 941E2B815D4;
	Mon, 27 Mar 2023 16:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86974C433D2;
	Mon, 27 Mar 2023 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679933933;
	bh=vdqssHVignhvMODkXP8HH8VTKfr6z1MWWUoqltaO3Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYTRjGZEBBXiXXfAOaZVoPNuFrTNI1Ijd/sAlIcF0ivsxiXPYqC8Jqu9JRZcqbQa/
	 8q1zUqogO4GXn5J+uYpXrtpARDsQttsg51Cyq2Am/ED+aZ2jFM95U9BAf7S2/PSd5W
	 FWv4JatvJakyZR+8hMV1gyOR9AKV6Y6gPF28KdbkekCmGiJlWJh4on8P+vBRloSmYq
	 MYQi7nRznGylJpSv2Lx3aB20I5xsrsErN8MlfzXjho3c23+Y6cbXtLtRzSiTCeQzUD
	 zB3BXHVE95K91O+jTp+bzBlp7JtbH19z/kNCW9FQooQ5banU8BuoUYEsvpgNpaFXQX
	 MEGWQsr3lD62Q==
Date: Mon, 27 Mar 2023 10:18:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Lukas Wunner <lukas@wunner.de>,
	Aleksander Trofimowicz <alex@n90.eu>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Message-ID: <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
References: <20230327143359.GA2834753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327143359.GA2834753@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_091902_213109_57668F04 
X-CRM114-Status: GOOD (  18.35  )
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

On Mon, Mar 27, 2023 at 09:33:59AM -0500, Bjorn Helgaas wrote:
> Forwarding to NVMe folks, lists for visibility.
> 
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217251
> ...
> 
> Created attachment 304031
>   --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
> the tracing of nvme_pci_enable() during re-insertion
> 
> Hi,
> 
> There is a JHL7540-based device that may host a NVMe device. After the first
> insertion a nvme drive is properly discovered and handled by the relevant
> modules. Once disconnected any further attempts are not successful. The device
> is visible on a PCI bus, but nvme_pci_enable() ends up calling
> pci_disable_device() every time; the runtime PM status of the device is
> "suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
> device from being power managed ("on" -> /sys/devices/../power/control)
> combined with device removal and pci rescan changes nothing. A host reboot
> restores the initial state.
> 
> I would appreciate any suggestions how to debug it further.

Sounds the same as this report:

  http://lists.infradead.org/pipermail/linux-nvme/2023-March/038259.html

The driver is bailing on the device because we can't read it's status register
out of the remapped BAR. There's nothing we can do about that from the nvme
driver level. Memory mapped IO has to work in order to proceed.


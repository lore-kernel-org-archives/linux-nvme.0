Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253CCCA47A
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Q6dtF1K+pJ6nMjh/i5v/KubJyDg4kO4UBoQXKNwWlII=; b=x0ggCfBdX4Mv4J
	fuR3jL88ULOUu7R68/G/7XQ4cLXS4IQ3OUetIHF3qEVRinaQsX91f5z6VNgBUg4jFpAv1R5dHGP/2
	ZVPz1GYF6aI7x1l7zywKtqflcKNlIcRkteigh/jcmkqIJTQsb41TantWxiy9R5KIshNaQ8RSo18tb
	b0ulP1km2+8uS3fZgPFiCvsXc8ElwJ3ViY3xJl136RjxhlHpXmWhIS3aKhbS/21rHHD6dOzAJO7qb
	Daha1z98r2oP5vy4E5KJ5FOuI0hf2kwluJ28CxH+hUbFMpraP0PjgFh8bHB+eWalBGR+uZ0vu8mOl
	5WD6+UY0jxDoTK2wPqJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1FXW-00Bi0A-GA; Tue, 14 Jun 2022 23:01:38 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1FXU-00Bhz1-Ae
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 23:01:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B14D3B81BB3;
	Tue, 14 Jun 2022 23:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEE1C3411B;
	Tue, 14 Jun 2022 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655247690;
	bh=0uCD3AXwENO/Bxz69LYMMOQrPnOqlOLGdU2KJqwaCX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eFWD1zQ5yiMvhfQ5Jytt3I/far5PQRv7d1h4eCpI+rsb0iF3OI4f1TnsZY3mvcuk8
	 NP4MpkRZgSswh3eMRZl/fAYke9hBR64YvUCtB4ttC0/xYvOE93t+//LziPpT/WbGQn
	 e7ceGkopIGC3w5P7xIaUKdnRna8u0N5keaXaEgU3eNmS3cNKKNBf5u5WkZMeUxxo0I
	 y5t/V0+/yjyYbOH5WuKBRfdcnfzAlMve9oyied4NAeJVcfEloxxkAYd0k3bpmmdpqE
	 5P4eJbtzARugGiokJYLBlLYJehe/DN4Oc8xiztb5Jk7b5ScUbdmT4iYnsVykjPZP0Z
	 Ld+ipjnaHCoYA==
Date: Tue, 14 Jun 2022 18:01:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
	Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <20220614230128.GA901712@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eae37ce-dd44-9c32-3f68-2b4e102dce8e@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_160136_545380_F56F00E3 
X-CRM114-Status: GOOD (  17.83  )
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

[+cc NVMe folks]

On Tue, Jun 14, 2022 at 07:49:27PM -0300, Guilherme G. Piccoli wrote:
> On 14/06/2022 12:47, Hans de Goede wrote:
> > [...]
> > 
> > Have you looked at the log of the failed boot in the Steam Deck kernel
> > bugzilla? Everything there seems to work just fine and then the system
> > just hangs. I think that maybe it cannot find its root disk, so maybe
> > an NVME issue ?
> 
> *Exactly* that - NVMe device is the root disk, it cannot boot since the
> device doesn't work, hence no rootfs =)

Beginning of thread: https://lore.kernel.org/r/20220612144325.85366-1-hdegoede@redhat.com

Steam Deck broke because we erroneously trimmed out the PCI host
bridge window where BIOS had placed most devices, successfully
reassigned all the PCI bridge windows and BARs, but some devices,
apparently including NVMe, didn't work at the new addresses.

Do you NVMe folks know of gotchas in this area?  I want to know
because we'd like to be able to move devices around someday to make
room for hot-added devices.

This reassignment happened before drivers claimed the devices, so from
a PCI point of view, I don't know why the NVMe device wouldn't work at
the new address.

Bjorn


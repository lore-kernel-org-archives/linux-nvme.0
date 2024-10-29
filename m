Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A23D5B865
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 02:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5yeoulMIVhLxjKed4Uri+Wob38RpVdoqCMi54vrKGk=; b=ARJbRnMyx+h4YTOqWPhE3MntuK
	SDgGUBfAq4q9yaPfzy/sOO5SaKsD4f4YwuITeqa5tph5IcycZIQ5e+JhqIqEUg1NRwwnvrHLXpuSo
	0SsyKJaLeKnjVfUb4RZwNo16ngFjQ4tKypRyqRGISBp48jtpwUPidb5RjJje5G3w/Ii5EXPOeMLcC
	0NER0PYsRhBOo4T86fzQAdSvxil1csK6PEiKwh36vbw0LNYfMgjpUpbvkGi3v1C/5rrax3KOSQYFl
	WtombartHK3wLJyk+jPFAW7a3I+xnbxPRGvlICSf0I5OWTYIMGDswofdc/rvvJRf0t1uM01Me2x4V
	ohLQ186A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5cLZ-0000000D1of-074w;
	Tue, 29 Oct 2024 02:52:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5cLW-0000000D1o6-1vKx
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 02:52:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 58CF25C4B0E;
	Tue, 29 Oct 2024 02:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B145DC4CEC3;
	Tue, 29 Oct 2024 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730170357;
	bh=/30j8m/4TwI+cAFWd4X7nt4B8VSmsRYpx7HC4ohV6r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKY1u0tTKAD0Ax48m3hfBzUt6LJbXAyADmx5UPgRREGnLpoOgc8tPGE9HEl/Ox7G+
	 hygHpObaNUchR8pK6dsi1B7ACMLcNsQjjJNilaYllsl+14ZXuOurbij2xrKE8BMZf+
	 Z7aBjmEK9lfB3k2VqAJBJjm2alTByHdtKmzAcIsw=
Date: Tue, 29 Oct 2024 03:52:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bob.beckett@collabora.com, hch@lst.de, kbusch@kernel.org,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <2024102948-granddad-exchange-3c05@gregkh>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029024236.2702721-1-gwendal@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_195238_569893_E02FA4AE 
X-CRM114-Status: GOOD (  10.49  )
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

On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> is a NMVe to eMMC bridge, that can be used with different eMMC
> memory devices.
> The NVMe device name contains the eMMC device name, for instance:
> `BAYHUB SanDisk-DA4128-91904055-128GB`
> 
> The bridge is known to work with many eMMC devices, we need to limit
> the queue depth once we know which eMMC device is behind the bridge.
> 
> Fixes: commit 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

Nit, no need for "commit" here, and no blank line after this one.

thanks,

greg k-h


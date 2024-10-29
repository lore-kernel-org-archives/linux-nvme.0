Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD48BD3A692
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KuBtlOLv8j9JOOzyvo5jFNw6qvEBOStv/scgRwvJae8=; b=qWpkYmKpNjZsoloizDzUJWQjmz
	xXTbFArVWOxQ6IDoT2i+7Ox1lUG7vui5R6k7x+Z5XlVqBpLGxe/h784bgFjroqVanQwdL3TZNJshd
	JxtLV/FFTd7AWXJ+RSQOBKWYc0vDp9eu4GnKXvSAzX18xbandfA/LINKgx1GhwnjhKEKJtCG+tZK8
	lZoPa/MqFgvhytjF5avHKBeMIM3hGYFN2bq1GfWRZB0painQ1yeAwCx5HJrsTnIDYXuRujtzhvXKb
	CFAaVxe/j7enERQCAyVENXllhIyJhSImK8FuTpx/N6Yjc4Bnp+EHcu6n68XpTYBu5Hj9PRK5HdnFf
	HPcVB57A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rho-0000000FdZC-1PLm;
	Tue, 29 Oct 2024 19:16:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rhl-0000000FdYA-2Kaw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 19:16:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ACDDB5C5434;
	Tue, 29 Oct 2024 19:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF2C4CECD;
	Tue, 29 Oct 2024 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229396;
	bh=R0tF8vC5j1/G4YXdwi/1Noa2d4Yl4mwDKVNkuCsDCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhdEUCupdItxcq0dmqfjSNmi0/Dca6AVKIdRebwMdgqKMJ5YDNNslbRGMVU5uXbUW
	 nTopo9kg7HFLbwz02Pa5O1VgGZuYxlNMgX1Cm/XlSVvf7gO374D48LidFP92bDV1IE
	 L7hdG2vd8jsztBCGJzH/7EPTKnBSTwbXqOTk4zFJeudauEBoeaOw5ljVtlfTTG6X7E
	 /GZZL3s8R2ZK1e1ao9frvouHQlPEIw0FA9Jzbh9ho2Xz3imRi9QIPWjtpP700QGBDP
	 UZ3V43Fc6YOQ5MLzxm1M0rTfMabc6DRmYwLJrJyfLSlY6fxaufKxMS1AIxzKvWvTjQ
	 A1+NK/OH5aVHg==
Date: Tue, 29 Oct 2024 13:16:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, bob.beckett@collabora.com,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
 <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_121637_659817_F0E10576 
X-CRM114-Status: GOOD (  24.11  )
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

On Tue, Oct 29, 2024 at 11:58:40AM -0700, Gwendal Grignou wrote:
> On Tue, Oct 29, 2024 at 12:41 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> > > is a NMVe to eMMC bridge, that can be used with different eMMC
> > > memory devices.
> >
> > Holy f**k, what an awful idea..
> >
> > > The NVMe device name contains the eMMC device name, for instance:
> > > `BAYHUB SanDisk-DA4128-91904055-128GB`
> > >
> > > The bridge is known to work with many eMMC devices, we need to limit
> > > the queue depth once we know which eMMC device is behind the bridge.
> >
> > Please work with Tobert to quirk based on the identify data for "his"
> > device to keep it quirked instead of regressing it.
> 
> The issue is we would need to base the quirk on the model name
> (subsys->model) that is not available in `nvme_id_table`. Beside,
> `q_depth` is set in `nvme_pci_enable`, called at probe time before
> calling `nvme_init_ctrl_finish` that will indirectly populate
> `subsys`.
> 
> Bob, to address the data corruption problem from user space, adding a
> udev rule to set `queue/nr_requests` to 1 when `device/model` matches
> the device used in the Steam Deck would most likely be too late in the
> boot process, wouldn't it?

I think that is too late. There's the module parameter,
'nvme.io_queue_depth=2', that accomplishes the same thing as this quirk,
if adding kernel parameters isn't too inconvenient to use here.

Alternatively, you could put the quirk in the core_quirks, which do take
a model name. The pci driver would have to move this check until after
init_ctrl_finish, as you noticed, but that looks okay to do. We just
need to be careful to update both dev->q_depth and ctrl->sqsize after
the "finish".


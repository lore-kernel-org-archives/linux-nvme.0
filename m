Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34710D2FEFA
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=M15Xkl5ZcDk5NG/Tu7CCm3wztP26sqy32y1viyPYFw8=; b=y/DStw40Ms6xqd
	tpxpNVRsqmwdstmFzE4B2JcSs73p2Zul3jymnaiJNaURjwOfz5ajSWd0sNduNeDdw+APy5J93xMjR
	dBf1Q975JKBTZK0OVczxsPC7s6H5xEe57RTgMi9P0Ttgcd7jJ2/Q0g/b4EZWCX+WisUNGYVJ3Ou3I
	RU6yRU5EsSCfX9XsOJQwOM4638xMKP+mItFIg3kttmv7I/EFon8qOmGQOvos6YHo+O9RAv2F9HrNT
	zRRydyaa8on/kclEOmHfuL20/v+4kGomgknpz8aA6zAr1v35gNF1wD2RZKar09yyknVP8hKbhCQu+
	Uk2+25Vy+6JuM3CfWm5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vksBP-0000000F9GN-3WGE;
	Tue, 27 Jan 2026 23:09:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vksBP-0000000F9GH-02gt
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 23:09:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 184AA600AD;
	Tue, 27 Jan 2026 23:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A941FC116C6;
	Tue, 27 Jan 2026 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769555353;
	bh=Op61aOMlFeGMVdPCCVR33HjYuvMukzcbNusVHdV2UIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t2tlhPnxqZIdlTaA76y1ofD6zHwao7HeH6XdM15Nfvssg1V1jRnDCfIpp2q+Jv6hu
	 K2uo61fTtCdW65GwDiM6q8dwQqTp9qNbPyuudNKRK4PhLrHRyHFk2xyxPQzxbH+DcS
	 pEazp+QhO4LJS/sxEXK9j5Z+IQGIU6Ur/vPp//cqq+DZHzNuhZhXzalKwVvPbnBHU4
	 jyzvcf1YejcxJ7Y7l+B8hOzwebRPYHliIBit2jDaRZSlireRAqVv2qIpxV41/kP3e8
	 KtibhScErW1U9nKyBKTa3NJcxAP8NS0vw1iRxgToB4FCgOwZYwpm1hSC2fbNOy7J1k
	 O+/6bYEXtlHmQ==
Date: Tue, 27 Jan 2026 17:09:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127230912.GA385193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
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

[+cc Jakub, author of 38972375ef7b ("PCI/IOV: Reset total_VFs limit
after detaching PF driver"), which added the message]

On Tue, Jan 27, 2026 at 08:00:42PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> > On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> >> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> >> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> >> > > The NVMe PCI driver exports the sriov_configure callback via
> >> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> >> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> >> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> >> > 
> >> > That sounds dangerous.
> >> 
> >> It is not. In a real SR-IOV device, VFs are created by the hardware and
> >> are independent of their PF. There are several use cases where an
> >> operator unbinds the PF and reuses it to improve overall device
> >> utilization.
> >
> > If this is expected, should the warn message "driver left SR-IOV
> > enabled after remove" be downgraded to 'info' level?
> 
> It is not important, no one complained about it. People who unbind
> PF, simply ignore this warning.
> 
> BTW, the use case which I presented is for SR-IOV handled by
> drivers. Maybe VFs created by NVMe are different here and they must
> be destroyed.

If it's to be expected, I do think 'info' would be more appropriate,
if nothing else as an indication to code readers that nothing is
wrong.  Or maybe even no message at all.  Or maybe the fact that we
reset the driver_max_VFs value is of more interest.

Bjorn


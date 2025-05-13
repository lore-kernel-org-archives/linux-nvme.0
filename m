Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6493C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suGKAUnOcC4v2FWUBFR0gvEryjGvIC0tfUwotwgZ2Gk=; b=V5TcJcYKcPgLoL+CEAdQbsUWUz
	ICTbVWSHBkVioBVBXZd8dJifNwEBdaDgNxNCf3d7GwatO2tXFQ57tWxWio0MOfLJBunCL7Fnhshkf
	j5HtZH55lTQhi1ApdxCAyj7xF4QjTIBEyqvlF97Dl/qKTOhLhyLHyK48LZWYtG9mK2wtTqMEC7oKm
	+2Mh1eJ8YVZM5D20TWOK5+Fexovt7nJg+YBpRL0gaWQE6hfABb2JEh2az+ELtLlYHYIaNfuNDYe5S
	sqdj62smGy3UP3TOLY3FbXCtrsml3CDnDXC5GhC5KVtfIIIMtUc1LK8De1vjpXm8sqe/XIQripUrd
	lRMR544g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkQv-0000000Bh2G-0SKP;
	Tue, 13 May 2025 07:52:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkQK-0000000BgyD-0bI0
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:51:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 45C45A4C95B;
	Tue, 13 May 2025 07:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5223DC4CEE4;
	Tue, 13 May 2025 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747122694;
	bh=QP+CUZBj2KZxWn3b0IkBoSpOHPkhW/xwoYyB7TNM9B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP3NM9MSsTtR2aZ+01NUlqp8yaDL3MnFDJkPV681wUnh/IWJlCo0KUk7xBhoO3SSw
	 R2UpNAacxfUH6lOTkrT0mThpyxjYeciV18WlGgumLbXp82ERaeRjs0mJnxA8Purkl3
	 sVjJZJLtcIpt/k0Ve9+/wgmagt3EDKSbOcK6EwZWq31FAzLK3p6pHbO3cE/v2UXruM
	 wautG7gmLRx36i4HclWTpinf88tPkRnX0SYXdIoYEwirlQKS9ZaNDfzObRsYG6jD++
	 LiorM8MC16mpZR/JHap/R2wWroVceLhZDt71tDnjxYpgQmPdBWcvpgvoXVUdssCg4E
	 uYd3hdSNci/Zg==
Date: Tue, 13 May 2025 10:51:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] nvme-pci: don't try to use SGLs for metadata on the
 admin queue
Message-ID: <20250513075130.GM22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-2-hch@lst.de>
 <20250513072842.GH22843@unreal>
 <20250513073908.GB2521@lst.de>
 <20250513074515.GK22843@unreal>
 <20250513074711.GA2818@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513074711.GA2818@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_005136_246421_0811555F 
X-CRM114-Status: GOOD (  19.31  )
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

On Tue, May 13, 2025 at 09:47:11AM +0200, Christoph Hellwig wrote:
> On Tue, May 13, 2025 at 10:45:15AM +0300, Leon Romanovsky wrote:
> > On Tue, May 13, 2025 at 09:39:08AM +0200, Christoph Hellwig wrote:
> > > On Tue, May 13, 2025 at 10:28:42AM +0300, Leon Romanovsky wrote:
> > > > > -	if (nvme_pci_metadata_use_sgls(dev, req))
> > > > > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > > > > +
> > > > > +	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> > > > 
> > > > Won't it be more future error proof to check for NVME_CMD_SGL_ALL?
> > > 
> > > No really, as this is used to decide to call into the routine that
> > > sets NVME_CMD_SGL_METASEG.
> > 
> > I see same NVME_CMD_SGL_ALL check in target code.
> 
> Yeah.  But the above check guards the call to nvme_pci_setup_meta_sgls,
> which takes a command and updates the sgls field in flags from
> NVME_CMD_SGL_METABUF to NVME_CMD_SGL_METASEG, and no other place sets
> NVME_CMD_SGL_METASEG. So NVME_CMD_SGL_METASEG can't be set at this
> point by definition.

Thanks


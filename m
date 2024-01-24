Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD598C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtDSuY1j4WNb49u16/1QXR2yCc+Rxe/sYzGYK7hl05c=; b=0kjlqb0ee4i2pO1BRYm3fOxwBs
	eArh7QEg79vevkSjK3k87vRsk/diVUsNIkFHOGRzJGTUrUZxX/LGj4SkAVWeTIatqpfAQelztVK9P
	nkL1iJej5AqT7V3Le6hNBoS2TtDAWPplJFbI4nayYNI62fAkQ+i5rIRb9TgLH+66elZQweSX2cciY
	Kt4oSwxF22Vf6H34qTbB6WBLQI2+KlG6GNJG8EjEkSqNhvqU7qHmFmWYY5sSytnWMCHIW+L8luZ4Q
	kPciZRAgVtTZYuss6EX1sMRZT+dGj7k3vJ4TYqYek6evupyajWEFF7Usomwx0DE2ycHa7bEqYsnQ9
	Xvp99oVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfNo-0040c5-2u;
	Wed, 24 Jan 2024 15:41:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfNm-0040bJ-1c
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:41:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C4E5561D50;
	Wed, 24 Jan 2024 15:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12761C433F1;
	Wed, 24 Jan 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110901;
	bh=xLrA5RcRjFK5SJZ2Re6Tza8ZXo2JQ9yye+jrNnLv+2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmR+KvCAduSd3EVQ3DxDH1HCU25j0sc8Vc3LNulsuOfeW0hPQKuaEQ/jfLuMxsaHc
	 emQ5WcoZ/cBNkEj0nBrpxUYvEIKbOeRYtIASsHGjbyArWmpZuOnmeD32SmV/kbc5SV
	 iEgnoxT1c9moX3kGQMLysQZfACxOOOMa9D2Eu3apcalQ1FtVIdAy4efjdlvtxjU7WG
	 D+0tKM3Ni7fjfHw5hB/gQLgaXJzQN/y8MkWId/VIz5wfKdGa/gwYN9Pt5t2tUbF2uL
	 SokOxMnC2LuIYwt611hv6hlxdQDh8N4rCBwgKOum3ZireYTAD0IaGcxih2UKb5D9Bt
	 1B/6hZgeHW44w==
Date: Wed, 24 Jan 2024 08:41:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
References: <ZbD7ups50ryrlJ/G@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_074142_617806_1C447796 
X-CRM114-Status: GOOD (  10.99  )
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

On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:
> 
> 	io_uring       submit_bio  vdb      6302096     4096
> 	io_uring       submit_bio  vdb     12235072     4096
> 	io_uring       submit_bio  vdb      7682280     4096
> 	io_uring       submit_bio  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> 
> 
> May this reorder be one problem for virtio-blk and nvme-pci?

For nvme, it depends. Usually it's probably not a problem, though some
pci ssd's have optimizations for sequential IO that might not work if
these get reordered.


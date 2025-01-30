Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA76C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knfZffP1E8GCt1DJsIY6J01u3AyeXOpAjIIq1CzbMsw=; b=ADbMHUFtBeczPe1ECXOfJCaoPr
	sSKivQgJ7qkSWudJ+h88ZTtrsj98svqloBy9XnBnKeJe+nBHOnVpcPXxy7Ql2mSeCAhpuwuPA1FMG
	Iqb4ZUJOZ3UwBtsaXLhLwIMdbUAtNJVk0/JSq7MU5WhIxh+HAb4Qc13HszNHf8CWhKE0csQjpD2Oo
	42J7k70xfMgj9m9wBMX3L+N4AsQn7mOiixl7XRkU3lyxac0yNHxBXXcUnD9q+Cqx43to/EdTaO2vf
	1MvUHIl/03R7E35k5d7tgstFebtkpwAs5uSrKkw1xxmrzlOA6WHiZzDQgkDtE/1Q2mGNLG+gdlPt+
	zjgcESiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdU2s-00000008nQb-0lXs;
	Thu, 30 Jan 2025 12:53:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdU2l-00000008nQB-1GdA
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 12:53:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C37EC68C4E; Thu, 30 Jan 2025 13:53:06 +0100 (CET)
Date: Thu, 30 Jan 2025 13:53:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com, dsterba@suse.com,
	clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250130125306.GA19390@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de> <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_045315_483846_CE0DF95C 
X-CRM114-Status: GOOD (  22.46  )
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

On Thu, Jan 30, 2025 at 02:52:23PM +0530, Kanchan Joshi wrote:
> On 1/29/2025 9:05 PM, Christoph Hellwig wrote:
> >> This patch series: (a) adds checksum offload awareness to the
> >> block layer (patch #1),
> > I've skipped over the patches and don't understand what this offload
> > awareness concept does compared the file system simply attaching PI
> > metadata.
> 
> Difference is that FS does not have to attach any PI for offload.
> 
> Offload is about the Host doing as little as possible, and the closest 
> we get there is by setting PRACT bit.

But that doesn't actually work.  The file system needs to be able
to verify the checksum for failing over to other mirrors, repair,
etc.  Also if you trust the device to get things right you do not
need to use PI at all - SSDs or hard drives that support PI generally
use PI internally anyway, and PRACT just means you treat a format
with PI like one without.  In other words - no need for an offload
here, you might as well just trust the device if you're not doing
end to end protection.

> 
> Attaching PI is not really needed, neither for FS nor for block-layer, 
> for pure offload.
> When device has "ms == pi_size" format, we only need to send I/O with 
> PRACT set and device take care of attaching integrity buffer and 
> checksum generation/verification.
> This is abstracted as 'offload type 1' in this series.
> 
> For other format "ms > pi_size" also we set the PRACT but integrity 
> buffer also needs to be passed. This is abstracted as 'offload type 2'.
> Still offload as the checksum processing is done only by the device.
> 
> Block layer Auto-PI is a good place because all above details are common 
> and remain abstracted, while filesystems only need to decide whether 
> they want to send the flag (REQ_INTEGRITY_OFFLOAD) to use the facility.
---end quoted text---


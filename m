Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A50FC021B6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6UqsUN7VzF5T/ZujnGBFyar90t0eeE8GWPy9XthEMh8=; b=K39nScj/vAM8yaHZ7liePOSzbU
	yx4LWcZm4MpTQ0U48MKq0bRYtt4NGYGEip7OAxraJ0ScSgpEwJ4x0wFDdpDROwfHQQkbeKu1lcoiN
	WjmidBqKjqIr1Brkp2NwDgmvrejjGZOI/sUuOKa221IOnvsX/u2VmHCLVVWcXb+AG9ND9SVjFRrZ4
	pNIfeGHmhhg6dsWS2UAht7sa2sUQRtj34VzCjoB5Eb6JIx06UQDO8nDYukvXEkTUarycTR5iNFkon
	wIbKDJswhppkEAyGb/IklVTaEVdqgWOlFdaKLGUHhFTICxFmOASDOZEGo3/TKNRpZMO6JIpThE3Wq
	tBNI9hXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgzD-0000000FNcy-2EA1;
	Mon, 24 Feb 2025 22:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgyZ-0000000FNVo-3d31
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:31:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA5BA68C4E; Mon, 24 Feb 2025 23:30:53 +0100 (CET)
Date: Mon, 24 Feb 2025 23:30:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
Message-ID: <20250224223053.GA15518@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_143100_039982_411FD603 
X-CRM114-Status: GOOD (  13.54  )
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

On Mon, Feb 24, 2025 at 10:21:24AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The data type is represented as a u64, but the metadata type as a __user
> void *. These two fields represent the same thing, so treating them so
> differently looks a bit odd. Just pick one consistent type of
> representation.

Yes, being consistent is good.  I would normally propagate the
proper pointer type as far as possible, but I can live with this
version if you add a little blurb why it's preferable.



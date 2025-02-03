Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE3FC02197
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7jKMxM84+orQT9dx9Z4geGmpukMKUuFd1/RLpB/DCA=; b=lay+wqFnsMPZy6hMfr759Gp7uY
	MrI6oNHZ//zBAL1oYN4gI8UQ2la0eeZgFcE+02L7qxbcjuBeVq9P8PBLTHkJXz19OoXM24xqy8jgf
	L+HmffxgRoJTXIrCddtDY3mlqLD42FCU8IJ772lkOAb5SGmr8YWLFNpv7/ro8xnCilidXCzvebzrp
	Zon/SJy3kRMdwR17qSh8yvddWFMSTURoSgOUJe8GwoDs1fOoeiVBLs4wxgMOtYu3eUAnugkFyGVZV
	VM7sDgjfwQgrU7Gsu4JtWUESqJ+CQ1Y+UqnQ8nCde8Nj3oPBkt5eiYl0cTHadm+WAc8pfT0oqUEvG
	A0vqr/IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terrS-0000000EqMp-1p52;
	Mon, 03 Feb 2025 08:31:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1termz-0000000Epjq-1crR;
	Mon, 03 Feb 2025 08:26:41 +0000
Date: Mon, 3 Feb 2025 00:26:41 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B9wVAWi0dp7f1E@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
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

On Mon, Feb 03, 2025 at 06:46:49PM +1030, Qu Wenruo wrote:
> The root cause is the content change during direct IO, and XFS/EXT4 doesn't
> wait for folio writeback before dirtying the folio (if no AS_STABLE_WRITES
> set).
> That's a valid optimization, but that will cause contents change.
> 
> (I know there is the AS_STABLE_WRITES, but I'm not sure if qemu will pass
> that flag to virtio block devices inside the VM)

It doesn't, and even if it did you can force guests to add it.  But it
would be an interesting experiment to support passing it through at
least for virtio-blk.

> And with btrfs' checksum calculation happening before submitting the real
> bio, it means if the contents changed after the csum calculation and before
> bio finished, we will got csum mismatch.

btrfs checksums before submitting the bio.  But that doesn't change the
thing as you still have the same problem.



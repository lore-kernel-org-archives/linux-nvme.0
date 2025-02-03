Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9EBC02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DPlPVTXHHQ+Xo8ld/N2ryqVQ9X+N2CpviGEAb9r8W0=; b=PxK88Ho3vKYJZjYhcXpDGFQxLo
	KzjtjoXsZtW2bTv3fepTVgisy/wO25lF0mZZZmVTugxuGmahmIfyt+MAtkADxKRttgu8iiiGDehFL
	KVLCCQHj2DYEW7y8F4JBeHD/VM9hoytnM/IQb8QhwzNZjsgbk9mjkQrN6BoVO5cqjcb3+DANyI8wK
	J3dzb1pWBOPuZxqa9PGMxHIxfnLzkxydIty1jJatZfY6Kmspi9xL963iDT96ruqXcdJQfgE73Gssc
	n6WDV4ml8+uIl8LGZ7riYr3hiXa87O5xxU0lK7eRRcLES5zL1pD3dUb9bzQwqbfQuqZzcuXgwPjGT
	5CmuK2/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terrR-0000000EqLV-2vFS;
	Mon, 03 Feb 2025 08:31:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1termw-0000000EpjV-3GH4;
	Mon, 03 Feb 2025 08:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+DPlPVTXHHQ+Xo8ld/N2ryqVQ9X+N2CpviGEAb9r8W0=; b=TH4aMWR4o0Nimu5uYbLVMk9zbh
	h4NljevwIyFt5pXq0ZJVv/TwBqZJgOIxTWt6ZEAMRd4wX8K8MCiTLFhuMqrSq6TtvqOUYrUpbesZO
	3J72/g/E4haIeEtqpKeNgnxeNyCFg5ZeQblfFBfzZ71kypSy+BWWL6d4BHh7X3N5VB0fp/B9aFVhW
	vwdpIfWdpsWKhULtZOJzq2bP6d5lnZGniQQ37QrGrTQ0Y3sUVv2Rnqi4m2CiOcrgZN6530pgEVY4f
	T5NuzBqUfdk/HbXB5byAWa73/V1oVrXt5kF2tkt4yPfq4fDxI25G3MNCYpCDQ4K4+Cr7moDgCyUyT
	Ws26Vj4g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1termr-00000000iiC-1obY;
	Mon, 03 Feb 2025 08:26:33 +0000
Date: Mon, 3 Feb 2025 08:26:33 +0000
From: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Z6B9uSTQK8s-i9TM@casper.infradead.org>
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
> It's pretty common to reproduce, just start a VM with an image on btrfs, set
> the VM cache mode to none (aka, using direct IO), and run XFS/EXT4 inside
> the VM, run some fsstress it should cause btrfs to hit data csum mismatch
> false alerts.
> 
> The root cause is the content change during direct IO, and XFS/EXT4 doesn't
> wait for folio writeback before dirtying the folio (if no AS_STABLE_WRITES
> set).
> That's a valid optimization, but that will cause contents change.

XFS honours the bdev flag:

static inline void xfs_update_stable_writes(struct xfs_inode *ip)
{
        if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
                mapping_set_stable_writes(VFS_I(ip)->i_mapping);
        else
                mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
}

so this is a block layer issue if it's not set.

> (I know there is the AS_STABLE_WRITES, but I'm not sure if qemu will pass
> that flag to virtio block devices inside the VM)


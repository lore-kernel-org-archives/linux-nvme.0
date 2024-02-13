Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135FC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6sDkJ9oY1WoUar4tzUr35LFpBqsWkcH4CMMt7esFz8=; b=eesqq5TeJ2f0wgFAIe/mfVuf35
	NJ7KXKbrwLqEYhva3sb7sswoansgNvP4M4V8jdBCaSsZf8jVfL+G7cyxfFaF0gh/LPZYH5Gvx3tyZ
	GFmD34putWCRygEoXPXseblhA/UhVQ20hvvYl63OcP4SXt70JrbYNCcDViBEGkS2ezYH1S2hb5qpp
	OYAcbCZkZ6OHXSQeANftMgjB3BjLUzgFmXyPMSTv0FZfY47wJeZKckd3G4vRp3RzaqWDdprAE0G6M
	VEwZ6jdV5gk0uZ9ZZE4WT2bMFmtAvDhVaGP5qLQocuC/j5DDxzjMmG4LBQWwlmCDymM8Q7X/gYMPF
	5OfdCM3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmUf-00000008AFx-30kT;
	Tue, 13 Feb 2024 06:42:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmUc-00000008AES-2tR7
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:42:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB9E1227A87; Tue, 13 Feb 2024 07:42:05 +0100 (CET)
Date: Tue, 13 Feb 2024 07:42:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Message-ID: <20240213064204.GB23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-15-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-15-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_224210_892245_F4B5632C 
X-CRM114-Status: GOOD (  15.77  )
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

On Wed, Jan 24, 2024 at 11:38:40AM +0000, John Garry wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
> 
> Support reading atomic write registers to fill in request_queue
> properties.
> 
> Use following method to calculate limits:
> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
> atomic_write_unit_min = logical_block_size
> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
> atomic_write_boundary = NABSPF

Can you expand this to actually be a real commit log with full
sentences, expanding the NVME field name acronyms and reference
the relevant Sections and Figures in a specific version of the
NVMe specification?

Also some implementation comments:

NVMe has a particularly nasty NABO field in Identify Namespace, which
offsets the boundary. We probably need to reject atomic writes or
severly limit them if this field is set.

Please also read through TP4098(a) and look at the MAM field.  As far
as I can tell the patch as-is assumes it always is set to 1.

> +static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
> +		struct nvme_ctrl *ctrl, struct nvme_id_ns *id, u32 bs, u32 atomic_bs)

Please avoid the overly long line here.

> +		nvme_update_atomic_write_disk_info(disk, ctrl, id, bs, atomic_bs);

.. and here.



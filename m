Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB24C369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rv2dakPVXVTJ6bA3DayTfLwtb11qLmILipkSM04qfUI=; b=BTBPlB5gs5to7CyN4FMzsUTT+g
	EjLHg9rRLsGmqC2wHoDTTTUpptm6Aqr3MhgSgMO9nld9O0lKE36V5IZf5TLXY8i0q5k8Wm6umGD/8
	udyGgEuJyxLknQs3H0TfzAZkmFLt3hMgYoU2+Oyq/yEsqT9ZQxsh+833sN0VeLerb3W99Y/zkOTHp
	rdo+hZRwSbz5VcApqP/N9cRRlv56//EEkcWmTqH/HltSCj21bYgOMzCP5AE/dapc5RuA41UjJEZEZ
	8qzfrqHYM0aYHwTXBlvN7TlS4o/+zkrfRUyoB7oMy4ibpIB6JugH30U7HE3HQDCtZOU8SLPHUDYk1
	EsDQYCVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nc3-00000009oMH-0Yfc;
	Thu, 10 Apr 2025 08:50:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2n9Q-00000009idC-1RnZ
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:20:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CDFF4395D;
	Thu, 10 Apr 2025 08:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ECCC4CEE3;
	Thu, 10 Apr 2025 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744273243;
	bh=YgQZI2+bS0r3KyGq34MBVFDhX4BUm2eJmrGkw/kgVT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpWvJqaKvTE/btMBJezY0+TzIVZFo6iMd3QE9E3IGJVCDFd2F76GVsz57hOknfpE5
	 jZxllrJ3N3DbH3+uv9ZHHYrrfFgyRcK7QqSakVZiTg5lJs+o+nwwllB2G2g2ivYJ0f
	 XZdHUzjN71la1YQ85wZ+ULJsoBZKXmxNkFFfI7zZILynyLL+8H34GHTgc8exE4YpLM
	 Wv85WSPJn19pxfUXpjS18ukegqDYAleOgGZ/39ODRJvzIgCsFk2LqnmO6ok1NfZjTh
	 p23jjdXQODTYtCQ9mESNPxKIFf4ZQAK9pzJunWbJgfcyy6XJVURM9aoh5Ev+5mz0DX
	 Fm0HaSUcp0csw==
Date: Thu, 10 Apr 2025 09:20:36 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <Z_d_VDvgBkgt4UhS@kbusch-mbp>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
 <20250409103148.GA4950@lst.de>
 <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
 <20250410071559.GA32420@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410071559.GA32420@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_012044_402109_50DC27AF 
X-CRM114-Status: GOOD (  18.20  )
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

On Thu, Apr 10, 2025 at 09:15:59AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
> > 
> > Thank you for your review and comments. However, I'm not sure I fully
> > understand your points. Could you please provide more details?
> > 
> > AFAIK, the NVMe protocol has the following description in the latest
> > NVM Command Set Specification Figure 82 and Figure 114:
> > 
> > ===
> > Deallocate (DEAC): If this bit is set to `1´, then the host is
> > requesting that the controller deallocate the specified logical blocks.
> > If this bit is cleared to `0´, then the host is not requesting that
> > the controller deallocate the specified logical blocks...
> > 
> > DLFEAT:
> > Write Zeroes Deallocation Support (WZDS): If this bit is set to `1´,
> > then the controller supports the Deallocate bit in the Write Zeroes
> > command for this namespace...
> 
> Yes.  The host is requesting, not the controller shall.  It's not
> guaranteed behavior and the controller might as well actually write
> zeroes to the media.  That is rather stupid, but still.

I guess some controllers _really_ want specific alignments to
successfully do a proper discard. While still not guaranteed in spec, I
think it is safe to assume a proper deallocation will occur if you align
to NPDA and NPDG. Otherwise, the controller may do a read-modify-write
to ensure zeroes are returned for the requested LBA range on anything
that straddles an implementation specific boundary.


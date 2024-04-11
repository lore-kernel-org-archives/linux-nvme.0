Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7824CD11C2
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OEIc3BFOzXRSk9xarIrXi9oKkK8pwQS/Tvtu7+e+Hyc=; b=OZadloMr19XaxzTYctuloXI2Wc
	ABLBh6rV45zax2/RaNlvR3b9avGKOVGIjAMmr+MJl0ozIjDZu/pAJUyd7xnp+TxiikcK7t/5fISs0
	NaQYRpm8qnHeBcEy9OXj1kfHqlgP5Wz/w1omSUtEaStjQy7bH6QlZ0GtpTSFJNXtD/e+T0X1/L0gw
	LyysI+R8He0AJxpq1aeiSSlrrCjNfcr8txD2NmB2kp30D1DffRoa5Gy/+Shn1TUTbVXfOrulcxG6b
	vZO7NmQNT5fiKvIbbBP4feIeFvfObqdPWEhzhXWkZEyPNxqUcO6c6ssViJBFDh7vbRcH86X5n7XsS
	lF6WMDKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruiJm-00000009ftL-0hTb;
	Thu, 11 Apr 2024 00:29:30 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruiJi-00000009fsy-1o2Q;
	Thu, 11 Apr 2024 00:29:26 +0000
Date: Wed, 10 Apr 2024 17:29:26 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>,
	Dan Helmick <dan.helmick@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v6 10/10] nvme: Atomic write support
Message-ID: <Zhcu5m8fmwD1W5bG@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-11-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326133813.3224593-11-john.g.garry@oracle.com>
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

On Tue, Mar 26, 2024 at 01:38:13PM +0000, John Garry wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
> 
> Add support to set block layer request_queue atomic write limits. The
> limits will be derived from either the namespace or controller atomic
> parameters.
> 
> NVMe atomic-related parameters are grouped into "normal" and "power-fail"
> (or PF) class of parameter. For atomic write support, only PF parameters
> are of interest. The "normal" parameters are concerned with racing reads
> and writes (which also applies to PF). See NVM Command Set Specification
> Revision 1.0d section 2.1.4 for reference.
> 
> Whether to use per namespace or controller atomic parameters is decided by
> NSFEAT bit 1 - see Figure 97: Identify – Identify Namespace Data
> Structure, NVM Command Set.
> 
> NVMe namespaces may define an atomic boundary, whereby no atomic guarantees
> are provided for a write which straddles this per-lba space boundary. The
> block layer merging policy is such that no merges may occur in which the
> resultant request would straddle such a boundary.
> 
> Unlike SCSI, NVMe specifies no granularity or alignment rules, apart from
> atomic boundary rule.

Larger IU drives a larger alignment *preference*, and it can be multiples
of the LBA format, it's called Namespace Preferred Write Granularity (NPWG)
and the NVMe driver already parses it. So say you have a 4k LBA format
but a 16k NPWG. I suspect this means we'd want atomics writes to align to 16k
but I can let Dan confirm.

> Note on NABSPF:
> There seems to be some vagueness in the spec as to whether NABSPF applies
> for NSFEAT bit 1 being unset. Figure 97 does not explicitly mention NABSPF
> and how it is affected by bit 1. However Figure 4 does tell to check Figure
> 97 for info about per-namespace parameters, which NABSPF is, so it is
> implied. However currently nvme_update_disk_info() does check namespace
> parameter NABO regardless of this bit.

Yeah that its quirky.

Also today we set the physical block size to min(npwg, atomic) and that
means for a today's average 4k IU drive if they get 16k atomic the
physical block size would still be 4k. As the physical block size in
practice can also lift the sector size filesystems used it would seem
odd only a larger npwg could lift it. So we may want to revisit this
eventually, specially if we have an API to do atomics properly across the
block layer.

  Luis


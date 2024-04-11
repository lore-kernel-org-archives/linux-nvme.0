Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2807CC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8fDcPBM4Ze2RPgrAoXs/w5z2M5QE6GW5bGItfgRyJ8=; b=wH3BDZwbZpxi31a+ep3bewAt2H
	0G8MyMWMcx4kYaDtn8SwIbO/0HFMYPUCFXmwLuT0WQIhMQkRG0WmCMTE8zeqmZO159wPzvtXnNAc1
	KkKqdSxVYbiz5nXXUcChdIkRTyEy6VH2h1UBnRu61usgd/9hUN/xMZRJ6SxQBh32uguxRawwhxn2d
	8gQj7sZL78krxtP28z5uvnIY5e85tp63Zmi4JpfEKtFYoBJIk1Ewewu9jW3jUOTYCW+CzZMkNI0l3
	Rfb0HIYLXYbPWYWNprZvMbxcfGa04nEpBQbg0PMMBWWOpc/vJZi51HiTc9OZFScSb4o74M/7hep4K
	75elTsSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruxCZ-0000000D3B1-3yWU;
	Thu, 11 Apr 2024 16:23:03 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruxCN-0000000D38A-1CHz;
	Thu, 11 Apr 2024 16:22:51 +0000
Date: Thu, 11 Apr 2024 09:22:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dan Helmick <dan.helmick@samsung.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
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
Message-ID: <ZhgOW8yBPuuae4ni@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-11-john.g.garry@oracle.com>
 <Zhcu5m8fmwD1W5bG@bombadil.infradead.org>
 <143e3d55-773f-4fcb-889c-bb24c0acabba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <143e3d55-773f-4fcb-889c-bb24c0acabba@oracle.com>
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

On Thu, Apr 11, 2024 at 09:59:57AM +0100, John Garry wrote:
> On 11/04/2024 01:29, Luis Chamberlain wrote:
> > On Tue, Mar 26, 2024 at 01:38:13PM +0000, John Garry wrote:
> > > From: Alan Adamson <alan.adamson@oracle.com>
> > > 
> > > Add support to set block layer request_queue atomic write limits. The
> > > limits will be derived from either the namespace or controller atomic
> > > parameters.
> > > 
> > > NVMe atomic-related parameters are grouped into "normal" and "power-fail"
> > > (or PF) class of parameter. For atomic write support, only PF parameters
> > > are of interest. The "normal" parameters are concerned with racing reads
> > > and writes (which also applies to PF). See NVM Command Set Specification
> > > Revision 1.0d section 2.1.4 for reference.
> > > 
> > > Whether to use per namespace or controller atomic parameters is decided by
> > > NSFEAT bit 1 - see Figure 97: Identify – Identify Namespace Data
> > > Structure, NVM Command Set.
> > > 
> > > NVMe namespaces may define an atomic boundary, whereby no atomic guarantees
> > > are provided for a write which straddles this per-lba space boundary. The
> > > block layer merging policy is such that no merges may occur in which the
> > > resultant request would straddle such a boundary.
> > > 
> > > Unlike SCSI, NVMe specifies no granularity or alignment rules, apart from
> > > atomic boundary rule.
> > 
> > Larger IU drives a larger alignment *preference*, and it can be multiples
> > of the LBA format, it's called Namespace Preferred Write Granularity (NPWG)
> > and the NVMe driver already parses it. So say you have a 4k LBA format
> > but a 16k NPWG. I suspect this means we'd want atomics writes to align to 16k
> > but I can let Dan confirm.
> 
> If we need to be aligned to NPWG, then the min atomic write unit would also
> need to be NPWG. Any NPWG relation to atomic writes is not defined in the
> spec, AFAICS.

NPWG is just a preference, not a requirement, so it is different than
logical block size. As far as I can tell we have no block topology
information to represent it. LBS will help users opt-in to align to
the NPWG, and a respective NAWUPF will ensure you can also atomically
write the respective sector size.

For atomics, NABSPF is what we want to use.

The above statement on the commit log just seems a bit misleading then.

> We simply use the LBA data size as the min atomic unit in this patch.

I thought NABSPF is used.

> > > Note on NABSPF:
> > > There seems to be some vagueness in the spec as to whether NABSPF applies
> > > for NSFEAT bit 1 being unset. Figure 97 does not explicitly mention NABSPF
> > > and how it is affected by bit 1. However Figure 4 does tell to check Figure
> > > 97 for info about per-namespace parameters, which NABSPF is, so it is
> > > implied. However currently nvme_update_disk_info() does check namespace
> > > parameter NABO regardless of this bit.
> > 
> > Yeah that its quirky.
> > 
> > Also today we set the physical block size to min(npwg, atomic) and that
> > means for a today's average 4k IU drive if they get 16k atomic the
> > physical block size would still be 4k. As the physical block size in
> > practice can also lift the sector size filesystems used it would seem
> > odd only a larger npwg could lift it.
> It seems to me that if you want to provide atomic guarantees for this large
> "physical block size", then it needs to be based on (N)AWUPF and NPWG.

For atomicity, I read it as needing to use NABSPF. Aligning to NPWG will just
help performance.

The NPWG comes from an internal mapping table constructed and kept on
DRAM on a drive in units of an IU size [0], and so not aligning to the
IU just causes having to work with entries in the able rather than just
one, and also incurs a read-modify-write. Contrary to the logical block
size, a write below NPWG but respecting the logical block size is allowed,
its just not optimal.

[0] https://kernelnewbies.org/KernelProjects/large-block-size#Indirection_Unit_size_increases

  Luis


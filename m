Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E40C2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0p4kqzKFUCVmNcLq/1A1C/e9CGTEhRb9a63Z93oJ7k8=; b=tbfNZD5rnZHTnk592CwpuaxX4j
	h7phfpixiqG2PeaR+cKjQsiZ+6dJxrH1YF+5ZDFfBdPShX70mKteQ3/3G0LVPT67m9oFdhl54yYAl
	cuRlxoSNn5JM3nWOZ6ZEQgZsJqYRKkPN+tGGVJqe9xfvNZhBEV4dr/SNjof93uzPfIWe2nmnMxSsU
	7SBynoNRAWVYO9xeWAXHASvG540uzjQ61ztHgm2EWo6WeLABgh+8NmI6wjAq0g282bI4c/Tmmh/dQ
	79yVWH/1A93rI9SHxWNudAiaBit/8/T/qxcpg++ONzG67tytklFnkNxCLhTK79CNBqKMYm3BkMaEC
	KZxv4DzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR55B-00000006Csu-1ayY;
	Tue, 09 Jul 2024 07:16:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR555-00000006CsK-2BJM
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 07:16:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7225268AFE; Tue,  9 Jul 2024 09:16:04 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:16:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240709071604.GB18993@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <yq1ttgz5l6d.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ttgz5l6d.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_001607_727321_8F307617 
X-CRM114-Status: GOOD (  32.63  )
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

On Mon, Jul 08, 2024 at 11:35:13PM -0400, Martin K. Petersen wrote:
> I don't like having the BIP_USER_CHECK_FOO flags exposed in the block
> layer. The io_uring interface obviously needs to expose some flags in
> the user API. But there should not be a separate set of BIP_USER_* flags
> bolted onto the side of the existing kernel integrity flags.
>
> The bip flags should describe the contents of the integrity buffer and
> how the hardware needs to interpret and check that information.

Yes, that was also my review comments.

> The other alternative is to only expose a generic CHECK or NOCHECK flag
> (depending which polarity we prefer) which will enable or disable
> checking for both controller and disk in the SCSI case. But that also
> means porting the DI test tooling will be impossible.
> 
> Another wrinkle is that SCSI does not have a way to directly specify
> which tags to check. You can check guard only, check app+ref only, or
> all three. But you can't just check the ref tag if that's what you want
> to do.
> 
> I addressed that in DIX by having individual tag check flags and NVMe
> inherited those in PRCHK. But for the SCSI disk itself we're limited to
> what RDPROTECT/WRPROTECT can express. And that's why BIP_DISK_NOCHECK
> disables checking of all tags and why there are currently no separate
> BIP_DISK_NO_{GUARD,APP,REF}_CHECK flags.

So what are useful APIs we can/should expose?.

If we want full portability we can't support all the individual checks,
because the disk will check it for SCSI even if we don't do the extra
checks in the controller.  We could still expose the invidual
flags, but reuse the combinations SCSI doesn't support on SCSI,
although that would lead to surprises if people write their software
and test on NVMe and then move to SCSI.  Could we just expose the
valid SCSI combinations if people are find with that for now?

> > Last but not least the fact that all reads and writes on PI enabled
> > devices by default check the guard (and reference if available for the
> > PI type) tags leads to a lot of annoying warnings when the kernel or
> > userspace does speculative reads.
> 
> > Most of this is to read signatures of file systems or partitions, and
> > that previously always succeeded, but now returns an error and warns
> > in the block layer. I've been wondering a few things here:
> 
> Is that on NVMe? It's been a while since I've tried. We don't get errors
> for readahead on SCSI, that would be a bug.

Note that these reads aren't readaheads (well, they actually are too
because everything in the buffer cache does a readahead first), but
probing reads from blkid / partitions scans / etc.  Right now the
driver has not way to distinguish them for reads that are really looking
for (meta-)data that is expected to be there.

I'm not currently seeing warnings on SCSI, but that's because my only
PI testing is scsi_debug which starts out with deallocated blocks.



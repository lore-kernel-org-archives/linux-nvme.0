Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F1C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSx5jpmmLEewlonMu1sE/caa7FmbXF5z9XALmJJ8S2U=; b=n/wuLNJJGhaCRL5j4X/1X3FEDG
	DcqRwkXDxZVUgy/rZiDXQsq/Iqpvzq5smdGkUBSpia3GCZ0jIhNA+209GgtC1E9wBKbRFB7ljDjx0
	Z4cOdt/2l66JHUh4g1roHV3TOAE6mIQl1SpfeZRpRPI9FSwUNrnl+tcqdLX4386Zqx7nkeWa2pNsW
	tfiEElYVmJDSwv/bwH1wCerm46Lc3BQ5PlSD2k1FxmrLP3mnS//ytkM4F+OU6G5K2nNRbuAzDlHi7
	HSaftnEpSKcEyDMTUbp2aOmp951ClpD1RhG4aYaK07giaxkQdSAH7DaZrgy4elnTVq6gL74UwfNot
	74wfj37A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUL0d-0000000BRLp-1GNL;
	Mon, 29 Jan 2024 06:20:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUL0Z-0000000BRLP-3TUb
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:20:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95A9768B05; Mon, 29 Jan 2024 07:20:35 +0100 (CET)
Date: Mon, 29 Jan 2024 07:20:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <20240129062035.GB19796@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-16-john.g.garry@oracle.com> <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com> <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_222040_050810_86A05BBD 
X-CRM114-Status: GOOD (  16.14  )
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

On Thu, Jan 25, 2024 at 11:28:22AM +0000, John Garry wrote:
> We have limits checks in XFS iomap and fops.c, but we would also want to 
> ensure that the the block layer is not doing anything it shouldn't be doing 
> after submit_bio_noacct(), like merging atomic write BIOs which straddle a 
> boundary or exceed atomic_max (if there were any merging).
>
> The SCSI standard already has provision for error'ing an atomic write 
> command which exceeds the target atomic write capabilities, while NVMe 
> doesn't.

Can you get Oracle to propose this for NVMe?  It always helps if these
suggestions come from a large buyer of NVMe equipment.

> BTW, Christoph did mention that he would like to see this:
> https://lore.kernel.org/linux-nvme/20231109153603.GA2188@lst.de/

I can probably live with a sufficiently low-level block layer check.


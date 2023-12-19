Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DE2C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiAuXmgC8GVNW3XfE0yfuXdAqapU0a48/ad7W5fezDs=; b=yTATAM43BgTAn701qQ7LiGVFMb
	rpWyVSkEeeLNSqcN4fphiyXf/+8lTU5pKDGtwKttGFJh/dbGFblwUER2CWtGv0wgXNfV38+h3FnKO
	SMeEnyMWvsuOwoyeD1pemgHTq+43/7lUA24USE2L/LVsNvbZujulv+ZcxOPSr/7zh1y9E11hl6Jmd
	SV3BNoLCK0pYjsDCsErpFPecIqhUx6UkXSXMFuOJWyLCVrzFCxY2L2S7y/8AM+DeJN6C/EJdNywnD
	PMyBVkbGSOI9dYvnxQUxvbS6tHLCM+nATjp3OxkTDzO6NBTloXoVob1pEbRv9kQW8GwygWC2WC6N2
	RKg6yCiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbrF-00EWgq-2j;
	Tue, 19 Dec 2023 15:18:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbrC-00EWfl-2z
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 15:18:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D046C68BFE; Tue, 19 Dec 2023 16:17:59 +0100 (CET)
Date: Tue, 19 Dec 2023 16:17:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231219151759.GA4468@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_071807_109667_AC3CC7E9 
X-CRM114-Status: GOOD (  12.49  )
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

On Tue, Dec 19, 2023 at 12:41:37PM +0000, John Garry wrote:
> How about something based on fcntl, like below? We will prob also require 
> some per-FS flag for enabling atomic writes without HW support. That flag 
> might be also useful for XFS for differentiating forcealign for atomic 
> writes with just forcealign.

I would have just exposed it through a user visible flag instead of
adding yet another ioctl/fcntl opcode and yet another method.

And yes, for anything that doesn't always support atomic writes it would
need to be persisted.


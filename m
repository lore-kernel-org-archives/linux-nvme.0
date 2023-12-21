Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C507FC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5A8S23WWSyecM76/3jjUJRcPk+ICW0RSwrI8FWXI0Vo=; b=yNwWG2MT38Ld9UbrOH2vPFTrRv
	LXDZr1Hsy81B/lwtXeyaAscTR5Dvbf0sucd0SbkkqgXSDtrINeOWQ/Y1Mg0yy27blslej/aZBRcp/
	+pFCQxVC5yuAU0/mj6CWfRxNBu7l2auvJeCO3bdd+x7IKtgbDDUQKtWwZvfo4jRaM9ks4+7mal7T5
	HbQXswj21yHqaSxh35a7622fC4FGOdf81fvGFfS2poVxGKZA7hOFxs9nc7EiRWsQQJVF31y+PTJ8m
	a4zVTZ3G8nQy2FaGdiv89kzJgBSQjbgUpRmDm3X4ddxeE7O8HVy+TxB0m74i9v00vgL0luXwMOovx
	IuELyKtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGI1T-002jSq-0v;
	Thu, 21 Dec 2023 12:19:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGI1Q-002jSS-17
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 12:19:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9193E68B05; Thu, 21 Dec 2023 13:19:25 +0100 (CET)
Date: Thu, 21 Dec 2023 13:19:25 +0100
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
Message-ID: <20231221121925.GB17956@lst.de>
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_041928_524235_4DD902B8 
X-CRM114-Status: GOOD (  19.51  )
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

On Thu, Dec 21, 2023 at 09:49:35AM +0000, John Garry wrote:
> I noticed the NVMe patch to stop always setting virt boundary (thanks), but 
> I am struggling for the wording for iovecs rules. I'd like to reuse 
> iov_iter_is_aligned() to enforce any such rule.
>
> I am thinking:
> - ubuf / iovecs need to be PAGE-aligned
> - each iovec needs to be length of multiple of PAGE_SIZE
>
> But that does not work for total length < PAGE_SIZE.
>
> So then we could have:
> - ubuf / iovecs need to be PAGE-aligned
> - each iovec needs to be length of multiple of atomic_write_unit_min. If 
> total length > PAGE_SIZE, each iovec also needs to be a multiple of 
> PAGE_SIZE.
>
> I'd rather something simpler. Maybe it's ok.

If we decided to not support atomic writes on anything setting a virt
boundary we don't have to care about the alignment of each vector,
and IMHO we should do that as everything else would be a life in
constant pain.  If we really have a use case for atomic writes on
consumer NVMe devices we'll just have to limit it to a single iovec.


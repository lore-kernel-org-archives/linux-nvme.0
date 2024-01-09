Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1D2C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lql9X72W4wEDKbW+TlkVeWbQSJY0E5ER8JGCc5S+EEI=; b=nbiUg+qIvG+yB2uQxb7HTdONAy
	MjBu0F+vvylUBrXt+f+Q0IVFpPrR8fd3OC3UFgT6heVfLPf4xD+OFa0XkSjiJoPr1dl2j9jzGO/b3
	fIQBh2MdovlTPb+ktaenr07awlXuIJU4O1+2+cKUh7CTds8EQjR2LWaB+GuQhFayrjNaKBEl9KIFL
	Cd0STYHVUozm6WvWFGFtemH1qsphBe1r9NhvW8P21pfWbySoVU2ZtFVewm7Awf+eJpoZivy6pVcYG
	uaA1ipWQrkRqqAFtzB/yTmzM99yi7WZUcuaZ7t+LGlHf/Ycu4CDmBqdXYhA/SZuJW7iuoZcT987uu
	V552Ql2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNEYp-008lTT-2Y;
	Tue, 09 Jan 2024 16:02:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNEYm-008lSe-0q
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 16:02:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97BB368B05; Tue,  9 Jan 2024 17:02:23 +0100 (CET)
Date: Tue, 9 Jan 2024 17:02:23 +0100
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
	ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240109160223.GA7737@lst.de>
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_080236_507314_B0C7EBD4 
X-CRM114-Status: GOOD (  15.12  )
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

On Tue, Jan 09, 2024 at 09:55:24AM +0000, John Garry wrote:
> So a user can issue:
>
> >xfs_io -c "atomic-writes 64K" mnt/file
> >xfs_io -c "atomic-writes" mnt/file
> [65536] mnt/file

Let me try to decipher that:

 - the first call sets a 64k fsx_atomicwrites_size size
 - the secon call queries fsx_atomicwrites_size?

> The user will still have to issue statx to get the actual atomic write 
> limit for a file, as 'xfs_io -c "atomic-writes"' does not take into account 
> any HW/linux block layer atomic write limits.

So will the set side never fail?

> Is this the sort of userspace API which you would like to see?

What I had in mind (and that's doesn't mean it's right..) was that
the user just sets a binary flag, and the fs reports the best it
could.  But there might be reasons to do it differently.



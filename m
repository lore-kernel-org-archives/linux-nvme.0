Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FE8C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iL8qAqst6kaCYnfb4UoKbSMQsve+KXdSW8fBor7n+CY=; b=K59gDe+VfC9FxCRCGL2sbQnE87
	xVWS2BSoGZpMCU5RmzHElKtqJEC4xuNxcrNG/UHee3jaDbQzGDv+UswArtAi3TFOWY0lY3TliofWb
	AViJt+N/6VOPSlCNdNMQyeNaw6UTMmIZ39ndLpbc17YdB0Y/Sb9oCaPKWZ6PeqidD76HdHVRRxHBi
	/Bl2ZyJEtnB7E/q63Nn7vikXD0gLgEHdAWPwaZVpdvdBm1JTmyrSqlBmATFEFXiDv0XHKpxTitN7V
	VbBrbmb0HaDnOXXO/crCNFvtR5sqfYRMjo7zp496chpssDQVuI8qq3u/QbT3QMPCR8F6bUY9wz5f5
	bJtF1tEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA9GE-004gKT-1H;
	Mon, 04 Dec 2023 13:45:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA9GA-004gJf-1t
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 13:45:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4613D68B05; Mon,  4 Dec 2023 14:45:10 +0100 (CET)
Date: Mon, 4 Dec 2023 14:45:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231204134509.GA25834@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com> <20231128135619.GA12202@lst.de> <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_054518_767194_99417EC2 
X-CRM114-Status: GOOD (  17.59  )
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

On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
> ok, fine, it would not be required for XFS with CoW. Some concerns still:
> a. device atomic write boundary, if any
> b. other FSes which do not have CoW support. ext4 is already being used for 
> "atomic writes" in the field - see dubious amazon torn-write prevention.

What is the 'dubious amazon torn-write prevention'?

> About b., we could add the pow-of-2 and file offset alignment requirement 
> for other FSes, but then need to add some method to advertise that 
> restriction.

We really need a better way to communicate I/O limitations anyway.
Something like XFS_IOC_DIOINFO on steroids.

> Sure, but to me it is a concern that we have 2x paths to make robust a. 
> offload via hw, which may involve CoW b. no HW support, i.e. CoW always

Relying just on the hardware seems very limited, especially as there is
plenty of hardware that won't guarantee anything larger than 4k, and
plenty of NVMe hardware without has some other small limit like 32k
because it doesn't support multiple atomicy mode.

> And for no HW support, if we don't follow the O_ATOMIC model of committing 
> nothing until a SYNC is issued, would we allocate, write, and later free a 
> new extent for each write, right?

Yes. Then again if you do data journalling you do that anyway, and as
one little project I'm doing right now shows that data journling is
often the fastest thing we can do for very small writes.


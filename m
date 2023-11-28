Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F111DC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79RQ5BK62/uIfmNJLcWbdBvAWQB/n8mjNXQaV7KOCs8=; b=uhUn6xyXMn728sNJrYzdgaeKyl
	1U0vaAKfIvqDGh5X2IuEtWT/8fqNaLrFzb1ZO01AxI5qLfGdcdQ/8M+uteN+EE0FnN+zwBbxHRwEn
	f1MRqkRkIAfEiDLgZR0u8Y4X9pVh9OrIAQx36p1MvW3no2XAen9ftEJ9V36rvV4Cbz0329L3ts3+e
	hkG3ZpoAB2pTiz6ZprsUoFGlzeU+EhV/uwuGIQv5FDgQDNBpPOCjzW6thIQHo6v7OMSBwBjK9K5SO
	Pt0J5LmU9AxBmfZsjzSvPkRG0IlviJFRXs4p4od5hgHLD629ITrli26SWnQqG5y9i/W7UaNCErqAd
	zDDLwyVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yZk-005QUO-22;
	Tue, 28 Nov 2023 13:56:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yZf-005QTh-0D
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 13:56:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6897227A87; Tue, 28 Nov 2023 14:56:19 +0100 (CET)
Date: Tue, 28 Nov 2023 14:56:19 +0100
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
Message-ID: <20231128135619.GA12202@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_055627_248935_3077F42F 
X-CRM114-Status: GOOD (  19.27  )
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

On Tue, Nov 28, 2023 at 08:56:37AM +0000, John Garry wrote:
> Are you suggesting some sort of hybrid between the atomic write series you 
> had a few years ago and this solution?

Very roughly, yes.

> To me that would be continuing with the following:
> - per-IO RWF_ATOMIC (and not O_ATOMIC semantics of nothing is written until 
> some data sync)

Yes.

> - writes must be a power-of-two and at a naturally-aligned offset

Where offset is offset in the file?  It would not require it.  You
probably want to do it for optimal performance, but requiring it
feeels rather limited.

> - relying on atomic write HW support always

And I think that's where we have different opinions.  I think the hw
offload is a nice optimization and we should use it wherever we can.
But building the entire userspace API around it feels like a mistake.

> BTW, we also have rtvol support which does not use forcealign as it already 
> can guarantee alignment, but still does rely on the same principle of 
> requiring alignment - would you want CoW support there also?

Upstream doesn't have out of place write support for the RT subvolume
yet.  But Darrick has a series for it and we're actively working on
upstreaming it.


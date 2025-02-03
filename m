Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC5C02196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GEeRARndOURU601MNaUwqkzgOLPL0RKLmzvNkf3CvH8=; b=LWHnwb3hgKMx2WRrV9CKnSkAmm
	VV6p6XvoMaj6/TtYt4WbRjACxEMstpFuJJL6nKymvQZuaUSe419EWMSrEa6CsjwyLru/tuoyYxOii
	Cn7FDvJwI72jIjEtJ7tfXKIotb2xf/Z+ehknOyZeZ6+2GTUhQAfMTNxtTTPXXBUmsM9YG8Jh/qQEx
	6r9Du0mmXd5KKq60H4JJRzrMtoNG0Oeb/Rp46O86++G20zmevtglfMSazHFsV1ocFzotCk5XyjyXM
	J/bdWDkFhCe0paeXdHe77uUziCpE/w7isQoY7Rpu8rkVUk2fbtIWhhPo9o/mGoSC/aQmU2EC3gge+
	3WSBVwlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terrT-0000000EqNk-1LWr;
	Mon, 03 Feb 2025 08:31:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terqQ-0000000EqEQ-1Jdo;
	Mon, 03 Feb 2025 08:30:14 +0000
Date: Mon, 3 Feb 2025 00:30:14 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B-luT-CzxyDGft@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6B9uSTQK8s-i9TM@casper.infradead.org>
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

On Mon, Feb 03, 2025 at 08:26:33AM +0000, Matthew Wilcox wrote:
> so this is a block layer issue if it's not set.

And even if the flag is set direct I/O ignores it.  So while passing
through such a flag through virtio might be useful we need to eventually
sort out the fact that direct I/O doesn't respect it.

Locking up any thread touching memory under direct I/O might be quite
heavy handed, so this means bounce buffering on page fault.  We had
plenty of discussion of this before, but I don't think anyone actually
looked into implementing it.



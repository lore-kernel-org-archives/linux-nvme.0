Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF9CC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EklWgIl7f2YxkVHDck9gMHvU/i9NPS04u1tBkQjqRM=; b=pEMxXv3wkuHR3EpraLvwXl2AlO
	GmUFC+sUEib8Tbfcq4w5h+G8VKA2PmW+a7Jnkor3dj/3nHn/b8rTBAqrVwmqX5zkB+S54SX+ughlP
	bATt0nneUajck0pYz8UxEvM5kV0qh9yn+SyHoGWLF1j9PojCzmvVB+96zmBkRhGlJMDPKzNcSicYf
	C0YzVreBVnNS4HnTw8v3X67c8HEZ28TKP3GwgnRGHOI/O1XFhjPabt+iFhgwC9XqaF/h4GUsSG/01
	VA7VCVnyErI/UuNHcsnrxB8o/PYl0olXK+dMV/In0T01fISawcz6x5FiPedr+R7tfBPsKaP9jSVsR
	S3kxfxcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSn1-0000000D7RY-3Hdp;
	Mon, 29 Jan 2024 14:39:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSmz-0000000D7Ph-0mEw
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 14:39:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF20468C4E; Mon, 29 Jan 2024 15:39:02 +0100 (CET)
Date: Mon, 29 Jan 2024 15:39:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <20240129143902.GA654@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-16-john.g.garry@oracle.com> <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com> <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com> <20240129062035.GB19796@lst.de> <ca58facd-db6b-42b2-ace3-595817c81ca9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca58facd-db6b-42b2-ace3-595817c81ca9@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_063909_391569_228393EB 
X-CRM114-Status: GOOD (  14.61  )
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

On Mon, Jan 29, 2024 at 09:36:38AM +0000, John Garry wrote:
> That would probably be in blk_mq_dispatch_rq_list() for block drivers with 
> .queue_rq set, but I would need to check for a good place for ->queue_rqs . 
> I can't imagine that we just want to inefficiently iter all rqs at the 
> ->queue_rqs call point.
>
> However considering the nature of this change, it is not a good sign that 
> we/I need to check... I'd be more inclined to leave as is.

Heh.  At least early on having the checks in one place in nvme makes
me feel easier for sure.  If we can easily use the block limits for
the checks we shouldn't have to keep duplicate values in nvme, though.



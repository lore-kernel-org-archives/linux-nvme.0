Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF9AC2BA15
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 06:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ufPFShQINU0uLcOBa8sW8ATP6/HudDM4ZW72iQ7Sqo=; b=CY2w2h1VA3rqyhBfNv4mRt90c8
	WGojFeLpNRfFSGqYCIkUosMXDFBTtkNdEqJ3+BWiN3Sbc3m4vp/qhkLzrbsS+ntUzboUuKhhiG9EL
	dZmPmV38IlGZgOLXJcYQLqKA744TKeSJSu8HOwixgU13kxpzxlLF/V8Qgh5JIineQoq42YiBG/e17
	bMIyArBZcVoxGvl83jpSl4qDKbjlbfIDXWJrTL0iNBxxcbVFSICxm1AA8ofDVIwq74QXhE2tdVc5g
	7i6fmhwsqPN8UnE1MNLzGveSYZzpNNOf8WXTCuUWJu5dDq+3RgkUpa1VfgHjeO9KPnfjajdd9RnrZ
	cWtw2wHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSh7-0000000DsZe-0O1y;
	Tue, 18 Jun 2024 06:51:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSgW-0000000DsPZ-423A
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 06:51:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70B8D67373; Tue, 18 Jun 2024 08:51:12 +0200 (CEST)
Date: Tue, 18 Jun 2024 08:51:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v8 05/10] block: Add core atomic write support
Message-ID: <20240618065112.GB29009@lst.de>
References: <20240610104329.3555488-1-john.g.garry@oracle.com> <20240610104329.3555488-6-john.g.garry@oracle.com> <ZnCGwYomCC9kKIBY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnCGwYomCC9kKIBY@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_235117_348781_525033BA 
X-CRM114-Status: GOOD (  15.29  )
X-Mailman-Approved-At: Mon, 17 Jun 2024 23:51:51 -0700
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

On Mon, Jun 17, 2024 at 12:56:01PM -0600, Keith Busch wrote:
> I'm not sure I follow why these two need to be the same. I can see
> checking for 'chunk_sectors % boundary_sectors_hw == 0', but am I
> missing something else?
> 
> The reason I ask, zone block devices redefine the "chunk_sectors" to
> mean the zone size, and I'm pretty sure the typical zone size is much
> larger than the any common atomic write size.

Yeah.  Then again atomic writes in the traditional sense don't really
make sense for zoned devices anyway as the zoned devices never overwrite
and require all data up to the write pointer to be valid.  In theory
they could be interpreted so that you don't get a partical write failure
if you stick to the atomic write boundaries, but that is mostly
pointless.


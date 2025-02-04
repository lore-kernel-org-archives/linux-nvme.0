Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41677C02194
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76c1TtSnx6JZufkNQiY8vEierEYkzU4cNo1gbjwWYaQ=; b=HIGEZigxnc52OC546/+uy6cGW+
	cv/WtNcJ+ZOXVdTLWKC19cdTMl+FWgFUw+K2P+CJF86LBor0AakJmTZ3cn94GG7Sk7R2TW9S0s0VA
	zJUreETwCo4yKydOf8YvXdIORxW3d03apIcS0eIty3MeHJzib2n46BQBiwZepDYoslrxtyg9R+rHz
	jqcWxww6HMOYcgoHFFHDhXoM4bkJBs3qzbtVrjSvErYlgaG23PJo5ntByhrgMK62Ule7DQGVPFU5U
	CGnCiwz9X2EL/M0vLamLW9pcfMaNrcMpLjx4qV3+qc8sHpb406mnZbFVroC96nFZOeH7I9OwNc3Nv
	8Z/aN0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJIg-00000000Zvs-1frQ;
	Tue, 04 Feb 2025 13:49:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJIc-00000000Zur-1tSh
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 13:49:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2825968D05; Tue,  4 Feb 2025 14:49:02 +0100 (CET)
Date: Tue, 4 Feb 2025 14:49:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250204134901.GA11902@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de> <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com> <20250204051208.GG28103@lst.de> <yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_054910_630005_67E6C28B 
X-CRM114-Status: GOOD (  15.14  )
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

On Tue, Feb 04, 2025 at 07:52:38AM -0500, Martin K. Petersen wrote:
> I have been told that some arrays use it to disable PI when writing the
> RAID parity blocks. I guess that makes sense if the array firmware is
> mixing data and parity blocks in a single write operation. For my test
> tool I just use WRPROTECT=3 to disable checking when writing "bad" PI.

Hmm, why would you disable PI for parity blocks?  But yes, outside of
Linux there might be uses.  Just thinking of a "perfect" format for
our needs.

> >
> > That would also work fine.  NVMe supports 4byte crc32c + 2 byte app tag +
> > 12 byte guard tag / storage tag and 8-byte crc64 + 2 byte app tag + 6
> > byte guard / storage tag, although Linux only supports the latter so far.
> 
> Yep, the CRC32C variant should be easy to wire up. I've thought about
> the storage tag but haven't really come up with a good use case. It's
> essentially the same situation as with the app tag.

Exactly, it's an app tag by other means.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D108EED606
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ha6rW27ZIti3ibXL0Tfok2s62J7TAoIUJwlpmmHK2s=; b=hMlz6S3PUQTcyAwTD7k3LffnZt
	40jHbFSNWchBFEYkQSN78cCPZE8BS/u3aw7Yc4E5Pfzg9q5ti0PndmYpIHcLBzhYta67RHdftHl6A
	wVDKoAPHXAwk1YAJ1eVJyuD+x6+O6kqA88VhS5G8g2CSzcg85A0gSecLYS+TbRQp+U4CW6j9F/DyA
	a2fWP2qKXoQwGDUK18jAMLuKGkTH22zKiWWgq88mompOI+6WwPGK7PLllKXb1WGgtpepFC0O3v9dL
	Kmj+d2SLsl8yREISLUAyPe1+yJV7hpWbeoPYKqVprgAxkh6g5+wI3lcFMwwwMd+LeOvgsV/sCqgrB
	DVObNBEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokNV-0000000DHWX-44uN;
	Thu, 12 Sep 2024 14:00:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojKb-0000000D6gN-0xL7
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 12:54:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1096E227AAF; Thu, 12 Sep 2024 14:53:48 +0200 (CEST)
Date: Thu, 12 Sep 2024 14:53:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
Message-ID: <20240912125347.GA28068@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com> <20240910150200.6589-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_055354_885298_4767713C 
X-CRM114-Status: GOOD (  12.47  )
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

On Tue, Sep 10, 2024 at 08:31:56PM +0530, Kanchan Joshi wrote:
> Rename enum rw_hint to rw_lifetime_hint.
> Change i_write_hint (in inode), bi_write_hint(in bio), and write_hint
> (in request) to use u8 data-type rather than this enum.
> 
> This is in preparation to introduce a new write hint type.

The rationale seems a bit sparse.  Why is it renamed?  Because the
name fits better, because you need the same for something else?

>  static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -			  enum rw_hint hint, struct writeback_control *wbc);
> +			  u8 hint, struct writeback_control *wbc);

And moving from the enum to an plain integer seems like a bit of a
retrograde step.



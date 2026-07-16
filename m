Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C39C44501
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vN6BZjNAL13b8uR7AaLLQSpyg/U4Cqi6Fq/CQ0mKf2g=; b=hdBJ1S5z00XbYGEmoAyH4ZQ9Gx
	OmWiSm1HiGaKNyfJco1kZvYSiA2nZPR68HDDDUg8FA42L65yPlyTf3Teh+LF/PR93dxxewbvGmSOp
	ecXSTn/ADESAy32PHAlBkuLoN5A2kLdZKUsex0/c9nmPSr8QVot4s0zfOyZc9mS3nn3Q8kKR3bMeO
	OIf9mvXM5MWdUUz8WXPZ7Sb7XxjrhuMUbUaUnBthxKOiHpIG3iDrf0/kD/Z0uqaeCBvkQh4GRbTkW
	FiZDzlZehjbqhjqaWZzfQO31e9OMqW2mfgOL6B25d1qxFkXLKF8tVquTmlvZAtYODDLShRHSWMpjL
	JAEFDoHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkL5c-0000000HEnd-2CK5;
	Thu, 16 Jul 2026 12:21:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkL5Z-0000000HElB-1rB7
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 12:21:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D99C68AFE; Thu, 16 Jul 2026 14:21:08 +0200 (CEST)
Date: Thu, 16 Jul 2026 14:21:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise
 BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <20260716122108.GA30437@lst.de>
References: <20260627061933.2187447-1-csander@purestorage.com> <20260627061933.2187447-3-csander@purestorage.com> <20260714135310.GB714@lst.de> <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com> <aleu49e4GxG-Z7B6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aleu49e4GxG-Z7B6@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_052117_645045_4CD09C48 
X-CRM114-Status: GOOD (  17.20  )
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

On Wed, Jul 15, 2026 at 10:01:39AM -0600, Keith Busch wrote:
> > I mentioned this in the cover letter (and that's why I marked these
> > patches "RFC"). Unless you have a clever idea, it does seem like an
> > insurmountable obstacle here.
> 
> We had a similar problem when we enabled PI at the end of the metadata
> rather than just at the beginning. This left machines unbootable after
> upgrading the kernel, so we have a module parameter to turn off support
> for the feature. It's an unpleasant solution as there's no upgrade path
> to ever turn on the feature without a format first.

We could opt into not faking up type 1 PI with a REQ_ or BIP_ flag.
But we'd really need a user that actually wants it first.


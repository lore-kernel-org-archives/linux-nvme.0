Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB20C6FA82
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 05:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6iAeX9q8mCDHKH2mZ0i3MKsdkJXmkphNfUOKwLrfvQ=; b=4K22p8TfW9WnUijqUWzMIPfEt2
	YFrv5ITRUa0jnCi0Q5mfrucjL5LS+mxYDvZ7ao3ntZJZsr/tX4tC/P9t1lHWWrQ2dzCEs/skRwjME
	UsuPPrXrjUA907K/Uj9vJE7ezLfcJxqTVzJVPWXP15MhkOpuwFpUj9/BF7IAsTt9DBae7jc1/xPBo
	gwDGrg69l6Ub6IbfhfTRojztTIlNnpz2e/VjLy30If03ukcjW2cY/Vdfsx2aLBDw3eLFXd197MhNE
	WQ4dFE2wbgZQAtxon7frowV4oP9OkoMOkrvsahY245rbJs3SYgiVN5yxcgOcMMD6oR9OtM7jVz0ct
	2mc3o+dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt9Z-006UPd-TO; Sat, 10 Sep 2022 05:35:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt9X-006UOd-Ky
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 05:35:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBD2F68B05; Sat, 10 Sep 2022 07:35:36 +0200 (CEST)
Date: Sat, 10 Sep 2022 07:35:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	j.granados@samsung.com, javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220910053536.GB23158@lst.de>
References: <20220909163307.30150-1-joshi.k@samsung.com> <CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com> <20220909163307.30150-2-joshi.k@samsung.com> <47e19485-f321-cd2a-3408-173434b04d01@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e19485-f321-cd2a-3408-173434b04d01@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_223539_848838_B9722B3F 
X-CRM114-Status: GOOD (  15.58  )
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

On Fri, Sep 09, 2022 at 10:55:45AM -0600, Jens Axboe wrote:
> > +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
> > +{
> > +	/* allow write/read based on what was allowed for open */
> > +	/* TBD: try to use nvme_is_write() here */
> > +	if (opcode & 1)
> > +		return (mode & FMODE_WRITE);
> > +	else
> > +		return (mode & FMODE_READ);
> > +}
> 
> The read/write distinction doesn't make a lot of sense to me. You've
> already been able to open the device at this point. It would only make
> sense to limit some things based on FMODE_WRITE imho, not FMODE_READ.

True.  Note that the I/O queues can also send fabrics commands, which
we must exclude, and I'd also very much exclude vendor specific commands
as we can't trust them at all - they aren't even guaranteed to interpret
the nsid field like the standard ones.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003FF532E5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFWI+NRaexg3w0uy7xvDl5tSHg0Q0/dCPAOWmhbacsY=; b=FG3sFaHhzbmxIvLEquiykPFHYA
	5t3YuuogLitrwQmYyJq9mR56R7YgNrf+j0oRBwNbA+pTzs9ebIprJUZNlpB5Te3jnzZtBdrgqHxZv
	yNZrh9eNtenhLbtCCZ/5oEMa2yFW15S6puXhF17tdbKM644nFgY5QIOngr1cupbS7oc2d56sdHc1p
	MZOkrJS9voY/TmlYBj5tGMOnf7TM/+CR+aarwBGf4v4dtzknJk6MaOTovNDqr9FCPyd2uz9JOxxJ/
	zoBEisuE+1DLNrwl2dyMHaI/lUZZyotTWWD9815U9MHDnIKsZ8+3v69qu41k4pd6HNELcbGYYLnXO
	oMRWr5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vda-00000000qXl-3oEQ;
	Tue, 24 Mar 2026 06:53:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vdY-00000000qXM-2hqa
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 06:53:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D769C68AFE; Tue, 24 Mar 2026 07:53:08 +0100 (CET)
Date: Tue, 24 Mar 2026 07:53:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] nvme: remove bogus check in nvme_pr_read_keys()
Message-ID: <20260324065308.GA1578@lst.de>
References: <ab5yUf3BqtlN3K-P@stanley.mountain> <acF-E8csusg-YbaO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acF-E8csusg-YbaO@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_235312_850380_25490AF0 
X-CRM114-Status: GOOD (  20.87  )
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

On Mon, Mar 23, 2026 at 11:53:23AM -0600, Keith Busch wrote:
> On Sat, Mar 21, 2026 at 01:26:25PM +0300, Dan Carpenter wrote:
> > This check for if (rse_len > U32_MAX) is confusing because if
> > rse_len is > INT_MAX, that will trigger a WARN() in kvzalloc().
> > Fortunately, the caller blkdev_pr_read_keys(), puts a limit on num_keys.
> > The number of keys can't be more than PR_KEYS_MAX (65536) and the
> > condition is impossible.
> 
> There's actually two callers: blkdev_pr_read_keys() ensures the number of
> keys is smaller than 65536 and iblock_pr_read_keys() is a fixed size at
> 16. But begs the question, what guarantee does nvme_pr_read_keys() have
> that all the callers validated the number of keys such that it can
> bravely skip checking it? I think nvme should validate that it's a
> reasonable value before calling kvalloc so we return an apporpriate
> EINVAL instead of ENOMEM. The existing UINT_MAX check is certainly far
> too high, but I think something like a 4MB payload would be a totally
> reasonable upper limit for nvme on this function.

Agreed.


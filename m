Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A913BD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s2s269VSQDr6DmooInNmrWpJCkW6Q3KucZcZCuzemCA=; b=G8ZhWd0iAB4v1vLllXfY5mmq6v
	Ats8xygTIQBJ9WcN2YDQsx7VsGSM8ruAjewkX5HMm6UjK6Bf9BzVHeQnZmmCkOqvyq5s+TUa9B0wo
	0fhyVtBRI+yoJ3ZzKm3lOZBff3mixCGd9eKY3FD6a56OyZ4KosoROToRUk7CuFIRSktVJ9X5CqaI0
	6NKvo2fp+eIDH8Ywac9S/2ejRiiSDphbObm3KSxnyH2k7D600sEow6WpSS2Tg0NiA+1eWbQIDLx/k
	eiwqHrakHk9z8s7XxwPglp3/O1RG0YBpS8IVyv430Q8uRJ0S3iUIJcWAPiZhgo42dunajsjSVqWSN
	Sk7e3+kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YfG-00000001sC0-2h8i;
	Wed, 06 Nov 2024 05:33:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YfE-00000001sBb-1qYj
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:33:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45C3868AFE; Wed,  6 Nov 2024 06:33:04 +0100 (CET)
Date: Wed, 6 Nov 2024 06:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj gupta <anuj1072538@gmail.com>,
	Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk,
	kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241106053303.GB31192@lst.de>
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141459epcas5p27991e140158b1e7294b4d6c4e767373c@epcas5p2.samsung.com> <20241104140601.12239-7-anuj20.g@samsung.com> <20241105095621.GB597@lst.de> <CACzX3AuNFoE-EC_xpDPZkoiUk1uc0LXMNw-mLnhrKAG4dnJzQw@mail.gmail.com> <20241105135657.GA4775@lst.de> <b52ecf88-1786-4b6f-b8f3-86cccaa51917@samsung.com> <20241105160051.GA7599@lst.de> <51b67939-cbd8-4213-967a-9c6b2ecd5813@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b67939-cbd8-4213-967a-9c6b2ecd5813@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_213308_665734_9AB4E58F 
X-CRM114-Status: GOOD (  15.40  )
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

On Tue, Nov 05, 2024 at 10:08:46PM +0530, Kanchan Joshi wrote:
> We both mean the same. Currently read/write don't [need to] use big SQE 
> as all the information is there in the first SQE.
> Down the line there may be users fighting for space in SQE. The flag 
> (meta_type) may help a bit when that happens.

IFF we ever have a fight we need to split command or add an even bigger
SQE.`

> What I rather meant in this statement was - one can setup a ring with 
> SQE128 today and send IORING_OP_READ/IORING_OP_WRITE. That goes fine 
> without any processing/error as SQE128 is skipped completely. So relying 
> only on SQE128 flag to detect the presence of PI is a bit fragile.

Maybe the right answer is to add

READ_LARGE/WRITE_LARGE (better names welcome) commands that are defined
to the entire 128-byte SQE, and then we have a bitmap of what extra
features are supported in it, with descriptive names for each feature.
Not trying to have one command for 64 vs 128 byte SQE might also be
useful to have a more straight forward layout in general (although I
haven't checked for that, just speaking from experience in other
protocols).


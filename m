Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B37D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58f2YdJn+PIiyr9oLcN0kt8L857PGVz3lksRbeBI2mM=; b=YbTeFQ3PE6IajmnUdLGNhhTfKI
	ZJH4qrnYexJn8szbYtNiSSxaKT/bw1Rei/p5eMNwUmzPx2sAQeeUcc6m5xgFPDqviD+tm5Oxxd6CE
	VLGKIY2utpGDtvwTH5U9/QUfBHmwU/uQVVOxk+BUDrEKHmBAe+7mFOJFtHePyRnHzWCtIPu5n0+HT
	sPdN3RFjrRbNqza8eCSx8uXw5WL251zlX172kb1o9oYoyHBVBJpjOL7BGz8lZZ/a6rbNXhfXx4xfT
	xi1iYQ+sQ/qeVs9hf1U0m2NJMUjqoWViEIG4fYHu4c4SDxd3HtER7EsW/KVUHZpxMNKlMj8OB4uDZ
	lJWAxCpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0cO-00000003dTm-2X9d;
	Fri, 15 Nov 2024 18:00:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0cM-00000003dTI-1Gjb
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 18:00:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B6C768D0A; Fri, 15 Nov 2024 19:00:21 +0100 (CET)
Date: Fri, 15 Nov 2024 19:00:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Pavel Begunkov <asml.silence@gmail.com>,
	Anuj Gupta <anuj20.g@samsung.com>, kbusch@kernel.org,
	martin.petersen@oracle.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241115180020.GA26128@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de> <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com> <20241114151921.GA28206@lst.de> <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com> <20241115171205.GA23990@lst.de> <97b3061c-430d-4fc0-9b62-ab830010568e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b3061c-430d-4fc0-9b62-ab830010568e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_100026_483072_EBB38E52 
X-CRM114-Status: GOOD (  13.04  )
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

On Fri, Nov 15, 2024 at 10:44:58AM -0700, Jens Axboe wrote:
> Let's please lay off the hyperbole here, uring_cmd would be a terrible
> way to do this. We're working through the flags requirements. Obviously
> this is now missing 6.13, but there's no reason why it's not on track to
> make 6.14 in a saner way.

I don't think it would actually be all that terrible.  Still not my
preferred option of course.



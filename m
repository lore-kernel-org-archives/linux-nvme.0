Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47801D116FE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pu5izOjh3tRvyNJZ54kEpgX2g6ULDR3XI5cmromcEt4=; b=Qcidt6aasffxKay6LsdKJM0PsE
	grcZzbQ+U89HS+l9UaQ4bwmC86MBrFiu2cdePXksK+pxNEzyd8rLpO/y6mQPU7h8Lck1swI3azEDl
	HpKP991JXfhwCjG/bDukdOAgCHVr5ycvFiqkI7W97AxNeMgjo3gqhYuEE5hbsCuzGVKPKLdYHbpIp
	2e4K78l87vIUL+ST5HuegJwyppJqfUbETEaObixwAApOBNvR3q7dKqLdGesb5AflxrL3g6vB1WmIM
	ihCJiDnnRXbuIv6QQG+DoY/OtgTIYv+e2YYPy/8/VHqzi41xNAt6XPL9a403krqKomDDMeFJkw0eQ
	lkVewaiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQX0v-00000005ncJ-2fD7;
	Tue, 02 Dec 2025 20:30:21 +0000
Received: from out30-73.freemail.mail.aliyun.com ([115.124.30.73])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQX0s-00000005nbp-05yK
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 20:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764707410; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Pu5izOjh3tRvyNJZ54kEpgX2g6ULDR3XI5cmromcEt4=;
	b=gQDdZ9umYzTXu0xhJ/iZQxPTU3NqekNnjDpcoVF1KdfqT95SJ4+gthSWh4eUBW+rDSxJEifWwBlJs2mrjt3z7KaQU1jYVIGHws54zuIwUUjGR3RKskSuhKipyyD8UDA/7adUHthTqnZurwuQ8MGq+abgt7TsTbkMffIPK5b1hVU=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtxxRk2_1764707406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 04:30:08 +0800
Date: Tue, 2 Dec 2025 23:30:04 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aS9MTGx6V6VacZeH@localhost.localdomain>
References: <aS3v2_VcV8IwsT6g@localhost.localdomain>
 <aS4yhAhZYjvHOqtD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4yhAhZYjvHOqtD@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_123018_574295_E19A9EF2 
X-CRM114-Status: GOOD (  10.40  )
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

> > -	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> > -		struct nvme_ns_id_desc *cur = data + pos;

> > +	pos = 0;
> > +	do {

> > +	} while (pos < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur));

> I don't want bikeshed this, but I thought this looked better as a
> for-loop. You can just modify the continuing condition instead of
> changing the loop type to do-while.

OK, tried to make the patch as close as possible to previous code.
See v4.

Also, adding 'pos += len' to modified `for` makes the line longer
than 80 symbols. However, checkpatch.pl says it is OK. Let me know
if it should be fixed somehow (e.g. by moving 'pos += len' to the
end of loop compound statement).


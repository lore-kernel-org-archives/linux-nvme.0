Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C954FCF34CD
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 22:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVj+wSsh4cf2uBOXlAJ67cfhtx5pQhOFpZ/jN++jz9o=; b=SoMWpoWHTQOhA5fC6JIPwoS8Zy
	3+4x1ra6lCqGAG0CjvQPJfbEwqWeDH6jbUIWT01ZNVvLVdFaC4I9Cz951wvcNZnv4Zim+gaVxgZPq
	NcPGRMapfQ+5SyqdB0Itb3G1tErGWDhBoZvLFtfOA6afA4P2GDma4bNlMfZxH67KUp640F29Xgby5
	z/sSVtxk55zLx/bcJBd1j1v0qpizgTyZSmf4aihKCHRQJjJQNwbXjWq1zTAbJ61r33k6K5oiiOtsY
	Xp8ocWgNp189x312uvp25JvOMni2/0Ss7hiJMgUOiHYi9ILJqRth6bsfhgqTGE1D+4pYG/9DxvMSX
	rEA1bruA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swTx0-0000000ATI3-0RV9;
	Thu, 03 Oct 2024 22:05:34 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swTs9-0000000ASTJ-18x4
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 22:00:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XKQbN2JFNz6ClY9l;
	Thu,  3 Oct 2024 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727992824; x=1730584825; bh=IVj+wSsh4cf2uBOXlAJ67cfh
	tx5pQhOFpZ/jN++jz9o=; b=ZJIG9etAuWeFo63DpU/5WwAcTYG/bRzhE3wzJYpQ
	oBlGAqnYxaBh+QVigZvS9kx6RYYOZkfl6xWqBUAt5BVnOJSoB3q4q6cz80o8aYvJ
	K2Shx0X1Rp/EttqJZWDy1nQ6nicWBMBk+7kCwtNmFw+8iVQtNCfTlmrvnNek6vK3
	GkKMMCgkVLY6o5Oh/Z4Iv/qfKoyZ6UHjK1sTb06NdoazfzcJ6+H21i5awSnrXFG7
	OxNoUffo9CbUWoWkio1vBZYQ5+rzzbgzGlhV/SS55svleC/L/5mWsp8qzDkBhGd4
	45/JSp1kRUppFi4ixDePMIhrbbHgu2ZYiwFaYBROcz6N7g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TAmCIb-0ZlQg; Thu,  3 Oct 2024 22:00:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XKQbB4FqSz6ClY9k;
	Thu,  3 Oct 2024 22:00:22 +0000 (UTC)
Message-ID: <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
Date: Thu, 3 Oct 2024 15:00:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 hare@suse.de, sagi@grimberg.me, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
 <20241003125516.GC17031@lst.de> <Zv8RQLES1LJtDsKC@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zv8RQLES1LJtDsKC@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_150033_372977_3BD69947 
X-CRM114-Status: GOOD (  12.49  )
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

On 10/3/24 2:48 PM, Keith Busch wrote:
> The only "bonus" I have is not repeatedly explaining why people can't
> use h/w features the way they want.

Hi Keith,

Although that's a fair argument, what are the use cases for this patch
series? Filesystems in the kernel? Filesystems implemented in user
space? Perhaps something else?

This patch series adds new a new user space interface for passing hints
to storage devices (in io_uring). As we all know such interfaces are
hard to remove once these have been added.

We don't need new user space interfaces to support FDP for filesystems
in the kernel.

For filesystems implemented in user space, would using NVMe pass-through
be a viable approach? With this approach, no new user space interfaces
have to be added.

I'm wondering how to unblock FDP users without adding a new
controversial mechanism in the kernel.

Thanks,

Bart.



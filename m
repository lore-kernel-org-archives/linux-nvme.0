Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451A5C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mWu6waa/eExAxYRUAnoTwItAGCpuazH4rLKqgG96C8=; b=efpUtsr+QLqJkxCT28URnsFw+W
	CftDNGCM6u+vaS4gTJVUc4/4FaIfDKzDf6Qc1OLj2GkqwgKzjdr9U5OQuI0iJiioh1s7FNSDihWNH
	pDyEQHVei4RWW0WJhiCvH7w6iBIXDXgDsQ3TUK7dApYVPbiEZzDG6GAajYEJ8VG1zNQRZrRE/BqrW
	1P+gm5uq2msU9dHmGDrK9+Ero/O15ClEqywpC+o2yLAGYSzRvqyypB/QFIMcI8ZyTwxJqPwR+4U/X
	PrK4DZYlYJHqCG8uWiTIy8ODs5GwjVt4zkp37MP7hgAnPmbrD4JMwg6HZRAfqQMtEhdA8HMz6j1t8
	n5YlkiYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMX5X-004F6a-On; Mon, 30 Jan 2023 16:32:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMWWP-0047me-Ua; Mon, 30 Jan 2023 15:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9mWu6waa/eExAxYRUAnoTwItAGCpuazH4rLKqgG96C8=; b=N7uPHTWPGmAjOpUyXSdHKwzsf0
	P7m5o2YCc2SPrUM53GBqEjstm4f9rUNbFiNVNO83vBNi9ApDmmn6E5TiygPJS+fxB+YXg++PPMub3
	kn/S1vPTebK8q5k+/NSJ7moWkYZ2bogSwfhWeuhfvU7o8Fd9krLZAjTbTaj3UWdWJEc3dDwQOS5Qf
	QaHhqInKGI88eUDDrj8MQF8DJvRCQ84LKPbSYsFGD8RpY6u+MUK11lsLrWyv3fxexoeL/Z23Fg2uJ
	Z2D+hrazKuC7PgrLiBO7nc8HyZS8LKtzv/C+N/2yPYdUbyZw4d+4uLeJy0iDzfCacGBAZj//H1EQl
	1eatJfqA==;
Received: from mx.cjr.nz ([51.158.111.142])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pMWVo-004074-1v;
	Mon, 30 Jan 2023 15:56:06 +0000
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pc)
	by mx.cjr.nz (Postfix) with ESMTPSA id AF6077FC21;
	Mon, 30 Jan 2023 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
	t=1675094184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9mWu6waa/eExAxYRUAnoTwItAGCpuazH4rLKqgG96C8=;
	b=IUWRXB4ZfZFvP08TAcu46IaSIPcqcOXTl56O8WHSQOaAhhkIQ9u88zYSEpIN2pbiC4jpac
	jwGLtOnkbS+BV6uGbYvUTH2ghLzufe3qfEFRbAHRz9p2wIlhENt9DpUj0oE60tlK+yywCT
	paOb0uNIIGHUk9S0XG3mYKsUFRPaYkoUgAjTvyhLEVU5Z9Cvmu7NO+rjrH2opN+EgEjgFa
	fnzP4VIRAyAwr2ru+CZp9aX3dvfrMSXIvEWmaEh/hC29vO//ntKkMtDT6T0I20V2zRFjSn
	4AWbxuRM00n7wzPS9dmDdPu7fsBiZbJIvRcLAZa39v75gFyA93kfj3o+j2QjPg==
From: Paulo Alcantara <pc@cjr.nz>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Minchan Kim
 <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <kch@nvidia.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Steve
 French <sfrench@samba.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mike
 Marshall <hubcap@omnibond.com>, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
 io-uring@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 13/23] cifs: use bvec_set_page to initialize bvecs
In-Reply-To: <20230130092157.1759539-14-hch@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-14-hch@lst.de>
Date: Mon, 30 Jan 2023 12:56:16 -0300
Message-ID: <87357shv8f.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_155604_954188_0A02268D 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 30 Jan 2023 08:31:49 -0800
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

Christoph Hellwig <hch@lst.de> writes:

> Use the bvec_set_page helper to initialize bvecs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/cifs/connect.c |  5 +++--
>  fs/cifs/fscache.c | 16 ++++++----------
>  fs/cifs/misc.c    |  5 ++---
>  fs/cifs/smb2ops.c |  6 +++---
>  4 files changed, 14 insertions(+), 18 deletions(-)

Acked-by: Paulo Alcantara (SUSE) <pc@cjr.nz>


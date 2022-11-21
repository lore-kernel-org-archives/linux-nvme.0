Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A3CC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-Type
	:MIME-Version:Subject:cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDwjBu4RghRAGfAihvi/wXSTBbp9s9Q2lKXWhxCyRLY=; b=33Ixsa4jWJjvHLYMcNZbfX8U3C
	gUDrfemDlVssxHVuDHwQ+qiSXt210RsLURtOzecuwa4P+ndJW7fc8HOurdSnK3mTmQ4D3j1uhoAXD
	8T6DTuLgllnTtHW4O31J3MqifzlLGLz6s4D1VkEkmc2ibesKsnQ8kbs5iqT7pT84QszyTmwGYHpO8
	M4/mD6JOfOzY4cECZfUzFr49tyGHKwVYp3wA9rj+0nHnzvQWlfnYxTxrmDEwjSkn8cXrnh332P08x
	yz53xWEsIbEnpG+13Y5uw+0rpN/1JCbAGh9FmUl1Sie5CNCcaYGkl4UC4h8hyHzYoBP/8zfXUeFFe
	QyXsEbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox95u-00FOfu-6M; Mon, 21 Nov 2022 15:52:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7IQ-00E9OS-Ux
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 13:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669039033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDwjBu4RghRAGfAihvi/wXSTBbp9s9Q2lKXWhxCyRLY=;
	b=bkPOmsZZUEPy0ywvExnX2YY9fPvl83no39+1/4A3FgMGKqSUr4yVkaZNl7x4R338gjD1aq
	J9IKjIFN+mmwG9zh0w1JUmoVA7sEcyFIY30zU8KRpJ+IV6u/t4UIkHzvK90/vTIIRAVrCJ
	CrU3ISXEmgvMGLgk3WKiuSspO+webm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-r7ih-rJfOeutGzbihEzMtw-1; Mon, 21 Nov 2022 08:57:10 -0500
X-MC-Unique: r7ih-rJfOeutGzbihEzMtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2049F811E67;
	Mon, 21 Nov 2022 13:57:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14F9D2027062;
	Mon, 21 Nov 2022 13:57:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
References: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com> <cover.1669036433.git.bcodding@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Philipp Reisner <philipp.reisner@linbit.com>,
    Lars Ellenberg <lars.ellenberg@linbit.com>,
    Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
    Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
    Sagi Grimberg <sagi@grimberg.me>, Lee Duncan <lduncan@suse.com>,
    Chris Leech <cleech@redhat.com>,
    Mike Christie <michael.christie@oracle.com>,
    "James
 E.J.
 Bottomley" <jejb@linux.ibm.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>,
    Valentina Manea <valentina.manea.m@gmail.com>,
    Shuah Khan <shuah@kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Steve French <sfrench@samba.org>,
    Christine Caulfield <ccaulfie@redhat.com>,
    David Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>,
    Joel Becker <jlbec@evilplan.org>,
    Joseph Qi <joseph.qi@linux.alibaba.com>,
    Eric Van Hensbergen <ericvh@gmail.com>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Anna Schumaker <anna@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>,
    Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
    linux-block@vger.kernel.org, nbd@other.debian.org,
    linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
    linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org, cluster-devel@redhat.com,
    ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
    ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
MIME-Version: 1.0
Content-Type: text/plain
Date: Mon, 21 Nov 2022 13:56:59 +0000
Message-ID: <382872.1669039019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_055715_091232_E0363E53 
X-CRM114-Status: GOOD (  14.82  )
X-Mailman-Approved-At: Mon, 21 Nov 2022 07:52:23 -0800
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


Benjamin Coddington <bcodding@redhat.com> wrote:

> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
> GFP_NOIO flag on sk_allocation which the networking system uses to decide
> when it is safe to use current->task_frag.

Um, what's task_frag?

David



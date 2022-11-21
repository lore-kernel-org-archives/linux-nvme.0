Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548A5C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=181ZHweS4wHRSdLySvK3fpfT7WMJLPwn/rNHBgW8rAk=; b=Ga+vWaWC5HQAH4Sy/pW/gYRWAV
	wQ3dLYzR7yQMXq+Kb2NyfdOJL+v9BPDiOvZ6V7Yy7Ai/zllb7CMey7a7RUxM5sLPqoGGydkU/oP0d
	7usKGaS8CZfo//6XhD4Ko75JC8n6OF9l+cF6gTRxQRYVkiXhogyNI/1zo9XCyHMSIUs2tVEqHmPPz
	Ef3ajVu5ABGmAIZaCYpRonQ/t65J1TTtRE6yWZHXHAYtttr5AmB8Cw9j0Icf3vBs2dkusvbOOS9DN
	WzxGGdZxHa25bBS+GiO9p6rpw9IiOEMZpw8N3zSsOLfBVZFZObg81ecrdT25aKyydeYmWEC7ZK8xF
	fCCmQofg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox95y-00FOsD-US; Mon, 21 Nov 2022 15:52:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7sz-00EZCZ-MR
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 14:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669041300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=181ZHweS4wHRSdLySvK3fpfT7WMJLPwn/rNHBgW8rAk=;
	b=aiK/KsY2wKTWcmefXXOuUYrTCtCiGRvPZfTwygH6p+GIoDYHia4WM5UPy2kwT7bpWgGeQq
	TniJf4bVqe+DMh4EbjqZWjCATAko9fuekkhz1Ye7zfoulNCDUQjgh+v4F+UPgNsj0wxLDo
	wvqCkOC6sNDOsWtpiZgha083BGTwLPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-cKpJPG72PVO5ijDDtOCqbA-1; Mon, 21 Nov 2022 09:34:58 -0500
X-MC-Unique: cKpJPG72PVO5ijDDtOCqbA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1521B811E7A;
	Mon, 21 Nov 2022 14:34:56 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 61D8E492B06;
	Mon, 21 Nov 2022 14:34:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie <michael.christie@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>,
 Christine Caulfield <ccaulfie@redhat.com>,
 David Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eric Van Hensbergen <ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, cluster-devel@redhat.com,
 ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Date: Mon, 21 Nov 2022 09:34:43 -0500
Message-ID: <51B5418D-34FB-4E87-B87A-6C3FCDF8B21C@redhat.com>
In-Reply-To: <382872.1669039019@warthog.procyon.org.uk>
References: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
 <cover.1669036433.git.bcodding@redhat.com>
 <382872.1669039019@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_063501_842099_A1F970BA 
X-CRM114-Status: GOOD (  11.66  )
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

On 21 Nov 2022, at 8:56, David Howells wrote:

> Benjamin Coddington <bcodding@redhat.com> wrote:
>
>> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
>> GFP_NOIO flag on sk_allocation which the networking system uses to decide
>> when it is safe to use current->task_frag.
>
> Um, what's task_frag?

Its a per-task page_frag used to coalesce small writes for networking -- see:

5640f7685831 net: use a per task frag allocator

Ben



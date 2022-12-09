Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58287C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OclmnU1jYcdMFqciE3c6RyUB6hgvanpdH2l220bFhz4=; b=moCs61PBVlJjHqTU5g7VGZU08M
	v/qw6HKQJdXveiB3HIytXk0t8W9cwjS564UeI+Ysm4wAePCtocFiSmAdpKlcpF97X9i76+T9q8U7G
	unvWDHMt4x+EV+goHIyoyCc/VHq+fDndLqYceqmrv4iUe7QtlxDn7bQtw5yUuddcbAV4e6lJg2Ba5
	bW7NT89NPTue7iyzT4QtxU/Jhl95ZhcR4UYQHGpw3SwaTj1hIQc7h5aHIsJ1cCO+yyt0PrSpLRPwZ
	FtaMKs+WoSG+o1yLiR2uNn5WMdrC1UhPRD3hIhA1CsbTCzibs7wTTnb+QxbivA2P+29dKMEBqLiYl
	MjOS/RVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p57s0-002cps-Fk; Tue, 13 Dec 2022 16:11:04 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3fxr-009J7c-UD; Fri, 09 Dec 2022 16:11:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 45F48B8289C;
	Fri,  9 Dec 2022 16:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20FEC433EF;
	Fri,  9 Dec 2022 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670602264;
	bh=OclmnU1jYcdMFqciE3c6RyUB6hgvanpdH2l220bFhz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lP5pQ24T3IT2YBfVVAYFE/vlA14kPUGpHI19DQSbfMFFqcLV6yfVQX2yzf3FWU9BJ
	 DEPOy15CleSzGVLHHvdVrCdctgS6AMOlWyxNMtd1UP4Jl6EFRe7WSmHsdwacu3KmIi
	 3gphHYn83fw+acEzH9vRCOj48wMtBY8ejFf/mJMd7kxsJCGH1dwZt2JHDO6M2WNy+F
	 RxYdcuexGpRtzv/r3df/M1OzYPk521V8CVwEXUXt0ZTCVSTYNw6OFG3RfFVHJS6f4s
	 Cy+bJUuWARFf6RP5DMfx0m0W7Y2ou/9vrV6yP2gJYTEe5AantjuQErI6+6QNzX5szc
	 v2qI3ygfSsAtw==
Date: Fri, 9 Dec 2022 08:11:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Christoph =?UTF-8?B?QsO2aG13?=
 =?UTF-8?B?YWxkZXI=?= <christoph.boehmwalder@linbit.com>, Jens Axboe
 <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Lee Duncan <lduncan@suse.com>, Chris Leech
 <cleech@redhat.com>, Mike Christie <michael.christie@oracle.com>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Valentina Manea
 <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Steve French
 <sfrench@samba.org>, Christine Caulfield <ccaulfie@redhat.com>, David
 Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Eric Van
 Hensbergen <ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-nvme@lists.infradead.org,
 open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
 v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Message-ID: <20221209081101.7500478c@kernel.org>
In-Reply-To: <d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
References: <cover.1669036433.git.bcodding@redhat.com>
	<c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
	<d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221209_081108_151068_2BBDA162 
X-CRM114-Status: GOOD (  10.01  )
X-Mailman-Approved-At: Tue, 13 Dec 2022 08:11:03 -0800
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

On Fri, 09 Dec 2022 13:37:08 +0100 Paolo Abeni wrote:
> I think this is the most feasible way out of the existing issue, and I
> think this patchset should go via the networking tree, targeting the
> Linux 6.2.

FWIW some fields had been moved so this will not longer apply cleanly,
see b534dc46c8ae016. But I think we can apply it to net since the merge
window is upon us? Just a heads up.


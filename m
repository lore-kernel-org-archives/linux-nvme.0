Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B543AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:13:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BE92089D
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KF2lE6n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BE92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N7QGD6Rh1FUKRQRmqO8CP2LNJggjf7V8jBWcJkrsxuU=; b=KF2lE6n/6kqUJM
	/W4hPsfAmbzP6W88ftVY3KvYjLpxM2Icc3XpVICu3+Maz/ByLcqMON5Ku+hZGEN1GdZaodS00tXNk
	slf7UvuSoSsER9v16QbhJx4jCCCP/tAGq0yHfXWILYRf5VTJqRzlDVk2LrXncPBVB0Sg4ls9DaKZc
	SdYjXz/3KsogT4u4vBY3KWTQU3Gc166mZqupPhCwpUZe4/FdQjk0fTkxYptykvRZtDehWnJbWdZT1
	IlEtdN8GP2HyCVR9nW126bChtP9aWTMe8bJH2nS604tqnb5XIQncp7ZWYDXQ08+pcHul+vgj1ISLg
	ssYKZD6vkAAXmh6LTYuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAqf-0001cz-Kt; Thu, 28 May 2020 05:12:57 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeAqN-0001QR-LQ; Thu, 28 May 2020 05:12:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: remove most callers of kernel_setsockopt v3
Date: Thu, 28 May 2020 07:12:08 +0200
Message-Id: <20200528051236.620353-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 cluster-devel@redhat.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jon Maloy <jmaloy@redhat.com>,
 linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ceph-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Dave,

this series removes most callers of the kernel_setsockopt functions, and
instead switches their users to small functions that implement setting a
sockopt directly using a normal kernel function call with type safety and
all the other benefits of not having a function call.

In some cases these functions seem pretty heavy handed as they do
a lock_sock even for just setting a single variable, but this mirrors
the real setsockopt implementation unlike a few drivers that just set
set the fields directly.


Changes since v2:
 - drop the separately merged kernel_getopt_removal
 - drop the sctp patches, as there is conflicting cleanup going on
 - add an additional ACK for the rxrpc changes

Changes since v1:
 - use ->getname for sctp sockets in dlm
 - add a new ->bind_add struct proto method for dlm/sctp
 - switch the ipv6 and remaining sctp helpers to inline function so that
   the ipv6 and sctp modules are not pulled in by any module that could
   potentially use ipv6 or sctp connections
 - remove arguments to various sock_* helpers that are always used with
   the same constant arguments

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

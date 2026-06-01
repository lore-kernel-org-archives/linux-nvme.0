Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4229DCD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9lZlRk3YRPMZnCFZJeXV/yskMMGrvYapFn0/QIAflQ=; b=oAPabqrCGpi+mZxgoJRNbfwHuj
	IWvLfObhcqPQ0/fai4Kjo6cZbPRU7uHArnbOUx+OODISi08Y2MzvbfGzDP4b7gREfm7R0+EbNVwmP
	V1zfNLOGgCwymUdfgQPLfFdzNqZ1HTcmhst6UmaTPCzEp72grvn7S2SDia+9pGWw+kqMVrp7i6V7Y
	Di0+NZ+kdofrbeQI4SOUqKit60Mn7AIS64oHC1pPz8a9QPn+eL1Q9zsSVYGWOFjM8fdmTqHJpY/HK
	hfxXUfozJKl5rYflj3t727TKHdS7MzgheHLJKEg9VpRnFlN/TteSMmT1qUNo2ynfmTdL2uxS2q3iP
	997+pPYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwoX-0000000AHYc-2tBu;
	Mon, 01 Jun 2026 07:11:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwoU-0000000AHYB-3PdA
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:11:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CD8A68B05; Mon,  1 Jun 2026 09:11:47 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-nvme@lists.infradead.org,
	syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
Message-ID: <20260601071146.GC7468@lst.de>
References: <20260530081059.428303-1-kuniyu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530081059.428303-1-kuniyu@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001155_017752_2F95B09C 
X-CRM114-Status: GOOD (  11.00  )
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

Looks ok.  Although I would have much preferred we would not have
done these stupid changes to the workqueue interface to start with :(

Reviewed-by: Christoph Hellwig <hch@lst.de>


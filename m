Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1481C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1720207DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xjqWv9wD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mahqk11P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1720207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RO2XIrxXgI0u4beGdlHM431Qo+iSqMD+B2L33PNebdo=; b=xjqWv9wDv+XEFkIGQiH2sogJkS
	H1iNsCu9xvLntVKSAgXExKERcHMtAuGoh642+HBgZ3JXQC3xN3almVi7FOBzk2LyobrPADU0XIgFK
	lpae1XXvrRtL44EtObLAGktK3VqSB55QbKtxjyg/40VWBrnBqiGWKi2RrtchvbOgCOi/0Luf4eCoL
	EXqxE1NXGk1au2zhtYHlj7XtrehhELdc2dyiXB6R4sglhH+kUgZstDUqDE0t/zBznjDCVILgR7tYr
	JHgIBrqqh/jwOLViwEptEXJ0bCrtOx9KVPEnFLdxTHrw2nbBQBIMrmkom93UZDwLTGb2GthEhbRNe
	hhH3eadQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k92r0-0000UX-3r; Fri, 21 Aug 2020 08:56:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k92qu-0000Ri-BK
 for linux-nvme@merlin.infradead.org; Fri, 21 Aug 2020 08:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=EVl8E61DXgRR1ZNIk2YxGikvQ2O1Ac8Y751dPUZf5kA=; b=Mahqk11P0dtVI6WvpVZ3wbPfd6
 TOLmouapre5P0kVTzEU3HqwZFByZlxCfsG6R4LCAQEde65aGjIHnOELkSeXiwBiVLsCgnaiFc5MSt
 bvGYyrZ9NusMwXnv+hlzhDJ+I4OVdlWF/WhR7di5/YwH+8C/4tFLNJRZdH9NKDu3+jfaCADVNAeGN
 ktm0Qw0jD8zXP93Qm5deyNsGMKjxkuKyjwIUIvulughoawMKj7P036hpaE1C8BhnQ1KNpjW7ltyqz
 UB5eZs1ummTyPWBBdfzQmKKtQe7CWVkU7RMOrEnMA4elIOFazI/1fyVNV75dx+bpdv3LTg5BtDuoO
 VVT7V/RQ==;
Received: from [2001:4bb8:198:f3b2:a2b:85ba:fb78:c253] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k92qE-0007el-7k; Fri, 21 Aug 2020 08:56:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: fix block device size update serialization
Date: Fri, 21 Aug 2020 10:55:58 +0200
Message-Id: <20200821085600.2395666-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Justin Sanders <justin@coraid.com>, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

this series fixes how we update i_size for the block device inodes (and
thus the block device).  Different helpers use two different locks
(bd_mutex and i_rwsem) to protect the update, and it appears device
mapper uses yet another internal lock.  A lot of the drivers do the
update handcrafted in often crufty ways.  And in addition to that mess
it turns out that the "main" lock, bd_mutex is pretty dead lock prone
vs other spots in the block layer that acquire it during revalidation
operations, as reported by Xianting.

Fix all that by adding a dedicated spinlock just for the size updates.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

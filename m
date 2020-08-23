Return-Path: <SRS0=yzsN=CB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC05C433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:10:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9802E2072D
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6F61BSs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j1K8V7pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9802E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A8NNaDWJdz8Qq4JS94+K1bIE7OxurcWtazCdXpZEIwo=; b=u6F61BSsCLrX9OfhDNwTyAtkZw
	GbJrXJQS3zv2eeI5v7o+m1iPXa3Psx/+I2ueWevEkntrL/IeCEVyXk8XmMThT5Rw0ubX/RSsD8bxI
	wWITcO/EQ4QC8tQ68ArsgJ9Qqw3In5r6W/VYOTyayPTeVXNvK7FomsPcEONtYsdDZXd7UtjIJ9Yuz
	fqjAeRPl4LWbQgfmCqoytvbbMVUjeRVQp+lGZhAItiYCLG/0TgqC31L1S+7VBtDqQ95h2k+GqPnpE
	Qn8On8eaI9/+xRFAfYsAbGr+63ek4eFlyR9mQOHUOIE+mqhrvpmkfNGd1F5/lzfZyD8+giUxV3npY
	S5MgQGBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9m1h-00089M-77; Sun, 23 Aug 2020 09:10:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1f-00088t-Ge
 for linux-nvme@merlin.infradead.org; Sun, 23 Aug 2020 09:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=No1/zNvYiAlQJ+2VM2KxEVKX9my3nDvRhpc7oRbGQdM=; b=j1K8V7plEOJeLPtvyxOs4Di0MB
 K/7b31MHvupcxYapWHKr1a0hx0nGDI6xZzN3XPcorEnvGv+Zd2hvS+dCLU05yaqKrDDzeFTm/4DtO
 upJ2qqAS7pLLSDzPsXlNqdj7D7Pc2xnMJCelkfwXxsJS21cH28KDhnBzkZGZGSwUwyHELrP7eZ6KM
 XOhkPG5Ftewq53mD+aBu0fTnMQD92wLWJFth+fzWO/WjGpN2OvwA8bBehgXFghsezlndydOr9WziI
 0j7oIrogrtZKa145H/tfv5KlcfSijH1M0kuxuZKyAyvozqf7s3ukgjpNbDng+n1qyEzvWz+45tV7+
 Ot/nIsDQ==;
Received: from 171.168.43.195.cust.ip.kpnqwest.it ([195.43.168.171]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1U-0003KT-Cw; Sun, 23 Aug 2020 09:10:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: fix block device size update serialization v2
Date: Sun, 23 Aug 2020 11:10:40 +0200
Message-Id: <20200823091043.2600261-1-hch@lst.de>
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

Changes since v1:
 - don't call __invalidate_device under the new spinlock
 - don't call into the file system code from the nvme removal code

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

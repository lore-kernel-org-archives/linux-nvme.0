Return-Path: <SRS0=SC3Y=FD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D8C64E7C
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 18:19:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593242085B
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1+v0NCZc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J0xbwQ+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593242085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SnXv1jspu7ogajA9uvwkyCwBkNT1LN1q5qlezzoBVyg=; b=1+v0NCZcW0gndsheWzJLbmXL//
	fw5GQ+2RmgqIfiZdE3LqvNjj5kNyql0LntGqcXG4YMCxgQNYp7rmrTcNJbNXc9YoT31ySv8hK7ppj
	tUBRS0Ce+wad1faNqONikj0uy3wJ0rIEkG8tNHLICCizSsz9B6FriiwkNH+StW9JEQJop2oRSpaEn
	/tpHXqM3kQPq8VCHUPV+jD0Df4YuhJOp9AelJwf8DSEi5k5nbZZwktPzuwRX2mKIdySqfwWc+auIY
	RDgUHUtVCULDmpXTvT2clBZcxPzDvqSURL0eoN/ZUg0U0EfDwNocg0l8FMlfUmTw69DElCqRAvqPY
	2mq0QnwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjRIW-0007Ru-I7; Sun, 29 Nov 2020 18:19:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjRIT-0007RZ-P0
 for linux-nvme@merlin.infradead.org; Sun, 29 Nov 2020 18:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=qBRhvARBbEpJSd0Ov2jhrf+2eiK0Ps4WvsnESinAIOA=; b=J0xbwQ+AZIdA4pOmO61IxJEmsb
 v/zKchTU+og2KXjyj1UatA6rvsgVzDzPlBTMVM2Kp7d2suehkxXuG9SIkwnIZ2IcRsNKucXDHaier
 6opmQz+HQvM9wxTbSTlQQR/JBN8vdr1E+Ya6ne1T1b6dvxrRASmvt1A0AFbFjC7zIfPiow4ssUZVb
 GogYVxBh5mT49CiexJRFYSbUdEMem1LfzQBor9ORiaRc/QfcjFyke35cOt4OqYutJEbqTIo0/v4Mc
 18ATFPYzOr1Z9Tw0eHZ+OmdfRIB5zGGSQMxqrGfDzCz/90gvA15ZpiKpwdBtsIJJVGqgP/TABm21T
 k40jR2Mw==;
Received: from [2001:4bb8:18c:1dd6:f89e:6884:c966:3d6c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjRIJ-00077F-BY; Sun, 29 Nov 2020 18:19:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: split hard read-only vs read-only policy v2
Date: Sun, 29 Nov 2020 19:19:22 +0100
Message-Id: <20201129181926.897775-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

this series resurrects a patch from Martin to properly split the flag
indicating a disk has been set read-only by the hardware vs the userspace
policy set through the BLKROSET ioctl.

This series is based on top of the

   "merge struct block_device and struct hd_struct v4"

series and won't apply to mainline or Jens' for-5.11 tree.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git block-hard-ro

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-hard-ro


Changes since v1:
 - don't propagate the policy flag from the whole disk to partitions
 - rebased on top of the merge block_device and hd_struct series

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

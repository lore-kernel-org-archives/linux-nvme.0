Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A112C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AB22082E
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imjnGK+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AB22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VNTYU5s2t01IKC99gyw3FrRSM2Ku3FEd7JIqdKeYJN8=; b=imj
	nGK+POasn8W+JCq6xOp3TKIpB20OmhDd5zoEWvuPfX763XIcCONwcfHkJzPcw0w2T9kRTbpzlbv84
	WnkwMAXzNzygelxv8VfZ23ZotLUaqtPNIVUdlF53pSp0PX/5Rh3TUYoPqSqY/t/C+0nLeIB1M+1Gx
	wmLx4qwfHAd+y1e2cEat0vV9yzlG55kDkRacTua3vKlhWobT+/dTKbl8XVGbRVB6K4/G6V0opzkfH
	nXRHYLCIAvA75Xe4vwGoPdqYQMmLRkRJNbMmbxU28winnYTE7Y2MP7TmffhfzN/XZVpDqDRjn2Spb
	WLb1bWOVkHEzk1dMl3YVCYXoYXFuWPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWh7B-0007J0-TC; Thu, 07 May 2020 14:03:05 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWh6k-0006oU-Hv
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 14:02:42 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 yorayz@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 7 May 2020 17:02:26 +0300
Received: from dev-l-vrt-071.mtl.labs.mlnx (dev-l-vrt-071.mtl.labs.mlnx
 [10.134.71.1])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 047E2QSS022772;
 Thu, 7 May 2020 17:02:26 +0300
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] Add nvme-tcp hpda support
Date: Thu,  7 May 2020 17:02:01 +0300
Message-Id: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_070239_170872_CB09C931 
X-CRM114-Status: UNSURE (   7.36  )
X-CRM114-Notice: Please train this message.
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Given the padding defined by user-space, the host driver will
send the requested hpda to the target which will support that
on nvme/tcp c2h capsules. The host will parse the capsules
according to the padding.

The request hpda is 0's based value in units of dwords in the range 0  to 31
(e.g., values 0, 1, and 2 correspond to 4 byte, 8 byte, and 12 byte alignment)).

Yoray Zack (3):
  nvme-fabrics: Add support for padding alignment (pda) option on tcp
  nvme-tcp: Add target padding support
  nvme-tcp: Add Host hpda support

 drivers/nvme/host/fabrics.c | 14 ++++++++++++++
 drivers/nvme/host/fabrics.h |  4 ++++
 drivers/nvme/host/tcp.c     | 21 +++++++++++++++++++--
 drivers/nvme/target/tcp.c   | 24 ++++++++++++++----------
 4 files changed, 51 insertions(+), 12 deletions(-)

-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

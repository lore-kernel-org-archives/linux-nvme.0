Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FDC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DA320672
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWrY1fRn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LM+byKgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GshiDBtCZaDLWpn0viILHfSBRl9lMyzWK85NHhBzOPM=; b=HWrY1fRn0QticfsoVBX+BlbsQa
	+i1i6SgITbKsGuHRbKrsc5LUEx314iw6Cn9/WhyWrUCgOCLZmXsULPU1hffBlyx4HjlAGqhXU+1+I
	aWohyqUwF8z0Q2aAjYluVbl55UeGNxZNj2r0NmUTIc0DbihQfNfiPS36GlnmAyp2R4T8cy64ocBxc
	OFmtosIq4ZtplhO4M0NNjs5QyVVQ4uHzYueOQHPPcTw65+dLZDVqJhPNBgAJ0ZoTyfL6RKcd64+zy
	OkHZ6Ic1YBo3S8NKJq0mnkWgPloV6cGvIXx4q/SrcZGG/ofbeXRCZJxelpr9Kl9Wl9KUwchxbGklR
	68UBxWZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0bxm-0006CM-KN; Wed, 29 Jul 2020 02:37:02 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bxj-0006BO-6h
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 02:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595990219; x=1627526219;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TolfB3x2n1hpMpxKqXCvzZoJinGdSAmb4PRSqAU8gdA=;
 b=LM+byKgob380GH6V8DMZ3E5zcL0LfoQQ/iNbsgiaevlgaWdxGLeDtMr3
 optct4mh7+2xaHoXmhLIGi0q1nDe9q5JKTRXUQSPfdOFklKA0tIT7UN90
 Jsqv9J1tMvIhk1XOAvIuboAY4qfre5IpO3GgJbS+OsDyLS+AnUiklaUXi
 nGeqf6PKkn5TLki3iLuEwLRf5edgyRn1hf5CoVZwnCqxHUs0WhyQr3n05
 tYMMcavjDtJuAFXFFbk9yjuBok86AoFUWKCXotMRKnorsSxBqA2wbidUA
 V13vwhTkQz0HjiCeTmOSK50dY0EUtAmp3CPelgFVtRONCQyhDiI+ZsLX+ A==;
IronPort-SDR: YI7YuMsgExZ/on8mf2qGECKIr8CTRhKciLZz3l9jXih1gVwPJNbqRZw9aFd2OACDqWIC0sPqBV
 f2r7mnXkvT5+y+tIE5aiypPyv8+WCkbOwD5iaSp3aPUOUxDizNd9qTcW1azM799+n0bMTISvSO
 EP41wA2qbxMJJFZFzluWqf7C1JC8T7o2zjZ2lioCHdfU5U3uSWqI0xxMUGdVJOO6tS2ecc/s53
 3KumgaRdsooXC6DBK/9AcsijzO+nXu7qZG9aMk3vul0N+fg/r/xb7oYmUSHDDtZXWlf9TDxljJ
 XPU=
X-IronPort-AV: E=Sophos;i="5.75,408,1589212800"; d="scan'208";a="143706166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 10:36:55 +0800
IronPort-SDR: qr3KY8Yp3DXVaCY3Mhv7bMt2BQUHzrjUMsI/CCOtNSxLx4laiYR/+3h0uwCGEPbpXBnAOCWoAn
 qU3U6kqD0/UMLP1ENWVtdxQiX+VaM1z34=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 19:25:03 -0700
IronPort-SDR: 1tnkubpIocgx58Pr3XB6xLCM3Mw7G1WgBkrotihtHJAD0mD2K9/TXN4P8bwWheJGb4WHwjLZP/
 gj4WPwh/0lew==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 19:36:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-loop: a fix and cleanup
Date: Tue, 28 Jul 2020 19:36:46 -0700
Message-Id: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_223659_439474_0C6C62D7 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series which fixes an issue with the loop
transport and removes the extra variable where a function can be called
directly.

Keeping the fixes tag on patch #1 if needed, patch #2 is just my
personal preference to minimize the number of variables when I touch the
code.

-ck

Chaitanya Kulkarni (2):
  nvme-loop: set ctrl state connecting after init
  nvme-loop: remove extra variable in create ctrl

 drivers/nvme/target/loop.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

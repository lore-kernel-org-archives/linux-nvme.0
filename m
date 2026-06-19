Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282AACD98FA
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 01:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WFQn9cyYD7xxCdJwqTB3QihjJ9Mi3lXMGfCrtiyosgM=; b=iJ91VvukyCGvObNloLxO+DlqPE
	L236miCXM/ce4R63EN63nTgaldplOVBlEmP/j5K7tSZ2UOFH/d2fyEqxUfoyWjD323BnQY/KTis2j
	heLtXlZKNNtkO9iNn3tQMpHwQFJOetofsT52gesMMEPNlJvZDHcyfw/mTPhKSXG+i+Zi6Tlj1T1Ll
	TQThcLAg1HosseniuvZGEOLQUO/1VcfP56b2qyPl2nsxBQn8mf0sBfurazlAjQvb3EvbidmmJbQnD
	/22p3JLnAKflOfYvexQ45gdbqGjSpkF0UuO8pVTRrezv7Ju8m5CgdvZcbD63NoC8qHh0bI1wJWL5g
	W5ZjwUtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7I-00000001v29-40xl;
	Fri, 19 Jun 2026 01:33:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7G-00000001v1N-2Ixy
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 01:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781832835; x=1813368835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JC1rLaV8mBzpHLseFLlm4ffQ+kFs4rOncvJQ0//9T1M=;
  b=YlaYis5j5uTA0bUmSHJHrLgH0kd6d2xCAeB6BJ8595bqv0wKo6cediBV
   g6QLG5sSq62zzFy10KRbPg6R0cQUdTcKklZDzOaW3ul0TVgteCTenVB6m
   FoDGf5nzy0ZN7+Nsz8Qav4rEi+MQBq2TLV9Z2lTIvW/pZWxRLJ+4zmHPI
   eF5xdOMpPVpDdKYsn35zOZVPPFJYY/WRgwV1yjLWjCRvRF3D3Sf7dqyns
   CHH2ZtlYhZPloTLTa3gkb0fVN9Q2bx6/YDCreW4ol6n8ZiT9nhTgFkpro
   pHpV6i0CxY0rCCAYsA+7flYVRhswR35s6ei3TVOhu4PZtn6NcyW3D8LTL
   Q==;
X-CSE-ConnectionGUID: 8+n/9owMS2yyucszkCyBAw==
X-CSE-MsgGUID: GnWERO+eRaOEqBRRO8HB9w==
X-IronPort-AV: E=Sophos;i="6.24,212,1774281600"; 
   d="scan'208";a="147932156"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2026 09:33:54 +0800
X-CSE-ConnectionGUID: URTlHVwSQwG++tXVmq1DYQ==
X-CSE-MsgGUID: SzS1iAtYRMWE7KdLfr0nFw==
IronPort-SDR: 6a349c6a_vhdpifkGE9OibsUAKZbsjVBD5e++15hfHjybqSztnepc8u2
 pERlQfz52J5SSxbJdPdm/IY2KU90AIdijrr6HtA==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2026 18:33:30 -0700
X-CSE-ConnectionGUID: 7hqhuGKsT9yAWD4mYTSQJw==
X-CSE-MsgGUID: EQ0brTKxTMq0+ExfuyxfJA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 18 Jun 2026 18:33:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme/060: avoid false-positive failures
Date: Fri, 19 Jun 2026 10:33:27 +0900
Message-ID: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_183354_682020_9A27ACF5 
X-CRM114-Status: UNSURE (   8.81  )
X-CRM114-Notice: Please train this message.
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

The test case nvme/060 fails often due to a couple of expected errors.
One of them is observed for all transports, and the other is unique to
the rdma transport. The two patches in this series suppress these two
expected errors respectively.

Shin'ichiro Kawasaki (2):
  nvme/060: suppress state file write error
  nvme/060: suppress "nvme connect" failure for rdma transport

 tests/nvme/060 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.54.0



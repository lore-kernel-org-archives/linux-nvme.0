Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4DFC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m+kw0mVtWDSeJDLfbFioBJ+hS3jC15/GQQeGeNgZEss=; b=flzdYLtbTHY0kJr748ej5okrAW
	KAS0iWrqAoYZ6hvCAqxY9aKRuKTrWKzZ565paCtiWWqX6LID/oWewWeYu8VASx2PNdTItStLhZO/p
	9yom7yiQjopEQRPMN2AYVGzp7wwHuXr8EUm4o7vY5WhlxlebQSfthrpZarVret6ZbfFjdJ+bWkuOd
	5FPeJTX1ZWCoO/WOE9zs82V4M/ANmxy+vdR5QDKDxfp6IJkaPlNQOB62GqNav9KeKk1sGbdnYBoB5
	y2aUpYASJkjIZamPTra5SJXBQ70QSHHJgJtAoAkV1uppyd319ZDcBTX3C3km6DTfstFH8l2sLBit1
	BeQ8vdtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Fz4-00000001AoF-0cRG;
	Mon, 29 Apr 2024 01:39:10 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Fyr-00000001AnB-38Kx
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 01:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714354737; x=1745890737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sValY2jZMY7kypT8y30RxotnJzXzzkLVyg2MlrviqjM=;
  b=OrvuPFiOSkKAVom+Z0c4/H4Ctz1zwCgM/Ir0dGdutrtqHgMY35Dp1FOp
   DNZipPH/nhu+RuCtnvmg88qDA76WirvKp3c+gJz0IbzCAJlIWvyutOAyi
   HDyJe9a7Sg93uGxOQ1qphndMDgkb3743B4BgtiPWB6BR3oFb032T2g5I/
   8tqv2IbN8O7hJSbGWhSDzvhvzM2SnAvP1eR/tcEEg0lgAiBQPJyQkS0Aa
   w2BLRg2DSRImXvG5qGoKv0KQ0g4tC3mCBEnWp9h4dBudU454/GZ2ZnskY
   Djy14CR8e9uhBwvB7Jcam8ojPQXUYFxI7F2HWU4P7xIpeWqDkLeHkowSF
   g==;
X-CSE-ConnectionGUID: Ao6nEv6MQqqMO/szQKnLlQ==
X-CSE-MsgGUID: n1isAfI3T06J4FuTFTXaJg==
X-IronPort-AV: E=Sophos;i="6.07,238,1708358400"; 
   d="scan'208";a="14456110"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2024 09:38:52 +0800
IronPort-SDR: eDNG1cxiufBtycUpOthw3XI62mwFKbNyqH+waW+9wAVHh79IHahe7vaiAeF/VHCqTAEZmevKJR
 Z3wTu85uedqDih1mquQY2n1fgd6HaLv5kd8zSFao+CwHdvG6Am/jjEphgsv43IcSi2OF3zrs50
 WYZYFjMkjUn+Q5M2uaH/RSVSZ+6enxV4usvQv9P+JcqQeN+QBSqAZIR1qttrtQte1vMeamk1X9
 5iowiiSMqBN8sn8Hf+2GguUP/6F/OjW/h7OGEJsi3JdWrleZYQJQPS6Wj3wPj1LL26bWm+bXEZ
 rfg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 17:41:16 -0700
IronPort-SDR: Rkpcjq3+F4UhkwGMYr2a5qppwopgi6JNs+/tR9Bj1xKxI4WOWQlaaA7hQIrHzER8siQZHlcCrc
 J17La36tlfd2bM/ZvxyS628u4DzYv0jitDZwRk5VDi++FTcYXSwuvqIrLxH9mllnwL3/IecLWM
 5dzVatx8kb9P69tuoOoZt6Vwa5ALrg1caUKyKF3ZCnegVztd0vmZL3Vjsp9636dWVZX7xOKNWS
 m+zBqb6pjM4SDOV3l6uyoMCQQu2q7tnspXiF5TONzp1C+vzGg4To6parHvyLS7hxmAzvip7/bd
 Y2c=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.19])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2024 18:38:52 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Alan Adamson <alan.adamson@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/039: adjust to util-linux v2.40 dmesg format change
Date: Mon, 29 Apr 2024 10:38:51 +0900
Message-ID: <20240429013851.181700-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_183857_880002_B4B68364 
X-CRM114-Status: UNSURE (   9.51  )
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

Since util-linux version 2.40, dmesg supports "caller ID". When Linux
kernel supports CONFIG_PRINTK_CALLER, dmesg adds thread ID or CPU ID
with parenthesis such as [    T123] or [     C16] to each message. This
made the dmesg string check of the test case nvme/039 fail. Fix this by
filtering out the added caller ID field.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/039 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index f92f852..a0f135c 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -24,7 +24,8 @@ last_dmesg()
 {
 	local nr_lines=$1
 
-	dmesg -t | grep -v "callbacks suppressed" | tail "-$nr_lines"
+	dmesg -t | grep -v "callbacks suppressed" | tail "-$nr_lines" \
+		| sed 's/\[.*\] //'
 }
 
 inject_unrec_read_on_read()
-- 
2.44.0



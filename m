Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E93D4334A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hlj2zyNdMuFdp/n99S3dX/U3LcKp1H8eQoLhgy/sYqI=; b=WtdKVz8lsbDi1g+/DH7XwC6Knx
	8N3b56dq+3WIroaQ6NUIV/pS4kjcXfB8OFJ+23EOdz8gH3xInJUgo7XF/C30dVXTB4hS2pU5IW3h9
	9NbRwwVVQldQFKLwJn9QZzy40NgLHpMADmiXM92UFsJM74GSLhkCOnbSzA1PIfxvaHaHqu8G0QM3I
	NyJBp3rAVmHpl3xgyzQkNg12MS1ddR1S0KDOUeP7qKKrgMdgQQ7GuvDKqp+Tk0JDPmrEB/afntJC6
	uKY5k7kSlJHWm7xXlDu/3HSP7Jv3V8lAP80J/OFQiLJTZdROkgq79xd0Hw40utTiYhkdwPy3ngIB2
	0+WVnauA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sg-00000006duw-0jFK;
	Thu, 07 Nov 2024 11:14:02 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sc-00000006dsC-03OZ
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978037; x=1762514037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0obDLkRCyleun7yOrisTso1XqT70aTp+TOt4K1FgZHA=;
  b=MuaN2V03vY0GVOvi3cpkCNKNmnT0Q14i4ScqRYgwcAyj2SAJB9wqxYfE
   QfiDJXc04hFRyyWDWNSl8KSfGpq9SoYOmsQVNv7kgtTMkTFzpQ3jwBZ4T
   IYGg0Jk8wRFDo6cedO1E2woDHBsP6GrT8QhBZlDBGfhZzmnyG5/76Bvmu
   +BUVSTOt3/jZUnGOgSD/BDYxIdbE98b9CI0i1iul4X9Z6hkWl7Sw8Qj6n
   vSWiOU3pZCGWtOcP406GyhZip7oPqUApisS1ep7TByfroNFo/p2ETPKnF
   A7vIO5MiDNsx398zYMzxkOsKW2HDzoPNXOOBB5+Oq7/VFohTs4tnxjOHo
   Q==;
X-CSE-ConnectionGUID: 8J/G7iPqTRWQcVPMBOR0Eg==
X-CSE-MsgGUID: 3iZp2UYBSh6ApjNK7CHLig==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851677"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:56 +0800
IronPort-SDR: 672c93bc_5n88uugPTN0T5/DjZzRsOGkVkJLSiQOJB62skHsr3a29LZD
 2zhV9602uH+5PSBKHRcU66LVEtMH+p2bAnq+bdQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:32 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:56 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/8] nvme/rc: Implement --blkdev none for _nvmet_target_setup()
Date: Thu,  7 Nov 2024 20:13:47 +0900
Message-ID: <20241107111354.80606-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031358_152606_32E170CE 
X-CRM114-Status: GOOD (  12.00  )
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

From: Hannes Reinecke <hare@suse.de>

Add an option '--blkdev none' for _nvmet_target_setup() to indicate
that no block devices (and no namespaces) should be created when
setting up the target.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index f03851c..05f9192 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -361,11 +361,13 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
-	if [[ "${blkdev_type}" == "device" ]]; then
-		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
-	else
-		blkdev="$(_nvme_def_file_path)"
+	if [[ "${blkdev_type}" != "none" ]]; then
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
+		if [[ "${blkdev_type}" == "device" ]]; then
+			blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
+		else
+			blkdev="$(_nvme_def_file_path)"
+		fi
 	fi
 
 	ARGS=(--subsysnqn "${subsysnqn}")
-- 
2.47.0



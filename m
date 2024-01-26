Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC52C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 06:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IfaWeXuDUUc+cD5x1WUSYCXgYShYtipmswK+q7pSzBI=; b=aojwsUiObOpLnvdutv7Kh270X3
	206JL7yNMTOF6X4EcEKyfkoK41yiIFoXVsMZwzK5yJ3n2Mru1hB1f7O1SVY35osfcVfztFhbNgfqY
	tti3z4qDU3zN+eIuOFh6a71V/OMWztyZ7WXUb0A4Gb3ZRTH3cpGfq1Eekh2d7E0DuvAT8DgsPFwTc
	+7X33lLNCrDA5g8HiQY75qjftHIwCSXPhAIj44ye+D3UnlH/P6k80lgGenSFCf/ECZNnAItV7ToiA
	BpKN/83cHIe9bOG2hUbDuY5fCTZmI8NUSicBRNaonFouxA1b6UCLCVTJRh7P6pZtaTCUwyqwpc1Q4
	dylRmsjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFQQ-00000003D7s-0ylq;
	Fri, 26 Jan 2024 06:10:50 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFQN-00000003D6Z-2fpm
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 06:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706249447; x=1737785447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tc0MZJFEbku/gUc3pQ+rnMmDwJ4TsQFu832MMB85ETU=;
  b=ZO6KWM5rso6nQzUZlhDBPJFYMWFkme3gSgyHiKXqIPa51nKubmj/DoOR
   FPC4WofNRmZZaYjeYQvAh6XG4nM9Ye/y4H3KO5h1OGp/9VRKklETACAj5
   tF26p3G2bAXKyrUgGtgdYmumbmH7yfbkrlJPdhHL/tuS+oCI+VCOXqPJS
   pMm9ZMR9gV3Xti1FKNCrqq51RDIw7HbViOFuwz1ms4SXcFafdvHH4wdv1
   y/Kr+CIjd+A/HyQIlPTj7Y/vJegk7FW0Vxg5u6eKNVbrOLTTBAxHiI5QK
   ElYJ50PQ6FA4uF3As2q1vVjP41pyfpjQIcvJubhvzfOXyZjaUvrdDbfNr
   g==;
X-CSE-ConnectionGUID: sFO4sjjgTEeC3xD/ARDc3A==
X-CSE-MsgGUID: 6QZplCQ+TZKWS00gn1EB/g==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7503028"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 14:10:39 +0800
IronPort-SDR: IcsVINobSOWtmRCZfv5wKO1tAVmvmPG4WX5n7F5/uoNdCAZ5c22pCI0O2s5N2PMYYoGtqii5ro
 X3XGI7cbko3w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 21:20:38 -0800
IronPort-SDR: GHs9RrbRzHYTnAkza/Tv9hvYWwUKWekFWehvZPQvb1oVDDivPK+Ywmc/aWE2gY2iWU4c4oODta
 LI5+iydJobhQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 22:10:38 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/046: change nvme io-passthru command option from -o to --opcode
Date: Fri, 26 Jan 2024 15:10:37 +0900
Message-ID: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_221047_832666_44B05867 
X-CRM114-Status: GOOD (  10.11  )
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

A recent commit in nvme-cli v2.6 changed the single letter of the
--opcode option from -o to -O. This caused the failure of nvme/046. To
make the test case work regardless of the nvme-cli version, replace -o
with --opcode.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/046 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/046 b/tests/nvme/046
index 942f252..7576a24 100755
--- a/tests/nvme/046
+++ b/tests/nvme/046
@@ -25,13 +25,13 @@ test_device() {
 
 	chmod g+r,o+r "$ngdev"
 
-	if ! _run_user "nvme io-passthru ${ngdev} -o 2 -l 4096 \
+	if ! _run_user "nvme io-passthru ${ngdev} --opcode 2 -l 4096 \
 		-n $nsid -r" >> "${FULL}" 2>&1; then
 		echo "Error: io-passthru read failed"
 	fi
 
-	if _run_user "echo hello | nvme io-passthru ${ngdev} -o 1 -l 4096 \
-		-n $nsid -r" >> "${FULL}" 2>&1; then
+	if _run_user "echo hello | nvme io-passthru ${ngdev} --opcode 1 \
+		-l 4096 -n $nsid -r" >> "${FULL}" 2>&1; then
 		echo "Error: io-passthru write passed (unexpected)"
 	fi
 
-- 
2.43.0



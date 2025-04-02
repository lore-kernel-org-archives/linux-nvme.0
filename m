Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F86C36014
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRnWzC4CC8VzlJG3Ox5m58cE03wVcBVU5Cb6MX+zWAo=; b=ecSEfLqmji1x6G40sVHiU9TW93
	8bs9khz6OlWAMkfElM5xA9ZJha64J+ifm3KGL2/96D/OLIJz46bc2Tnc7u8eMy8d6yDm9YwNwLI4N
	K+93k8VUZB55cqIipjzpqKLuJzBKZ715bIoSmD70GZjHzuDo34kRTEcta9E+/zRyPrLBJ26VLIsLR
	l7UH8gSGuSkTdKHHaWTy3Ln1gkV5BQTS0yB17YfqxDJc2hlL7+9UKVUjfPegXK530RRcaRkbsIPdK
	geyqS/dbEW9INvPCwRwrq6mYSH/iJFkuxEzvCKBi8P32CyzCIqw12GwmbrYcHWKskYveGYRinLzK4
	IK/H/TjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ4-00000005NHn-0ptu;
	Wed, 02 Apr 2025 07:31:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDu-00000005JxC-05kh
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577758; x=1775113758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxBN7WHC+BPZl+big/3dpOEyGx/GAd3rlYitT6IXIRI=;
  b=H3qAZ3Pt6dwp6m/vYt401tZAzpmk7oYOHoB4WSKQ8ks06Hi+35OAUmKV
   BoIMTNnHI4HxqIQUOCvXX9myiMBqPeSlFZxrZyxu1P4gss1I3KcnZGPfP
   ZAtM2BgDfZ4Hc/7w6nZpgZOIoRVqrlqCTXjUu7cfERMQ+iETXFlxCATZ7
   4fFpY2shPLBQ225cTpPKAn6c3JN4qYQ0ezZDt4/WO/qNnvwoSVNPiV0Cw
   tUn6jus4c4DnC9UNRhaiCpuHiW65aVjjamMoQpuctgjtEWYaPlyldIDLD
   og9szDFiNchb8BzKL8KGfIirvJvOq1b+vFkcGp0lpUJ0vRLKdOGhsorzB
   A==;
X-CSE-ConnectionGUID: CeesmgStS8aDwqQau7M9wg==
X-CSE-MsgGUID: dKeXpGVPSRGpyCGjhpoZug==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793498"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:17 +0800
IronPort-SDR: 67ecd4a6_R7Dfb4nz+iSU1WaY6I0q4wXYL26h7z9bQZPEMxE1+mlToBe
 BxZsX8yuy1JotkZjwUfw5hpJjiS7AnrSM79Z3uA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:43 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:18 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 08/10] common/nvme: handle option '--concat' for _nvme_connect_subsys
Date: Wed,  2 Apr 2025 16:09:04 +0900
Message-ID: <20250402070906.393160-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000918_087945_992D9C58 
X-CRM114-Status: GOOD (  11.13  )
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

To start secure concatenation the option '--concat' has to be passed
to the 'nvme connect' command.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/nvme b/common/nvme
index 47bcdc9..402db18 100644
--- a/common/nvme
+++ b/common/nvme
@@ -275,6 +275,7 @@ _nvme_connect_subsys() {
 	local hdr_digest=false
 	local data_digest=false
 	local tls=false
+	local concat=false
 	local port
 	local i
 	local -a ARGS
@@ -345,6 +346,10 @@ _nvme_connect_subsys() {
 				tls=true
 				shift 1
 				;;
+			--concat)
+				concat=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -405,6 +410,9 @@ _nvme_connect_subsys() {
 	if [[ ${tls} = true ]]; then
 		ARGS+=(--tls)
 	fi
+	if [[ ${concat} = true ]]; then
+		ARGS+=(--concat)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.49.0



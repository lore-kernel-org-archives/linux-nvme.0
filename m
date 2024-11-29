Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E12D6EC09
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5ApVESRhI/Me1SLjL4X02sPH3GbdoyPuUO8yXktmZU=; b=dJ/rb+R8c6ZnzDHC3T5t84kB2T
	S3Y6VcAoWfZBsNHl4ECsVZdodwiTj02gWJD++SIXcgCscI48fl6lhxUFPgnJCdelBPdNNWKZOJns2
	MokvHlEThBOz2g7xMUU/+7aRrwJfV/aURbISJOJlNlnzHS7/qf5w01BRJYhHlnMX21SUcIn2p74cy
	g2Uw2Fjyy/Vq7MhBlk9XwaeY7AupE30vPHOUuZQKhWfdP0rK68hW3S879Ua11T1lNWqQdx4fQ9NI5
	hMwBU+lfV6WUv90D+Z191gpCsyyKcJHMcbSKsvRhRu+EtUKvDRup1I3OAPG+jZ5IiK3rEO1NgkhyD
	e7KkCoFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10t-00000000BMF-2PuC;
	Fri, 29 Nov 2024 13:26:27 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10p-00000000BIQ-2oJK
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886783; x=1764422783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZFtIxq525BxYZw2fU0zZnNWw0GaXb7g2rZihmBm+a8=;
  b=UkL6xkaHwedLbrVN/bMkoiCP4eVEdKBMeMK0MuXGg/YneUQFsbpDj//9
   0wYmAmIdLdCYcU3KVavjcptvYSIwyMidQO9xgk4hkRlk0X3Gn4JLGt+5f
   ru5hjAK9GzWsn+VrvvQ1zK1f3+zyaBJrfF8yTk0dEOiplmTMwTtYfenQg
   gJQi7S0D5gvTUwGe/wVjfEvgsQRgcY3CvaWk/rXm5TzHZKR5rbVaAXy5x
   A/huSY+j8mOxQi48c8Tz2piwsr/TaPrEvZ/9mo0yJWrMPm2er3/kwFlmD
   Zedd1VcjP8/y5x+tTRpiTq0kbXOcj2EUR5OLCaiULB4x2m9cOq76U0umd
   Q==;
X-CSE-ConnectionGUID: GCFTyEpKR5ytx5u1mHLjNw==
X-CSE-MsgGUID: K2DeZaMjQNOvpP0O5B4knw==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015170"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:20 +0800
IronPort-SDR: 6749b25d_Jdu5jr9CjyovOe4DkYuPxI8Z6xBlIRGlb9bB+lXv4uZUsR4
 T7kfF+EYzh5jL9FzXaTGt+UmBkdbiVG4Mi758vw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:23:58 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:20 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/7] nvme: add _setup_nvmet_port_ana()
Date: Fri, 29 Nov 2024 22:26:12 +0900
Message-ID: <20241129132617.400429-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052623_766985_B2B3220F 
X-CRM114-Status: GOOD (  10.01  )
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

Add a function to set the ANA state and group id for a port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/common/nvme b/common/nvme
index fd472fe..e11776b 100644
--- a/common/nvme
+++ b/common/nvme
@@ -8,6 +8,8 @@
 def_traddr="127.0.0.1"
 def_adrfam="ipv4"
 def_trsvcid="4420"
+def_anagrpid="1"
+def_anastate="optimized"
 def_remote_wwnn="0x10001100ab000001"
 def_remote_wwpn="0x20001100ab000001"
 def_local_wwnn="0x10001100aa000001"
@@ -470,6 +472,23 @@ _create_nvmet_port() {
 	echo "${port}"
 }
 
+_setup_nvmet_port_ana() {
+	local port="$1"
+	local anagrpid="${2:-$def_anagrpid}"
+	local anastate="${3:-$def_anastate}"
+	local cfsport="${NVMET_CFS}/ports/${port}"
+	local anaport="${cfsport}/ana_groups/${anagrpid}"
+
+	if [[ ! -d "${anaport}" ]] ; then
+		if [[ "${anagrpid}" -eq 1 ]]; then
+			echo "FAIL target setup failed, ANA not supported"
+			exit 1
+		fi
+		mkdir "${anaport}"
+	fi
+	echo "${anastate}" > "${anaport}/ana_state"
+}
+
 _remove_nvmet_port() {
 	local port="$1"
 
-- 
2.47.0



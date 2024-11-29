Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211DBD6EC07
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oD8NEx6KWCxXlO3BtUChY38+RiUHCPV/uOypAVH3eZg=; b=Ty1nIlDUtqiVNT7gb003xpMEW+
	oYViJq5dGxq8234ifYsZ+2Pqivp4EQ5E2Cibkmio1GMG0GhkVjbwsDBX1gIcmoTRB7AMVcqNLUJRY
	1V2ciI/kAKPTyiEY+B8MNoEq+Uw8ZnqYuEwFTjDJvk2ImqpiOHk3R4xbyHaZ96TWY+eBKOWhaALaD
	UKl4P4RR1G3fnoBwm6d7ujUzXB4Ucv9JhbLy3tX0o6h1zljDdWkSdmZi2ZifD18w/l0rCqPYbudHR
	07EVFqTYJyZhlANKSdcLnMrB2U6AqMFH1duj76Sp9UB4jx330xouy5bUDnqEZraBAF5Z8QqTESU//
	HcM5kSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10v-00000000BNn-2GFb;
	Fri, 29 Nov 2024 13:26:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10q-00000000BIQ-3rza
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886785; x=1764422785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnXI/xMt7W02bZuVXtwrJeRyHkMM+o1H079ozcdPEwI=;
  b=LhfJaG5mTRsV/KYj/1Wvf6cas2Gmh0EFY1VJmpZo8Ekmtbyox5aewdk4
   H/JkKRQ3hu6gJm02FlMwYD7xc2d+At5DZiLKUtFV+G7rOviTFX5B+dYot
   pXbyR/2y0t0S4CAk3xFwvw2DAdywmbz4z1MyjSGSc5ulBu5J0tqVpal8b
   a0oXy9NU+zGd57V7tXs1H4pXQrSuKyuHh6L70sTA6S0wIQ8z+4Iobidvr
   2nyzu5RI90n6VUqPK7tBss77m+E6W1G9toqeIaEC3hLmcLMQIs+apgXr0
   09ne5mcjf8mk71gJ8zuTvrCYwyDzHLxSdAoAY4Pdj8vyj3fcLg0YsG/z1
   Q==;
X-CSE-ConnectionGUID: 0We20jvGS82tOZd5qKdlHg==
X-CSE-MsgGUID: f/kD6PN2Scq4RCDmL+GzgQ==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015176"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:22 +0800
IronPort-SDR: 6749b260_k/Ht5qO1IYl4A+MUnl61TKrh4Pn7FYvpGdRYRAvn4JhCEpv
 Jo/OihmQKnkRh1xBRH3od7xr6d7qgL1aSY0jEdA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:24:00 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:23 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/7] nvme: delete all ana_groups when removing a port
Date: Fri, 29 Nov 2024 22:26:15 +0900
Message-ID: <20241129132617.400429-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052625_025466_DAB96ABE 
X-CRM114-Status: GOOD (  11.17  )
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

A port might have several ANA groups, and we have to remove all
ANA groups with a group id other than 1, otherwise we cannot
remove the port itself.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: fixed shellcheck warning]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index dfd9876..8bce403 100644
--- a/common/nvme
+++ b/common/nvme
@@ -491,6 +491,8 @@ _setup_nvmet_port_ana() {
 
 _remove_nvmet_port() {
 	local port="$1"
+	local cfsport="${NVMET_CFS}/ports/${port}"
+	local a
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_nvme_fcloop_del_tport "$(_remote_wwnn "$port")" \
@@ -499,7 +501,11 @@ _remove_nvmet_port() {
 				       "$(_remote_wwnn "$port")" \
 				       "$(_remote_wwpn "$port")"
 	fi
-	rmdir "${NVMET_CFS}/ports/${port}"
+	for a in "${cfsport}/ana_groups/"*; do
+		[[ "${a##*/}" == "1" ]] && continue
+		rmdir "${a}"
+	done
+	rmdir "${cfsport}"
 }
 
 _create_nvmet_ns() {
-- 
2.47.0



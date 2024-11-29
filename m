Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F05D6EC0B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31awOxVlyy/nlPQwnCZm1aBnoV4CLGsjeF9IXOsw1nI=; b=UYhaRoQbsfePao0BOHUpZrLeK+
	3DhTUqtkEgXZ9E7+sOLgjgQDSwCVX5lc1yzGJUFmoTX6e8zHjtJz6/RHPsz3vsaXMTjEVLPCG+aSX
	o6JxomS5IjS30VF9YAyWTCRM1QRTkgd1vk8BShI+GofcXg8xB6V6Ml7Bkx3TXxNzYpWBlU1/GJ9KC
	1dSXqOgisVhLhuY1KCN6eWpT5ADWMC0/XbfIH4P1c/gjCZC0TzBvRIf4YDUoJ0kOjrEwF4aWUB4T4
	PQ0LVNkl9ueVCKxknoY6VWMW9uxkc++ryWgEe916SPEKCYrX2MbZy8O5Xy8v88dHZi5D6riaRwFxK
	Lr9Tv/sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10u-00000000BN5-3ktB;
	Fri, 29 Nov 2024 13:26:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10p-00000000BJ1-3dBI
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886784; x=1764422784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqFQyuUbMxmtq2C2p0kayom2PfGtOtZL1odRxicMvbc=;
  b=n20bOZtYqd7ax6JejMLqbKCwH24BKe791YX2W5X7zcgNQcOjYzcn6cI9
   Ex5+euLfFe5Tm2a9E4gOi0eimJ78ImPn3B4FxNFNRLImTHTgiTFMxDb7C
   fOXErr0tQ+0lJuk3Pp5wMwqpFq1UQQZKe7CY8JvP37AaEZ6ZQI5MAu2FS
   eGK5xnGn9raRrBd45a7wMwsivbWjBXD/Q3oizsSCrCuPnRjlWqOej9NEV
   5wR5jBA43V1v1ydYXPA13iXOlkl1w2BZqNLElmnSvqlkIbrR8KYszI7Pr
   3Xn+DC+wWV5HkPLQMigZqFZmrXjLHUd9M+/tYA7mzY5tUfUwYMD+MArP5
   A==;
X-CSE-ConnectionGUID: LNTgBYJjTzqfDGSBecnUsg==
X-CSE-MsgGUID: myajYNWKQYyRczPvvurJww==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015174"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:22 +0800
IronPort-SDR: 6749b25f_XPnA0kOSZbt2F/rs8cOOlowkDaME/aQLFBRw8UxPz9VxRdl
 ppnNKU2BsA8CbZto2HR0RcouIj/i9foTf0wgA7Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:24:00 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:22 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/7] nvme/rc: add argument '--ports' to _nvmet_target_setup()
Date: Fri, 29 Nov 2024 22:26:14 +0900
Message-ID: <20241129132617.400429-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052623_962084_4526B7DD 
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

Add an argument '--ports' to _nvmet_target_setup() to specify the
number of ports to create.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/common/nvme b/common/nvme
index 9786e4e..dfd9876 100644
--- a/common/nvme
+++ b/common/nvme
@@ -798,7 +798,8 @@ _nvmet_target_setup() {
 	local hostkey=""
 	local subsysnqn="${def_subsysnqn}"
 	local subsys_uuid
-	local port
+	local port p
+	local num_ports=1
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
@@ -827,6 +828,10 @@ _nvmet_target_setup() {
 				resv_enable="--resv_enable"
 				shift 1
 				;;
+			--ports)
+				num_ports="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -855,8 +860,12 @@ _nvmet_target_setup() {
 	fi
 	_create_nvmet_subsystem "${ARGS[@]}"
 
-	port="$(_create_nvmet_port)"
-	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+	p=0
+	while (( p < num_ports )); do
+		port="$(_create_nvmet_port)"
+		_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+		p=$(( p + 1 ))
+	done
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
 			"${hostkey}" "${ctrlkey}"
 }
-- 
2.47.0



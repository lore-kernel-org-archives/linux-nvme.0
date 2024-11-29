Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40512D6EC08
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfayBfGKwjkSrJ71gG04SZiBwn1WIYpDSn6qnnKfLUI=; b=A7rUB2kXz/TixnE0QzWHDnlcrD
	LhcOSG1iVjJhbGWoG3TlzBkOD0JgpexXy3QZiCxLIHtK14PLkZdke4KXk8ZXUfuwK8wusslXVqiGj
	tSnZb4rV7i7hAnnOtrWhk3rIsDXPn9R5PqEXxeTK9NmKMcXvTTH8Nis/59Il/S1YkAUJt2qzTFzoI
	OHo9cKj1ZK/ABb5zyiHAkkIPwNn3MGh0K9ix2f30umv1N83ZjqnDFkhb77lLH7OZqlrdlvKflI6sz
	ona6UnICjLmEtWkVnXZ1ct32AGTFlKtvm1Jyj+Z7x2eorcr/IT/htjgPzcUTAVuC6Mr2m9sKBuHWM
	ipzqWrTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10q-00000000BJs-1Nte;
	Fri, 29 Nov 2024 13:26:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10o-00000000BIQ-18zx
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886782; x=1764422782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4zs7monpFFNZIQAw/znu4gc9jhT9GfhkfYdW1ZD5Ps=;
  b=kY9IpIa0RiOqWPZaHY68JXVFd3T8OPqLw8nhoPHAN4cCftRdKnYb/8KG
   /BZH6rJ1vM/ANqPDseBEaq7f8tubfYCvDRDU7ZPXilXzHinCji2EOUJq9
   bZLkmab0IY82gGfsKCNlFmcK9I5ff0Vo6GMEmGyLvKK5x/UF9QNzJGPqT
   J0KmCbDulHqjYDpGJEJVjoYH+o+50ybv+JFlB/lOi84DCQ64Q3klv6+my
   q2flCCTad1b0Xdj+3H1GFZU21XIIyweqhzoFC5nFOnjH48tGUPz3d/Oko
   viLSrBuyzof3k7wDw7CrHvQ+vVfqV7+3vEFWrQRZ0MpB68CZQJTPYcKbt
   w==;
X-CSE-ConnectionGUID: xPepIaveQbq1O7MaU0J6nw==
X-CSE-MsgGUID: GzgN0tqIQi63Ac/cADMZgA==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015169"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:19 +0800
IronPort-SDR: 6749b25c_+6pDT+bvocKBO3bGeBHoFZw7M5ri/e8kqchba9+RgZlC15s
 /A7ZBNPtCqwPP+VoJsLVzaQJbcaHFoJjAkXqijQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:23:57 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:19 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/7] nvme/031: open-code helper functions
Date: Fri, 29 Nov 2024 22:26:11 +0900
Message-ID: <20241129132617.400429-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052622_401008_B85351F3 
X-CRM114-Status: UNSURE (   9.96  )
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

From: Hannes Reinecke <hare@suse.de>

The default helper functions are doing quite some things which are unneccesary for
this test, so open-code them to call just the required functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/031 | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index cd69e8e..3333338 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -44,14 +44,18 @@ test() {
 	port="$(_create_nvmet_port)"
 
 	for ((i = 0; i < iterations; i++)); do
-		_nvmet_target_setup --subsysnqn "${subsys}$i" \
+		subsysnqn=$(printf "blktests-subsystem-%d" "$i")
+		_create_nvmet_subsystem --subsysnqn "${subsysnqn}" \
 			--blkdev "${loop_dev}"
+		_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+		_create_nvmet_host "${subsysnqn}" "${def_hostnqn}"
 
-		_nvme_connect_subsys --subsysnqn "${subsys}$i"
-		_nvme_disconnect_subsys --subsysnqn "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys --subsysnqn "${subsysnqn}"
+		_nvme_disconnect_subsys --subsysnqn "${subsysnqn}" >> "${FULL}" 2>&1
 
-		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
-			--blkdev "${loop_dev}"
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
+		_remove_nvmet_subsystem "${subsysnqn}"
+		_remove_nvmet_host "${def_hostnqn}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.47.0



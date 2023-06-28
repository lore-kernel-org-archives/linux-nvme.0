Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A3EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MiVCSAEXzHUPi4d/SizL7/xNGo4js3nAXrlRXKHpULE=; b=vQnlWpU1/qNhmXUPV/KQnz4cWy
	VCuIy3yi9y5xcocAgolez/11m24pi3ZKZFTauifcAnzvAyBLAX8e92dekjzafi6iPmR/f6/SvGXyQ
	qTToM8E0zQamhxGDTCIkFuWOZE3p8CH7XIfg+DwL3pOPYvHfTk13hJLyzvf+rpgvUIV6uI7Xjm3bF
	TW61nlu//+Ioh7+F6THy83+wKqMlcqmLDrveXwYPd0b1z3nSMx7IARVo5/o5rsPKJw9rj/1d6YvGU
	xFLIGWh+oT7wY/HeDQErcvBDgq80pR1j+WQUd5umv61xsWITtXWy/I4/lG+8rmxj5LD6eU0/hz/1Q
	I6l1Obug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEUWV-00FgDO-0T;
	Wed, 28 Jun 2023 12:43:51 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEUWR-00FgCQ-32
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 12:43:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687956228; x=1719492228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gfx1u99cyhBlTpKJXO9JdtXu79VGGOr+tEjCoTB3OPc=;
  b=fPkMQIwH7n+Pc1ZD1MGKIZPBiC8fmYc9RyPiaZockuyZfq9G77OEGVTt
   t0fsWgogvabAKrjScolUZaY503bwtYEcJvUT7J4zJZO6Xz8eGyhc/JmIn
   MOQWKuc7Qg6aB1zKKxTtvoQ839364T9mof2h9jkpjdn+NOlOZe1if82AL
   FQraP0syIYYQDIj42PHbYemhJya8yWom//rUAWwJHfEW2M5inFCIY6z3o
   vN3o7s/LcsSH+wWEkGBdXyhC56W53hMBZvoFDbYAu2ew1TDZ7M/V5APD6
   zCcUMtpyroxrFuRSJnwLy76Smjo7ep/UN6JCIt1zWRAXjzAuqfebWuOd3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="236444525"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 20:43:46 +0800
IronPort-SDR: noEfvCtrFoZ92fCmkRVHodnHNhOMA69Go1W3WYOga2KQCvOZ4k4wcc23t18ABEt6VLnTjN1T6a
 GPa/OI/WpMUGkQ8Ryp0FsPOl0GN0cIK85MIsza9aQkg82CZS82dSWix7EPGd79Vqrp3ds9V5VB
 RsCWaHg26nZpyXl1kw0kV56KhbKDZ1yjF+O1oO21gTH1/pn5UebDDW1RgoYuoPualMm3hziPnH
 hyGXKfx+16Z2Pxz3S0qq+XClgN7LcH1DJMsWAGZfmBRJT9cUPSnwkU5ZTL5ZTT1M9GplfbtaXb
 CdE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2023 04:52:23 -0700
IronPort-SDR: a2MkjIK5YvVFE28Z+bgP8TWuo8y79y5+LMH+xYFo4pB4FYWdnJ4DdMYvYKA7YTUjfQoyxZK9yH
 pfv8rOVeFl5Q4ZGyhhicHBcWZEVE76k7VYP+KUnphpEOBNJ0SODHRRU5XXEPm0eEBNeFsRDFOt
 leJaN2C7ZmEBSOSNYT4hn5Zw2QcT8VEqsuyp1mfZRVfsysymfFUgtEYT5+J3M3u2vMv41KWYY/
 Wm53qHKU3CMrNRT+XcSZp1kWlbxywFyDvjsshB5nn2yxTxmfb5l7lh7vQc9XGc1t5zpwMn6CwX
 0gA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2023 05:43:45 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme discover and connect
Date: Wed, 28 Jun 2023 21:43:43 +0900
Message-Id: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_054348_042367_B5F2B3DA 
X-CRM114-Status: GOOD (  11.44  )
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

From: Max Gurtovoy <mgurtovoy@nvidia.com>

After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
of existing host"), 'nvme discover' and 'nvme connect' commands fail
when pair of hostid and hostnqn is not provide. This caused failure of
many test cases in the nvme group with kernel messages "nvme_fabrics:
found same hostid XXX but different hostnqn YYY".

To avoid the failure, specify valid hostnqn and hostid to the nvme
commands always. Prepare def_hostnqn and def_hostid even when
/etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
values, add --hostnqn and --hostid options to the nvme commands in
_nvme_discover() and _nvme_connect_subsys().

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-nvme/CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com/
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2..1c2c2fa 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
-def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+
+if [ -f "/etc/nvme/hostid" ]; then
+	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+else
+	def_hostid="$(uuidgen)"
+fi
+if [ -z "$def_hostid" ] ; then
+	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+fi
+
+if [ -f "/etc/nvme/hostnqn" ]; then
+	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
+fi
+if [ -z "$def_hostnqn" ] ; then
+	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+fi
+
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
@@ -442,12 +457,8 @@ _nvme_connect_subsys() {
 	elif [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(-a "${traddr}" -s "${trsvcid}")
 	fi
-	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
-		ARGS+=(--hostnqn="${hostnqn}")
-	fi
-	if [[ "${hostid}" != "$def_hostid" ]]; then
-		ARGS+=(--hostid="${hostid}")
-	fi
+	ARGS+=(--hostnqn="${hostnqn}")
+	ARGS+=(--hostid="${hostid}")
 	if [[ -n "${hostkey}" ]]; then
 		ARGS+=(--dhchap-secret="${hostkey}")
 	fi
@@ -483,6 +494,8 @@ _nvme_discover() {
 	local trsvcid="${3:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}")
+	ARGS+=(--hostnqn="${def_hostnqn}")
+	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.40.1



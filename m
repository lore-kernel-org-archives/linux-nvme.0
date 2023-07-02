Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44049EB64DC
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jul 2023 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U7MIR5K7BHlH/NwMrBKqk/dJGTeSqv8VQPIfD9bn270=; b=BoGtZPhKdMYFIGTgfF04vnGO+p
	OpsdZN2RbdiAV8btJk6gY3ZGNo1vHQNMmgrw1oav8+iqBEx49KMLR7+pTWPAkore6/y/T1K4MmRcf
	h8T22ffqjYp/qs+6VdKmGIIyCL2TzUJXzexlL0SJF1n7nUvU7+2MHU5kzrjDXQTFEheJTFywXKwQs
	5IVcs1azruA4ufGWpt6MfVZuKzy6qi7YD9EMKadXJiIWScMWIDVjaTB+L2eeOl6T1wcWXE6cDBW0X
	teIqbyvSRGRQSpsGcAP8Au+Io4RiZyLCQO/zhkckCKPBqfe35U8IeZCZeEuIT1uyjbW5RHzFyg0Zo
	TnwiDRvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFmko-0070M8-1F;
	Sun, 02 Jul 2023 02:23:58 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFmkk-0070Ld-31
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jul 2023 02:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688264634; x=1719800634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOHTH95YY93leBh/fcJ7VeUM3SIH1RVMu5krpxGXr5s=;
  b=KNymiB8HmJGSW31XAhQqVZaOsnN7u3da3WOTIzLf+n6h07FG1vFsMKj0
   Cm1AOkAx70eyPYwUPojVmLWvUhd/HNOL68Njg/CEwl/QqgZHpfxNh/6pl
   qyV83o5Gf5qN4JJKZMOcQFranIV+6dQG8+N8g85o40qwXsUOisqomXNAf
   shx3M/QEmx3Qd5JI3dVhsYsGZMLiSyilbrjFf04KwEjI+sNNAMJ+vzFjh
   z7Cc9gbRvkhbdEaIc3fO5GiSdSuSqGe/nQDTQZcmAS2lulOMQdV2a0su2
   802UrDo2MQbilPxkP/Ehn7IkCevyhvG3/lccN965j+n95Y1LpknLJXZZ3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,175,1684771200"; 
   d="scan'208";a="348885569"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2023 10:23:49 +0800
IronPort-SDR: pCjHkFJzkKEqx4uEHUebuWSxr1SYsnJ6DshAQhCZI9aXcqnX7grXrrc8jYZHuQwuDXYemiXdpv
 QF+LQ9k4kfvGCQZsqtXjDwYI60qzEEFyK1oOCqH5mG5zgs+sLeMvrVFurXnk+0wqlvGRCUzFDP
 EmFjG6uuv8UUMv1d6w6PfyH886jeQCvCtPv+390znzQhznny7+SAjLiSBYu4MwaFPWdrjQ39LY
 yvfo0g0Ma45lEl+qdi9bAXKNYTg0kHWjeYIv2GcHL2Y+V2khtshtADUTCg9zA9NBVMeI2cTZ6f
 EKo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2023 18:32:20 -0700
IronPort-SDR: OxiGq+8siWauTObgBuOYKuGwGcCplRFCF3MxJtNmwWhifpifiT043np2mMGZJ0c3qMJMZG66ci
 jtvQ7nVctL+u1D5BSM3WScuySRds3gNnodtthaH/pCAEEW2mhmmj5o1LkiO4gGJERk7roO1KOy
 q/R2CCzzLQEpC4V94PcH77S9f2dHuHgiXtGWGbeTvSH1hZEy78+juRgM1KsF+/HfkSNK3TUw23
 lm8Fl2BXF0nnTQI72U/hnD3iC3n/Z5quFj36RVOXKZ3SJHqoOUia6v/+/trWeoTfZJGubtH4H1
 GzY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2023 19:23:47 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH nvme-cli] fabrics: Use corresponding hostid when hostnqn is generated
Date: Sun,  2 Jul 2023 11:23:46 +0900
Message-Id: <20230702022346.3150889-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230701_192355_041888_E4F97BBB 
X-CRM114-Status: GOOD (  13.17  )
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

After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
of existing host"), kernel ensures hostid and hostnqn maintain 1:1
mapping and "non 1:1 mapping will be rejected". This makes 'nvme
discover' and 'nvme connect' commands fail when they generate hostnqn,
since it does not use corresponding hostid.

To avoid the failures, prepare and use corresponding hostid to the
generated hostnqn, taking the hostid from the hostnqn string. Also warn
when the hostid is different from that in hostid file.

Link: https://lore.kernel.org/linux-nvme/l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 fabrics.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index ac240cad..2eeea48c 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -677,6 +677,26 @@ static int nvme_read_volatile_config(nvme_root_t r)
 	return ret;
 }
 
+char *nvmf_hostid_from_hostnqn(const char *hostnqn)
+{
+	const char *uuid;
+	const char *hostid_from_file;
+
+	if (!hostnqn)
+		return NULL;
+
+	uuid = strstr(hostnqn, "uuid:");
+	if (!uuid)
+		return NULL;
+	uuid += strlen("uuid:");
+
+	hostid_from_file = nvmf_hostid_from_file();
+	if (hostid_from_file && strcmp(uuid, hostid_from_file))
+		fprintf(stderr, "warning: use generated hostid instead of hostid file\n");
+
+	return strdup(uuid);
+}
+
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
@@ -753,8 +773,10 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 	hostid_arg = hostid;
 	if (!hostnqn)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn = hnqn = nvmf_hostnqn_generate();
+		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
 	h = nvme_lookup_host(r, hostnqn, hostid);
@@ -966,8 +988,10 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 
 	if (!hostnqn)
 		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn)
+	if (!hostnqn) {
 		hostnqn = hnqn = nvmf_hostnqn_generate();
+		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+	}
 	if (!hostid)
 		hostid = hid = nvmf_hostid_from_file();
 	h = nvme_lookup_host(r, hostnqn, hostid);
-- 
2.40.1



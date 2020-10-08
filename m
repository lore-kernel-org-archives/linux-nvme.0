Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C1C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1C221D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N81zAurL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LT9egte0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C221D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkZE4B/H9vd0U/rJvaEUbzHBosWgouG9hzeJRsVF7Wk=; b=N81zAurL0U3/l5yRKP3VmJMMD
	8T5sO+fSNVjLKB9JuM6QP0CTqjUiuxDxNH/x2nPAqqowyZuWhwReMTagj22JieUr4c3qhOJpTOAf3
	yWOW35kic0JrT0h9KW0qls0h7rFLFrIjKSiOWmi5PTbAGx8/w/Wo2OnXXJtkOzmq5oAopgreJGP3Z
	mlKB4u5zpqAfCpk0ec06E+6ZnU2hJ5KMDpDMvT0hYzBASc/hOMw3v2hN9KFma5F7+p1Gc9Wxp55LK
	lftgXThgutp0aCKJXugq9pb+8h0vTNKBEutE9rfFSfxU0CYJPzTQ/gAapSprRbLgI3g95MZ5hR/2o
	wIpSDOzsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYyh-0003dc-Bw; Thu, 08 Oct 2020 16:41:15 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy6-0003MX-Sm
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q/NKCn8cpUBMyzr61SmefQR3jE4zs7Vhct3Ys5N6EOQ=; b=LT9egte0+0Y8oXUezjbF+UuN5b
 9JhGOnRRHBbusFBbHU8arfLRVYsK29K+ZHnCCMTbvQsdRzRreU1bsE5buBXp0ujSLwr397/6FK0cQ
 SZVIXRgS8Md8J157a7kaznTlwKjxM6gmA3A01bOYee1Kv7ONAXVAIJrwp6kGeEPcoTkEDMPjtrlwP
 iL6onpVgKs+ppIhT9UOSwEL9WLUqr5eJNPu81c1sjcJVUmarJChQNQU6zzBf3EAQzUfN61LiFWgQY
 MpGJ3fPKctQg932XkOyDFimDNPYQUKDmtGJcw/lgXP5HQlW9ulTsWbS+pU1803sw3HCEvz+qT0XtA
 eRCucJsA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYy5-0000if-G0; Thu, 08 Oct 2020 10:40:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxz-0003HU-AP; Thu, 08 Oct 2020 10:40:31 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:18 -0600
Message-Id: <20201008164024.12546-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 05/11] nvme: Add common helpers for passthru tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124038_938558_799C071B 
X-CRM114-Status: GOOD (  12.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add some simple helpers to setup a passthru target that passes through
to a nvme test device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/rc | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index dfa57a299625..f0b6f360da8c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -73,6 +73,16 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
 
+_test_dev_nvme_ctrl() {
+	local dev=$(cat "${TEST_DEV_SYSFS}/device/dev")
+
+	echo "/dev/char/${dev}"
+}
+
+_test_dev_nvme_nsid() {
+	cat "${TEST_DEV_SYSFS}/nsid"
+}
+
 _cleanup_nvmet() {
 	local dev
 	local port
@@ -257,6 +267,27 @@ _remove_nvmet_subsystem() {
 	rmdir "${subsys_path}"
 }
 
+_create_nvmet_passthru() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local passthru_path="${subsys_path}/passthru"
+
+	mkdir -p "${subsys_path}"
+	echo 1 > "${subsys_path}/attr_allow_any_host"
+
+	echo "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"
+	echo 1 > "${passthru_path}/enable"
+}
+
+_remove_nvmet_passhtru() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local passthru_path="${subsys_path}/passthru"
+
+	echo 0 > "${passthru_path}/enable"
+	rmdir "${subsys_path}"
+}
+
 _add_nvmet_subsys_to_port() {
 	local port="$1"
 	local nvmet_subsystem="$2"
@@ -292,6 +323,50 @@ _find_nvme_dev() {
 	done
 }
 
+_find_nvme_passthru_loop_dev() {
+	local subsys=$1
+	local nsid
+	local dev
+
+	dev=$(_find_nvme_dev "${subsys}")
+	nsid=$(_test_dev_nvme_nsid)
+	echo "/dev/${dev}n${nsid}"
+}
+
+_nvmet_passthru_target_setup() {
+	local subsys_name=$1
+
+	_create_nvmet_passthru "${subsys_name}"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	echo "$port"
+}
+
+_nvmet_passthru_target_connect() {
+	local trtype=$1
+	local subsys_name=$2
+
+	_nvme_connect_subsys "${trtype}" "${subsys_name}"
+	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
+
+	# The following tests can race with the creation
+	# of the device so ensure the block device exists
+	# before continuing
+	while [ ! -b "${nsdev}" ]; do sleep 1; done
+
+	echo "${nsdev}"
+}
+
+_nvmet_passthru_target_cleanup() {
+	local port=$1
+	local subsys_name=$2
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_port "${port}"
+	_remove_nvmet_passhtru "${subsys_name}"
+}
+
 _filter_discovery() {
 	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \
 		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

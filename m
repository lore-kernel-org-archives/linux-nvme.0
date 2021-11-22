Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D49EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9aiMRiHpdksvjOcge1FwNOauZwpDS+XoczL7CyeLSs=; b=YtWFjY+r6KxJsP1Tc+M1QKE+uD
	rBjgYnalK7EYRSV3JHPlGvuzRPQWPAuZs28maaVxwFXn8Qcwl0zm6cNKkuP3EwXwgqvU6+YV6ara5
	qHB21x1mvar3Gv3+FVPfICLhz8DFt91IwOxJnZlLkom9zTXFCkOvnFRWxirPBaLcdOPC4s94EMioJ
	DM21siirbuwghTSiwZQebuQhFgqKKP/6jzsDD3HTzH+vbvHxbunwfo+57aQUOK4BdZryUFKYn6/P0
	IFu3WO9pgT/6qwo/Yob1co6AqeENeCbDxfrcgdkD83fsDl5UDG2Y8yQiQOQIJjltC+zZQvhmwVecg
	QlJeK9Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4MU-00FDUf-Fc; Mon, 22 Nov 2021 08:07:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Ar-00FAuF-To
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 77381217BA;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9aiMRiHpdksvjOcge1FwNOauZwpDS+XoczL7CyeLSs=;
 b=OoarMgkC6RKh1VK5z9cp32Um3m030f5+3PEf6Ss4hnnOFM3rGUB1bNKPR5kPmuBORuiNt3
 DgXXg72LZyioLCoZtDh6OTNQw2dYP0K2PPeJhKqfiwPusa2QYaGxUYDOnA7V/y+41Cpexv
 riHV5Ck9e+ph0dlEihH63merVj6yrI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9aiMRiHpdksvjOcge1FwNOauZwpDS+XoczL7CyeLSs=;
 b=vtAzny6ttm07q8Q9K29h5ehkaDgRSJ1cW/V+JqVXOBtrJibp5TKONfVns7+FYsyTaTg3Y6
 SH77kHW5uPxc/5CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 55BBDA3B8A;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 42BCC51917F3; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/9] nvme/rc: add functions for in-band authentication
Date: Mon, 22 Nov 2021 08:55:18 +0100
Message-Id: <20211122075524.26207-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_196603_1368419E 
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

Add functions to enable in-band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index aa223df..7d05e4a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -247,6 +247,17 @@ _create_nvmet_subsystem() {
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
+_create_nvmet_host() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	mkdir "${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+	ln -s "${NVMET_CFS}/hosts/${nvmet_hostnqn}" \
+	   "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
 _remove_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid=$2
@@ -266,6 +277,13 @@ _remove_nvmet_subsystem() {
 	rmdir "${subsys_path}"
 }
 
+_remove_nvmet_host() {
+	local nvmet_host="$1"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
+
+	rmdir "${host_path}"
+}
+
 _create_nvmet_passthru() {
 	local nvmet_subsystem="$1"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
@@ -302,6 +320,42 @@ _remove_nvmet_subsystem_from_port() {
 	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
+_set_nvmet_hostkey() {
+	local nvmet_hostnqn="$1"
+	local nvmet_hostkey="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_hostkey}" > \
+	     "${cfs_path}/dhchap_key"
+}
+
+_set_nvmet_ctrlkey() {
+	local nvmet_hostnqn="$1"
+	local nvmet_ctrlkey="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_ctrlkey}" > \
+	     "${cfs_path}/dhchap_ctrl_key"
+}
+
+_set_nvmet_hash() {
+	local nvmet_hostnqn="$1"
+	local nvmet_hash="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_hash}" > \
+	     "${cfs_path}/dhchap_hash"
+}
+
+_set_nvmet_dhgroup() {
+	local nvmet_hostnqn="$1"
+	local nvmet_dhgroup="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_dhgroup}" > \
+	     "${cfs_path}/dhchap_dhgroup"
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.26.2



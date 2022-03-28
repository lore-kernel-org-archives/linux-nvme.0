Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86D5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=; b=vo6979b8gioUfroT7pb4FasgH2
	tee+UB1IP6JliF+uOepRgXGzWmh5Oq++pzZKZjxFvImYomt4yj035UEwFTdDcQ2ss1bxSjyZVtGBx
	420odAWuCdoqzOKE7zGu5RheyvWuLLNRsmGEdRv7pnih0W9tBLXPozhwKbSSZQAH3nZRoDYmSDPFn
	GBh4oQK+kKL1Ifp0T06x95EcZxbB7KAM+4lhMDVLqzAKfg7GkAOGpcwIppnDZ28Y2nSFT4z47aAip
	MnuI5ZDslM8pmBPq4D4IMWQrFubhErEK+1HqYiEoNPHTL+dNe7Ux9Ui25RUNgkaobc03bn/GW7HWG
	dPxefdBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTS-00893W-E6; Mon, 28 Mar 2022 10:19:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uV-KN
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 505D11F380;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=;
 b=y0Sn7ZKZ0vfgGQT8QnMN9CLXmea2FOv4qh/z1q1ZuGj7STuIwO4AMv9SKhYvD36HqOrGvn
 AISTBxHpgHD0eMZuwwPtmWolhayQ34T957lwLVftOWn/AIBzEFnN33MitTiS37+SYjvkkN
 fx89FXNyXaYlYgmdHenKCk+aHAW2B0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=;
 b=vDifuxWiBx8SGF8t5D6wdrEOVdDHrGJJHLIv+qVvDp98b9c407KenwkIyUto2A3oC/RkaO
 77wBdWG6yprEPjAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 45134A3B94;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3A1CB51939C1; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/10] nvme/rc: add functions for in-band authentication
Date: Mon, 28 Mar 2022 12:18:49 +0200
Message-Id: <20220328101855.73975-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031921_948977_BE7480C5 
X-CRM114-Status: UNSURE (   9.19  )
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
 tests/nvme/rc | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c284602..6e08b41 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -73,6 +73,17 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
 
+_require_nvme_cli_auth() {
+	local hostkey
+
+	hostkey="$(nvme gen-dhchap-key -n nvmf-test-subsys 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		SKIP_REASON="nvme gen-dhchap-key command missing"
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
@@ -253,6 +264,25 @@ _create_nvmet_subsystem() {
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
+_create_nvmet_host() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local nvmet_hostkey="$3"
+	local nvmet_ctrlkey="$4"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	mkdir "${host_path}"
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+	if [[ "${nvmet_hostkey}" ]] ; then
+		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
+	fi
+	if [[ "${nvmet_ctrlkey}" ]] ; then
+		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
+	fi
+}
+
 _remove_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid=$2
@@ -272,6 +302,13 @@ _remove_nvmet_subsystem() {
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
@@ -308,6 +345,42 @@ _remove_nvmet_subsystem_from_port() {
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
2.29.2



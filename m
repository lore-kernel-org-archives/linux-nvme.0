Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=; b=b3elwpT0nB0Ar2HHvpHs8ymdEE
	KUw1h+u8YNutGRAiOytFxKFlSwk9Qej5ZUo+Z5j18hM0BhprdMAJsV7sLbxsED9q9Tq3dqqQE1Nt6
	NwEXK+iht12++iptjq53/wuJG9Lm0oGJUxv2aXSPxrET9HLhOyCaV/8FLGS6xJgpRVEY8rBq7sikg
	c4kGRBLkByqAA9CCAHZdZXtRCBBtICJI0iTITt1YWn/JE5YNP6nz3OfkpOaCuz2sdL6xCA5yfplea
	/A0lYt7k4JIh0MwkELcB8raD326DbMadVQnDoWdtzR2xewBMRhIl+fG9buafGr0y+YNJVZ16dNE83
	a5tcJfJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQZv-00173f-Vi; Tue, 23 Nov 2021 07:51:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYq-0016h9-3U
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:55 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 197581FD5A;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=;
 b=YhkQ0r7C1I6K2jyJDh9h6hhqq7JIH5D9euC08VyNy1OwSG1QT0kURzGsjoPgRUwZqTowkl
 GciGG3d105gf5RwcL6xOORZALJEZgOF3eHHzZBa4piXFj0cuyIwPVWnlammwPH1vGOA5YH
 Mc6yja/XoWutMw8zxdsecu4L06oYHuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvWU2giyHT9SSftcmsoxv6KXjzj8KgUEQojb+FZtjSM=;
 b=gSjl8k/CirGU/+UKASO+nnkCrysOl1I8xo1THKNH/Pa0jo3+RQCtp3LA0AePpNb0Xj8+Z/
 oSLM7KWWaCcVlFAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 37953A3B8B;
 Tue, 23 Nov 2021 07:49:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 227545191889; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/10] nvme/rc: add functions for in-band authentication
Date: Tue, 23 Nov 2021 08:49:34 +0100
Message-Id: <20211123074940.113390-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_382106_4A6921BE 
X-CRM114-Status: GOOD (  10.90  )
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



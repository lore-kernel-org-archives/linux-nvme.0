Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0AC41513
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONB0rT+VRdNbFZzplDFSYd3J2+VwEauFZ4m3EdIIa7w=; b=yRoOEhfy5bMTLAZlauWFxa5c+n
	21Dyubaio0AMOg9fLShWRFp/y+LFdi40BBIPBfI0v2qV3COS2d8NlAann6l0BidfOu2Y2GH0V6135
	SbpIn0f8a3dFpiY8aHqpaV59rKJOb5t/yboDeEJ1AFPwrb/7+2Eah2L3mgN15SAtbGRVxoF5fgp/I
	hWmFeLDgZp0vI0/OYRukdapoKHyeje00vWQPr62s8/mg4iFIHMhOG2FOnEwNe9nM7PB/qJAa6pHI+
	XUkX6woQR50e2qyQQ+pYOX87vUvcPHZbKeoPQ1Y6hK1+WSFFLmNVqnrjD3Gu8GIkYxy9Ae64NmWb/
	DXE3MQxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZd-00A0Mb-12;
	Fri, 11 Aug 2023 09:36:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZR-00A0BP-2V
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 09:36:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90DE121881;
	Fri, 11 Aug 2023 09:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691746596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONB0rT+VRdNbFZzplDFSYd3J2+VwEauFZ4m3EdIIa7w=;
	b=vXPAhoaecUfc3nRG2DWFLi6cthWO/0rZvkaAWjUqkyhtY6vhKDxO5hpoh0JGHkzkBA/Vdu
	rBoQmwc8waBX440zY76tVffz29ARY+U9+IrSM+AMI5kJ1zf26t70NWrwDcXeIklh8KX9UA
	+It47EeQrmAIwD+oswf8Y+wwCQ0pnI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691746596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONB0rT+VRdNbFZzplDFSYd3J2+VwEauFZ4m3EdIIa7w=;
	b=FX7SI2W90x7QzkTw3STpDrjYVPdrJpArtwtc/Jb7dQ8DqvvxRIchakm1+ZU00Tj6P0Dsxn
	+rUkEpfu/WYRFKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DE83138E2;
	Fri, 11 Aug 2023 09:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8ErKHSQB1mTPHwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:36 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart2021@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 11/13] nvme/rc: Add helper for adding/removing to allow list
Date: Fri, 11 Aug 2023 11:36:12 +0200
Message-ID: <20230811093614.28005-12-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
References: <20230811093614.28005-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_023637_965187_FC27CB01 
X-CRM114-Status: GOOD (  12.11  )
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

Add two helpers to add or remove the host from the allow list of the
subsystem.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 7f5829a2e58d..61cc2e6d2c2c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -612,17 +612,32 @@ _create_nvmet_subsystem() {
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
+_add_nvmet_allow_hosts() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
+_remove_nvmet_allow_hosts() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
 _create_nvmet_host() {
 	local nvmet_subsystem="$1"
 	local nvmet_hostnqn="$2"
 	local nvmet_hostkey="$3"
 	local nvmet_ctrlkey="$4"
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
 	mkdir "${host_path}"
-	echo 0 > "${cfs_path}/attr_allow_any_host"
-	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
 		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
 	fi
-- 
2.41.0



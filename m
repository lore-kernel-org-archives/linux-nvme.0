Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC99BC0729B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=; b=gKkmAFEWulcF+gSV+cflJ7O564
	TMHyiA2VhyEjZzohl7Y3hbFi+XFBNgmfw7bxdOXntNU9Hp1wNEHO2Ps1y2t7ydNFq57jpr8sqH4gY
	NxZLN0qswTjXFUKwSAqMX24RQFo1DELktDMRAOQRvWZg6fawCS8ax12tIyt1FUoxLI9suddqkHs25
	hRAYnB5fS55LZOeMixM9hxEAuQL8QWZ4NLivAkyqY8xKIn5nTB4bkTU5M9aBliY456+BEuWUhT0AB
	JNUDtxVzsJh6PkDl9gzpGQECIUShuKg4um7+aXIIIAJDG4JBoi4OY/Iu5Q0uJuIpY7OBmDk5LZJlD
	fBsGDe2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bp-007MN7-0k;
	Thu, 10 Aug 2023 11:13:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3be-007MBy-0t
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3F971F86C;
	Thu, 10 Aug 2023 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
	b=eD32g5e7+DejaklZmtWfypKG0DHy38hs7P30hFzCJwNei9dwT1sccO8UFdoGbvyemj6Fz3
	XbXjlxlEykaPx9zmHROUn8vi9yw9WsndbBFdk/GB0dRoc7H2fXO1klLAulJlc1tsa6zVRn
	LrugcSF2cfz4d7B0sVF+fXcg4AkhKh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
	b=88V9IPQgLUdSdgN8/3+8sO6R3vYyROmPLAB+Q1exLZ8Y5c7w8hFGYX9Ip1YSJFQkKUB+pp
	Ce3ZLNk/XgFNCrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4913138E2;
	Thu, 10 Aug 2023 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XOYAKFfG1GRKLwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:27 +0000
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
Subject: [PATCH blktests v2 10/12] nvme/rc: Add helper for adding/removing to allow list
Date: Thu, 10 Aug 2023 13:13:15 +0200
Message-ID: <20230810111317.25273-11-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041330_486317_FF979CF8 
X-CRM114-Status: GOOD (  12.40  )
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
 tests/nvme/rc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 7f5829a2e58d..706f95d74a4b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -612,6 +612,23 @@ _create_nvmet_subsystem() {
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
@@ -621,8 +638,7 @@ _create_nvmet_host() {
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A747FC0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=; b=rGiuk4EbuXwOQtb4698mTS0rnM
	5JrVF8azmnRfvreKnXpTXLOD1Yqs+aZe+vrk9tM8l1AQ2H+UfCDY4f/Mh1VFhQMGswUThjT/VWnln
	gWC2NcurnZow0yO08PjqsrtRU9Ozq7eX1IRJ3enkK0fzKdHi+hYddHoYJqWYVC1+9VPiPonJu2X/k
	cbUY5iQJ/uyPu1UUyJBuJfhfOksGUCb8uDKQi0loRTTnua0uLo90hNHrYR2RrJ7PRFmEePgxhKv2A
	mbeVusGqwOMKzF6Eg5ECqERIIz9YIyxLFE4GrOBjSeId1bz0yWtMolzRDv1NdbJqWbSfBHjUSQoci
	0zw5zhwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOdv4-00AP4g-04;
	Wed, 26 Jul 2023 12:47:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOduu-00AOud-18
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 12:47:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12D0521D67;
	Wed, 26 Jul 2023 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690375619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
	b=IVpoEmzB618sHE+gXRxUAfpUC+adllHxmEgT/42LjijRnplRIRMd4A4XKcm90hrzoauAd/
	nv6TaYDg4TOXegey4m/rzH5Oi66WUukIq2YepAVdzudxpX/8dBz8Ze5pgT80AQvhIP/tMz
	Gf9pXGIiHB4lJaymmjhZhx+ZNNZC3z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690375619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
	b=zRg8nVC28ELOyWnGUF/wx3Q6cPY3R3jxTLgqsgJjHY2FisvuZ4A9zMYJ5+ORm4tKGUhKCq
	wdl+9umcw/NZsKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04982139BD;
	Wed, 26 Jul 2023 12:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id n+8bAcMVwWRFUAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:59 +0000
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
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 10/11] nvme/rc: Add helper for adding/removing to allow list
Date: Wed, 26 Jul 2023 14:46:43 +0200
Message-ID: <20230726124644.12619-11-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_054700_532759_7FB385C0 
X-CRM114-Status: GOOD (  12.01  )
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



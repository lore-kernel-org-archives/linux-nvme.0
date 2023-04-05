Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B1AC76188
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=; b=0fHwiCJc0m4blzTNR0+wd1CJvl
	wRMPrTReyQUG84B8ZY+7rHyB3uxXMfemSjMTFxH2SBQs8MbkoO2RI5kIuYyGk3nf5LOW5ZknxN4O0
	BnZGXP39M9TfQ1OfkCkCtQhVPin4TG0vhQJcFHyZElt0wl1ibaUCb13TiB2slhODiqkn4vMkuQUk5
	nfkA5CK92Ai8KNs0FxPfqaFUbiMaMz30eObjZDwJo7i2aN8ApfJEjwG8FKFL9HeRF9kIVjcOFf/GB
	uRDHtYN33HksxHW36j6BlBwRisSvTuksmX/Aq/Z9Bdj69npAeoJ89bDMEtGmq4hrJX7CSftbD1t42
	9H37ifQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HD-0059dF-1G;
	Wed, 05 Apr 2023 16:46:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk6HB-0059cN-1S
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Apr 2023 16:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=; b=MlQs6E9xmxC1mja0ibVUul82QM
	szm3MGZi+/XG26zjCA4iCfi7g9it7n9vvrcY/xcvvcWNmVpghPB9kTCWVqprIb65Dvl+adFfuiLw9
	WyhO0hDW+9dOM5JNoB8kIxEQE1shxYNkgIMc0sKLCVS4oJfrmGyMihIFyKU2TCvG6RIibBVeqeiDc
	lvDjNgT5Fem/pESv2Wvdi+fT40Y2RLsi01EGj2ta0E7PpoLdHTyGPSdIKWHp61E1TfiUzUUqR2cni
	eUza9xoTSwHEd/v4AR18Mw+tTcK6eSlLDcBRftbtwUViTH9t1+SursgCkPaNWrUpmik1+Alf4uj2H
	/dxjUOqg==;
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pk5LK-009zh7-2D
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 15:46:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3B9C228A5;
	Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680709597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=;
	b=hXI7/+RAmDrKYDmb/PL0Vk+RHGyndaRKR/Wy2HdNHbFej/Dd0Pwe/mX2lt6ARQNSRkg0E1
	J5virmxIoe+5CwxT0MoTJolq/LsE1hXNF6dMMACEUrUTQh0ReRrXyqKkEiqu8lhU3vjNrH
	xGGOZ+QDQ5hy/zhXbqYN3d6g2m/hMc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680709597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=;
	b=7S+5P+EQs7nrqjsSfLuXUYSr7Yx3q7awzcMlT3F/Gc7RZMutAcNS9ZvTIbi8AWuv7jwEXc
	1RuoBt4JuaWN1HAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5D0213A10;
	Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qaUvONyXLWTeNgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:36 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 3/4] nvme/rc: Add helper to wait for nvme ctrl state
Date: Wed,  5 Apr 2023 17:46:29 +0200
Message-Id: <20230405154630.16298-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_164638_842257_EA940F08 
X-CRM114-Status: GOOD (  10.24  )
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

The function waits until it sees a given state (or timeouts).
Unfortunately, we can't use /sys/class/nvme/nvme%d because this symlink
will be removed if the controller is going through resetting state. Thus
use the real nvme%d directly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e720a35113aa..ae4a69fe8438 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -16,6 +16,7 @@ def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
 def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+def_state_timeout=20
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -198,6 +199,28 @@ _nvme_fcloop_del_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port 2> /dev/null
 }
 
+_nvmf_wait_for_state() {
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+
+	local nvmedev=$(_find_nvme_dev "${subsys_name}")
+	local state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	local start_time=$(date +%s)
+	local end_time
+
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+                if (( end_time - start_time > timeout )); then
+                        echo "expected state \"${state}\" not " \
+			     "reached within ${timeout} seconds"
+                        break
+                fi
+	done
+}
+
 _cleanup_fcloop() {
 	local local_wwnn="${1:-$def_local_wwnn}"
 	local local_wwpn="${2:-$def_local_wwpn}"
-- 
2.40.0



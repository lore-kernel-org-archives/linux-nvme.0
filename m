Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B9EEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdu4SLeXRX96eYJIkjFLNcHQfvWSCAFCqgoWIOGzVEU=; b=V91vJUzT2GcpCkmtZqfMeDEwSF
	8vFPiJrjIC5DVr3yj7adKROiyAqFcvl52GKtTZ3kaUWZX1KnvprWix0gIP8GzgP8VYhkY1oD5g6pM
	/EK7Oj34BYubJsNxd5UZR0fEuWoKoFr/W4uV4dqtM3TkqhGH7jPaSnFLfjkJzb7ZEG4x1T90VmUtt
	kPXhKZ4AvMESdm+KIIfot1vGdD7f2DejHkGnp5LPquBePG8RLyr0asKqeH1uddBjaAzSBsgracrbZ
	C1+txDe0PQB/gDluqsqF6Rcp/bbLTvYfiur6mCe2WSjXteXUXff3/VXLjs3QspbJ4ZwtbGZx09qa3
	GwVQ5sFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbOI-00BNso-1t;
	Tue, 20 Jun 2023 13:27:26 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbOF-00BNom-02
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:27:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7156921846;
	Tue, 20 Jun 2023 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687267637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdu4SLeXRX96eYJIkjFLNcHQfvWSCAFCqgoWIOGzVEU=;
	b=VpHAssbZ6FRo5bahpfqMn2JLtxTsbdwQg8XiNVzAWn97FXnm2W4DQ0d0Ut+s3zkXWwPh9+
	jtUimsqy1R29joc6RPnp3JJmhuwmybTMHTgD/yOAeKdyCcYoUEON9FxV4TQ5EA8R1kYDvZ
	p+wheu/EeNaK0wnzNf7kARKfnfjwCnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687267637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdu4SLeXRX96eYJIkjFLNcHQfvWSCAFCqgoWIOGzVEU=;
	b=KX02MQlMHQWX8D3ST42NL2EOoRv3f2X0aZYichzWCZ1f8zSFb8mwk5+Uwc6XodYr/je8+R
	65J8aSgfNXeRXSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6370B1346D;
	Tue, 20 Jun 2023 13:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YfhCGDWpkWSdOAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/3] nvme/048: Check for queue count check directly
Date: Tue, 20 Jun 2023 15:27:01 +0200
Message-ID: <20230620132703.20648-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620132703.20648-1-dwagner@suse.de>
References: <20230620132703.20648-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_062723_191028_CD4324C0 
X-CRM114-Status: GOOD (  13.83  )
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

The test monitored the state changes live -> resetting -> connecting ->
live, to figure out the queue count change was successful.

The fc transport is reconnecting very fast and the state transitions
are not observed by the current approach.

So instead trying to monitor the state changes, let's just wait for the
live state and the correct queue number.

As queue count is depending on the number of online CPUs we explicitly
use 1 and 2 for the max_queue count. This means the queue_count value
needs to reach either 2 or 3 (admin queue included).

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 81084f0440c2..3dc5169132de 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -42,6 +42,26 @@ nvmf_wait_for_state() {
 	return 0
 }
 
+nvmf_wait_for_queue_count() {
+	local subsys_name="$1"
+	local queue_count="$2"
+	local nvmedev
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+
+	queue_count=$((queue_count + 1))
+	if grep -q "${queue_count}" "${queue_count_file}"; then
+		return 0
+	fi
+
+	echo "expected queue count ${queue_count} not set"
+	return 1
+}
+
 set_nvmet_attr_qid_max() {
 	local nvmet_subsystem="$1"
 	local qid_max="$2"
@@ -56,10 +76,7 @@ set_qid_max() {
 	local qid_max="$3"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-
-	# Setting qid_max forces a disconnect and the reconntect attempt starts
-	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
 
 	return 0
 }
@@ -77,12 +94,8 @@ test() {
 
 	_setup_nvmet
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
@@ -103,7 +116,7 @@ test() {
 			echo FAIL
 		else
 			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
-			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
+			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${subsys_name}"
-- 
2.41.0



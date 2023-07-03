Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56419C001DF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=; b=5Fe4yp5mOdjwnRnfRBNWgCrMFM
	rjSEygb5qH3OFnQlH3Bfh9B2rHpyU/NgAUHUG+D7wN+0eaTu2c70UOq8NfWLmz8x1axfh7R6OMqL7
	GqG/QeUzdfU7pnVBRT47ugf38JFh+VqZJf4IKsjkncjooMNVd0QcX5bZGQNjlqcZswAv3eKkzuIqz
	CcOf6UyZPha/hSvJwPKMD3x7R7aybELGZusZ2SBg0RdhxQx523BytIES6pqEO2xtlzuolG+MLqqrF
	3pfZ9MuY/4L0HUiHfjc3qCQB1O6gApU0TFY3SxUMlKRWE6TkMgXY23hlcOqjwID7UKeLCMRzQPdRn
	LKNXfc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFg3-009tV6-2Z;
	Mon, 03 Jul 2023 09:16:59 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFg0-009tT3-28
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:16:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 379731FD72;
	Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
	b=AYN6Xg5ypCLI8zd2oJ/WFghR//Umb+TVkxatu2rqY+riUBTN8uOgJYo72f5tilyspvJmhi
	XlMGYX8FZRRrASEccYMIfJ11tc/REdDaUt9x072X1oeQdw9uVbZCd2ilDOs392wjBlERwM
	f3/Y8M8nT8SWQ5CmfqV41Yi+Wv3ygxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
	b=4IzB3ZJCS0YkTVGdVhkf1yUtpT3iH6mRH45T72e4QNjOLQDYo/Ik3Ll3A33Gnk6HaWYUjh
	QEvU4exRzv9RxuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29C2313276;
	Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3M7bCQeSomSJDgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 09:16:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/3] nvme/048: Check for queue count check directly
Date: Mon,  3 Jul 2023 11:16:45 +0200
Message-ID: <20230703091647.800-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703091647.800-1-dwagner@suse.de>
References: <20230703091647.800-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_021656_844276_3E572BA7 
X-CRM114-Status: GOOD (  12.84  )
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
 tests/nvme/048 | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 81084f0440c2..bbfb9873b5e8 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -42,6 +42,24 @@ nvmf_wait_for_state() {
 	return 0
 }
 
+nvmf_check_queue_count() {
+	local subsys_name="$1"
+	local queue_count="$2"
+	local nvmedev
+	local queue_count_file
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+
+	queue_count=$((queue_count + 1))
+	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
+		echo "expected queue count ${queue_count} not set"
+		return 1
+	fi
+
+	return 0
+}
+
 set_nvmet_attr_qid_max() {
 	local nvmet_subsystem="$1"
 	local qid_max="$2"
@@ -56,10 +74,8 @@ set_qid_max() {
 	local qid_max="$3"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-
-	# Setting qid_max forces a disconnect and the reconntect attempt starts
-	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
 	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
 
 	return 0
 }
@@ -103,7 +119,7 @@ test() {
 			echo FAIL
 		else
 			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
-			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
+			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${subsys_name}"
-- 
2.41.0



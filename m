Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE5EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=; b=aa04SOzmISFJSuxydPGSvcZh6A
	dmg/8LePcAhYGBvc1n4QiOEr2Poh5JTvrOxK9jP8exsHOtb8eFr+YD3hYX21MXZA5b90MHm3Iueqr
	BABN7IJoHbqDlU/sewjKEEvUDsX0g6dXm0YWTAN9UQJfBvTnizUIpUbF8TRKQV9Kkk/Ls/WHyYbQR
	9b2HibD/YLeO1YKZukSe8vIB8rj9KnPevOXmZZMFapw4MKYOyk6M/PoPrDI80wv17uxAVZqPCbYNX
	KSnrFUxnWzAbRFWuvwiK+Nqr+HowoixA0ITFrOhz5TB+bhO4hk8cnZl4H3Q7KHzvO9SWjyi6lZZxC
	5MnbmXhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuF-00FwwU-07;
	Wed, 28 Jun 2023 15:16:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuB-00Fwug-2o
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 15:16:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B4B421860;
	Wed, 28 Jun 2023 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687965386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
	b=mPp5Gnt1bSBq8z+O3iDXMBeGZfZVLiov6zxoT8q41d15eE1O8kGbV5zALKsiWs2TjYVoxU
	PhWkUsJiYeB6+eQ30m6xhIzuHdIk454kuaZFTqFrYndolcpW/8j3mtUxtXW/GPatlsTKPm
	B2AWIV51K/icuPejvpjgOWthfDDcnL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687965386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
	b=4KbCazMVeoHA4YKRFdDw2HfCRMOh7D8AGUfhG1PZoSrCSuMCiF+wJ3HhZLeUFCB5/iFanq
	xkRUSobbAqL92mAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D308138E8;
	Wed, 28 Jun 2023 15:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Tq/tBspOnGQxOQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:16:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 1/3] nvme/048: Check for queue count check directly
Date: Wed, 28 Jun 2023 17:16:21 +0200
Message-ID: <20230628151623.11340-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628151623.11340-1-dwagner@suse.de>
References: <20230628151623.11340-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_081628_071784_CD030246 
X-CRM114-Status: GOOD (  13.00  )
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



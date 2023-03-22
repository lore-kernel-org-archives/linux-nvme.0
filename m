Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB391C761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9UkWbDbsudQ9RC4SZ2+HeX6ArJ9hOreEut9aeSDzOY8=; b=Nxd3gTVXrKJn2sEkW6SdmbhdbU
	2RNSCcBxo4FXqwiLak44YlHVPUjxOaHWLwN4noJqG32s9aT3nYCxMk6evfLLakHz2f8SgjYe4PjPJ
	B4gf/Wt0pnjt39P88zKprzQztjZW/0Jzm19T9CPyR7j7A8ndURIVm1DtFVI9V94bWWG6Kn+fAhMTw
	dQQfH+wnFZKiErSQleGtqWhPswF8xb5q+bI+DpfWGh04858Qwm7xNMariNlLw74KMUDPYMHNsWmSx
	L+yNKuyjO4Hs0OILGysiI8wc3TMUqsQfv/xZcEkwTPwuFnruP8AWOpGpd5vhbHHRhwDo2ZvuxNN2k
	ZehOdBDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWc-00FbbP-0v;
	Wed, 22 Mar 2023 10:16:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWY-00FbZO-1b
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 10:16:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA55120C4F;
	Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679480212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UkWbDbsudQ9RC4SZ2+HeX6ArJ9hOreEut9aeSDzOY8=;
	b=0TNCMXIZPQYRMnd7cNXaeB/Z9ZFjNYtlJVb8j1vOUUjBWAQEDRsXnsJasu1294q4Mc/h4r
	1YC5BjrIVgQ9EQmcfHHebjdR32IPOFInqS85Yfaup6vmIDR/e2FycH3SkJY0B4ZtCzoGfe
	j7HoKS+iFyjhGovWhtT8zyl612gA8TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679480212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UkWbDbsudQ9RC4SZ2+HeX6ArJ9hOreEut9aeSDzOY8=;
	b=+woj71bBoB/8kr9Ykb+qiyTA8mu7rD3jzjMg+JlUmXAXtOmkiJ2BqIB6pjG1oy/tkveOG6
	XFS5jTV5T7IiFbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC53B138E9;
	Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NfvHNZTVGmR+DAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 10:16:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 1/3] nvme/rc: Parse optional arguments in _nvme_connect_subsys()
Date: Wed, 22 Mar 2023 11:16:46 +0100
Message-Id: <20230322101648.31514-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
References: <20230322101648.31514-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_031654_680124_8BC543ED 
X-CRM114-Status: GOOD (  10.20  )
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

Extend the nvme_connect_subsys() function to parse optional arguments.
This avoids that all test have to pass in always all arguments.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 |  7 ++++--
 tests/nvme/042 | 10 +++++---
 tests/nvme/043 | 10 +++++---
 tests/nvme/044 | 23 +++++++++++------
 tests/nvme/045 |  6 +++--
 tests/nvme/rc  | 68 +++++++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index 8ffcf13a500a..03e2dab25918 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -55,14 +55,17 @@ test() {
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index d581bce4a9ee..4ad726f72f5a 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -58,8 +58,9 @@ test() {
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 		udevadm settle
 
 		_nvme_disconnect_subsys "${subsys_name}"
@@ -75,8 +76,9 @@ test() {
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index c8ce292ba2e7..c031cecf34a5 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -56,8 +56,9 @@ test() {
 		_set_nvmet_hash "${hostnqn}" "${hash}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
@@ -71,8 +72,9 @@ test() {
 		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				      --hostnqn "${hostnqn}" \
+				      --hostid "${hostid}" \
+				      --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index c19a9c026711..f2406ecadf7d 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -66,8 +66,9 @@ test() {
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
@@ -77,8 +78,10 @@ test() {
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${hostkey}"
 
 	udevadm settle
 
@@ -88,8 +91,10 @@ test() {
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${ctrlkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	udevadm settle
 
@@ -100,8 +105,10 @@ test() {
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${invkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${invkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index a0e6e93ed3c7..612e5f168e3c 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -65,8 +65,10 @@ test() {
 	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${ctrlkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 210a82aea384..1145fed2d14c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -316,15 +316,65 @@ _nvme_disconnect_subsys() {
 }
 
 _nvme_connect_subsys() {
-	local trtype="$1"
-	local subsysnqn="$2"
-	local traddr="${3:-$def_traddr}"
-	local host_traddr="${4:-$def_host_traddr}"
-	local trsvcid="${4:-$def_trsvcid}"
-	local hostnqn="${5:-$def_hostnqn}"
-	local hostid="${6:-$def_hostid}"
-	local hostkey="${7}"
-	local ctrlkey="${8}"
+	local positional_args=()
+	local trtype=""
+	local subsysnqn=""
+	local traddr="$def_traddr"
+	local host_traddr="$def_host_traddr"
+	local trsvcid="$def_trsvcid"
+	local hostnqn="$def_hostnqn"
+	local hostid="$def_hostid"
+	local hostkey=""
+	local ctrlkey=""
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			-a|--traddr)
+				traddr="$2"
+				shift
+				shift
+				;;
+			-w|--host-traddr)
+				host_traddr="$2"
+				shift
+				shift
+				;;
+			-s|--trsvcid)
+				trsvcid="$2"
+				shift
+				shift
+				;;
+			-n|--hostnqn)
+				hostnqn="$2"
+				shift
+				shift
+				;;
+			-I|--hostid)
+				hostid="$2"
+				shift
+				shift
+				;;
+			-S|--dhchap-secret)
+				hostkey="$2"
+				shift
+				shift
+				;;
+			-C|--dhchap-ctrl-sectret)
+				ctrlkey="$2"
+				shift
+				shift
+				;;
+			*)
+				positional_args+=("$1")
+				shift
+				;;
+		esac
+	done
+
+	set -- "${positional_args[@]}"
+
+	trtype="$1"
+	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-- 
2.40.0



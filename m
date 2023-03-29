Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D04C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DgnundXw3/fWoRWwwxsBqOoYOOJIiKIHvv0PtfL9Cg=; b=pIP9rX9M0Fk37ZEe6y/BCgiRPT
	Fwfw/Wv4R6lzifSZwJ56ZZTB9wD0J5py66K5c1RqziEZZafH7OIkK7UVMylb4d5+VPXDIbeoU38l9
	NhQ9HN9PibqtPRjugSsuWHvxJvyOmgKHXFWsN6szaYkDSlK5gblsUZ9niwipYyXhXkHSEbeNZep0B
	R2oYKcp+01sSjdJVpAT/Rziv/mwHnftlTjO3uc4ttqJ6X1aQW+Sjf/lT8psD7PoS7P9j8Yvpd0yaR
	h5MgRs66crNQigYJ8dXNjKd5dvTpibBWofLwXC0UaJOJvfcBBMYA0MvnGhIFQh7cp6bovjNRYBLpr
	w2JZ8/Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh9-00HFGY-0Y;
	Wed, 29 Mar 2023 09:02:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh2-00HFC7-36
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 09:02:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18E001FDEE;
	Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680080525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DgnundXw3/fWoRWwwxsBqOoYOOJIiKIHvv0PtfL9Cg=;
	b=agi/1BkpWD2l1Qyo1c2qv3YaQts4+RLvve+8UPQ8bhiKa9Of0fLDzivj5lU1kuc3PnWs+W
	NoC0xNzkpBj6YyZjFEaxhZ8+vFgDwB/MumYkRF0pzE/TfUzbuNCSYXdWhXS7kzEGp506gy
	uJB2hoyQCkYRfmZQpmewBrGjPgO5Rrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680080525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DgnundXw3/fWoRWwwxsBqOoYOOJIiKIHvv0PtfL9Cg=;
	b=5ColjjWeDLLqbxU6XSf6fRh/362uPmUe3bknNlRlEs9n2SV20dlGtuo1l13BaX8QvmitcB
	5LRomWgFqqomUnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09FF3138FF;
	Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4rtdAo3+I2RUdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/4] nvme/rc: Parse optional arguments in _nvme_connect_subsys()
Date: Wed, 29 Mar 2023 11:01:59 +0200
Message-Id: <20230329090202.8351-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
References: <20230329090202.8351-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_020209_151872_323C436D 
X-CRM114-Status: GOOD (  10.14  )
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
 tests/nvme/042 | 10 +++++----
 tests/nvme/043 | 10 +++++----
 tests/nvme/044 | 23 ++++++++++++-------
 tests/nvme/045 |  6 +++--
 tests/nvme/rc  | 61 ++++++++++++++++++++++++++++++++++++++++++--------
 6 files changed, 88 insertions(+), 29 deletions(-)

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
index 210a82aea384..20c5e2fa32cb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -316,15 +316,58 @@ _nvme_disconnect_subsys() {
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
+				shift 2
+				;;
+			-w|--host-traddr)
+				host_traddr="$2"
+				shift 2
+				;;
+			-s|--trsvcid)
+				trsvcid="$2"
+				shift 2
+				;;
+			-n|--hostnqn)
+				hostnqn="$2"
+				shift 2
+				;;
+			-I|--hostid)
+				hostid="$2"
+				shift 2
+				;;
+			-S|--dhchap-secret)
+				hostkey="$2"
+				shift 2
+				;;
+			-C|--dhchap-ctrl-secret)
+				ctrlkey="$2"
+				shift 2
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



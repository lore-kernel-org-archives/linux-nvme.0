Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320BAC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYu2UT5lDEOdiTT1ESF8e0PH0sTJl298MdWvcXc3Wac=; b=Wlzo67d4UQDad/g0+MrOOweLvf
	MzR3X5FPqrnV2qFWtdqLzAnbJj8B68VXFtkW1vYTL3/pE8/Qh06VindkcNP+6kn0jXFUw252TnFih
	wJv+cXl1zQO2ti/+LdpqjkH87bH++rd6qDo5m8hhg71MyRjpjyD2EY6xaheNqlSil6TMbah2tdHEX
	O1eh+LGoWAlWlGtvxcvs5KemeLw5/O9kYna3FKS1pv7TrJEoKkuqSJAtK9ejITEItNX0r+aHxLuTg
	0ehEnj6qphXLXeXl2oPVQApz8rM6c30BJw5NYMNtv3taAkusYaRhdD5peze0ZTkadHZZ9fOPayR+Y
	RuyBDmBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ4H-008jwT-0Z;
	Thu, 20 Apr 2023 18:31:41 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ47-008jnl-1T
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 18:31:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E319E1FD8C;
	Thu, 20 Apr 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682015489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYu2UT5lDEOdiTT1ESF8e0PH0sTJl298MdWvcXc3Wac=;
	b=2KswRzz5JfO3CyQW09bNUue/G8SyuDqDFi/Td2fvqHSZMoaprZqLtlL1KKby8cda08qn8X
	WUidgiJRXSp74k0coJJ2NEf0UaD81agu7iSU90t7Ug7XCZxl7IFSymvd1c66oDU6zkPFqm
	dPss0lp++NXTi/S/IcS+7whCKNbMgzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682015489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYu2UT5lDEOdiTT1ESF8e0PH0sTJl298MdWvcXc3Wac=;
	b=4F5D1uLN8oDmjxNK57MVatI40n5X6KRkRsLf7i+sLBN7kdZAv0MP/s90PKf5OWi6tW4kds
	HTmB5bAluOHI94Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5CDB13584;
	Thu, 20 Apr 2023 18:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GGjdMwGFQWS1NAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:29 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 6/9] nvme-rc: Add minimal test image size requirement
Date: Thu, 20 Apr 2023 20:31:18 +0200
Message-Id: <20230420183121.4489-10-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
References: <20230420183121.4489-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_113131_641387_906D9CB4 
X-CRM114-Status: GOOD (  13.05  )
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

Some tests need a minimal test image size to work correctly. Thus add a
helper to check the size and update these tests accordingly.

The image minimum is 4M because some of the test have hard coded values.
All tests which use the xfs fio verification job have a minimum
requirement of 350M impossed by the xfs filesystem.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/012 |  1 +
 tests/nvme/013 |  1 +
 tests/nvme/029 |  1 -
 tests/nvme/045 |  2 +-
 tests/nvme/rc  | 15 +++++++++++++++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/012 b/tests/nvme/012
index ecf44fcb5a51..efe227538c57 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -16,6 +16,7 @@ requires() {
 	_have_fio
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_test_img_size 350m
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index e249add46295..14e646a19c47 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -15,6 +15,7 @@ requires() {
 	_have_xfs
 	_have_fio
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_test_img_size 350m
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 1808b7b0edf1..c6d38b42af70 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -14,7 +14,6 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
-	_require_test_dev_size 1M
 }
 
 test_user_io()
diff --git a/tests/nvme/045 b/tests/nvme/045
index 7c51da27b5f1..99012f6bed8f 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -120,7 +120,7 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_run_fio_rand_io --size=8m --filename="/dev/${nvmedev}n1"
+	_run_fio_rand_io --size=4m --filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index e5ba9a6d5f54..b1f2dacae125 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ nvme_img_size=${nvme_img_size:-"350M"}
 
 _nvme_requires() {
 	_have_program nvme
+	_require_nvme_test_img_size 4m
 	case ${nvme_trtype} in
 	loop)
 		_have_driver nvme-loop
@@ -94,6 +95,20 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_nvme_test_img_size() {
+	local require_sz_mb
+	local nvme_img_size_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	nvme_img_size_mb="$(convert_to_mb "${nvme_img_size}")"
+
+	if (( "${nvme_img_size_mb}" < "$require_sz_mb" )); then
+		SKIP_REASONS+=("nvme_img_size must be at least ${require_sz_mb}m")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_trtype() {
 	local trtype
 	for trtype in "$@"; do
-- 
2.40.0



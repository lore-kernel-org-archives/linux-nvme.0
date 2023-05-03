Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49928C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UkWJx05E9MLusXpaMoAUDzDV3FpDulw27zMIYbaE6Bk=; b=BObK2e65cPrnN0gO9HWIiKJwYi
	pg7iU0q1rQ6Ics4KuK0/Qfnc/6m7aEY6ledXzGJocjEbGyI+Z36Gx/YMeIoWcRlXfTVHj3K8Y1HDw
	/STu7Jtz7j8qX4jsbjO5weLdUbXt4Rd2CR5LEJ1oTDZiO7nBZDhMB/ZR8MWjrHrAABkeAoJGB+3z5
	VJ365hkklu1sGYONZ4LnP0DXKhX663j/i/0Op2HvvYImFwlAMW+LpexjtkKHd/EkkKfr1qQAZSwuA
	/LWLgyPwcrm55IN9AplSbcd1CI2ix5ZHAC4g+oVmXCyI9bJ2mNQVdJckEfvMrNOrDcubsGwIy9+uP
	XNsaNadg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SU-003kRI-0k;
	Wed, 03 May 2023 08:03:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SI-003kDv-1l
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 556AA200AD;
	Wed,  3 May 2023 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkWJx05E9MLusXpaMoAUDzDV3FpDulw27zMIYbaE6Bk=;
	b=KU2DPa6TI7pReNFUqNP0wRVepwFCjfFKul70wQS1VRH+6q/hewinLQlxjr2PsZC2u3QjPO
	PEGqhR4hMzzbp0mSwv37J7RZ+2TmhTHTE+FSBSF2qLSlCJqww/k9dS9aClssmmyO+qQ7yp
	OQyE4W/dKCspm6r2e3QKn6vf1nuLBjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkWJx05E9MLusXpaMoAUDzDV3FpDulw27zMIYbaE6Bk=;
	b=WkFTJhIjxJcjgTR697sFSUMl2oF6CroR72eIue0A1r96lDhzJ/YT0pswtHorapXyoWaFPV
	58dLGyC09jtK+qBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C4E81331F;
	Wed,  3 May 2023 08:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xt1dDkUVUmRLYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 12/12] nvme: Make the number iterations configurable
Date: Wed,  3 May 2023 10:02:58 +0200
Message-Id: <20230503080258.14525-13-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010318_751233_D8492835 
X-CRM114-Status: GOOD (  11.81  )
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

Some tests hard code high values of iterations. This makes them run
relatively long compared to the other tests. Introduce a new environment
variable nvme_num_iter to allow tune the runtime.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 2 ++
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 6b34a253fd97..243975e43583 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -107,6 +107,8 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm' and 'g' postfix
 	are supported.
+- nvme_num_iter: 1000 (default)
+  The number of iterations a test should do.
 
 ### Running nvme-rdma nvmeof-mp srp tests
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 4eba30223a08..c0c31a55b190 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -17,7 +17,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local port
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0248aee9bc41..e1674508f654 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -18,7 +18,7 @@ test() {
 
 	local port
 	local file_path
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
 	_setup_nvmet
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a14458d5b80f..76ca683a40b4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,6 +18,7 @@ def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
+nvme_num_iter=${nvme_num_iter:-"1000"}
 
 _nvme_requires() {
 	_have_program nvme
-- 
2.40.0



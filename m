Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0059FCD1282
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=; b=JEDZS6/YsZDF/kufgHSaBWk3a5
	UqC0kupn3PKuBZjxdh7RL8mLsO+xkoIJEkNtsgRYCmHy2tCugsJI0ZYywmAuMAAduILAuQeJDkR3E
	N52Fc5HW1cBE5bthsK5n1ol/U1PC7A8+F42YxP96DMMwSerSex/YR1Ec9/qe64aOUh68b/G26PAam
	i4lqBH+OyBm/StFZgPMA7Q+ZhjcvugYXWpmnfYhd3ALmB56cVB4uwo5YZQPMm7PLfbN1ln/6zWe6a
	C2EBY/4CvpnEWXZsc2YhAo7ww150HAWJ1tzVhseOJpi7BWLd45xGYrSIsxecAFBwDsG1Pystzv07Y
	SZyM28ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rngPl-00000007f81-45oJ;
	Fri, 22 Mar 2024 15:02:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfID-00000007PzM-19DF
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Mar 2024 13:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=; b=Hd7QjvxvL21gry0TMUQ3vm+FHe
	gE6tTKRQCqzl/23HSh70OKVDLm8BzqtJQFKB7XcA1TuqCEn/Y2canI8RZkp0Vetz3eWisZP0LvE0l
	/pscQeuZ5Ruxo3xA0q1estnUrBXOZQrEndzUOkGVqiN1k8/yGpf6Ww3nf/MFKGe9i3HozWcF8+I9+
	qguodoYXyYG+kohtfbv8rC3Zmhuy7lOntldSCC6hT7UnMx10Enc32szr77b3ntU6ICrmCjRge5J3h
	pu6hS5YkobF/3Duulq0ejEnv9sdI45hIK0hoMB+hzDlag9/3zI4Q7nE9QfI4l+LU8pmyU6X+QG7z/
	m3ZBHWKA==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfI8-0000000EoTf-3EYz
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 13:50:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E2C5FE26;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4294C136AD;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aGPoDqGM/WWSJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 10/18] nvme/rc: remove unused connect options
Date: Fri, 22 Mar 2024 14:50:07 +0100
Message-ID: <20240322135015.14712-11-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 53E2C5FE26
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_135041_221653_8EC374FF 
X-CRM114-Status: UNSURE (   8.55  )
X-CRM114-Notice: Please train this message.
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

These options are not used, thus remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 7f436037eb94..4ad6cb640627 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -410,9 +410,6 @@ _nvme_connect_subsys() {
 	local positional_args=()
 	local trtype=""
 	local subsysnqn=""
-	local traddr="$def_traddr"
-	local host_traddr="$def_host_traddr"
-	local trsvcid="$def_trsvcid"
 	local hostnqn="$def_hostnqn"
 	local hostid="$def_hostid"
 	local hostkey=""
@@ -428,18 +425,6 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
-			--traddr)
-				traddr="$2"
-				shift 2
-				;;
-			--host-traddr)
-				host_traddr="$2"
-				shift 2
-				;;
-			--trsvcid)
-				trsvcid="$2"
-				shift 2
-				;;
 			--hostnqn)
 				hostnqn="$2"
 				shift 2
@@ -498,9 +483,9 @@ _nvme_connect_subsys() {
 
 	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
+		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
+		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
-- 
2.44.0



Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35971C4727C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:54:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BA520708
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLv29vej";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ZQOD/b/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BA520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KuFpa88BSwbsfc2QdwHrzDHv3wZ6vZlYWKEB+94ONII=; b=eLv29vejgW+XB7QqYH7mOQDVd
	INtxN1+5lHaAgW93Vqad1MZ69gL+m59QoFdIuuULWzXiEGVzf/XU723IaubNM6WM5dS7+yUk9bX0c
	JtQIklayZRC0wF1jYBpQyYi9ELdPnSbeaqbQuY018+Qzm71VwkFdRTAmOiEwXtq6Ly6tmPcNMI8PN
	ATkvs1OJatcesi8kx15ikzbd8Sjn2sWLuBDos3lyDV1hsCaFxUCWITTViz/jVI8CYf5T4xFQ5NSz8
	MnofE6HgeQcVUx1Hv6ZnUp0gKoI2Ex2Vbuo5FIIXJ6cXLin8REFExeMJPDfjuwi2QIlPIygL3Da5R
	bBZZkxdlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNhFc-00075S-4r; Wed, 30 Sep 2020 18:54:52 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNhFJ-0006vQ-8j
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 18:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJSHvT1QhRVl+G04VHp6oB+MDJJauXzKMIhMmzCIDDM=; b=ZQOD/b/n4WQ66CxWM/hXXEMnhK
 0NYEsye4QqL616Iw5u2GZboX3lty9Lq8lZODHVzOUhB+y/DLrbg7HypDABv4UYvUlcUw5kqtbTiMH
 QLIUfPGgkbYILPEtkuOAkxbd58IF+JnPtt5OAh1kSlSdaMjQqdd3P1l+y9GbDHGSDI9IqkJoEge6w
 XA1uld3DMwjGPmttwaMbphFCu3uoTSoe24ac18NwOnAtu1tOlzQfhK0TdNMeMFr1cIL2c6TRidfjJ
 WuW3uazKXx+d2/mmmJ18YzLhdNXvzGB5I4MQiry+tHnJ/tw/glq2TuPpcm5DaT3Wq/lPAuxpHLn9U
 IfEC3Vbw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFE-0000ux-52; Wed, 30 Sep 2020 12:54:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFD-00030L-6Z; Wed, 30 Sep 2020 12:54:27 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Wed, 30 Sep 2020 12:54:12 -0600
Message-Id: <20200930185422.11494-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 01/11] common/fio: Remove state file in common
 helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_145433_343393_E70D3D33 
X-CRM114-Status: GOOD (  11.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of each individual test removing this file, just do it
in the common helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 common/fio     | 1 +
 tests/nvme/010 | 1 -
 tests/nvme/011 | 1 -
 tests/nvme/012 | 1 -
 tests/nvme/013 | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/common/fio b/common/fio
index 8bfad4238dda..94c65c107a14 100644
--- a/common/fio
+++ b/common/fio
@@ -181,6 +181,7 @@ _run_fio_rand_io() {
 _run_fio_verify_io() {
 	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
 		--iodepth=16 --verify=crc32c "$@"
+	rm -f local*verify*state
 }
 
 _fio_perf_report() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 9d96d7803be3..0188e842213e 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -52,7 +52,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -f local*verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 06dc568fb6ea..543dbe840874 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -48,7 +48,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -f local-write-and-verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8110430e49d4..1dbd59804ed7 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -63,7 +63,6 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 176b11b9ccb5..df7f23e69252 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -58,7 +58,6 @@ test() {
 	_remove_nvmet_subsystem "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

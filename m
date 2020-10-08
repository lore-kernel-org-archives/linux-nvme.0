Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8EC43457
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BEC21D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0cvvDDIt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="jNX5k7Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BEC21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QGVuUvM/Bkqc2h2347TbmWr4vFK7E6Ck9KyZDNJ91/I=; b=0cvvDDIt8ZKwjhUBiSFFHRMkE
	5CPj6k9R3XX0zFExK8HwjLrCBseKkIFDKe8tcPW1zlvKK2hSUcYuR2Udk9oaOuFZugjbazOYW7pWB
	7Xho5dMgdFMyQRksI/wntJbgrszUrVVW4z/d7v9JGeyGQVzVIhObV5lUBgy+zLvfATu0yDYj946Xp
	8M+gerrh9lCwyZA6EHYnrIwfmDTW0WXI5w0a6F4RMtogmbELnnE+rcxla6Ui9BbL0iy5AqIR0KwMH
	rU4uyOEtEMzmj2kiJJ5UatOOiS08aUF+nAJST9hq/3rkwRUhPtVz2exCmfuv6+kq37Gkpzg1LiQgN
	Qll1qtPyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYyJ-0003RX-Ru; Thu, 08 Oct 2020 16:40:51 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy2-0003Jp-FS
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6OG5y6dqCpzubmOr4AhBg3Vthy6MFMXRPZfk6ASRz7I=; b=jNX5k7WlCE0yZBTiSD8fVqsX1d
 xRzk0YoEdrAnVg8SJyjNLiC0ru9ywM+GHMQFsk6e6ogdLKEQt4qseG7weNyC+Hq78jv6BTQJKnmPn
 tofsvQ0IOwJMcgpBDrOmV3pQppOj1fXJWTvEdZsKuZ09Ta8N7o3zW3H2/wuvWO92IGsmZ8ikeR8I6
 XXn/hmoCSUnKMktYayCLkgiYi5Gf9qaUYuElkG2Nai2YzAnqcd547zJOnI18W/+4BtHhEnKHHkvYV
 rvaZExb/phIZBg4+vkKXWAsyDdyTLZ54IB41BmpmFoqE4nwH9oyjfMP0/1Xptc2C9Z4MDlPIYUl80
 juOgWODg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxz-0000ik-Pp; Thu, 08 Oct 2020 10:40:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxz-0003HO-2s; Thu, 08 Oct 2020 10:40:31 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:16 -0600
Message-Id: <20201008164024.12546-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 03/11] common/xfs: Create common helper to verify
 block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124034_587752_C1C3F456 
X-CRM114-Status: GOOD (  11.81  )
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
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Make a common helper from the code in tests nvme/012 and nvme/013
to run an fio verify on a XFS file system backed by the
specified block device.

While we are at it, all the output is redirected to $FULL instead of
/dev/null.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/xfs     | 22 ++++++++++++++++++++++
 tests/nvme/012 | 14 +-------------
 tests/nvme/013 | 14 +-------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/common/xfs b/common/xfs
index d1a603b8c7b5..210c924cdd41 100644
--- a/common/xfs
+++ b/common/xfs
@@ -9,3 +9,25 @@
 _have_xfs() {
 	_have_fs xfs && _have_program mkfs.xfs
 }
+
+_xfs_mkfs_and_mount() {
+	local bdev=$1
+	local mount_dir=$2
+
+	mkdir -p "${mount_dir}"
+	umount "${mount_dir}"
+	mkfs.xfs -l size=32m -f "${bdev}"
+	mount "${bdev}" "${mount_dir}"
+}
+
+_xfs_run_fio_verify_io() {
+	local mount_dir="/mnt/blktests"
+	local bdev=$1
+
+	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
+
+	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
+
+	umount "${mount_dir}" >> "${FULL}" 2>&1
+	rm -fr "${mount_dir}"
+}
diff --git a/tests/nvme/012 b/tests/nvme/012
index 1d8d8e3cc271..a13cd08ce6bf 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -26,12 +26,9 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local mount_dir="/mnt/blktests"
 	local file_path="${TMPDIR}/img"
 	local subsys_name="blktests-subsystem-1"
 
-	mkdir -p "${mount_dir}" > /dev/null 2>&1
-
 	truncate -s 1G "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
@@ -47,15 +44,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	umount ${mount_dir} > /dev/null 2>&1
-
-	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
-
-	mount /dev/"${nvmedev}n1" "${mount_dir}"
-
-	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
-
-	umount "${mount_dir}" > /dev/null 2>&1
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
@@ -66,7 +55,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3819a2730d9b..1ac725ea83f2 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -24,13 +24,10 @@ test() {
 
 	local port
 	local nvmedev
-	local mount_dir="/mnt/blktests/"
 	local file_path="${TMPDIR}/img"
 
 	local subsys_name="blktests-subsystem-1"
 
-	mkdir -p "${mount_dir}" > /dev/null 2>&1
-
 	truncate -s 1G "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
@@ -44,15 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	umount ${mount_dir} > /dev/null 2>&1
-
-	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
-
-	mount /dev/"${nvmedev}n1" "${mount_dir}"
-
-	_run_fio_verify_io --size=800m --directory="${mount_dir}/"
-
-	umount "${mount_dir}" > /dev/null 2>&1
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
@@ -61,7 +50,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F3C2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118E206D5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m7Oauc9u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aheVQadZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gkDmVr0mmtA+TaEGXRNQySEBaZ06zTtoQ16UF2KSRI4=; b=m7Oauc9uoZiYqE
	gWJs2EGfnKE4Cvh+XAt97u244gzEYZH1nDY+TiiomnewJAcF+KymtwnkD8ch+I0BoeRr30ES+pYwD
	ywI9UCvLyYg6RkKsZh8Q9X7MHGPfcSM2pOxjr+ThSlGgip+bAi1XPZzXtVyUM2lkooBLHwbxRGBR2
	ZooRcJ8PQDFw+56gG6EKPWnfKsd3QO0pLwKuE9RoVX5iQgNMwENnysI+qE0wx+N6btWfc4Kn0OBCA
	M/t2rXJvr1IyDv2e00TzyoUvfa3EIa+WPpPyq+AhvGghQe4KJBZ9vpzHSb8di5gX+mPp74rKXKGzK
	UAJEAW4N+ndO6gAHyPiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwwnC-0004g9-0x; Wed, 29 Jan 2020 23:30:42 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwwm7-0002ax-M8
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 23:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580340576; x=1611876576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SVMZ6rDXDxbqh4kdUlp9IH8pJ8H96RNHWhe6WJPfMBM=;
 b=aheVQadZI9bAEdFKDBey+yg6KcmzXVhvXsxhfP1QhK9IJsibF2jeIP+f
 R9XUGmt5ZwbfdFStFPCgSoWWZ8DOyP+HdYvOuJE5pB6cwG6wHSA8sXAfv
 /IxQ57a7uvCdd9/7EvB3LcxN1au1WatmAN8HuNCaE8lB+apdafSLGl1GP
 roiSOjXiUv7Lc1FAH2sfhhEMdgyQ9H4AAuxvmTvdSAfgtEKsoQ3STUsNM
 90VFirGOybE6uaSYcqZbAWx/Q601dIOkWxDe6Vbjxor9qBt3F5GLsR+K2
 ODEOZL/IHB62gaI7wbVmkM7RFREoRWhhr8gvObfBWAgFA5T/15C2UdVrt g==;
IronPort-SDR: 0AKdBUyKEuk/M8StOYdvrfVf1zstzpjudKBCH2GPC8QcO+tpg6wZdj/48ir4cvJyp3KQSVyRNY
 IVhQuQznRxNidBA7A2f1ii6wp5jDAf1DAm1f1TT0rrSFal4k/WA1a88reLGIo9TIN62FtqUoLD
 1CdytV0LIwjg6F+sZnVNap6JyQICsOllLH0uye1gAB4V1VxarHgj/CLIaZpp+/tXjjhqRy8rRN
 WDRpCGhsVV1x6ZndUovqCRssQ3pnJK0DmKb6Kzr0Fio5Tr2WoY+Ue4mrneCsDuF6/8i4YfuEmW
 KFw=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; d="scan'208";a="130160267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:35 +0800
IronPort-SDR: 7TyjDrYmQpAsAa6qiqjIJfU5D2D+229Dgoe4GimYlYXZYP2rSYBmONcJB0OpYgod+zo6POYLQa
 lTWJIBTv3zJICi566tDTlIGsCv3O9hSFRObTjM7kdWKZXg1J6Xm6vfCKz1ELp+tZcke0ZZbk7K
 l4j/1nsNbph7V8Lgz3C5tP36z0vA0dw9XAPzjER1ywXMjkFLRoqKd/zr+902fteFKwfziKiLb6
 G59E/aZUpFrIo5TDey/qAS3EIrUBkBoeA/XVl/8xQFNzRu3O8hmiEV6zXBvFyt0nhLqDIZeSXV
 zHIGB7niUo7w2/D9gG0TlHK1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:22:46 -0800
IronPort-SDR: 0XlCdI7bSbpDT5MVYWh1/IJHF+0QNycY++B3dtpf3KPw0hkBZP8wtAa/c2Z0m5c0kNZWsMOTZx
 rLEOMnrTUvxgMLgyi+I1KFaAOa4ZtTqecRp/ruoJVJ5Vb5LSh6KeSx4cFuwW8EcIOgjmo8Qy48
 W/YOP+GOn4O1d2L90C9/kJI5YLCNLGUIQ90SYS+iQOLj3mHtD9dnsbhV2EKBalhrxFlCt/YUdh
 9PI+sN10C97nNTXRqVgHx9Al0HBYL9vQTxoOvj3GSgHMLrTfOlvAwAnAjnAu9ct5yqq2IlTnMs
 Kfk=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:35 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Date: Wed, 29 Jan 2020 15:29:21 -0800
Message-Id: <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_152935_769258_AAF69178 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch makes newly added testcases backward compatible with
right value setting into the SKIP_REASON variable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/033 | 60 +++++++++++++++++++++++++++-----------------------
 tests/nvme/034 | 59 ++++++++++++++++++++++++++-----------------------
 tests/nvme/rc  | 27 +++++++++++++++++------
 3 files changed, 83 insertions(+), 63 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 97eba7f..db5ded3 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -9,49 +9,53 @@
 DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
 QUICK=1
 
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_cid_min_max()
+{
+	local cid_min=14
+	local cid_max=15
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+}
+
 requires() {
 	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+		_have_configfs && _have_cid_min_max
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	_setup_nvmet
-
-	local port
-	local nvmedev
-	local loop_dev
-	local cid_min=14
-	local cid_max=15
-	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
-
-	truncate -s 1G "${file_path}"
-
-	loop_dev="$(losetup -f --show "${file_path}")"
-
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
-	port="$(_create_nvmet_port "loop")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	nvme connect -t loop -n "${SUBSYS_NAME}"
 
 	udevadm settle
 
-	nvmedev="$(_find_nvme_loop_dev)"
-	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme id-ctrl /dev/${NVMEDEV}n1 | grep cntlid | tr -s ' ' ' '
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${SUBSYS_NAME}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
-	_remove_nvmet_port "${port}"
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
 
-	losetup -d "${loop_dev}"
+	losetup -d "${LOOP_DEV}"
 
-	rm "${file_path}"
+	rm "${FILE_PATH}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 1a55ff9..39d833f 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -9,50 +9,53 @@
 DESCRIPTION="Test NVMeOF target model attribute"
 QUICK=1
 
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_model()
+{
+	local model="test~model"
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 14 15 \
+		${model}
+}
 requires() {
 	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+		_have_configfs && _have_model
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	_setup_nvmet
-
-	local port
-	local result
-	local nvmedev
-	local loop_dev
-	local model="test~model"
-	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
-
-	truncate -s 1G "${file_path}"
-
-	loop_dev="$(losetup -f --show "${file_path}")"
-
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
-	port="$(_create_nvmet_port "loop")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	nvme connect -t loop -n "${SUBSYS_NAME}"
 
 	udevadm settle
 
-	nvmedev="$(_find_nvme_loop_dev)"
-	nvme list | grep ${nvmedev}n1 | grep -q test~model
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme list | grep ${NVMEDEV}n1 | grep -q test~model
 	result=$?
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${SUBSYS_NAME}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
-	_remove_nvmet_port "${port}"
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
 
-	losetup -d "${loop_dev}"
+	losetup -d "${LOOP_DEV}"
 
-	rm "${file_path}"
+	rm "${FILE_PATH}"
 
 	if [ ${result} -eq 0 ]; then
 		echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 377c7f7..77bafd8 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -128,15 +128,28 @@ _create_nvmet_subsystem() {
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
-
-	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
-		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
-		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
+	if [ $# -eq 5 ]; then
+		if [ -f ${cfs_path}/attr_cntlid_min ]; then
+			echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
+			echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
+		else
+			SKIP_REASON="attr_cntlid_[min|max] not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
 	fi
-	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
-		echo ${model} > ${cfs_path}/attr_model
+	if [ $# -eq 6 ]; then
+		if [ -f ${cfs_path}/attr_model ]; then
+			echo ${model} > ${cfs_path}/attr_model
+		else
+			SKIP_REASON="attr_cntlid_model not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
 	fi
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+
+	return 0
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC413C5478A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/jSPxsrSvPZBNaszGXLbUeROhgl5r3nVBSlOeQx3eY=; b=mO3+qUoPXNJaHvt+E2Is9asmoG
	Ww+nhxTP5gVfMZ/3/CutERIdXe7nb/PD9Y7xhocSvjTmjV/3L886fTBYW+iMgKvnrP8DgBonEkfbc
	FSN8u8klH4+7KQ9U9bcRPD01cJFo7Zv9KKS0OfMEjKjDAsZJvOEWSeL1zTWEHC3faHNF3cO3Jjfb9
	nEzQyR9XNJTUAsB0GJDr71G1A9TmaimK0L4WP5/0aMk99lfY8sbfIcpaRmhBCt0qdvngewEHnFG+q
	nTEd88bqwiwiEUGZXvdn33wrxxbdhgOBDFtdRhNvSToXBsEj7mNQ7ApUGKMJGkNv8Yk5YaIkSrYFY
	7i0owFWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrTK-000000028jg-1Vxe;
	Wed, 21 Feb 2024 18:37:34 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrR8-0000000282o-0BZj
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 18:35:23 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDiW3V017568;
	Wed, 21 Feb 2024 18:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=J/jSPxsrSvPZBNaszGXLbUeROhgl5r3nVBSlOeQx3eY=;
 b=KYrWYROPxujjpapWei/5UiLlluPLWWdlD9QCRk46uV2xbyuNVB5ZmC3i42AQ6zxazDlm
 ptIHe10pfY1P2Xzx+zTBAZcGT9gru2FzjAtMkegT7m+ZTa6AjGR5xBhksUQRAXyT3FHZ
 sYj77qjtEMut4/5y7HoWPzs+ASiR2AbZBkPnMN73Sk0nsFSiESx/c6xthKXEZzjEZBpU
 85L4PxGPQqWZ/8lVlf+v/sLFM5egGc7xdLvG/4CgHnggtvwyRkQYhMLVyt3GA/xG0XND
 zB+S4ZbY2o/QEz5tEVvU5ZhaB54+hkLT4V+eZE0+rM8CTgJLnhaDpXtEJIhH3/CHNuBE 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4kntavn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LHDwhq039661;
	Wed, 21 Feb 2024 18:35:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89evh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LIVkxf039971;
	Wed, 21 Feb 2024 18:35:14 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak89evfs-2;
	Wed, 21 Feb 2024 18:35:14 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V3 1/1] nvme: Add passthru error logging tests to nvme/039
Date: Wed, 21 Feb 2024 10:36:40 -0800
Message-Id: <20240221183640.3432605-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240221183640.3432605-1-alan.adamson@oracle.com>
References: <20240221183640.3432605-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210145
X-Proofpoint-ORIG-GUID: eaEa0hZpsPaInQOjTbUljV3gLUOK0iLE
X-Proofpoint-GUID: eaEa0hZpsPaInQOjTbUljV3gLUOK0iLE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_103518_706129_4E903D78 
X-CRM114-Status: GOOD (  16.96  )
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

Tests the ability to enable and disable error logging for passthru admin commands issued to
the controller and passthru IO commands issued to a namespace.

These tests will only be run on kernels that export the passthru_err_log_enabled
attribute.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 73b53d0b949c..f92f852cd56f 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -130,6 +130,29 @@ inject_invalid_admin_cmd()
 	fi
 }
 
+inject_invalid_io_cmd_passthru()
+{
+	local ns
+
+	ns=$(echo "$1" |  cut -d "n" -f3)
+
+	# Inject a 'Invalid Command Opcode' (0x1) on a read (0x02)
+	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
+
+	nvme io-passthru /dev/"$1" --opcode=0x02 --namespace-id="$ns" \
+		--data-len=512 --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+	if ${nvme_verbose_errors}; then
+		last_dmesg 2 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		last_dmesg 2 | grep "Cmd(0x2" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -155,6 +178,26 @@ test_device() {
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
 
+	if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then
+		_nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
+
+		# Test Pass Thru Admin Logging
+		_nvme_disable_passthru_admin_error_logging "${ctrl_dev}"
+		inject_invalid_admin_cmd "${ctrl_dev}"
+		_nvme_enable_passthru_admin_error_logging "${ctrl_dev}"
+		inject_access_denied_on_identify "${ctrl_dev}"
+
+		# Test Pass Thru IO Logging
+		_nvme_disable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+		inject_invalid_io_cmd_passthru "${ns_dev}" 0
+		_nvme_enable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+		inject_invalid_io_cmd_passthru "${ns_dev}" 1
+
+		_nvme_passthru_logging_cleanup "${ns_dev}" "${ctrl_dev}"
+	else
+		echo " Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0"
+		echo " Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0"
+	fi
 	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
 
 	echo "Test complete"
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
index 139070d22240..fea76cfd1245 100644
--- a/tests/nvme/039.out
+++ b/tests/nvme/039.out
@@ -2,4 +2,6 @@ Running nvme/039
  Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
  Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
  Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
+ Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
+ Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dfc4c1ef1975..2d6ebeab2f6f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -943,6 +943,23 @@ _check_uuid() {
 
 declare -A NS_DEV_FAULT_INJECT_SAVE
 declare -A CTRL_DEV_FAULT_INJECT_SAVE
+ns_dev_passthru_logging=off
+ctrl_dev_passthru_logging=off
+
+_nvme_passthru_logging_setup()
+{
+	ctrl_dev_passthru_logging=$(cat /sys/class/nvme/"$2"/passthru_err_log_enabled)
+	ns_dev_passthru_logging=$(cat /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled)
+
+	_nvme_disable_passthru_admin_error_logging "$2"
+	_nvme_disable_passthru_io_error_logging "$1" "$2"
+}
+
+_nvme_passthru_logging_cleanup()
+{
+	echo $ctrl_dev_passthru_logging > /sys/class/nvme/"$2"/passthru_err_log_enabled
+	echo $ns_dev_passthru_logging > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
 
 _nvme_err_inject_setup()
 {
@@ -985,6 +1002,26 @@ _nvme_disable_err_inject()
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
 }
 
+_nvme_enable_passthru_admin_error_logging()
+{
+	echo on > /sys/class/nvme/"$1"/passthru_err_log_enabled
+}
+
+_nvme_enable_passthru_io_error_logging()
+{
+	echo on > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
+
+_nvme_disable_passthru_admin_error_logging()
+{
+	echo off > /sys/class/nvme/"$1"/passthru_err_log_enabled
+}
+
+_nvme_disable_passthru_io_error_logging()
+{
+	echo off > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
+
 _nvme_reset_ctrl() {
 	echo 1 > /sys/class/nvme/"$1"/reset_controller
 }
-- 
2.39.3



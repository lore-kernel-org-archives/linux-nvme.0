Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6F7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wn5OkM5Ai+3Pwa2ZmApyaSDNLntVr1QkElfVJ9EUuE=; b=gzO+sqXZvd9W7gaFy27CS2oK2g
	dCSwPaX8gtS4e9NQs3hLY0BnY/5Vy5UiD1RPwAaHtrFxX5oMvqUcLo+ClXsvg5aAdws0ryjGI4rCk
	h4Bo2hyvLdeRIgcZPOB/zw96OOIRgex72tLFSUgM2eWNeUzNRMUaG4gomtrHj7zrQDVApYeXzZklU
	VRzd57dh3T2EGElUaEgebn2hmxCrQH9XG21a4bhmuwelY3DK9TOZ646drlMU6OpqV3s1Cfv0E/Agr
	iOWDdozFrCQzV/t4z2DhXZPoeHkLFmTntatA1ilesSBgkBsC+SN1XiMBRFBIRMp+b6cnemJGrQd1O
	cv4ipTlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npXbW-00Glqo-FA; Fri, 13 May 2022 15:53:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npXbL-00GlnV-A1
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 15:53:14 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdC7O005769;
 Fri, 13 May 2022 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=+wn5OkM5Ai+3Pwa2ZmApyaSDNLntVr1QkElfVJ9EUuE=;
 b=KR0O2tvyB7lDBqxYj09Bd/cTUL8lOUhE2dGIoy/qRP7ddrthGsnEqo71D1ysgLqHO+3q
 PmlYBwnPa/iQOykVTZKmFb0KAT5DrATkT5kbEFBWlAI4HiSOJAVa6ZK6pCxRytaP545u
 MDV0EFg+fUKVAYtJwJLdaQWab4vbv9TjAzkW3+pLDmauh8FPxB1bHHUiIIMBWSg2yoKO
 tB2Px3+lIQH2XWXf57Zms+cK+GhBfVn1/BoLbcrx4+44qpR7gAFh6DGok+GqvsDaiUip
 6ZQTfPYl16StMNOfowh6N00MLj/ePykXO29mjbHk/xjKiiJ7CD7G0qI/PzBbzcJkKZwL ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatr09d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 May 2022 15:53:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24DFjZHc012200; Fri, 13 May 2022 15:53:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf76626h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 May 2022 15:53:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24DFr1xS034295;
 Fri, 13 May 2022 15:53:07 GMT
Received: from dhcp-10-159-226-103.vpn.oracle.com
 (dhcp-10-159-226-103.vpn.oracle.com [10.159.226.103])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf766243-3; Fri, 13 May 2022 15:53:07 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: [PATCH v3 blktests 2/2] tests/nvme: add tests for error logging
Date: Fri, 13 May 2022 08:52:52 -0700
Message-Id: <20220513155252.14332-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220513155252.14332-1-alan.adamson@oracle.com>
References: <20220513155252.14332-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o64VwStvWTXNi9ilZa1VG9iHxGbQC7ue
X-Proofpoint-ORIG-GUID: o64VwStvWTXNi9ilZa1VG9iHxGbQC7ue
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_085311_437068_AECAE06D 
X-CRM114-Status: GOOD (  19.54  )
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

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 2 files changed, 159 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100755
index 000000000000..dd216cbb2ef0
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,152 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Oracle and/or its affiliates
+#
+# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
+# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
+# run with or without NVME_VERBOSE_ERRORS configured.
+#
+# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
+
+. tests/nvme/rc
+DESCRIPTION="test error logging"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option FAULT_INJECTION && \
+	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+}
+
+inject_unrec_read_read()
+{
+	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_status_read()
+{
+	# Inject an invalid status (0x375) on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unknown (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unknown/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_write_fault_write()
+{
+	# Inject a 'Write Fault' 0x280 status error on a WRITE
+	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
+
+	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Write Fault (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
+		    sed 's/I\/O Error/Write Fault/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_access_denied_identify()
+{
+	# Inject a 'Access Denied' (0x286) status error on an
+	# Identify admin command
+	_nvme_enable_err_inject "$1" 0 100 1 0x286 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Access Denied (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Identify/g' | \
+		    sed 's/I\/O Error/Access Denied/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_cmd_admin()
+{
+	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
+	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Unknown/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+test_device() {
+	local nvme_verbose_errors
+	local ns_dev
+	local ctrl_dev
+
+	echo "Running ${TEST_NAME}"
+
+	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+		nvme_verbose_errors=true
+	else
+		unset SKIP_REASON
+		nvme_verbose_errors=false
+	fi
+
+	ns_dev=${TEST_DEV##*/}
+	ctrl_dev=${ns_dev%n*}
+
+	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
+
+	inject_unrec_read_read "${ns_dev}"
+	inject_invalid_status_read "${ns_dev}"
+	inject_write_fault_write "${ns_dev}"
+
+	inject_access_denied_identify "${ctrl_dev}"
+	inject_invalid_cmd_admin "${ctrl_dev}"
+
+	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 000000000000..162935eb1d7b
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,7 @@
+Running nvme/039
+ Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
+ Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
+ Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
+ Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
+ Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
+Test complete
-- 
2.27.0



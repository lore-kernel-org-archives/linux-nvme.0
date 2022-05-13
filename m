Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E32C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzDDomZrhd1Fm0N161zQGvrwgmKjqLx6L/iQYjbjKzg=; b=A0V+q522yvBrHhDGscRUfIxxXa
	t1zLgKOcMNW3tLcLWmQUbFm4Tyu8SlFk0pe+bnzJh79Wgk47BzFxFWT0TQOEotPj8bdBjfwf/MOlo
	mIt3RXTHx0ETsDNtKZiolbx3eiz5J/vL3H36SdU7Xunim1WDI1cDKOcESwLZxGciQqLCvX/DWpZaV
	IuUjW3g9NYvpQcuifhh6K6Bq5B7qKZY6IyGkVzHXX55oTw930nF5TJhz69weqzmegJZqQp2qP2vRz
	Mti1MJc+E1fmevkw53S80Lqc3y/AFAsesKExpKIa/ve3c/tCD75WAQoxHbMl3tx83XZ0UQHuWHQwH
	qch3EkKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npXbS-00GlpE-7w; Fri, 13 May 2022 15:53:18 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npXbL-00GlnS-A2
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 15:53:12 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdDOq005776;
 Fri, 13 May 2022 15:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=dzDDomZrhd1Fm0N161zQGvrwgmKjqLx6L/iQYjbjKzg=;
 b=COhETa82qKBBZHgRGh96dQIpHC0M6cGcuOXKWJUUfitif9zYJgtH8VURBMZNW2+ozGqo
 Wj3ZFWcWAR7zxeQYl73yPOssaaraMjm1TTbRnWEqiLPhywWmGliNTw0I1HPOfbJZjhbi
 OiF0ig4dKNt96lH9UWpACfO1/Enj/cC+T0XBUJqt2N6/WQtkHicBfrLo/Pq8M0CPBXj9
 qeHZ0X14nljyZw/YsK6SfCgNKmazjb7l7DSX+T1NMvwaYri0eGdrgvUs7NTtNwV0T8uq
 df8Hcjk5IqJMtfW9753yTMyF5RZTLzEifNrW2zOn+nFSuqYKP0YicS5nelwHIxTRXcp2 IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatr09c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 May 2022 15:53:07 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24DFjZJL012167; Fri, 13 May 2022 15:53:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf76625r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 May 2022 15:53:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24DFr1xQ034295;
 Fri, 13 May 2022 15:53:06 GMT
Received: from dhcp-10-159-226-103.vpn.oracle.com
 (dhcp-10-159-226-103.vpn.oracle.com [10.159.226.103])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf766243-2; Fri, 13 May 2022 15:53:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: [PATCH v3 blktests 1/2] tests/nvme: add helper routines to use error
 injector
Date: Fri, 13 May 2022 08:52:51 -0700
Message-Id: <20220513155252.14332-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220513155252.14332-1-alan.adamson@oracle.com>
References: <20220513155252.14332-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SudgCAGsnfO4Emzjuj_lh-2ZGFTWvXYi
X-Proofpoint-ORIG-GUID: SudgCAGsnfO4Emzjuj_lh-2ZGFTWvXYi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_085311_391505_01AACEB4 
X-CRM114-Status: GOOD (  14.18  )
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

nvme tests can use these helper routines to setup and use
the nvme error injector.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3c38408a0bfe..c49a3c5d78da 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -375,3 +375,47 @@ _discovery_genctr() {
 	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
+
+declare -A NS_DEV_FAULT_INJECT_SAVE
+declare -A CTRL_DEV_FAULT_INJECT_SAVE
+
+_nvme_err_inject_setup()
+{
+        local a
+
+        for a in /sys/kernel/debug/"$1"/fault_inject/*; do
+                NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+        done
+
+        for a in /sys/kernel/debug/"$2"/fault_inject/*; do
+                CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+        done
+}
+
+_nvme_err_inject_cleanup()
+{
+        local a
+
+        for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
+                echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+		echo ${a} $(<"${a}") >> /tmp/iii
+        done
+        for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
+                echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+        done
+}
+
+_nvme_enable_err_inject()
+{
+        echo "$2" > /sys/kernel/debug/"$1"/fault_inject/verbose
+        echo "$3" > /sys/kernel/debug/"$1"/fault_inject/probability
+        echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
+        echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
+        echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
+}
+
+_nvme_clear_err_inject()
+{
+        echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
+        echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
+}
-- 
2.27.0



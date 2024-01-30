Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4AFC47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R/2YZvJtPUmfQnKyvgAqFBXFI5+jjumW98xXQI9JqvE=; b=FKchNRYOeUVKnH5PQYtyOIwZg1
	DkqJ8HD57wi83jFMNSWwt+/NRJRmKOBq7i7EnJbEIm3aIDAgY7ePrsgudiQv/pV+Z6K4z4OWdNeW2
	1F51KFTwN5GCzwJUDhjs7y+V57yER79PkWakzKDDHDobd1SyDJ3QRUVtVEnXSVGj/v4VqXRE/jCzr
	G3oo9CM5dyjZZDUapns1UT38BHRPjBSu3K6Yu4RrZ6GqUKw6vTELqFkyiHLhJwvj8o7I/FmV8smXt
	Mp2SVzvroATfow5ulxdrgyhd44BqJ5/qd9y4C8k+RkBMBeUxI2NZ35CZjA/85fTJmyDcKHahHfdjA
	6woliYSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUbpo-0000000EgEr-0Thy;
	Tue, 30 Jan 2024 00:18:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUbpl-0000000EgE0-0hRA
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 00:18:38 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJie0e030899;
	Tue, 30 Jan 2024 00:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=R/2YZvJtPUmfQnKyvgAqFBXFI5+jjumW98xXQI9JqvE=;
 b=JhzvbpsEXp8u6YeiMq53w0zr/qq2Xz7/O+gCxBQ41fNo9CUey6I3TW1N7Qqf1Jg5oZd1
 lu4zrGESnJtVAyGyvGHUfuSMFK0Rfu6rOxxPDwqTt0+47VKEfcY/hpm+2pKSNQjN9InE
 8vvQfzRInv4GR174gbVpHtR43djFyCj/PF9Tm0tgmr1VnAsj0ZoDatPhSycAJJQqPnDf
 jcke/FNXqQ00ZyDkpKJDAoNg1+jVN4dUAZOz9wFwEIsr8uSI2XOAo37V+las9A2z7G4+
 bmp1gE3aOXRXYFhybOAYucTAJglX8T2vyKuT2nUXjO9lVevnUHhqPnb4aBb0TEuqO+zK dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcdd9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 00:18:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TNRv5t014761;
	Tue, 30 Jan 2024 00:18:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9cnnk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 00:18:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U0IOrV028387;
	Tue, 30 Jan 2024 00:18:25 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9cnne3-1;
	Tue, 30 Jan 2024 00:18:24 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V9 0/1] nvme: allow passthru cmd error logging
Date: Mon, 29 Jan 2024 16:19:37 -0800
Message-Id: <20240130001938.1103354-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300001
X-Proofpoint-ORIG-GUID: aixNCoU_bAl9Z4uJv0axUofixWdH5Wcv
X-Proofpoint-GUID: aixNCoU_bAl9Z4uJv0axUofixWdH5Wcv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_161837_442376_64D72CD2 
X-CRM114-Status: GOOD (  17.92  )
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

In nvme_end_req() we only log errors which are for non-passthru
commands. Add a helper function nvme_log_err_passthru() that allows us
to log error for passthru commands by decoding cdw10-cdw15 values of
nvme command.

Below is short testlog :-

* Admin Passsthru error log off, no errors are printed
* Admin Passsthru error log on, errors are printed
* IO Passsthru error log off, no errors are printed
* IO Passsthru error log on, errors are printed

v9:
- Move logging_enabled flag in device structure to nvme_ctrl and nvme_ns structures.
- Create seperate show/store functions for nvme_dev_attrs and nvme_ns_attrs.

v8:
- Add a logging_enabled flag to device structure.
- Add a passthru_err_log_enabled sysfs attribute for namespaces to
  allow logging of passthru IO commands.

v7:
- Changed attribute/flag to passthru_err_log_enabled.
- Use kstrtobool rather than kstrtoint.

v6:
- Rebase, retest nvme-6.5 and add test log for admin and I/O
  passthru error log.

v5:
- Trim down code in the nvme_log_error_passthrough().
  Use following to get the disk name as an arg to
   pr_err_ratelimited() :-
        ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
  Use following to get the admin vs I/O opcode string as an arg to
  pr_err_ratelimited() :-
        ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
             nvme_get_admin_opcode_str(nr->cmd->common.opcode),
- Rename nvme_log_error_passthrough() -> nvme_log_err_passthru().
- Remove else and return directly in nvme_passthru_err_log_show().
- Generate error on invalid values of the passthru_enable variable
  in nvme_passthru_log_store().
- Rename passthrough -> passthru.
- Rename sysfs attr from passthru_admin_err_logging -> passthru_log_err.

v4:
- Change sysfs attribute to passthru_admin_err_logging
- Only log passthrough admin commands.  IO passthrough commands will
  always be logged.

v3:
- Log a passthrough specific message that dumps CDW* contents.
- Enable/disable vis sysfs rather than debugfs.

v2:
- Included Pankaj Raghav's patch 'nvme: ignore starting sector while
  error logging for passthrough requests'
  with a couple changes.
- Moved error_logging flag to nvme_ctrl structure
- The entire nvme-debugfs.c does not need to be guarded by
  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS.
- Use IS_ENABLED((CONFIG_NVME_ERROR_LOGGING_DEBUG_FS)) to determine if
  error logging should be initialized.
- Various other nits.


Testing
-------
* Admin Passsthru error log off, no errors are printed :-

[root@localhost ~]# echo 0 > /sys/class/nvme/nvme0/passthru_err_log_enabled
[root@localhost ~]# nvme telemetry-log -o /tmp/test /dev/nvme0
[root@localhost ~]# dmesg
[root@localhost ~]


* Admin Passsthru error log on, errors are printed :-

[root@localhost ~]# echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
[root@localhost ~]# nvme telemetry-log -o /tmp/test /dev/nvme0
[root@localhost ~]# dmesg
[ 2364.008105] nvme0: Get Log Page(0x2), Invalid Field in Command (sct 0x0 / sc 0x2) DNR cdw10=0x7f0107 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0


* IO Passsthru error log off, errors are not printed :-

[root@localhost ~]# echo 0 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
[root@localhost ~]# nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
[root@localhost ~]# dmesg
[ 3131.602986] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[root@localhost ~]#


* IO Passsthru error log on, errors are printed :-

[root@localhost ~]# echo 1 > /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
[root@localhost ~]# nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA Out of Range: The command references an LBA that exceeds the size of the namespace(0x4080)
[root@localhost ~]# dmesg
[ 2944.910393] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 2944.910423] nvme0n1: Write Zeroes(0x8), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0
[root@localhost ~]#

Alan Adamson (1):
  nvme: allow passthru cmd error logging

 drivers/nvme/host/core.c  | 59 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h  |  3 +-
 drivers/nvme/host/sysfs.c | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 7 deletions(-)

-- 
2.39.3



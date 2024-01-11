Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C19FC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 00:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SKbHp0WkadjhtONYCw8dkANNDkRCdSyesCvh1uLk4f8=; b=aA1Z7//2rlyO9tTVaXr1AlDISA
	YZ21yr5LDCs5MKyBJs+LoUOwWBwz4FNHsURhEvsECkJqhrwN6ASkfIcCqfajLax112eQHpycRJVu+
	KqggPP1uF/ylj9LrtRtRQ/FsoPmFssjnPa6ge2rEuBPx4/nzI1YooQVVG3sobG5/+5RINj9q5ua0q
	i8gA7NLLeYUWhNNn/TLztDPAmDtLB8WyTxdCde7QObLW5q4NQcQGftA6stIPZWtbseKgzaIASBn6E
	+lqGW9zdJs6ZLAUWpGr4qyE8RMLjqQzQsZPCc2XhWdqEQiONfotPy9mumcLEhsiUht2H/cYPbyshB
	n/Pb6skg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNibs-00EqUi-0o;
	Thu, 11 Jan 2024 00:07:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNibp-00EqRX-0G
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 00:07:47 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ANShpY024825;
	Thu, 11 Jan 2024 00:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=SKbHp0WkadjhtONYCw8dkANNDkRCdSyesCvh1uLk4f8=;
 b=XTOSWB2F57Pq2EZYYR1y+cn16bDCSUP7bjHEYfSI0JsgEpIXnQwkJ4gAkf5eMO4RPOH/
 qenOCVG4hlzMhlqNp6FrIMFqxJ9x/GdwPxdA/AQOVKpSU49kIaj7yYNm7HByF6ONkfGE
 O0XET6ggCBMnQpnwkPbfXSX3gT2ReiTzGQSeHAsCMzag+mgRRXpBFk5WJ85/Sanspb1x
 Ky5/Q7XKq8j1SrTj9rAyhps0cAV5JAeZ65O7xvvlwgIH87A/1SwAbz54Y7RoFtIelw1Z
 QCn8NUpIrdV8HgCSndkrJKxpfnZz3OmKg5SiR4haIiR5ENdDpBuQpJ48T0Dz8D8uWGK1 IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj4wwg17k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 00:07:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B060i8012220;
	Thu, 11 Jan 2024 00:07:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwk62am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 00:07:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40B02aXl024177;
	Thu, 11 Jan 2024 00:07:35 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vfuwk62a1-1;
	Thu, 11 Jan 2024 00:07:35 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V8 0/1] nvme: allow passthru cmd error logging
Date: Wed, 10 Jan 2024 16:08:54 -0800
Message-Id: <20240111000855.1800481-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_13,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100191
X-Proofpoint-GUID: jt5HaH_gWCW26PGMQ28La5oDq8lX6Atk
X-Proofpoint-ORIG-GUID: jt5HaH_gWCW26PGMQ28La5oDq8lX6Atk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_160745_437471_8B5C2C56 
X-CRM114-Status: GOOD (  18.54  )
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

 drivers/nvme/host/core.c  | 52 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 44 +++++++++++++++++++++++++++++++++
 include/linux/device.h    |  1 +
 4 files changed, 93 insertions(+), 6 deletions(-)

-- 
2.39.3



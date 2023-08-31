Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D66CA0FE1
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bbg4ZJ6CchpubyTt9niGr165FxNG4zOMjolG7crg1ok=; b=x/CHQi4pOsPuU1uoasUKI8RyWp
	dZedJZcp+FAwwnuC4kV7ETMd89cPoKUWtiZUirXIAKeBMzirnRIOmJisSqD78LqJonM5AhUPJeo0e
	1nv930cwjB5mOdUdP/h4SQxfD2FmVCAlEfGhnBFqOOuFhJ7v50UhD/6Nil89lzH3DimKC6CEbPxwC
	MjdvEHlab4CZB3UpArUUgDRZqTGzwjxBxrN5HjI9TS4m430NJuUdwX2HHdqyt9bJE5sYCFhtkRx3K
	RXHzJ/4r8K6CuGPcjYEz/nCF/FJ+wkPIlK0QgKqdFBO2Np263mPFP8vEm8CkECFFXSzhA/05zanDe
	Tly8nmJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbqwK-00Fx93-0V;
	Thu, 31 Aug 2023 23:19:04 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbqwH-00Fx80-1n
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 23:19:02 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VMxacB017432;
	Thu, 31 Aug 2023 23:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=bbg4ZJ6CchpubyTt9niGr165FxNG4zOMjolG7crg1ok=;
 b=sahiVcn9YP+ALtS1/+VADh1Wu8QnXLWPZm+IHJF8QV3/XD4+INatRRrvVPi1BuO7klx+
 SEjz2MRmsPIbCl598SPzRI4iaRyrxcoJltM3DoZuYqBVxksQ8HZ/fCH9xU8xGA18V3k0
 szd69VEIkYu8G655b45sbtT9cjgGJHWjAipV6LB87kX2dB/cc2FjhagJUdm9rimsnqj3
 BOfoDL4sENn7Ouii1BbjWuwaiylifi9ur2t9mVIvMOWlCZON8vR/54BsGyerrnIwU7Um
 pR9oYYviEA1g+XJRqNaBToAAVHzpOrys0zkyCQqxUsdD6GSxkz0+zvVuJTggdpoNcKZU 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mctxgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 23:18:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VLUREk024335;
	Thu, 31 Aug 2023 23:18:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6drmph3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 23:18:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VNIWXe032008;
	Thu, 31 Aug 2023 23:18:32 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6drmpds-1;
	Thu, 31 Aug 2023 23:18:32 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH V7 0/1] nvme: allow passthru cmd error logging
Date: Thu, 31 Aug 2023 16:18:26 -0700
Message-Id: <20230831231827.3896883-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_20,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310208
X-Proofpoint-ORIG-GUID: _jvm1GXzvFOPTLbDsi7ozok6jbqqJ5c9
X-Proofpoint-GUID: _jvm1GXzvFOPTLbDsi7ozok6jbqqJ5c9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_161901_601041_2280389D 
X-CRM114-Status: GOOD (  15.48  )
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
* IO Passsthru error log off, errors are printed
* IO Passsthru error log on, errors are printed

v7:
- Changed attribute/flag to passthru_err_log_enabled.
- Use kstrtobool rather than kstrtoint.

v6:
- Reabse, etest nvme-6.5 and add test log for admin and I/O
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
NVMe status: INVALID_FIELD: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry header 16386!
[root@localhost ~]# dmesg
[root@localhost ~]


* Admin Passsthru error log on, errors are printed :-

[root@localhost ~]# echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
[root@localhost ~]# nvme telemetry-log -o /tmp/test /dev/nvme0
NVMe status: INVALID_FIELD: A reserved coded value or an unsupported value in a defined field(0x4002)
Failed to acquire telemetry header 16386!
[root@localhost ~]# dmesg
[  892.573216] nvme0: Admin Cmd(0x2), I/O Error (sct 0x0 / sc 0x2) DNR cdw10=0x7f8107 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0


* IO Passsthru error log off, errors are printed :-

[root@localhost ~]# echo 0 > /sys/class/nvme/nvme0/passthru_err_log_enabled
[root@localhost ~]# nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA_RANGE: The command references a LBA that exceeds the size of the namespace(0x4080)
[root@localhost ~]# dmesg
[ 1037.307902] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 1037.307991] nvme0n1: I/O Cmd(0x8), I/O Error (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0
[root@localhost ~]# 


* IO Passsthru error log on, errors are printed :-

[root@localhost ~]# echo 1 > /sys/class/nvme/nvme0/passthru_err_log_enabled
[root@localhost ~]# nvme write-zeroes -n 1 -s 0x200000 -c 10 /dev/nvme0
NVMe status: LBA_RANGE: The command references a LBA that exceeds the size of the namespace(0x4080)
[root@localhost ~]# dmesg
[ 1076.779806] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[ 1076.779900] nvme0n1: I/O Cmd(0x8), I/O Error (sct 0x0 / sc 0x80) DNR cdw10=0x200000 cdw11=0x0 cdw12=0xa cdw13=0x0 cdw14=0x0 cdw15=0x0


-- 
2.39.3



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248ECC6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SJkqXoQLLyTNQe4VizlrD0rXpuK5h0M4gUBGLc5iBhc=; b=NlhQ4uAY7H441hGNpQh0KxUByH
	l308MCXyc0G1aqe1ZYbVji50ihOMpx4aOCQooaPI17/QIff3ooSJ9zWYg/V9yURuo4DEKkcT3OAh/
	edF8oAQQMhyQ8QPv8ubalNFKfBaU4qf8kdYJ4XV+w72wHXyeRDxHs3ZLJBHgmqXGNh78/1SOKG/Bs
	PHO88q0M3zaQ5w92PGU8EcofOHHf1dbv7CvNeFtNHoNLSXMZyXzhimZxqW1JGMObL517S6YaZwXyq
	9ln6ec0YWIuIJ4yHX4Hhz6w2DZ4ap4k3RwlxPejJ04oLgD3qOMPKZ+jkylZmQFwfyQt/AOeYVFgk1
	FxL5/YgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLf-00B2Wa-33;
	Fri, 07 Apr 2023 20:06:15 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLc-00B2Ue-05
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:06:14 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337FwobR017328;
	Fri, 7 Apr 2023 20:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=SJkqXoQLLyTNQe4VizlrD0rXpuK5h0M4gUBGLc5iBhc=;
 b=q1NpzSyicelZz/EJcjAv9KLV9wPgT9RciIMrqB5hUursj4cRgyB5AtNzBQQIGMOjw0qD
 g+xIhPGqsrssM5xjtvtCnG20DxXdmClEO4MASIDmPieBxPyluHV037zmNxGBukqLDbOU
 SflEujEYMJleRTTCR8VWL2S4mXnH9pjrF56+0Mj0yLewUoSRJ42Qq+gipmqoWQYrnHnu
 PqDSEPWluknceZGqv5Nr/+h5X97VJjtRmUdqArcwd123oGOnZ3MS7ifKcOaOUfR0Ae1G
 ZizVT8h6tzzvy6Bh5PaTGfCbyR6WmwSkzrvQvPSuCDWO2tda7JvS+9O1an1XYvRrif4C Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd5wu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:05:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337J0UK9034219;
	Fri, 7 Apr 2023 20:05:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxeec5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:05:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5tqq010228;
	Fri, 7 Apr 2023 20:05:55 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-1;
	Fri, 07 Apr 2023 20:05:54 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Subject: [PATCH v6 00/18] Use block pr_ops in LIO
Date: Fri,  7 Apr 2023 15:05:33 -0500
Message-Id: <20230407200551.12660-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Proofpoint-GUID: iHg0PBtxfmh4W4-XsTYDZ3rbexyC2Cq0
X-Proofpoint-ORIG-GUID: iHg0PBtxfmh4W4-XsTYDZ3rbexyC2Cq0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130612_324013_3FE91269 
X-CRM114-Status: GOOD (  22.42  )
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

The patches in this thread allow us to use the block pr_ops with LIO's
target_core_iblock module to support cluster applications in VMs. They
were built over Linus's tree. They also apply over linux-next and
Martin's tree and Jens's trees.

Currently, to use windows clustering or linux clustering (pacemaker +
cluster labs scsi fence agents) in VMs with LIO and vhost-scsi, you have
to use tcmu or pscsi or use a cluster aware FS/framework for the LIO pr
file. Setting up a cluster FS/framework is pain and waste when your real
backend device is already a distributed device, and pscsi and tcmu are
nice for specific use cases, but iblock gives you the best performance and
allows you to use stacked devices like dm-multipath. So these patches
allow iblock to work like pscsi/tcmu where they can pass a PR command to
the backend module. And then iblock will use the pr_ops to pass the PR
command to the real devices similar to what we do for unmap today.

The patches are separated in the following groups:
Patch 1 - 2:
- Add block layer callouts for reading reservations and rename reservation
  error code.
Patch 3 - 5:
- SCSI support for new callouts.
Patch 6:
- DM support for new callouts.
Patch 7 - 13:
- NVMe support for new callouts.
Patch 14 - 18:
- LIO support for new callouts.

This patchset has been tested with the libiscsi PGR ops and with window's
failover cluster verification test. Note that for scsi backend devices we
need this patchset:

https://lore.kernel.org/linux-scsi/20230123221046.125483-1-michael.christie@oracle.com/T/#m4834a643ffb5bac2529d65d40906d3cfbdd9b1b7

to handle UAs. To reduce the size of this patchset that's being done
separately to make reviewing easier. And to make merging easier this
patchset and the one above do not have any conflicts so can be merged
in different trees.

v6:
- Drop dm use comment.
- Move scsi pr type conversion code to scsi_common.c/.h.
- Fix le NVME_EXTENDED_DATA_STRUCT use.
- Fix sparse warnings like sense_reason_t use.

v5:
- Use []/struct_size with nvme reservation structs
- Add Keith's copywrite to pr.c
- Drop else in nvme_send_pr_command
- Fix PR_EXCLUSIVE_ACCESS_ALL_REGS use in block_pr_type_from_nvme

v4:
- Pass read_keys number of keys instead of array len
- Keep the switch use when converting between block and scsi/nvme PR
types. Drop default case so compiler spits out warning if in the future
a new value is added.
- Add helper for handling
nvme_send_ns_head_pr_command/nvme_send_ns_pr_command
- Use void * instead of u8* for passing data buffer.
- Rename status variable to rs.
- Have caller init buffer/structs instead of nvme/scsi callouts.
- Drop blk_status to err code.

v3:
- Fix patch subject formatting.
- Fix coding style.
- Rearrange patches so helpers are added with users to avoid compilation
errors.
- Move pr type conversion to array and add nvme_pr_type.
- Add Extended Data Structure control flag enum and use in code for checks.
- Move nvme pr code to new file.
- Add more info to patch subjects about why we need to add blk_status
to pr_ops.
- Use generic SCSI passthrough error handling interface.
- Fix checkpatch --strict errors. Note that I kept the existing coding
style that it complained about because it looked like it was the preferred
style for the code and I didn't want a mix and match.

v2:
- Drop BLK_STS_NEXUS rename changes. Will do separately.
- Add NVMe support.
- Fixed bug in target_core_iblock where a variable was not initialized
mentioned by Christoph.
- Fixed sd pr_ops UA handling issue found when running libiscsi PGR tests.
- Added patches to allow pr_ops to pass up a BLK_STS so we could return
a RESERVATION_CONFLICT status when a pr_ops callout fails.




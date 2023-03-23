Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7F8C7619A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 23:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/PzUFEw6uL0rl45BZYHJeGaxnrbkxA71Z+M9+lOr7zE=; b=BdbJJvzRdp+EgP3ikBHETcv2ck
	10VZ04R/vs6z4YDyQKSSiPAK7WiOoU1BUSYxUoJ0EBxoZRGJkzD1/N78Q4jcmnw20wA0wyERm3Q4a
	UZ/czLWra+WWqjrHplQY6O/AXqOIYsSf5iCklUlY8bWbJAxlt7hhFftZ9x2zJXXmLqCFHLsQ1cYfI
	6lN5GSvT87zAkZ9CBjr50f/y1fcMeAh4BXLJA7tIyOXbQnpQ4mLhGns+JR4VMcM/tiY7HukZFbrmx
	3ZGv4AVGlNgWYuqK1nDrIZ3CTrkQelfHqbUOINSElV66Kpgy8+AaaAvlHVtX0IyYp+PdALQAHYfAE
	IQWPVSQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyf-0039t1-2m;
	Thu, 23 Mar 2023 23:04:13 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyb-0039rE-18
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 23:04:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NMtBGB022123;
	Thu, 23 Mar 2023 23:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=/PzUFEw6uL0rl45BZYHJeGaxnrbkxA71Z+M9+lOr7zE=;
 b=0TepSsYOdlIG21DkTWZR6940UChX1Is4YzxGo3bI2iawxtN7B+habUIPlFV/GvUgocDW
 AuKbBEyKVuY9A5gJU2Fl45gkO/p9vqlvVNwYE/OsofLvyq6xE3Q/PDyXK4HTHzlcJwRt
 +2fmmvaNg5TcZ0kJKJwULtojP+jY8eHGqku8l/YfUF+KEUnV9VVkxHEKnkqM502/sO/Z
 2Byl6wSd0PYF2D7br8VRn2cvzYfUCzZAVtOyTlPDAzT2asmozgUm/IUwahUcqNgGMbec
 9ia80srCCX5bUDKVq+JxiyWYmg+zx5lGlc898mlpSMazBgrZnqmRw3iLIQyGPUXWAR33 Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgyyn80as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NLJIdF001300;
	Thu, 23 Mar 2023 23:03:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk3akxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NN3fh3040061;
	Thu, 23 Mar 2023 23:03:41 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk3akmn-1;
	Thu, 23 Mar 2023 23:03:41 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, p.raghav@samsung.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: [RFC v2 0/3] nvme: add passthrough error logging opt-in
Date: Thu, 23 Mar 2023 16:03:13 -0700
Message-Id: <20230323230316.2914077-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303230168
X-Proofpoint-GUID: AIg-_tusZ30nW1022ywa0BHg8cSkbKI9
X-Proofpoint-ORIG-GUID: AIg-_tusZ30nW1022ywa0BHg8cSkbKI9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_160410_227223_633E1BAE 
X-CRM114-Status: GOOD (  13.96  )
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

v2:
- Included Pankaj Raghav's patch 'nvme: ignore starting sector while error logging for passthrough requests'
  with a couple changes.
- Moved error_logging flag to nvme_ctrl structure
- The entire nvme-debugfs.c does not need to be guarded by #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS.
- Use IS_ENABLED((CONFIG_NVME_ERROR_LOGGING_DEBUG_FS)) to determine if error logging should be
  initialized.
- Various other nits.

  
Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
logging for user passthrough commands.  This commit adds the ability to opt in
to passthrough error logging via debugfs.

Currently nvme uses debugfs for nvme fault injection. A change is needed to extend
the nvme debugfs implementation to go beyond error injection.

Move Fault Injection to nvme-debugfs.c.  Add new config parameter (CONFIG_NVME_FAULT_INJECTION_DEBUG_FS)
which enables the compilation of Fault Injection functionality.  Other consumers 
of nvme-debugfs can be added without requiring Fault Injection.

Add new consumer of nvme-debugfs (CONFIG_NVME_ERROR_LOGGING_DEBUG_FS) that provides the
ability of passthrough error logging.

To enable passthrough error logging:
	echo 1 > /sys/kernel/debug/nvme0/error-logging

To disable passthrough error logging:
	echo 0 > /sys/kernel/debug/nvme0/error-logging

By default, passthrough error logging will remain disabled.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>


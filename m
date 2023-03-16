Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC06C74A5B
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zOtf7b+zJIc5xrVBd6YrTOT78j056SI1jeJkJZw6lcQ=; b=NLI40f3UVH43dKzEt94CpWQSt5
	0AXImouR5syYk50tV3CIdJt4gg0kMqJXY9Pim1MyNzKrjj/y2AomKlDq2NGjHQILASl+oJ7SDji5t
	+56Wc42ekICiHmErgPg2VVADWWQYuajsslzFNkDUn06KA/NYx2CFWEhEiEbC3bY6A4rRmBkzyAy5s
	vN3xC8PrKVQzWNTKS77ryOtDOdhJ0vh6TYACYjXsI79lji6kassj82lxyRir82fP41stvqdiQq3Ov
	DoVdF+8YSysYldvspL82J98/vvxKc8N2Me6CJnccvFHJDtRJcM3Xfi2ApEj1i/2ls/Kch4jiwdqPv
	VhoUWPIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcxMl-000MIY-2m;
	Thu, 16 Mar 2023 23:50:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcxMj-000MHU-0s
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 23:50:38 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GNNa3Q016553;
	Thu, 16 Mar 2023 23:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=zOtf7b+zJIc5xrVBd6YrTOT78j056SI1jeJkJZw6lcQ=;
 b=SKx09GeJOYfDJvKEbUALqTuDNqjN/sHTIiob+0deWV/G0H3nUobqTFap9wieLoFvFBor
 IgV7jjqdTzl/5htwO4ur8OuUR1aCnovS5V+bZjm8uKcZwi0Cv7eVnxAGMAS2iRGk7YwS
 RTopoa37zL0RnRqNilL/ylbcV+aiKqcTNSSR950TFnNlDlX+ivJ87cXUobOVnwWXKskg
 HWbgI/Kz+ebSr+yK5zyXpPgtAgI24BSYiz/alwuNbz+WrYpAkdrHOSJ1cKf94dr7f+L6
 Hl8PC/IaADntzmbTpHqWj1fgh7RUa9dhjagIWk6WI3JCmjLEgKPEjRgUdpYekhaG/5je BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29jmn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 23:50:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GLj7DO020454;
	Thu, 16 Mar 2023 23:50:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq471utr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 23:50:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32GNnxec029512;
	Thu, 16 Mar 2023 23:49:59 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pbq471ute-1;
	Thu, 16 Mar 2023 23:49:59 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC 0/2] nvme: add passthrough error logging opt-in
Date: Thu, 16 Mar 2023 16:49:56 -0700
Message-Id: <20230316234958.1486700-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160177
X-Proofpoint-ORIG-GUID: ElXjHk4v_UC0sFnwa2hYafKTLsUpWwJD
X-Proofpoint-GUID: ElXjHk4v_UC0sFnwa2hYafKTLsUpWwJD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_165037_445844_B9C4CBCA 
X-CRM114-Status: GOOD (  12.51  )
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
	echo Y > /sys/kernel/debug/nvme0/error-logging

To disable passthrough error logging:
	echo N > /sys/kernel/debug/nvme0/error-logging

By default, passthrough error logging will remain disabled.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313FCC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6OKRVSi5+QVtZWVv7MJ9cHj72Ttwc3NUJiGqq4HrypE=; b=f+Eh630HnhbFMJU8T1wzP9wwvy
	oq1PK3riJyYaf1z7s39uuOgy8sBkvEGMO7yBQsoLDz4W9lWXh7dbvlMY1yARVIMGar13gLxXwrS7c
	z81YMFnlyyeGG0PVlXgqAeFgMu19h6+1KhSJj2+dIYVU8xnew0v1fia/xdtQK0mbzIJeAd0hGGBDW
	84ITLjcNJb9qHa5vBPFfQsG6/pEVU/uILVoz56oz9+DvB9qJrs1spTOX6hYKyJrQEICym9L8HxHm7
	4h2j1aMHlUnGgvQE0h/AwOnB1ZK+UTQKpG9okbFva6Xtp2yUWuTvBAjrARpltX720axHrEQXp4k8y
	wjV/l+AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcvDf-000000062o8-37Ii;
	Tue, 28 Jan 2025 23:42:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcvDc-000000062n7-3r5U
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 23:42:10 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SNT09H007512;
	Tue, 28 Jan 2025 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=6OKRVSi5+QVtZWVv7MJ9cHj72Ttwc
	3NUJiGqq4HrypE=; b=oa5pgAXMX069JLqDO//afhLVz1LuUMtjbfM00IKlc9wLk
	CS/rd64zhZIfXIPxYrKGfPRw0O98d0alvQrySC+sVU+zTq8v0EmRw7NFnETn7pud
	qR9gptMmIP4l83Idz8+bUN+Hd0Mw2eUWB+35Afv8Wb3XDsBYQ9rjHkDRImL7zsfr
	Lqt4HjvqCAiGzJZEon9kAsH8qX6jOIWPAjJ5UhRpI+RmsO6qxi6jsVPA7MTi03oP
	IM3PSVyWqS1HZlIh9p9Cb8UKZsy3qw9EM6jlA1DytchujXnt5gAjJxLkHLHv6kaJ
	YyNHXmYBZYlnLXvEhHyXkHpLxKh8iYXNxcO1CGnug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f8xu80c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLwMYc035935;
	Tue, 28 Jan 2025 23:42:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdf2mws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50SNg3Ws019555;
	Tue, 28 Jan 2025 23:42:03 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44cpdf2mvx-1;
	Tue, 28 Jan 2025 23:42:03 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v2 blktests 0/2] Add atomic write tests for scsi and nvme
Date: Tue, 28 Jan 2025 15:50:32 -0800
Message-ID: <20250128235034.307987-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280172
X-Proofpoint-ORIG-GUID: NdP3q6EmR7iSka9k6gMXWK42TurPBVVn
X-Proofpoint-GUID: NdP3q6EmR7iSka9k6gMXWK42TurPBVVn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_154209_082720_F2E8816A 
X-CRM114-Status: UNSURE (   8.02  )
X-CRM114-Notice: Please train this message.
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

Changes in v2:
- Add additional comments in common/xfs
- Remove xfs_io and kernel version checking
- Simplify paths for sysfs attributes
- Fix failed case output (missing echo) in scsi/009
- Add local variable that sets Test # and description (test_desc) for scsi/009 and nvme/059
- Only use scsi_debug device if no scsi test device is provided.
- nvme testing done with qemu-nvme.
- scsi testing done with scsi_debug and qemu-scsi (no atomic write support).  No testing on
  atomic write capable scsi devices was done.
-------------------------------------------------------------------------------------------
Add tests for atomic write support.

Tests will be delivered for scsi (using scsi_debug) and nvme.  NVMe can use the qemu-nvme
emulated device that supports Controller-based Atomic Parameters (QEMU 9.2).

The xfs_io utility delivered with the xfsprogs-devel package (version 6.12) is required by
these tests.

The Linux Kernel 6.11 (and greater) supports Atomic Writes and is required by these tests.


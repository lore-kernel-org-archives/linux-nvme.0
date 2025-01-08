Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0357E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 14:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UhkOifTAy4cWa7RdpAT29vNzHfWalx9Qq1yDHwu1mjc=; b=ll3p2C0ow20APwAgedILCODXxc
	10R5gzSNY2pK+8HcTphBM2Amu/Kw1Vs3MpH9yP64Xc+ZqlOvU+u8ACyJjH1f8y/gEAdTEHaSO53EU
	Y8clI0qdlrh0sdlUcZ/Ft97VMc8SsM92LlfBvdpVho168KZCnyrULLAJ6LdOMf69muoTJhd0HUbAu
	AKe5qM1kY6qVY5IjucUoBJkxvwGx8xiwyvkkC6ZM4GRS7mah8jjM40vwyigxxPIWJgqEiSLxht9W5
	rivYGjLlZGkiVOd1epHm4asMszTo/xz/jpJJfwFG+Hf4MW2fAbiA+8hlbIafz8gSUZiYzMSGcFJZZ
	pT7ulrhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXBi-00000008ohq-2e4T;
	Wed, 08 Jan 2025 14:37:38 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVX5N-00000008nNh-1MID
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 14:31:08 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Dhl6q023578
	for <linux-nvme@lists.infradead.org>; Wed, 8 Jan 2025 09:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=UhkOifTAy4cWa7RdpAT29vN
	zHfWalx9Qq1yDHwu1mjc=; b=c2Nu3UIQ57gw7qLrd5LvorJD44lX9azFmyfNFPU
	KcQTNL3kFxahGAFuOTtmc1hts9rcQwxa8ENT8g5dV7NFAn5YPg+UN5qOLcmdfYP6
	NWiC5NxSyOFWHX31jpnDf5jyne+SCRa57EVNaaTMsKFsmlZ3+hoQOVIPfZwc5WfW
	yXAtj3IC4JU0/e3WBNtqwdBku1pYaX55EpdZzCvZsCqAcXHhdMiScO1O8RCpudi0
	cagZqaeQT7aKtlHuMv/eHCukwUq/tXT8wAbvrK4tp6/OEFe8nIHY9cPoltGOH5Iu
	bOoDPueEJzzWS+oZLmFPL9bqVgLepibx4Cs9O0PDmpaHY7w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 441tgkr7jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 09:30:51 -0500 (EST)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EACer025286
	for <linux-nvme@lists.infradead.org>; Wed, 8 Jan 2025 09:30:50 -0500
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com [143.166.203.150])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 441n68vs0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 09:30:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1736346649; x=1767882649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UhkOifTAy4cWa7RdpAT29vNzHfWalx9Qq1yDHwu1mjc=;
  b=EZGYMJK1l1XMNx6ZRlJ3fLL/BaWRrLcQpFz4s/aQgXgUoKEdm3Mat+c/
   85Hx9ZWEIRSpfYqCYmcNjkW7U+GqSvc1dLa619vcxqDsnacvlzVFyGCgI
   YYXXwKq4E9D5GWHJMPu9nDH7A/NeJJp7CsfKc/l0W5tcrvS3hhCyAzHKZ
   B5OhdFuYSm0ejdv6ruUE+1P9baVs5k6mUXsnKy/71gMFwQsTG2fAZm7CI
   MykMYjjbEOLntM3U7/MV6RfWSiVinfaAjIB1iXEcZ5mylCW6LBEkMBnpH
   KlPSU3LKcDooStdwvUXQa7iD1oPLRxBBl52gy8NYGecyP250U+AZIpnpX
   w==;
X-CSE-ConnectionGUID: jBcg0yQtR6KVFfYynqI6aA==
X-CSE-MsgGUID: atU80LB2TpmkjMC0HKADzQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net) ([10.215.64.31])
  by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:30:48 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 8 Jan 2025 08:31:36 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 8 Jan 2025 08:30:46 -0600
Received: from mdziegieubu1.cec.lab.emc.com (10.227.238.157) by
 smtprelay.delllabs.net (100.64.0.134) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 8 Jan 2025 08:30:46 -0600
From: Marcin Dziegielewski <marcin.dziegielewski@dell.com>
To: <linux-nvme@lists.infradead.org>
CC: <amit.engel@dell.com>, <pawel.baldysiak@dell.com>
Subject: nvme-rdma: possible issue around error injection debugfs entries
Date: Wed, 8 Jan 2025 09:30:45 -0500
Message-ID: <20250108143045.1872447-1-marcin.dziegielewski@dell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1011
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=767 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080121
X-Proofpoint-ORIG-GUID: vpx_Di2ps6f8aKhYrbwYFCtryl9qPuDt
X-Proofpoint-GUID: vpx_Di2ps6f8aKhYrbwYFCtryl9qPuDt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=778 priorityscore=1501 clxscore=1011
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_063105_375541_3EEE133C 
X-CRM114-Status: GOOD (  11.45  )
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

Hi Experts,

During testing one of the corner cases of our NVMe RDMA use case, we discovered
that in the event of many failed connection attempts, the inode_cache and dentry
slab can grow to a huge size (and is not reclaimable). Consequently, if we wait
long enough, we can reach an OOM (Out of Memory) condition.

Example from crash:
ffff88dd2abfca80      592   29007830  29007936  537184    32k  inode_cache

During debugging, we noticed that in the case of RDMA connections, these debugfs
entries created in nvme_fault_inject_init are created before a successful RDMA
connection. So, with many failures, these entries are created and removed
repeatedly. This behavior likely causes some troubles for slab/debugfs.

So far, we have worked around this issue by moving the point of creating these
entries to after a successful connection, and this has fixed the issue.

We are wondering if a patch with the same or a similar approach can be applied
on upstream, or another approach (for example: raising the issue with debugfs
maintainers) should be chosen here.

Thanks,
Marcin



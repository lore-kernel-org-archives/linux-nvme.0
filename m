Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E286ECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pno+6RJS/zimmaNlcNpeXxEfJdjrkdY/Ud7Sg1IvRlc=; b=BGR69N9iVJB980HEpPFX0zX3eh
	oLbFrapCVZBssRkdk9+qlxzRMOJr92WT9VSQCHG1V82hDGqOz3zIAw6T6Naq5BJAi2S7tFmY4nqrg
	QyKEbBgM4lRLWK80SvyMJwjTm0uxMQNrJNaOTrgACY48VBIbO5qGXLMnl6Ux/H8pfFqCZfQmIPGx8
	i9DqVN5z9SiIb+I3ztuGMOKPXm5VK0uc+aMZHIeNPFj8fgENre+MXhO4RolSGrTyJcK0GnVYJaJB/
	nI43vrjLnXV0DRjbVPEcJ5SV/HyN2E6BpgPOQ2jTz2J/1AiMWbjXj6+uMlh71mnhGsg661dNp00WL
	vMyw5y1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbNo-00FNts-LG; Tue, 06 Sep 2022 16:25:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVb7C-00FCiz-Df
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:07:57 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F3eE5019064
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 09:07:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=pno+6RJS/zimmaNlcNpeXxEfJdjrkdY/Ud7Sg1IvRlc=;
 b=NiC7+QRLVIDcDkvXlQSWFruNeVbapzxKMgWCU/+dn11eK5xItfVuMCLSSH6xgcKIzu6M
 qltDekTDL3zgL4Nyb1rJy71EiGCLfGggshSmM+RhTmryphHrTYvJGPY4JMdbtvLXZM78
 rWZIRmKIcFpNEl+VB9Ay/b/rfCNkA/tUBxo= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jc4eyqe84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 09:07:53 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:52 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:51 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D6A81847D5B7; Tue,  6 Sep 2022 09:07:42 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] 
Date: Tue, 6 Sep 2022 09:07:34 -0700
Message-ID: <20220906160738.2289621-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PsBJP-m6DOm4VlhCKBM94R-Ue0CwEoX3
X-Proofpoint-ORIG-GUID: PsBJP-m6DOm4VlhCKBM94R-Ue0CwEoX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_090755_276988_A6DA75E1 
X-CRM114-Status: GOOD (  11.35  )
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

From: Keith Busch <kbusch@kernel.org>

The series adjusts the struct nvme_iod fields for optimal sizing.

Changes from v3: rebased to upstream nvme driver with sgtable changes;
this makes the previous series' patch 4/5 unnecessary, so it was
dropped.

Keith Busch (4):
  nvme-pci: remove nvme_queue from nvme_iod
  nvme-pci: iod's 'aborted' is a bool
  nvme-pci: iod npages fits in s8
  nvme-pci: move iod dma_len fill gaps

 drivers/nvme/host/pci.c | 64 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

--=20
2.30.2



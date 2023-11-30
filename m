Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E274CC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=11exKg3ZnsRTT5ybj72lSgW6CmpKbELb2RISVcksvgs=; b=4C9DTJlLK3bPwrMFPs5PCu+W7J
	wdnXnpVsBLM8QeST/e/UzQExPk4EiAMLty3kTSnj+uTwkHnpKvzNg7dikkgIKL5z1q3uK3lZjaiPn
	OVLEr/FyImgXoPcPnNsT1zb6Ayf3/a5bHPfmUGGOpkm8vIxWJ/l+xmUyhSIF6KfeyTqOR/CbH39bJ
	N+MEG/SG1IzGXw3VG/F4OxFBOej9LhT+SY8Goo1ycK6i3VQZ8wZCMFzym9GuK2aRPAdHagXoQR0J7
	KRz6qr2dHHOUi8BU/NxdbRtL52j8wFJ+Pv1iQ0QrjYu47nBmsbX7DnJzQzWev7lc0HBSoHYDlrKpa
	2vQPBmAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8oyL-00BzRZ-1p;
	Thu, 30 Nov 2023 21:53:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8oyJ-00BzQM-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 21:53:24 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AULJ2C6014893
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 13:53:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=11exKg3ZnsRTT5ybj72lSgW6CmpKbELb2RISVcksvgs=;
 b=FxVFm3E7BkmGUUwVm9sfd1CnEnnZx5VfaHjbcQxmNcd/9jakFluJ54lk6eIumwckSCeW
 xy7K9WwMHr+jwdCAdqXjNsS1N1kqXbs20dGqHjdmZ8ei223YCsBIrp1nEQR0ZvcSxLH8
 am2p73xMgPyt9JgE5rlDVelBHyLmRRWAdK7ujoyQIzJmXZr1Q0jO94Atpeq1/ccvEMoE
 WVXU0YZb96YblLCGTmHCOKj79vpfmO92woaQ8UfCZOIaeIZGZ+Qw756+Gz3hOTdk6P6q
 MgPPzK5nQq80uGO6p75YJfrbagJkUY4N1LUbj15f+Z3VAQ6b0p/e9z1iEU+YgQtq/aKw 6A== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upeus7w67-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 13:53:22 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 13:53:21 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 2C089226BF681; Thu, 30 Nov 2023 13:53:10 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 0/4] block integrity: directly map user space addresses
Date: Thu, 30 Nov 2023 13:53:05 -0800
Message-ID: <20231130215309.2923568-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: opYuzTHjzp9aJdvyoxQ3finWtbqP1w6A
X-Proofpoint-ORIG-GUID: opYuzTHjzp9aJdvyoxQ3finWtbqP1w6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_22,2023-11-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_135323_810380_9A720CC1 
X-CRM114-Status: GOOD (  11.48  )
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

Handling passthrough metadata ("integrity") today introduces overhead
and complications that we can avoid if we just map user space addresses
directly. This patch series implements that, falling back to a kernel
bounce buffer if necessary.

v4->v5:

  Unpin user pages after setup for write commands (Kanchan)

  Added reviews to the unchanged patches (Christoph, Martin)

Keith Busch (4):
  block: bio-integrity: directly map user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c     | 214 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 197 ++++++-----------------------------
 include/linux/bio.h       |   9 ++
 include/linux/io_uring.h  |   9 +-
 io_uring/uring_cmd.c      |   1 -
 5 files changed, 254 insertions(+), 176 deletions(-)

--=20
2.34.1



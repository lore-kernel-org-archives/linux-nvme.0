Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E0CC00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mnVn/VaTVrvfisk5tGCfqBRVKkQE5IusMv7TNlRTP+A=; b=yJdYlb5OJ6cTpjItnDqGK5N58w
	RQqmN5Gv0G+JV9jNkOWoMY+vVVU30Ig6uaYkNJnsnAUvrKpJPP3lKd4WSakHtFr0rPffjzIArQ4rj
	CyvtPEMCIGf4vxgVeoZwBXJSmRV8WYLmWvcCC3glq0yeMW9B8u5I4g6Sandrr4sVbrNTwC09r3Sjv
	c8a8DNg2hGFhyLgdAmNkzKffRnLQtxc7FZ/vu1g6VwjLgcWZhDJtfLwbrHGXiZ9Sed8s3HxMSgj9a
	xHhttRsKCtqrPizzz9wnmzP3S1pFFem0TvlQKRVFPEz9KZSu4p1fkE40cjNdUcMfo0PB5R0GLptYP
	VZNNQtSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrn-006Nu1-2N; Fri, 29 Jul 2022 16:29:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrP-006NZ8-Ip
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:13 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T8ZBW8008789
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mnVn/VaTVrvfisk5tGCfqBRVKkQE5IusMv7TNlRTP+A=;
 b=KGfaLUi7RgEoiwTqUILviYxHXzss0QZjhOnB7Vj5Dqk3odori9SgTM79tImL8mB3Ff1g
 dLG0EcLcpxHa8RSAEU1awoCWKas/75XqcxW3HVCM2lSnTnrdntjiR35LI1hpUjKB6rcY
 PixWuzl9nA6Wp5CbHshzNGNLnGe3OI11m1s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmc55ak8u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:06 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:04 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 91BEB6BA33D5; Fri, 29 Jul 2022 09:28:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] nvme-pci: iod optimisations
Date: Fri, 29 Jul 2022 09:28:46 -0700
Message-ID: <20220729162851.1574210-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2Xb01Y_y99eKYKhbVmqbWShJAV_2zTVg
X-Proofpoint-GUID: 2Xb01Y_y99eKYKhbVmqbWShJAV_2zTVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092911_665769_E6859AF0 
X-CRM114-Status: GOOD (  10.46  )
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

The series adjusts the struct nvme_iod fields for optimal sizing. The
end result on 64-bit arch removes 24 bytes, from 152 down to 128. We
typically allocate many thousands of these, and the cache aligned size
is a nice bonus.

Keith Busch (5):
  nvme-pci: remove nvme_queue from nvme_iod
  nvme-pci: iod's 'aborted' is a bool
  nvme-pci: iod npages fits in s8
  nvme-pci: iod nents fits in u8
  nvme-pci: move iod dma_len fill gaps

 drivers/nvme/host/pci.c | 67 +++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

--=20
2.30.2



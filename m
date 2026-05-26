Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5517ACD5BB1
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P/avqlvhJhFA5rGWItvqIGoBfVYSFdFc2WtS7pAl5Eg=; b=utH0LD9RrNo+7Ta2OYdZJBLoEN
	YuAXuR005VNMiI7fnunAvAnEDvcR+dPSJJQByRUKj5t1LeL8XkzJE9u1ddd0ET3h/8dv+8UezTBAm
	VFfvAqKCQmq/ZMWFSlmJDfNBhu5pV+eyoFos5+MCplcOoz3vL+59uGsp8qH//X+dd/8veRbGWMOmc
	0OyoWAcYokoWvN+o6vubTrBObGhnwJauHpWAecayb5KZeEwBE+SkNHO3c0v3Pc3CbODZRE6/av4ZC
	O+9USglDnJ0LIBYyApP68xWHFjzgJrY8QKX02xdT/xgtLQeMdpH7BJ/n52z7qjRKATTZJ9nIPsQbU
	ZcGyJ2XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsU-00000002Oty-00nj;
	Tue, 26 May 2026 15:39:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsR-00000002OtI-24q6
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 15:39:33 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLZQsK1983916
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=P/avqlvhJhFA5rGWIt
	vqIGoBfVYSFdFc2WtS7pAl5Eg=; b=czSKC/v4t2w7CY7warP0SdQ7KSXzhJjqUK
	b0LMMeFyMo+ZrZhhQ5m5KnJLzpym9e1XYtBWJMS3Yvg6I1Boz5v+pTa7ySlArkDS
	dSZZYG76hMBDxm4Ppbk8fYCIt/m6CyK/3B0OlUanW4vjQmZpyhhQEgrZsshnJ0/X
	NWKpLYC8Jt6UW1XxjWqtAJB1oxbIYSYx6YnjvZn3jYJVh2mrWoiBC9jaPYvVJI6q
	2vU65oAsEV4wtMiI9F8Peorz6WeCtz/Sm1wkXFrRDuLu3pn850b6FFdW4Ds+17IJ
	4WT0ptdPZlEl98XmOJ0aIS1KT3XudC8QwuqeUBqqc+VQMlIJNV1Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebmw6vvrn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:29 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4313A1CA8D4B3; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 0/2] block, nvme: enable passthrough iostats
Date: Tue, 26 May 2026 08:39:19 -0700
Message-ID: <20260526153921.2402015-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SCqTyoIRx7az0SOdeFP9UM_US-V-J1Lw
X-Authority-Analysis: v=2.4 cv=X5xi7mTe c=1 sm=1 tr=0 ts=6a15beb1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=M_XrtetGi9rww7Nx39AA:9
X-Proofpoint-GUID: SCqTyoIRx7az0SOdeFP9UM_US-V-J1Lw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX/dbH0LzzQwUB
 SncpJtplmMK0iAj4657Xe04p/y/TkCdpVO8g12k+mzzm4lHmYYZgHtjgv6+km4xwJjTMhcLsO2v
 fJqPpnqz18sByT1iau8gkJ/mnoNbGane2AoiESj1NRbpHQbi0bvdcZyd0JzCNqloimidnrGc6E9
 cEyeqpkUmtkkIm7aCoc/gMiiZOuwd0o/IIpQf4X2t0ZdT2Yu30F67KwwIPQvQkviIB7J8ql9icB
 OjQvuZO2dhlmE0q8CqN+L5Y8u9LBjaU+nUzrpYSiY35ss/O3llEPpkBd5THN1BNxJs8GmUScKBi
 k/ujbwFAeTYf/PFSVz+oC4HydHXdPq/s4Ijpz3yNaK0XZEcwYf52w2Y/ATt0G1SGIfRgDeuKlbx
 iGxXDh1jVK+1xavYBrmMZ+FQHPL5WkXBwMGvxcgARhnjV6OBYLQgwmO3QO/rGxIikQSmVig7crv
 K49xdqDMptlnZz8YF9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_083931_675907_7EC75C2A 
X-CRM114-Status: UNSURE (   9.14  )
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

From: Keith Busch <kbusch@kernel.org>

v1->v2:

  Split the block and nvme parts into separate patches.

  Fixed up the nvme driver to ensure passthrough commands go through the
  multipath start/end functions.

  Have the helper function take a request_queue parameter since the
  queue accumulating the stats for multipath isn't the same as the
  request's queue.=20

Keith Busch (2):
  block: export passthrough stats enabled
  nvme: add support multipath passthrough iostats

 block/blk-mq.c                | 32 +-------------------------------
 drivers/nvme/host/ioctl.c     |  4 ++++
 drivers/nvme/host/multipath.c |  5 ++++-
 include/linux/blk-mq.h        | 30 ++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 32 deletions(-)

--=20
2.53.0-Meta



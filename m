Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75186C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I9KMgXDSa+o6Z19obGaZP5mWQ/PKM2XWhqeAlSDq9BY=; b=VJrdZTh4UmPkpgMYqGeZQx0oQk
	uiitRgPhiziwu8JyQa6hM2g0w42f+Lma77lr5WNlHKQu4wkoL/7lW/k8Dmw1CXvz9bgQ2Jt6wBfAG
	YsjP60JMomYPp5aExEXPlnxK4dP8LEIIwZj5ahn+vvN385vYNo5tTwZThL0gyx074GOvXPrEoD4Oy
	9c13ZzeqfCZEXVTs6ApLxk7GCSKI69FJTUuxZlgVDe6u6be4FBJnGYTfBaubeTpEBmBH5adE/PxiD
	MyhQCxBzHlnZu38n+BSNj9IO91n2w87aMzddV8DT1X2f9YRXeUZ3zSMhWttxffzulC3QcGSuGOdIi
	wDdxgkwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0lf-0000000DHXy-48w1;
	Wed, 17 Jul 2024 09:16:11 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0lb-0000000DHXW-3zr2
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I9KMg
	XDSa+o6Z19obGaZP5mWQ/PKM2XWhqeAlSDq9BY=; b=C3a28ldbbEu5ISH0YNPcs
	Z3aYA4Y0bhcFZSow9pqSuDPyjEFRn/FjR1PLFj5SGRZlZWPVha6fQv70kkLDvS6R
	E7Nlmw0vqhZObBt4FyfXCVAiLgjR28+twVKK5gjIE7Nn4+XgehF7jqtCjhQbEf3I
	0V5ARDMdRy2XDeM/IjUNSA=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Py3Ki5dmGNFmDQ--.41698S2;
	Wed, 17 Jul 2024 17:15:55 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
Date: Wed, 17 Jul 2024 17:14:49 +0800
Message-Id: <20240717091451.111158-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Py3Ki5dmGNFmDQ--.41698S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCry8tw47Zw48Xw18Krg_yoWfWrb_C3
	93urykG3WxuF4UtFZ2gF1FyryfKFs8X34kta18tF1DKryrZr1UCrsYkr95u348ZF48Aw1D
	XwnxAw1Ik3sIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi1xR7UUUUU==
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKA0fKWXAmTj8kQAAs6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021608_337628_1958ED77 
X-CRM114-Status: UNSURE (   8.08  )
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

When running nvmf on SMP platform, current nvme target's RDMA and
TCP use bounded workqueue to handle IO, but when there is other high
workload on the system(eg: kubernetes), the competition between the 
bounded kworker and other workload is very radical. To decrease the
resource race of OS among them, this patchset will enable unbounded
workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
get some performance improvement. And this patchset bases on previous
discussion from below session.

https://lore.kernel.org/lkml/20240717005318.109027-1-jacky_gam_2001@163.com/


Ping Gan (2):
  nvmet-tcp: add unbound_wq support for nvmet-tcp
  nvmet-rdma:  add unbound_wq support for nvmet-rdma

 drivers/nvme/target/rdma.c | 10 +++++++++-
 drivers/nvme/target/tcp.c  | 12 ++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.26.2



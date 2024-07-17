Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2DAC3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WISCAYm5x4Ne2pkT2yciOq9HDZYc5vds8WQqUH95bt0=; b=WKwM8YZ0JrSMJSdODPIhNbLM7C
	z7goWlYCvVTKVdvcCq0YTWYtq2s4T12mPxc/FfveWJz+47whBebLI2VHB59AyKJnM6VUMWJWa/45x
	xqvD1AMl/9UMbibWjM6QgjxROiA3NUsahfy4mGMPXSKWtGZcTLaHhyPXUhgIt6WbAp/co+S2Ygwld
	Ki5HfiVEYd760UpZcrwt2EYhtjKEEYtNSxWna5oCddfwD7Fgg0/+pI1dF90WLik9X08dld9Z1lOiw
	paxSFrevnvi3WT04U7niab22PHX4oq3aFD8pJh5poyGSxKR/7V/qz8cx4wXplx3UuCMGAc69XNHIO
	fv0XpdNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTY-0000000D2QV-0GQo;
	Wed, 17 Jul 2024 07:53:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTX-0000000D2QF-006E
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 07:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WISCAYm5x4Ne2pkT2yciOq9HDZYc5vds8WQqUH95bt0=; b=N+F00Db8e6aeb3ml5znbupSNN0
	c+uFu4hlee5xL6XE9TkZwElxer9W65hH+kZEk10MpG4DU6bzGqtHUUFSZvdoZZs6q6IEaknJYKfkA
	jYldnhb057X5rAPaM+egUirUjiHaIzCxEzwIGMC0i9Bq63jExT64zLtLRN9oTqQFBHzRll6ZsTnNi
	hgUjTNBPKxYtsqAqkq46M2VWTEe5qrQcIQcMXIpMZe6PLIny5PmXbchebQjdCWwATN8P1FJxrw50L
	YecZokmq455PYLL9ZQmObS1j4w5gFL3Kmio7PqDHQhc3FO8PsPf0lGFFLhQmkRioJKyH4pXhiRiKX
	DlDidmig==;
Received: from m15.mail.163.com ([45.254.50.220])
	by desiato.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTT-00000002GGB-041T
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 07:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WISCA
	Ym5x4Ne2pkT2yciOq9HDZYc5vds8WQqUH95bt0=; b=E00qJGiR9bTqb7ouWngPC
	5yOGXdj0quIZJZIzrS/L+VDkoik29RIiWy+uZS+PFdGERH0r0tSXIBwBvX2MSw4x
	kkTrJKe5nVdd3KpFEVh5NajCkrYwgTAVA7e7zuDXsIaHtkYBLL5TexL20aDIwPus
	Kxg/5nDoAD8/zAead8nJWc=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S2;
	Wed, 17 Jul 2024 15:53:02 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support unbound_wq for RDMA and TCP
Date: Wed, 17 Jul 2024 15:52:06 +0800
Message-Id: <20240717075208.87324-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f3ddeJdmTsbxAA--.36565S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCry8tw47Zw48Xw18Krg_yoWfXwc_C3
	93urykG3WxuF4UtFZ2gF1FyryfKFs8X34kta18tF1DKryrZr1UCrsYkr95u348ZF48Aw1D
	XwnxAw1Ik3sIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi1xR7UUUUU==
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwABsk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_085319_742649_8E914E1F 
X-CRM114-Status: UNSURE (   7.54  )
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

hen running nvmf on SMP platform, current nvme target's RDMA and
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



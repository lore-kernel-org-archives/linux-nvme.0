Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B640C44500
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3BIK0ahr192iMfA9FxQ6YwSKOIfPli0O0VqeQVyl8eM=; b=wQZwZZwVIJzr9B3tRDvS+F80Oq
	qxVS+zJDkwIiryA9UBs/Ilrn4KWnmFMdYbHdQh5iAXfQLu8dX9w/fp0IFg243L11mStDltajrR1jg
	o7nV21weXbeJBMo24TD1LDITpSqs1EBo3oL+E1SYhPETNOPqW9Te3+vk1knRpA2Z9skJmYJlpXEEN
	S5Ve8cktMm9bDg38IGetUdAHsS+3iRGuK/jak+CUrpHwMUonk4SbSbrtG0W96tUOSZP2Yl4Zqrq0I
	eXPHq5hGzx4348CObBsjCPGw2AsOk5xlfYURD1EE5LdtF8UIGa4OIcti773iOK72DNHVw+U8I9APM
	aO/QxyQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE9B-000000046Ly-0grl;
	Thu, 02 Jul 2026 09:55:53 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfE97-000000046Kh-2kQs
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 09:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782986147; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3BIK0ahr192iMfA9FxQ6YwSKOIfPli0O0VqeQVyl8eM=;
	b=FM4R+CbEnna67BI+ctAJbLmT7GLWLS+OGbZZZOpKVQDQLrfvHWZ6LU7H2wHyEPfmnyW0Ebn7fF0hgEiy7l7g9W4PD+LDtYzIa5A6oqVNCO6Ir7+R0UvLPfiFMmrqM6hOPObfcJUzy0mOYhjKISIWD+yIBUXPJI/f9inlH39pQkI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6Dzy7o_1782986145;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6Dzy7o_1782986145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 17:55:46 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2 0/3] nvme: add ABI documentation for sysfs and configfs interfaces
Date: Thu,  2 Jul 2026 17:55:38 +0800
Message-ID: <20260702095541.1145128-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_025550_015148_89F64918 
X-CRM114-Status: UNSURE (   9.07  )
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

This series adds ABI documentation for the NVMe host sysfs interfaces
and the NVMe target configfs interfaces, and updates MAINTAINERS to
route patches touching these files to the NVMe list.

Each documented entry has been traced to its original introducing
commit to provide accurate Date, KernelVersion, and Contact fields.

v1->v2:
 - sysfs: group all TLS attributes together and reorganize the file by
   device class (controller, namespace, subsystem), keeping related
   attributes grouped within each class; split the combined
   passthru_err_log_enabled entry into controller and namespace entries.
 - configfs: group attributes by object type (ports, subsystems,
   hosts), merge dhchap_dhgroup into the DH-HMAC-CHAP host
   authentication entry, and split the combined ANA and PI-enable
   entries into separate port and subsystem entries.

Guixin Liu (3):
  nvme: add ABI documentation for host sysfs interfaces
  nvmet: add ABI documentation for target configfs interfaces
  MAINTAINERS: add missing NVMe documentation files

 Documentation/ABI/testing/configfs-nvmet | 352 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-nvme     | 450 ++++++++++++++++++++++-
 MAINTAINERS                              |   4 +
 3 files changed, 796 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-nvmet

-- 
2.43.7



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231CC5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rnzdMRi0C+5Y9siAeTodJDt7LI8OnhWnGKbTD2qlu0o=; b=nI3bmrvNhrrF4Dty60HJEO9TT7
	bfyPHWoCWuFgL68s0ervAhEyk3YIwIbLhSV7pQC4sk75R+ObS2DGNYzLhek3P7SAl2+LtiHon5L66
	T3qGda3oUfAZryYhome5IhxKcfNLlzNkuencUiylwPhqiYbiVCae/rdzrOwNNukpWpYvPJnDCl4sj
	pjFgqWKskBsP42lISY3QPRxoa1c7N+zJI6NaQVsSyLRreDRkWqHZsbUC4whTA1Nv7Jq09e0USwf9G
	+Ebzoj/8famIMiA5y1MD1npfVakhE7tvCFhEACNH4eMj/R8PfWk7JPhCkF7Lum3PzHlC+HyA0VvPJ
	ixTxmGYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEJ-00000004PCq-2opP;
	Tue, 27 Feb 2024 08:54:27 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEE-00000004P9v-34Su
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 08:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709024056; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rnzdMRi0C+5Y9siAeTodJDt7LI8OnhWnGKbTD2qlu0o=;
	b=TjI/8pSc+Rjy+zG3JYa+nDWloKCLgC8LHf81E+HQF/W0dIXp0vRBGTeaC1y2Dn0lVQyz8XfrK52qqtiaCLH4XM/KW7A5oBGd0Or/jMBkmpiH+1RphgQH2ZTe1Q5B7gk61lycJVJEWF+iXKs5KYqz3MnHfmwiU5zN+L9Ke/VpmZo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1MCVI2_1709024048;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1MCVI2_1709024048)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:54:15 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvmet: add some commands tracing
Date: Tue, 27 Feb 2024 16:54:05 +0800
Message-ID: <20240227085408.130161-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_005423_305846_348C22BD 
X-CRM114-Status: UNSURE (   6.89  )
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

Hi all,
	This series of patches adds tracing support for ZNS commands and
authentication commands to the NVMe target module, as well as updates the
tracing of DSM commands to be more readable.

Guixin Liu (3):
  nvmet: parse dsm command's attr deallocate when tracing
  nvmet: add tracing of zns commands
  nvmet: add tracing of authentication commands

 drivers/nvme/target/trace.c | 72 +++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

-- 
2.43.0



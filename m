Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE71C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:38:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9504D64EC4
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9504D64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iJWZ2LHaHMd0rgtAM5BaDX7W9GiRDeloU53SgkfkcfE=; b=YMuGdIYZpHmngzX8f7fcVuLffE
	nKixce4gFaztZzCtjLTuExfej8R9AkzAX5MwGy4Uc5I5znYi0H7KQWgkGLMBbRm3gTeQdFiQ4cBlV
	GJyni7AuiWP71ef6j+QrEFqcEelnAVI1TWm+1OgezAmkS3lqexQp1cp1Hv9vdZ4BK/Ia0T4K0Xkec
	uLSZZHuZXUPtzUY1G1LDwuJeH/iDEKfBsnL5lYQTN7kuHVXfhrmdxr+Jatm2kZ1SZg0vncaZGwkTX
	Lv3aPEGtw/xZuY55g47Q5gDdgGYZDY5BpA4onrFv5O+HQUM2EOYxixLDPhkjNUKqbNPSmMKqUf4v9
	BdN0B4MQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCzPm-0000yB-Ot; Fri, 19 Feb 2021 06:37:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCzPk-0000x2-2Y
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 06:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613716764; x=1645252764;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zQbchDM9gnAA0ttH5pWaJAoYa6vKIkvphKwepMpmA+o=;
 b=jKcFjLStLs041vKCGpy/GgL+I+tJMk8VgRR910IXBKhF6r+9qJzFpJ01
 zqheXjQpH82tMFEC0HpAO3TsPm6AZo2uMzbUw/fxebNiVoaW8sK4ZcCAg
 y6k2dRQDJRqPZF/Jip5xzo4/N51OEp1B7jHbgJWVb0/mR0JUhaI0rv5L7
 zcKjDi6vX+HpMQ5u9BCkxVF9KnCVdw05yi2WNDDWW0HG4HrwhVb5jPZan
 WCmkwgXNaUxkA2is+4/hI77rIAaig9YOeVEVbtAUb+KBZwH+gi5DUhpD/
 ODFOtz9gk4aAZRJvVmTVWbnSsGZq0o1BehLonvAxtSrre5ooJ1AMP3MRB g==;
IronPort-SDR: Dd0yaHddBKCQhPkcnmxlcI/gJH4krQm1gzGsakQT1Fa/Pa1LAZdk4Uu5ky9XgPYf/5NBVA9z+P
 kVv4+H2Hy73nvHYdDsQ9sJclJZbdKWeuXk/mQJO7bmET4jdTYQShL6AxUUCgYIClzw0yPS8ZGp
 52NYVS4i34uwfvc581sMt31qNLHr6oSCEkW0+hnetsa9B1zSDI4UB1icvoWXULgFxwS0skZdDV
 GbTMtW+K6PUgjqeAVD8relo34IQGK5zIHudgK7nXmC2GCqBr1m6bEuXKy0y16EjnPssl/V8g74
 nE4=
X-IronPort-AV: E=Sophos;i="5.81,189,1610380800"; d="scan'208";a="264514754"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2021 14:39:18 +0800
IronPort-SDR: zre6JK+kJzQG3JabW0Wa3j4l/M3inlYMEBdjHpXCM8Kv91XD6lC3ClG1Zim4mNFUPLZY6SW5oV
 QkmR2apYp1FQcFQMgGl9hG8Sgt8jFul2cy3vepx4nLi0N1e1ldAdxEbBrO6TWhFN2HRwGsqs3u
 2fyOIxtdg0Rg66mEwICZruk99hUT48Z8DuWWhY72IyLzo2A55BEkeW9ZyavowS50MvDoMFF2l/
 EVowf6GdL5vxOHq6HSFqyuO0oDoLFCPYKDDCMs5IGaX+x/AZYuXx0bO0AC4DN7gVhZjBnc1BAn
 lNLEi04HmtpRbMiXiAKllUIP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 22:18:55 -0800
IronPort-SDR: q8CVtakusesP+FYqRcdFwppgZH8+G3+RPr1r3DCF7+YjD1apQmraj6p/TDUIHWJnr6oiZeZjhP
 B/4Cjoi+LknxyZ8beMiB7cbwS3p5NnSooOJDPOAkcgCSZPcZZp+gHggXNXa62aKMz0gJyNnFXI
 eX5Jf7lcJUugRFRmP4oPe6dA4lM7hgKalZ34xfihJqarCkW8RnMcQ3U1RthHB3qmJhJ+AzXV3n
 7XS+/1fbsPaG0FEhGtSTWtImG9hneqcN9cKx6ccdMM9bmsgFzbUFuaHR37CAm5lPv0KIkZpDjl
 uqM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2021 22:37:16 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-pci: remove the barriers in nvme_irq()
Date: Thu, 18 Feb 2021 22:37:15 -0800
Message-Id: <20210219063715.63666-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_013720_310407_9327FDB2 
X-CRM114-Status: UNSURE (   8.53  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

The first patch removes barrier from the nvme_irq() and second patch
does the code cleanup for the same.

-ck

Chaitanya Kulkarni (2):
  nvme-pci; remove the barriers nvme_irq()
  nvme-pci: cleanup nvme_irq()

 drivers/nvme/host/pci.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

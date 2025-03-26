Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28C5C36008
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=; b=hGJGvbwfd+Ji8dBXP3nrWDo4nw
	qRdJhRkoXhMyMcjU2D/dhRSkA7sQyxrKO9x+KNKQF+tlrmDkJGfnhfiKduDLvIu1+DNnUjn46L1/4
	WtXDPEoU6Y/Ksg5mUxf1ZYt2Ue3A9mylqMcc6CWRIn6+I5QXMNA9rJz4BbrfQxDUEm3C9AIsfDl74
	ES6+NwQeNAQvkGo716ncg/FSOX81naJgmgRf1hRfnzTBo1pOjuM7XbTiWXdwzmErSWcXwVOgyFM6O
	yTa8Cjkthwdl8HFj6GHuMCCHgkebMAS7NyoaA35mrMrbugBFVgz9eaeY99x8VFQHmVAg1oh5jwjzP
	QpV9C4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNoG-000000089MK-2V3t;
	Wed, 26 Mar 2025 10:16:32 +0000
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNnd-000000089Jn-3dI1
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 10:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984150; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=C4nkqd3teuBmaYzx6wNAgVfPtESI28m6aszFmWuQ8SuqfJbNros4Q85Nw51H+7Tcy
	 EvSg7ptrQkZJyCWYzNVa++6i/OklPRB3QOwwsU1UGjsi2tsv5BwcRt2szO6lZdqbxv
	 +rYoySBRn8TRIuZlwpVjKOVZmIE4+QSokffGthWk=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9CB1E93; Wed, 26 Mar 2025 18:02:28 +0800
X-QQ-mid: xmsmtpt1742983348tymg8gqam
Message-ID: <tencent_788D1D0B2D8FF4E718D8627502FE0A949C0A@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpw/8JYyJ3ooYbJzsFXNTv1AzBVLrEzcEDozd7Gi3pxJXXng3JTf
	 4EyF9cys7CNem1txEpdA0W/FqJcoHUOotZzyj9sjtBKblw0YDcUmBbddAjUXNzyClLjm+VSPPY0Z
	 H7xWsuMkfTmJ9lR0gclwtET0zyi2mTsXIQQPHjnQ/eAmMBxQseDA/EAgNB0S4gyxnKHz6zxToGlT
	 tjMe7224lEQuxLFAilMZ789i5APrAo0JxreeMeP+wodSLgLafET17iUlYIZz4ZCPJiQjeZ73mucp
	 +rkMoAUy/CBjbTSKMlc/aV4bPeRcHcIpkVAZdUcdbNQjW9m9d8KnGSLCPG9JcpqI2HQTGfWhAHxO
	 Npd+//ypEMa8h4R70oLh8htZi9GZ3nwj1cNEbRwcDVSMVcOBk/SY4AZjt8Iy0We2GgUzLeebRu/p
	 qBFuiYUp+xFNvt48laKMQ1J6Dr1n+9DonEz4wXFJNmqOfsjqFlC3/vErNAr6gWA0rx5DO5o2PIYp
	 vaog3W+fk7bfDs4U6+ijKX6F4uzGZc8psttgGXbTl30QYtyCCY2qsN6+fTOZj55cjpauP8zopAEw
	 XJmS43XMGNR2otxD5reKGKl6sucBOp77lGRnCSOMxgJTDNyxO/wL+gw3dB4QGlyr/sCE7YYZZz3/
	 CUmzUByLesj+q0wjY5DDMZGwnDes+ndQpZmt6YuiHVaKkwNX8yGCSl4kMC5eKzII09I4Q1mCcewT
	 n38w2IlxgZKp9wiA9RaC/buwz38BSmI0/dRFcs7csJMQzrnaK6nKlVqynXmR0BOFeY5wC6gtcPku
	 kjdADH9/q3d5EHjeWv0FvgC2XupewcexET9C1Lo/S6VdhGZMuUOFHJBSPD2deAjfpjkKE1US/Be/
	 qt8PVzA9rrS1l7N3VmgMZYacoxTAUbuMKK9DfR6SSSvvrOslsk1Txur/5CdU9yM6muEGXG476kk4
	 6RAb8+PoYJ1iUAJsnIOPPwdWYgxB6hAYQ4fHLTFojRgBrUp8w2tcAjgidERJ8NWDZJD/S0eMuXL2
	 bSmbDr+w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] nvme: Add sysfs interface for APST configuration management
Date: Wed, 26 Mar 2025 18:02:24 +0800
X-OQ-MSGID: <20250326100227.1306684-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_031554_204471_1A3F7D8E 
X-CRM114-Status: UNSURE (   6.97  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

This series enhances NVMe APST (Autonomous Power State Transition) support by:
1. Adding warnings for PST table allocation failures
2. Exposing APST tables via sysfs for runtime inspection
3. Providing per-controller sysfs interface for APST configuration

The changes allow better visibility and control of power management settings
through userspace tools while maintaining the existing functionality.

Yaxiong Tian (3):
  nvme: Add warning for PST table memory allocation failure in
    nvme_configure_apst
  nvme: add sysfs interface for APST table updates
  nvme: add per-controller sysfs interface for APST configuration

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1



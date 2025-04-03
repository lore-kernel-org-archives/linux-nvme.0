Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF88C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OpjX7re8NPi1tJd+wCQMYrDRx68gd4pxONw2WALjE4k=; b=cTVV4tVxAR96e8wwX8aDuBm+ve
	pKtpekEqQO7LJtRsTvlUcNq7T668aZ3daEXTf8Cq7vh3V4hOboj3mtQw+Wvv6pAB7vEk4Z2wFG5D9
	73Ge4betZKdT0sy8+PpiqJR2RnOZpWR1E9YCu/tqMcR8m/8h3s1MqCzV6KCHmXeqLKW+0dWOfP/OF
	UPoAI8z9VoBevoEV/vTOuXeusNZQCwfT1U5YL0CipV0lgoyHODPMfCNDBMO6eX54NjWfyte5kn1de
	G+jLkzu7PUTy13Oxx5bqEIE14kKe6CVKef/6SfRKI9G9tshRR+Mhh2oaYt5poy3Jzcbr515LdkVy1
	hY/mMZTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0F0R-000000086r2-1QO2;
	Thu, 03 Apr 2025 07:28:55 +0000
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EtE-000000085dp-2gvt
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743664868; bh=OpjX7re8NPi1tJd+wCQMYrDRx68gd4pxONw2WALjE4k=;
	h=From:To:Cc:Subject:Date;
	b=vQ3gL+rU1fAni7cLRr0SuWVwiv1Oy68SO2MI21iJaxp2zJtdXIrNAdC8Ce0wdyu2W
	 rNwOq/uwLD6syqjOcQfG2Jg2/vH2XhZPIto1f9alQIqimAJOUGj6S0OL45NdAZYvLS
	 I9i6nfsTvlq/1xHVzJ5IBnjsdnLld/sqxXQ/p9k0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 546986F6; Thu, 03 Apr 2025 15:21:06 +0800
X-QQ-mid: xmsmtpt1743664866t9jej133b
Message-ID: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No9MP5Y6U8o890FzRKoBecWJRn708CXoeLJTvdfQvvMiZLSeSzyn
	 2V8b2qwtUPGf1t9b4s+iugup7TxVZZ0hetYQhmK9IAhrDt9R8aFfTwpRJ6No+cWEUUSV39j8Xc8C
	 08TCD3dqEDjlmfCLajaZAypaYiQCS0avAcRjqx+oiKTCWlqzYvjqkaBqYF03Xz0i8NYKDYq7IW+Q
	 JUMoD4BvwEt5WtAQsmHhvU0WKYCAoL4lOjdvUmEEQikVT7pLHClcciVRWc4aKsL7z1uKOph9Z4U8
	 5Yhkd2H+jF+K8ekUWBC0BSHZYvQRF92RQyAuIPlX1pCkZ7xIrNtr3h09B3Ou5qlBmMzJIiTEJoBR
	 Dy0H6y6wjxvzmWKnSRDnNHceOqiAxSKQyz256q5bNHOvyu8UMaR2cete9J466xIFKYKt+xNbfNPx
	 YARPEBik/vxsjqERMc9mx/iRFjAGaRjZ2bxrpsT8JVrEpizuLnKrt2oweCRxFElOBKfpoIBw0Ocf
	 GCtmUjWjSVf75JSryVjkJlD9Awn3V6gTmUgU646ZZA5t5f96Ia7k0Y9LLbMi/WeOfoCmBYC5ulMY
	 sG3j/IqMEprBhn01+NsEg7iWwmccToZ+xJkBG9kAvqHLSI1+JQ2GlwK6LCM+f/7bwgJt+YE/L7wd
	 bdjmatFTal+o7eAN91UxNGFxy4kXAuX+y1IYOWmtjWwkYm5o32COYgRi7dLNEt3uuTIR9b239D5B
	 dL3FMrTrStw6XtUCI5fO17tGdBNOfnQ9wtM7h/IApPjstEbp9h4LY668NH1PdAUzPcnhpWIED9JC
	 ZMzmnsRhCN1zm7rEEo0Tj9nzNBUbvxZ3l2UoIkZgEpoyhYtqJ/nGtYhEA2DQZZFOjEdhjTS+VLXs
	 0zk3ROCG2opeudrEUmV1092cdpEu2OqBSehKzYPDFseohTj5oN8QrtN0mnGRD0AfY4ZcjmZzQ+wM
	 YUnwm3X7wWfyw/vTaE52t3FbxSR25W
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v4 0/3] nvme: Add sysfs interface for APST configuration management
Date: Thu,  3 Apr 2025 15:21:02 +0800
X-OQ-MSGID: <20250403072102.1204659-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_002129_244790_DA9C5168 
X-CRM114-Status: UNSURE (   8.61  )
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

Changes in v2

Add mutex_lock in nvme_set_latency_tolerance() for Potential competition 
between nvme_set_latency_tolerance() and apst_update_store().

Changes in v3
In  PACH nvme: add sysfs interface for APST table updates,Add why dynamic APST 
updates are needed in the commit message, fix code formatting issues. 

https://lore.kernel.org/all/tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com/

Changes in v4
Avoid the overly long line in patch (nvme: Add warning for PST table memory allocation 
failure in nvme_configure_apst)

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1



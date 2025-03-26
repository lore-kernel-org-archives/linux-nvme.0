Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340EC36010
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=; b=AwH6AYHk+UgqaH7mxKf+LST4WZ
	9Y3MEkHUEIOecOPJahsm+NmceLQqnhfAsUJs5qgn6uwBijv0C6eamkK7742E65g+/nB0xf8FJivZp
	drNcMPnQBpeejhNNjlmHxj/qkCjg7jd7168tZRkb4lzU+wHQNQ7QIg1UydPmh9FkglGG8Rkbmy7lL
	iYncpNqGLvK6Un7r6upaoLd5ZzZbQpcOKCrKvM57zVqueoTOJl15QTvn7t4TlXirV31nHsyIpH722
	MuWfr4ufvaXUPR0CzbkLg305SAHUpiZ47MQ6f7+kbmsksGZedTaI3EKsF2NixLThkM2OKYOb4ynXj
	ykIEZHag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNXt-0000000860a-2yRO;
	Wed, 26 Mar 2025 09:59:37 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNXm-000000085yV-3vwR
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 09:59:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742983102; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=qLIEHvhZfYbBJJ5udg4HEDK2iR08NfZkdAMTWx2pA5TVwYiqBszmON0iBqWoMOX3+
	 GQ56Pd4IAxePBjimg+yYRKUwtUPvU+p6xcZ6QaksPIcP7uS3qv3nX3tItG2tEfFBlf
	 BlzGYJUyFHLHiwdaumKY7vQPn4g1Y+N+1qPWoqOA=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id E809F01D; Wed, 26 Mar 2025 17:58:00 +0800
X-QQ-mid: xmsmtpt1742983080t69ymxsez
Message-ID: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+ZrUAlHVGcvrCGFv1twgmb9koVlBwb4p/Bzwcwg8qFg910QmTNx
	 kbsyisMmk1x9HuhXNbtiWlDyX+SoNWTkloYzuNVcQtc9IooAOddpCIfDa0MMRKRaV+re7IzkqNgn
	 3l+LLZMu9BVCit9xXwef98f16wYkR41OxptHEGkZyFwHZFTfKZT7U0orbd4lNj1AZMftzXSd5WR0
	 wKG0lbNgICf2yl0V5KBGTbQUY7A4g24rcaTPa67Z0RIGdLMocyuf9e+a+usO5Mw9CHUZ8JyZpQab
	 gP0JHREkqgZPIyJn5Uj6ny9rHP/MVmZ+zzZ3O9xLj3rqJGqlP2ukiBMt0ji9jSgYAiH7oCanknbS
	 E5ndXEXpcUq5n677IeNeFdscg+NkfNpf5wvAgqMg6uYni79CvkQ5jxTQ5tcXVs4aLIs0u9Pox4Fv
	 HN5M1K8t+bSSlHuJiY8dSF+d/9uD7M9RJ4Gl1ZGbuqQn82+yLL66MGy2NFgjxYZ2heDqV7G70jP4
	 eN5aKmDD7+q5suoBTJpYoi5eAELeXFhE4dJwx+mdk2yl3R0/TMekS+Q5350+QQrfTB7S8L2fgVlt
	 zbGfirFsqSzVMvB+AF0aGFs0Q869ZlfpIYperZxvnaI3YlS5t3MbJVAsO4MDgzieANgzDvvQtnyi
	 WOgRN6x6hdJ6wdI3mpFr9C4VAIIrMe1jxro/dWl3BlHFFxNTDPT1L3f5DKGJez8wjtU3+W2/jkvQ
	 FGILC79K5Uup7BYlDq+34J+nXOHf8dI0vgFZ1V1KqjGfTAqRr4QaQg2xoMEOpx/zBx10zDcDXBO6
	 JniRfspyEqBC9wDvAX4V38CNNDxVdMrUqfMITUEi21eOxCb9AseXluZeBcRpkS9r2Iy9ScQvTjy8
	 6bwkZzh64O1HSZ35tnzE+4Aa17U3+SbNj4tRoFYw7fafPGJJAwUAX6KwBBRgy+24tndd42kXM5
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
Date: Wed, 26 Mar 2025 17:57:56 +0800
X-OQ-MSGID: <20250326095759.1292617-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_025931_335622_3153C87E 
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



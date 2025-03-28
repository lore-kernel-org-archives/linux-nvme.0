Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B889C3600B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9j5d/J8zcsc5onhRmFuStFe5/dVv8ZloWD0b6T9BVks=; b=alV4D4IGs4J7RToHOB1+v51T6S
	hE3mCjDK+BYsng03Zitv1a8tT8mK992FC12rhD7x0GiFCAiCYdNcXW3+TPdxlxyarvl5W72zObN2B
	5/6Aiyqsv/Yqg5E3n40Ts6yQOMDmLF6yOjxI2ngmaSVrQuqjEIPYFjyanj0OHpyXyxeJMGJMffjEN
	BQMzqgQv8/BCkMQNHmPSn/PazkzC+ZkvV7ftn6E/hEF74ojUV7NqcbkqpaEJeqe/kltp5DIcFETZw
	zoYjvoJf9iuz6nB3oSt0QO9MG0eQofxfVsNGAH0wjBs036bPWPBGHZsWALpx2EhDySR4h0/uRzfRp
	6eQHlYIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txygH-0000000CM0U-1vqQ;
	Fri, 28 Mar 2025 01:38:45 +0000
Received: from out203-205-221-239.mail.qq.com ([203.205.221.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txygE-0000000CM02-0wwB
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 01:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743125914; bh=9j5d/J8zcsc5onhRmFuStFe5/dVv8ZloWD0b6T9BVks=;
	h=From:To:Cc:Subject:Date;
	b=piaMnolpT8Ns+3xwKntupyzCLef6BpBf+fwtygP+wwb1NwtTNrii8m7bO2hCrMgYs
	 YHmgK5F2YQhfiESSAJguIWYP7VVWgOoQNnR/WyXMuZJu2AEM21em5AQCAoQfs4qLhq
	 r6S5jOG4yYozbUdWWQbAbvv0VXdKK2DoJqHhnKmo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 98D004FD; Fri, 28 Mar 2025 09:38:13 +0800
X-QQ-mid: xmsmtpt1743125893t1l3naihh
Message-ID: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Juz8M7sFYLcR+S2gUYWW88+ryy6gT64V8NCj4docy/xDcvjiPm9M
	 LSAki3QnsVpmF2d4RcsYT+c/x2BH8fxVtlzpZst4EWiaIe4X4hSvBpE8IPt/NMgSK/wmZxqERESN
	 EqiReWMHMQf9+6cAYEBtAvWvP72J0BIbcGsowh+jG/F+LXwY/3u57yWDqx2fqMJQzB6BCIFNU5f8
	 sIUILE1JhEs/Njh/EmDrYTAcVJwHWem+H7LzDdolaLZ0LhW5iAmLnv7676RcZSsli0oOQXDQcfmr
	 v3fSmvPKSfy/gfVHdwLhmm25Wz7aVwjUx6Bt5ia9HCgUBZSR7QSTHfoIkqVwRTq8KuY3IRosWWlQ
	 PC4OTrRzOJwf5AszMqVvU1KzKnHFxfKxqmp5rrJUpfOjOcD87SWjGWtDpUEpMLusOQkEglGEsE4X
	 xOzusL+YKWFqvm47QHjExU+gS431ouvlq9uIctx8w5pWUfATwlVQvaAXupKsEStdhfp4QUby02wn
	 tLc/dSixNNT0ujJcYq8D9otMEzJ6bNw7Q5KNyRYPHnJoy/9qy0rTjA7Iz9jzncO9jD28W8lEI4Bz
	 De4eqTMbEGFtrrEjOYTpEnxkhf0Ujg5q/Q+WvsAnphif6sPgOYB2d0DCLfLlAN3TScr0adn8tfcQ
	 6PTeW2ayTv8zjlWGRub4hKuCkeCkSOPEBsenoz/CC/YPFhYStGPpnVN4re80pg+ozAsIItMG07Jh
	 25LvylM0mCkcf56tKk/i4G13suZcaYMVG35cXCoA/WwqvH7LsopS0qggE7rU78+wyrE0wTKb9N7S
	 i9fSvNKASVxzOonYUekX6qFKrJG0ZQb0bHlvUQCR+oHDS6cky0/I10HX7HwvhZeDAnKSfjfr6FuL
	 ZZwK7JvmswWav5NmcdBzYMi4nmKCkCvkcDtzrad0C6OiOmf5JRlYjNGbkRhun75Bi5r9uzB81iAZ
	 w+TJl/BpYBnKGCT5gtPib0DPqIF1AURqCD03en7H8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 0/3] nvme: Add sysfs interface for APST configuration management
Date: Fri, 28 Mar 2025 09:38:08 +0800
X-OQ-MSGID: <20250328013808.88688-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_183842_788111_EABB07FC 
X-CRM114-Status: UNSURE (   7.26  )
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

Changes Since v1

Add mutex_lock in nvme_set_latency_tolerance() for Potential competition 
between nvme_set_latency_tolerance() and apst_update_store().


 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1



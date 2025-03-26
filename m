Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4E1C36008
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=; b=v/IWOMr6fxat51dvTNN3CnRrAN
	q+QziuATP26JamQeHF3A3vslEtdBSvSUsNHWZ/5+tfoO5Fig5mPocPzz0oxTEI9GJi7NSM+rCvFNr
	DswDaljJYlOMyfXPO+0m2e9A1TOYPhj26TikFWLq/3qhY2fnF6RFwt8tkiHzX7tfZEUpWEC5Vskfz
	JzXdamWzmBRSagUpxB3m9gNvmtIUecJdfROeTsLvd4cZpMe5zWjHx3nT4YqRB86AudEl95yQY0Nif
	K+JPCbwIuGVgj5wDa0otikHAkKR6d/ps91aIZzKaZV9u3Ue/j8JLswrDJ4oW1oY8lLMnQ263Gnvsr
	sj7Jp9rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNfK-000000087YG-27Nv;
	Wed, 26 Mar 2025 10:07:18 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNes-000000087Ru-42db
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 10:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742983598; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=kt1TsZrPEDQyg5p7UhwVmm95Po8cT+Ti6uCtmbvW5X5Nhn7zuaJuKlEZlL82T2BwD
	 6eMs0w3KMczW+1k5rCAPvMy7JDSuIahCgcsyKigJOoxRgfuh6vDGKyesmQ2K6/wxyO
	 h63bXiBBPj6OhMkVH7mBsH6+KqO5+RpdeHVSYMQQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 1A40FA8D; Wed, 26 Mar 2025 18:06:36 +0800
X-QQ-mid: xmsmtpt1742983596t640hwne1
Message-ID: <tencent_08386388426E23693951B6B09D78BF0E2508@qq.com>
X-QQ-XMAILINFO: MKQst53PCfggzNBQsZ5bQi6ShZPnoKO5qX6Ouz5NkULKXT45QLP4IxOVxq2LsD
	 iauNHEUlYuFx4YynfKf1RxBfe74ZLYIgwojAy4GTpEQ+UHrnqw/b5v2jgGq0tNOKyGqa4Y2lyU2U
	 CaiZvlK+0tvUGPnJGVV6HLDvjTtAW8UHLHMPClxfEa5bj6zTDGnaZx7nu4EFgOo16n89XUykUWsx
	 oLZQkG2bG3dl4x1ecNjmWNTsCj8eCaSGfJCQ+Lkzu2x7JqNV5c2LZpiul8Yfu0aavwN1Yh5JqW/u
	 hGH3NpuPOQWIZMN+Q29Oeif5Krv+iNgBn2pw0KkaYD/zaBpP0KEfVKsuTm/WPfmVCIcElbYGKk1w
	 dS0AXTXX+KusbXeIbclk7tYPDrP2UNQs8WMf5jecUmhiY0NPUCJjwJ7Cz1VwzOTEzf+fBpbtBP/B
	 2Dn8/Bizjl18+dwCa1PJeZhK66gqVAK/T7enFW0mW7CSPopHrZqwCWulGF54KCJngE3jYBSHXHjF
	 R/akBSYQgKFYy3wbFJ3790WeTjFI+MxvxL33Tk5Zdv6aLs8i0o26ae3FSe+74hof8rK6xsEOZCsh
	 +gtqXriEPVCvozXpBr/tmoO5xeyWuW1qPho8Nl+QMVY5C9MZTxNE8xMi/f3kJ1MdIqD4e56JCmAG
	 onvAjVvezGcEajpvcK0IFhPdMXcu0fHiixz3S0I1LRVH253rKeFk2uBld+ka4uOt3eFoNP93E29K
	 nJreqAX7juwhMxPMu6VyjD5Zw+UtumuKe4OfIwqD14FNvBFx+Y1tjupCxUgEYxS9rmt+B7i2Fm2v
	 spR3AocO/j185/xYGPlvbe9YBEYiU/PcVtyA+hnaNl28C7k8VYIss1Ndp7RGfWfNpklbNjZob/Ru
	 9OyJ0PoVMHtA0OMqKY1uwuOaqnYTGLkugJYDJExpvY7Se4hkGZn2qzMROr/YKxSaPOzeH+fLVk9C
	 CWmY05CPEHgPa0ZeCyVYURjrzILtGRtCyEK5CwTSt9EjMmZzhih1FVdJlOVRgmrZcURwJsz1TaWu
	 5oLo1mNA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] nvme: Add sysfs interface for APST configuration management
Date: Wed, 26 Mar 2025 18:06:31 +0800
X-OQ-MSGID: <20250326100634.1319638-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_030715_585504_45763F57 
X-CRM114-Status: UNSURE (   7.06  )
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



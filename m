Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9537C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J4tPm62OlajVqueO6CwcbbTm8B+VyZAmH30HgzEhSNE=; b=UuQR58XmyYc2fctZoIRvmLD7d9
	aku4H/cI03UK/cpV4rsITK5S/XIsK6NfYTQoE28EO33QcX+eaRMdjSoC5gy1pxnNLbZGwpU2TsVoZ
	15sxHRVOiKGOcRc9IYEP/4Yx3C2Y696ssoQgKEaaHRsLcI/OJiTbi0xnWEyXzcoUZJjl4QKkQNNRt
	ZLNVmldjb/cCQv6Bybve+dDav4fk86B1OqSCXiX2Dt/y/w8kio5lC8vQ+2jTEFLz7VwhbNO+rNo8Y
	TpC+GQ9GxjL8lyb6g+EZMhD8P1PEKyvxm2WgW4+kmOauxr8tXO8RPbD/qJ7osdRxldcHR9IV6A8w9
	FcphEhSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neUwM-00GlYl-M0; Wed, 13 Apr 2022 04:49:14 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neUwJ-00GlYU-7G; Wed, 13 Apr 2022 04:49:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
Subject: quirk broken namespace identifiers v2
Date: Wed, 13 Apr 2022 06:49:02 +0200
Message-Id: <20220413044905.376785-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

this series adds a quirk to ignore namespace identifiers on controllers
where they are completely broken and then quirks two controllers for it.

Changes since v1:
 - validate namespace descriptor sizes even if ignoring them
 - also handle another MAXIO controller with the same problem
 - fix up a few commit messages


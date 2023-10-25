Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DABC25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xTMGiIf9BvcjDTMlnBhMDXLdKdTkxQrxNd4R2wPfqL8=; b=K6drm2aCOHIZMZoMcotx0iOgJ4
	P1lVqjPGiIt+sgf8rbbFRosuCE+L5kbulvz4bjZ6RaA0WfJ84GbY1+yoUtulKwYYszqgggGvdGslk
	Q8MwE8j4Pei/lhNx3IozQT07BCwKMgn/gtRLsuT2ceHtgSVbCammS+i+ZUt/t5JRZaJFT0K3C9ml5
	VgwZgQVx6mz84ERNf+hb7VwtR5AS9bj2F4GWVj57qevSZRrMGMCm/dBl/8PcC/r8spw7uAMc8PT/W
	Aju4VRRjvVSmv0sbq0Z07C+dJV/TQj3egy05F68zIYE/8rjD88Ij5AzG0K3Ep2i8trjRKPnyNmPUS
	ZFnfzEaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUI-00C7JD-0E;
	Wed, 25 Oct 2023 10:51:46 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUF-00C7HR-33
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:51:45 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 38DEE240103
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 12:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698231098; bh=0FIw4YJi8aEpRPqIX3rgKn5FpRFYwb1qqUHkTAzLsjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ewWc+fvryAkPURvNf09ookvNOU0cLZIF8Ake76dylPBepOa2hRTOzLUnkcGMmYD2q
	 pHysgkghxNSsVaC3uOR2+zCYpDdwhlAIPQQSxOSeWNr3BdlWF7FWm2QBorfMMVBygm
	 3yxKsJhrOWbt93TGkkU4B9ADtOLuKR+hVujTbRIRekhpC7xw10eyi+DMWP4g4Fvr7E
	 5c11mmtVU4qjstY1kCMO8b783kO6N0cyCk7tPFfYmOwrEqe5d3BsnVurW63gfPBPus
	 PzoZnpC26XNV15S5sMrML28ESbJbMASmeIdVEMbdifYX9bfzYpELikM9nTWpe7R8+z
	 5hcH5q2J4CFbQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SFm2G6rRLz9rxB;
	Wed, 25 Oct 2023 12:51:34 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Date: Wed, 25 Oct 2023 10:51:22 +0000
Message-Id: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035144_133581_0ACC7125 
X-CRM114-Status: UNSURE (   8.79  )
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

The first patch is a small unrelated fix which makes it clear that the
response data section of the Success1 message is not optional.

The second patch removes use of the host sequence number (S2) as an
indicator of bi-directional authentication.

The third patch causes us to always set the host sequence number (S2)
to a non-zero value instead of the 0 value reserved for the secure
channel feature.

v1: original submission
v2: rebased + added dedicated variable for bi-directional auth
v3: nvme-target code now reads seq-num

Mark O'Donovan (3):
  nvme-auth: auth success1 msg always includes resp
  nvme-auth: add flag for bi-directional auth
  nvme-auth: always set valid seq_num in dhchap reply

 drivers/nvme/host/auth.c               | 13 ++++++-------
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 include/linux/nvme.h                   |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)


base-commit: 4f82870119a46b0d04d91ef4697ac4977a255a9d
-- 
2.39.2



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DEFC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LdXHMpBQc335yDmqjBJfb5u6GDq7w+Mw7JpmmsgDA2M=; b=Qgf12YLGANWrI3DdKUIo6kStqr
	43lyiH4ZwZfdElbtNhV0ypKFkef1hW+i73hRvnYqNw1EtOpil5fpKAVEmQHmap0rsohcxpDEcU6Qn
	09HGMnUPJTeyd3uhgJ0G3U/hJ08d8ykhU2Isie4OuEUjmJWNtLS+SvDlA1GGBws7EhC5bT/qrSb85
	yLpaX+wKnDJGgT3tbsNpgrMSJgGA/LrePuX4LT8WXUwK0o7VdUKBIejcllX7uxRmbGSHxauPntqBv
	XwxF5T7YcLhnQCwnhHc31ttGGRwwrgGbHj/RIGfXFkApAQ6dUeIEXmjYzAs7PwuwQ+E8IrOkSrDHq
	mqzdLL2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrR-008ZcE-TB; Wed, 26 Oct 2022 08:34:05 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrO-008ZaU-5C
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:34:04 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 35C3640416;
	Wed, 26 Oct 2022 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received:received:received; s=mta-01; t=1666773233; x=
	1668587634; bh=ddUZG5gq+jEAS5Difg0isGyw5KsE7mxd0BYnE7UPJzc=; b=h
	BhXF9Y/FWF2QThZmhXF6nrmBKeZNWOHgV/qSCELsdAil3rrXcTCLafsBLVYPD67/
	mLXpPLKIUl5S+fHCBaZb3kQTWtqpsehWWuB/nlc7d7/Tqj0er4J+ek7UE2MpJBCl
	geWNjr80zvokfYZDzIgdRHUqeEsrhlnmEykVHFrxJ0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hg86c0MdT4Z; Wed, 26 Oct 2022 11:33:53 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id E77EE4120E;
	Wed, 26 Oct 2022 11:33:38 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 26 Oct 2022 11:33:38 +0300
Received: from yadro.com (10.178.113.226) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 11:33:35 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Aleksandr Miloserdov
	<a.miloserdov@yadro.com>
Subject: [PATCH 0/3] Allow user to set nvmet firmware revision and IEEE OUI
Date: Wed, 26 Oct 2022 12:31:32 +0400
Message-ID: <20221026083135.77125-1-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.113.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013402_738542_85A684BF 
X-CRM114-Status: UNSURE (   8.26  )
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

This patch series introduces changes that allow user to set nvmet
firmware revision and IEEE OUI via configFS.

Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>

Aleksandr Miloserdov (3):
  nvmet: fix memory leak in configfs
  nvmet: expose IEEE OUI to configfs
  nvmet: expose firmware revision to configfs

 drivers/nvme/target/admin-cmd.c |  11 ++-
 drivers/nvme/target/configfs.c  | 122 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c      |  17 ++++-
 drivers/nvme/target/nvmet.h     |   3 +
 4 files changed, 143 insertions(+), 10 deletions(-)

-- 
2.37.0



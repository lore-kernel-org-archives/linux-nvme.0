Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12D3C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 03:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lLx3tvIgU/4yN4sDZhMrO8NWTDBTZ1MwIuAfsDw88AE=; b=YlphUp+tltZferQhIpp2DWYeaG
	5IzgtCbIvOViJr8N6+pADCfP0bXcFqGYc53YLAYtVQO0mq/YzVu5jciPeXYlayA+P63LHDiwIsKik
	oaL5MNxs1XmvJST0fXRWMdT9YteQsjel1GELQCmSCaXPeWjaU9c65Ag6KowVe4rW34EAVn5YKwVWW
	SOyBKU/cA5e/6s0FLtz+/Yf3HO8r73Kx5hudlGem+QEFqALSK8xAV1/Zv30lt/I6MakgrecTzRQzX
	D32mb3BBhLnDXZRjPE9arn8dO4cWCODNDZELKhllVgIfj7LCg7LQ5kEvCmtUg2cVOnGVw0qhIxvaZ
	996tjpZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSVXr-00EqF2-7t; Fri, 11 Mar 2022 03:02:23 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSVXn-00EqDb-If
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 03:02:21 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id AC42544014D
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 11:02:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646967736; bh=lU6HzNdZHgcc5KiwB5BXRJdLlGkJStkMFzd16R4L3jc=;
 h=From:To:Cc:Subject:Date:From;
 b=XWEk04t8YeEqCoh0KeGQSVfBDO8NhJr+Jx0r+NrJzZRGKXXcCApRRl2na2ImMs0Re
 pF1IEQM95FYCPvtvM40U4cTQndUnxmsoV3StmlJaYD4LA5OC77K4A2h6d0UFUURrri
 KzHeAYz8i1z2+CSpp/9RwHuJ0/eC/ARLdafjx03Q=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -1561347654
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 11:02:16 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646967736; bh=lU6HzNdZHgcc5KiwB5BXRJdLlGkJStkMFzd16R4L3jc=;
 h=From:To:Cc:Subject:Date:From;
 b=XWEk04t8YeEqCoh0KeGQSVfBDO8NhJr+Jx0r+NrJzZRGKXXcCApRRl2na2ImMs0Re
 pF1IEQM95FYCPvtvM40U4cTQndUnxmsoV3StmlJaYD4LA5OC77K4A2h6d0UFUURrri
 KzHeAYz8i1z2+CSpp/9RwHuJ0/eC/ARLdafjx03Q=
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 55FAF15414F8;
 Fri, 11 Mar 2022 11:02:13 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH 0/3] NVMe/TCP: support specifying the congestion-control
Date: Fri, 11 Mar 2022 11:01:10 +0800
Message-Id: <20220311030113.73384-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_190219_998849_22BB924A 
X-CRM114-Status: GOOD (  11.27  )
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

From: Mingbao Sun <tyler.sun@dell.com>

Hi all,

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe_over_TCP.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would benefit
the performance. On the contrary, the performance could be destroyed.

Though we can specify the congestion-control of NVMe_over_TCP via
writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets that
have not been explicitly assigned the congestion-control, thus bringing
potential impaction on their performance.

So it makes sense to make NVMe_over_TCP support specifying the
congestion-control.

patch 1/3 export a symbol on behalf of the following ones.
patch 2/3 addresses the NVMe/TCP host side.
patch 3/3 addresses the NVMe/TCP target side.

Since the change made to netdev is pretty simple, so the patch
is generated against nvme-5.18 of the nvme.git.

Mingbao Sun (3):
  tcp: export symbol tcp_set_congestion_control
  nvme-tcp: support specifying the congestion-control
  nvmet-tcp: support specifying the congestion-control

 drivers/nvme/host/fabrics.c    | 12 +++++++++++
 drivers/nvme/host/fabrics.h    |  2 ++
 drivers/nvme/host/tcp.c        | 15 +++++++++++++-
 drivers/nvme/target/configfs.c | 37 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 11 ++++++++++
 net/ipv4/tcp_cong.c            |  1 +
 7 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.26.2



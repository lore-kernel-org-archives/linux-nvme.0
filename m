Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513E6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zRVfcIogyzz3kay4Zy60qX0IQxMWgx5zYUXyMchieh8=; b=jcvIXScLhIUutTGLzbGMxFi1YM
	JaO6BGVuTIasfZ9Hx0XC7ushhHG9X8mdNFgQ1B6bJ1545b7M20YVlHRPSda+1hzdYJTJnTMS6gnQc
	vtLuPVzzoPZ9OWxNefAKdQfeLwJUl+dGTFmpONTxTKi5zLs+pr1sta/JEAs0Fi2hOBXwtKpkfRgLX
	EAII/dm/u6vu1Eqyack4LsFTXJ+Rdb0DJc+R6MGfWFSBcOsfFD3zF2WDSVqAbH9Kvd3tKlN8gEJfp
	pSgwY259vNmAGKBooHYtirHndbruTJSV77Fz/8DK/86rqO095Uh+3r/mmIrd/L6NUq+rzTjjumtQ0
	yKZrGmFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQ4T9-009MgC-Ke; Fri, 04 Mar 2022 09:43:27 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQ4FP-009Hth-EO
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 09:29:17 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 4582BB00D47
 for <linux-nvme@lists.infradead.org>; Fri,  4 Mar 2022 17:29:02 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID -28983117
 for <linux-nvme@lists.infradead.org>;
 Fri, 04 Mar 2022 17:29:02 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id 3C3A2B00D4B
 for <linux-nvme@lists.infradead.org>; Fri,  4 Mar 2022 17:29:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646386142; bh=aMp8az1QxA+F+29KIpcxkWlKDGd5ciQhH043yvhJWFo=;
 h=From:To:Cc:Subject:Date:From;
 b=YJqjGMHOZndk8KtYi7zlRKagQFVvnpreSXeaPO8mhh7gFtVcaQeSCzezxwJXhhiUf
 m0j4VPZTnUzEq4MgQmfjGz+BTGxKn0PxN77z6ahX2jV3/bS9qZUoFJsKg2FO+yV6uh
 5rdXEDKcBqhS0q6vbJwK4TPTC8htafzEs6IUudcU=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id A4FDED41596
 for <linux-nvme@lists.infradead.org>; Fri,  4 Mar 2022 17:29:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QqOmr1xGgqkC for <linux-nvme@lists.infradead.org>;
 Fri,  4 Mar 2022 17:28:59 +0800 (CST)
Received: from localhost.localdomain (unknown [39.144.44.23])
 by antispam1.tom.com (Postfix) with ESMTPA id 1C9CFD41502;
 Fri,  4 Mar 2022 17:28:58 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH 0/2] NVMe_over_TCP: support specifying the congestion-control
Date: Fri,  4 Mar 2022 17:27:52 +0800
Message-Id: <20220304092754.2721-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_012915_748358_19CD1BF1 
X-CRM114-Status: UNSURE (   9.38  )
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

The first commit addresses the target side, and the second one
addresses the host side.

Mingbao Sun (2):
  nvmet-tcp: support specifying the congestion-control
  nvme-tcp: support specifying the congestion-control

 drivers/nvme/host/fabrics.c    | 24 ++++++++++++++++
 drivers/nvme/host/fabrics.h    |  2 ++
 drivers/nvme/host/tcp.c        | 20 ++++++++++++-
 drivers/nvme/target/configfs.c | 52 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 27 ++++++++++++++++++
 6 files changed, 125 insertions(+), 1 deletion(-)

-- 
2.26.2



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0012AC531F9
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 03:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LO7oRDncXzyVtKyopk4UqQvArYIV5W7bMdnezBOtJQ4=; b=lHAfFCRGKJC7ltx0jCAmkW6keK
	W8XJWC2/FZxZgmJ9bpQKJE69krMryxbHs11oerJF0TVV1mftR5SSuoH1csEqrZ+qPtOTSg3Rnn0ZO
	nmk+HeW/PwWlvQ4JD+0x6i5TG/emiOrcEziuaIcY8xv+YhGBP2dABFBjt27AAgD1c5XFvqTHu/HSa
	KKiOGyzdpPIpzsPYttGy8AbmxM/eWzn5NHOPuNPO1blNWqCE3q2cJOrDXdHtuHPeQ1OaCKRI7DlN7
	EYwgCHA8fQnGuvaoAkP8sfCU5bVMC9L89XDM2++FBKAyy0ezu8ryoAE2kiVYSMBfW9g9ZpOxc1Et4
	u6hSJp7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsK-00000001rX5-1PUY;
	Mon, 27 Jul 2026 03:19:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsJ-00000001rWy-1NsQ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 03:19:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 62CA0600D8;
	Mon, 27 Jul 2026 03:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844771F000E9;
	Mon, 27 Jul 2026 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122370;
	bh=LO7oRDncXzyVtKyopk4UqQvArYIV5W7bMdnezBOtJQ4=;
	h=From:To:Cc:Subject:Date;
	b=iYI1II/cobjeedmaYUQsdcw/yja2Wxr8inHxjRHyWDt193fh9cy5Rtxl7iOxb2YuY
	 g2B12tMM5rXHs2LwGyLYl8QV3SGFauBTZMedfWiIeuBsV/597eGoJoQGI1Rc2R/cgD
	 y0rsGCZgcWj1Q8zx3gluFUe03YMIRB3/6JHlXYy38Zv4Sr+kZSqlU6w5DwHp5Q/equ
	 iXiwLcu2ULLXwAtpH4Pwo4pQkW2fpoj2aopN5rM3sBqR+yDZXY2Mc/xSi3OCnUGY3j
	 KUJGDKkeg5bWAHl2Mv8d1vo8V1AKqhALRDa4oxPDwET3KpUo8sXqeqmE0E1oAkC37e
	 cuAQyD/SB3xLg==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvme-tcp: add IPv6 traffic class support
Date: Mon, 27 Jul 2026 11:19:00 +0800
Message-ID: <cover.1785122120.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds IPv6 traffic class (tclass) support to the NVMe/TCP
fabrics stack, mirroring the existing IPv4 TOS configuration.

The current code path only handles IPv4: nvme-fabrics exposes a 'tos'
option, the host (nvme-tcp) applies IP_TOS to each queue socket, and
the target (nvmet-tcp) reflects the value received on the wire. This
leaves no way to control or observe the IPv6 traffic class for NVMe/TCP
connections, which is a real gap for deployments running over IPv6 or
MPTCP subflows that need a non-default tclass.

The series is split into three patches following the natural
fabrics/host/target layering:

1. nvme-fabrics: add IPv6 traffic class option
   Parse the new 'tclass' option in nvmf_parse_options(), validate
   that it is in the 0-255 range, and store it in
   struct nvmf_ctrl_options. Use -1 to mean "transport default",
   matching the existing tos handling.

2. nvme-tcp: support IPv6 traffic class
   Advertise NVMF_OPT_TCLASS in the nvme_tcp transport and, when a
   tclass was provided, set IPV6_TCLASS on each queue socket. The
   existing IP_TOS path is left untouched so IPv4 behaviour is
   unchanged.

3. nvmet-tcp: support IPv6 traffic class
   On the target side, differentiate the socket family: for AF_INET
   keep the existing TOS handling, and for AF_INET6 read the traffic
   class from the incoming socket and apply it via IPV6_TCLASS.

Follow-up changes outside of this series expose the same option
through libnvme and the nvme-cli, so the new tclass can be selected
from the user-facing command line; those patches will be sent in a
separate series.

This was tested with the selftests mptcp_nvme.sh [1], extended in
"nvme: add tclass support" to pass "--tclass" on the host side and
validate that the value is reflected on the wire by the target.

[1]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/

Geliang Tang (3):
  nvme-fabrics: add IPv6 traffic class option
  nvme-tcp: support IPv6 traffic class
  nvmet-tcp: support IPv6 traffic class

 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/tcp.c     |  8 +++++++-
 drivers/nvme/target/tcp.c   | 15 +++++++++++++--
 4 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.53.0



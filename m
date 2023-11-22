Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3474FC61D99
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=otp4fgCwJWHHZAZ6q+Y95tBuL6x5UnP3IJclvbCUkI4=; b=gHuAiIbNxQ5uRihrnIQ6QUumYH
	Cs0eLRGi+Pd/N9nZdiEEsbwcT9iqDU5/symj59UDeeY5phS3XCw8n8orjEQ5wDv3yEGm8zU2/XiTJ
	l92DTPzAM/GQkTg+qYZrnLpXfFolzZRYNh2ka1nHzM7N102qzE2M65SWJb/pTAvtc8nyKeG42NXNz
	GW4AgLZQZ1GDaaKdrKqj+2RNry2VbJ6CuCckm++GSywnrKuCIfF9cdsH1ajxGnQfzf2ZrD2IYCjgF
	NoJ8L1e+DTIkO+IONYsrM6kvGFjf04F0cG5tnV7mjc5UemI5CrhVOVlb1reiIfPclt3SaQfsKmyYM
	PLhSALZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5q55-002SVA-3C;
	Wed, 22 Nov 2023 16:28:03 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5q53-002SUL-22
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 16:28:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0B38DB828BD;
	Wed, 22 Nov 2023 16:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCCDC433C8;
	Wed, 22 Nov 2023 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700670479;
	bh=us70tRFkSZlPYDI8XGYRIAlRdPhuJ96HznHxEngJs7E=;
	h=Date:From:To:Cc:Subject:From;
	b=gvImniuyFPs8s+BigEK4KKBTF0RwImzbHcykIPzCydh/VRPVVNn+Ipf0I67PAHMVC
	 9oi6++VFsluG/8FcnCkjGTYPVbwniogoQnNnHpfR7IC3w6E6UpxdcdUOGrv1udy1+J
	 lN2VA5DRfp55K2NuT4sHR68+eGCXmCPTtl+ZBwRlvr54EFDF+y0RouNKwaz/HatwIy
	 WcCQGU/X9dHvOcXFCdjiQqrAfsnaLUHg3TxWjMQkpcFYdxNLMHPkuI84c0eSkrrcoR
	 SX7LVI0Jx1fomJjGpBTaTVaBBDgeIjLtaiXnBX+b2LskSGyX+mGO2n0n3UNk6aX1dq
	 7YX+OuQkJVYqQ==
Date: Wed, 22 Nov 2023 09:27:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: [GIT PULL] nvme fixes for 6.7
Message-ID: <ZV4sDByrMVX696n1@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_082801_818785_A39F1505 
X-CRM114-Status: UNSURE (   8.33  )
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

The following changes since commit 37d9486874ec925fa298bcd7ba628a9b206e812f:

  Merge tag 'nvme-6.7-2023-11-8' of git://git.infradead.org/nvme into block-6.7 (2023-11-08 09:19:16 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-11-22

for you to fetch changes up to 3af755a46881c32fecaecfdeaf3a8f0a869deca5:

  nvme: move nvme_stop_keep_alive() back to original position (2023-11-22 08:07:02 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.7

 - TCP TLS fixes (Hannes)
 - Authentifaction fixes (Mark, Hannes)
 - Properly terminate target names (Christoph)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvmet: nul-terminate the NQNs passed in the connect command

Hannes Reinecke (5):
      nvme-tcp: only evaluate 'tls' option if TLS is selected
      nvme: catch errors from nvme_configure_metadata()
      nvme: blank out authentication fabrics options if not configured
      nvmet-tcp: always initialize tls_handshake_tmo_work
      nvme: move nvme_stop_keep_alive() back to original position

Mark O'Donovan (2):
      nvme-auth: unlock mutex in one place only
      nvme-auth: set explanation code for failure2 msgs

 drivers/nvme/host/auth.c          |  5 +++--
 drivers/nvme/host/core.c          | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c       |  2 ++
 drivers/nvme/host/fc.c            | 19 ++++++++-----------
 drivers/nvme/host/rdma.c          |  1 +
 drivers/nvme/host/tcp.c           |  3 ++-
 drivers/nvme/target/fabrics-cmd.c |  4 ++++
 drivers/nvme/target/tcp.c         |  4 +++-
 8 files changed, 37 insertions(+), 22 deletions(-)



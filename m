Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CEAC5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/PkTYmB9Xqmq9DAbPY6/2gP1sruDO+EphGFwKZ0TkE=; b=ARKEGJy817z5hom6EAxKNxZcK6
	V48OAjh+SJJwUz3+Z+ROK/Xb8CpQ55lX22Amd6qBqcqZc+j2/pBT0LT75ea8I0yMSj7opeGYsQrEz
	orQnIig/BisSTgBCthGXAdh1QxNwRGP1Q7gcNje7Yw8Fc0YYpc7u393b8/XmTZJSzNQQt9XiC1iQQ
	0D2dDlaNash7+7wl/friWfDq4+8s3UUK6yC8OvKWCuRdzFf4haros2+gv1bNvSYLAiCZBeHtSlzk3
	8xh7C8yq9wEuF2tJ3Z0EJGJrxmIeSKufwJUDpuhslxt/STERXPBTiT4RL50cAvLupEJZnJUXO5hAe
	2jRKJRig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTJ-0000000GlXa-1krz;
	Wed, 12 Aug 2026 18:14:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTG-0000000GlT8-3Cw1
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/PkTYmB9Xqmq9DAbPY6/2gP1sruDO+EphGFwKZ0TkE=;
	b=OzsOcqF0Z1tg6wmoqJvESlDS8vhkd5YRbnAT4lvwk8l1aSvcQX2ZxvP011anp0Mwk079kC
	L4krEwAtSvaY9ryWT5u2j6f15QICdpTjr6Q3aKuayVtC9weaOCyVZQjf+l/ojolN8EDggF
	Z2ouayb3Hk7NK5E3O4yIdKhkS+ARfUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-wKVI966jP82PysGX33rujA-1; Wed,
 12 Aug 2026 14:14:29 -0400
X-MC-Unique: wKVI966jP82PysGX33rujA-1
X-Mimecast-MFC-AGG-ID: wKVI966jP82PysGX33rujA_1786558463
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1000195605E;
	Wed, 12 Aug 2026 18:14:22 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75607180034F;
	Wed, 12 Aug 2026 18:14:18 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 13/13] docs: nvme-multipath: Add FC-NVMe marginal state
Date: Wed, 12 Aug 2026 14:13:00 -0400
Message-ID: <20260812181300.3712426-14-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -Ef6kUADJZ06nMlZIdxwu2KJz1H1S7KnMCjO42cgeZ8_1786558463
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111434_950128_AACF575E 
X-CRM114-Status: GOOD (  12.77  )
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

Adds documentation for the new marginal state for
NVMe over Fibre Channel. Documents how to check and reset the state,
as well as a description of how it affects multipath policies.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459..8df4235d4d10 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -31,6 +31,23 @@ To set the desired policy (e.g., round-robin), use one of the following methods:
    1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
    2. or add the "nvme_core.iopolicy=round-robin" to cmdline.
 
+FC-NVMe
+----
+On NVMe over Fibre Channel there is an additional state called `marginal`
+All policies will treat this path as offline and will not use it unless
+all other paths are marginal or unavailable. In that case, the policy will
+select the best path based on the policy.
+
+To see the current path state, use one of the following methods:
+   1. cat /sys/class/fc_host/host*/device/rport-*/fc_remote_ports/rport-*/port_state
+   2. cat /sys/devices/virtual/nvme-subsystem/nvme-subsys*/nvme*/state
+To reset a path to online use:
+   1. echo "Online" > /sys/class/fc_host/host*/device/rport-*/fc_remote_ports/rport-*/port_state
+
+The marginal state is caused by a
+FPIN-LI (Fabric Performance Impact Notification - Link Impact) event.
+FPIN-LI event counters can be seen with:
+   1. cat /sys/class/fc_host/host*/statistics/fpin_li*
 
 NUMA
 ----
-- 
2.54.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D35C87FCC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lv7yxZjsANwZuExWF5D6Tu2dwm9bHE1TUeSlxyjQERU=; b=CtoPrQXN8LTGCVuFBYkcy35vaK
	M/EsIP0novmwM7aeTGbuoxv6QUUbYdclFdKgUED7LrgvNu92N11BrXspjBaL2DYjM0p0Yuq9l9xWU
	z22C3pgQ7T4gXnGhcthOqLwsuRScZtAI4zzs8hcLRERRffymyxbfrfym6OxLJ6Vs9pOK/VlnEYz60
	EjApk/yKTn4lsTTmrPKIX6TB6Mj3FfH1MAU8IxlxjPza+3Hvb+GNlafOXicwjWSA0H2P5AbCezf+t
	3YKMRaU890LTohhKHi1RHnVUNJheN1cTJ36o2EhewCIyyugu51HnxFkJJIzibk1xb31xRc5qF7zsn
	QBF17SwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhDDH-00000002MgB-3J1f;
	Wed, 30 Jul 2025 20:15:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhD8J-00000002M26-1hxV
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 20:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753906237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lv7yxZjsANwZuExWF5D6Tu2dwm9bHE1TUeSlxyjQERU=;
	b=ccJ5/g25CL/e7OqNZjQHRR78jHTPkiZhSA4tcnzexQGw5AHRwUnuuxYFtSjRFlVlyjW3xi
	UUiADBFEZ5PIdHlDCqcXS+4cIl/VC6PsHpeO0zDKVcQIW8bUrSabRsFIQ159MLTV9x0kYa
	/4oVSxItgtgEhCXELLJwfxCbZZ88YG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-thRp1xOjMHu1rmh0xqeHkA-1; Wed,
 30 Jul 2025 16:08:45 -0400
X-MC-Unique: thRp1xOjMHu1rmh0xqeHkA-1
X-Mimecast-MFC-AGG-ID: thRp1xOjMHu1rmh0xqeHkA_1753906123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89DF019560A3;
	Wed, 30 Jul 2025 20:08:42 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.90.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D1F119560A2;
	Wed, 30 Jul 2025 20:08:37 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH 0/4] address tls_alert_recv usage by NFS and NvME
Date: Wed, 30 Jul 2025 16:08:31 -0400
Message-Id: <20250730200835.80605-1-okorniev@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_131039_560436_41F22C0F 
X-CRM114-Status: GOOD (  11.48  )
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

This is a multi-component patch series: NFS client, NFS server,
NvME (target), net. 

tls_alert_recv() has been originally written to retrieve TLS alert
payload out of the msg iterator's kvec buffer. Yet, the callers of
tls_alert_recv() have not been careful enough to make sure that
msg has always been initialized with a kvec-backed iterator (ie.,
some times bvec was used). Furthermore, callers didn't account
for the fact that the msg iterator's kvec is advanced by sock_recvmsg
upon filling up the provided space by the copy. All that lead to
the ability to construct a malicious payload that would trigger
badness in tls_alert_recv().

This patch series attempts to address it in a couple of steps.
First, there are patches for each of the current consumers (NFS
server, NFS client, NvME target) of tls_alert_recv to address
an immediate problem which I think should be backported.

Note, patch#3 is NvME patch that had no testing. Compile only patch.

Second, the last patch builds on top of the fixes but changes
tls_alert_recv to force the callers to provide the kvec directly
in hopes that any future users of tls_alert_recv would be more
congnizant of providing location to the actual TLS alert payload.

Again note that nvme changes in patch#4 are compile only.

Olga Kornievskaia (4):
  sunrpc: fix handling of server side tls alerts
  sunrpc: fix client side handling of tls alerts
  nvmet-tcp: fix handling of tls alerts
  net/handshake: change tls_alert_recv to receive a kvec

 drivers/nvme/target/tcp.c | 37 +++++++++++++++-----------
 include/net/handshake.h   |  2 +-
 net/handshake/alert.c     |  6 ++---
 net/sunrpc/svcsock.c      | 56 ++++++++++++++++++++++++++++-----------
 net/sunrpc/xprtsock.c     | 51 ++++++++++++++++++++++++-----------
 5 files changed, 101 insertions(+), 51 deletions(-)

-- 
2.47.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64EC00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xAi4q98RWEBh4O5+OIgD8Ak9QXXcaQTpr6G2gbe70p8=; b=cMrvPR5ta0ZGyg8OzFOKegyxBk
	dhA1ACTuyta8NQsOzp58vya7cBZF5Dd0VRaoStkD83CeVFaJPJTZpGpnIEaIHIdj/XNsbukr7Nied
	ZRf2V5/sdL6iJBcLXEDgrpQKqLyvOj7WjmQA876yvgqV0VLPwP+Eo4/HULF/ZzKChgGRnfEkKQpSU
	JxVckTOQYihpW1fwb3PXA9RvbGdvak3+mZL6Bn24DINYEC6sUiS9haxc2TmTPkmvJoT7IPfJhRr5+
	LWpF2Fr1D/aCBJci+1clE0ceTkcYxamzziDcPmp76nw6zzDH6L7fdjeJqvY0Q1/2AIAJeC+m1PtaJ
	H1eiVEug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oItgB-00FKGL-PQ; Tue, 02 Aug 2022 15:19:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oItg8-00FKDo-SQ
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 15:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659453565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xAi4q98RWEBh4O5+OIgD8Ak9QXXcaQTpr6G2gbe70p8=;
	b=SmP9/lzc/le+AEB0sZRF2xbaTo33k214PecorndwE99ceFlk4TsVwqX94khGU4eJzdcJA5
	Fy+vIcFNAoScLvgFQeJ/XUaTstc5zNjBB7FVLobZe3zrCWU0eTFfeHk+i1FLP/U9t7UQ0O
	hFgh2kZt6geZwME8vHa7Qav/Cxpf2wg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-uL24No6zPtKGVuCup0My0Q-1; Tue, 02 Aug 2022 11:19:24 -0400
X-MC-Unique: uL24No6zPtKGVuCup0My0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A62E1032969;
	Tue,  2 Aug 2022 15:19:24 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 642552026D4C;
	Tue,  2 Aug 2022 15:19:23 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH] nvme-target tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Tue,  2 Aug 2022 17:19:22 +0200
Message-Id: <20220802151922.480571-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_081929_013139_AF897C27 
X-CRM114-Status: GOOD (  11.30  )
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

TCP_FIN_WAIT2 and TCP_LAST_ACK were not handled, the connection is closing
so it's safe to call nvmet_tcp_schedule_release_queue() and avoid printing
the "unhandled state" warning message.

[ 1298.852386] nvmet_tcp: queue 2 unhandled state 5
[ 1298.879112] nvmet_tcp: queue 7 unhandled state 5
[ 1298.884253] nvmet_tcp: queue 8 unhandled state 5
[ 1298.889475] nvmet_tcp: queue 9 unhandled state 5

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5f9303232e86..b06a58eb02fc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1524,6 +1524,8 @@ static void nvmet_tcp_state_change(struct sock *sk)
 
 	switch (sk->sk_state) {
 	case TCP_FIN_WAIT1:
+	case TCP_FIN_WAIT2:
+	case TCP_LAST_ACK:
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSE:
 		/* FALLTHRU */
-- 
2.31.1



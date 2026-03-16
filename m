Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335BDF53D6D
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Io1wOnWbyy6FbSnvgXjKlJgQRm10c80hH1z01liIJ5c=; b=I43Go/UZbEEhaIUdmz0mrlkJAt
	85/yykG4wR3jmLWyw+umqsMmE++3K81cIRCbwdXQWNS2Di45vuHVTs6O6GFZNj4LeMll0dGOMuq+9
	GiTFZXZaVcVGV/zM9fEAZt8r3Dq8r8uqdaPccMkrn+6wGrpnwAZtHwnpLmEeioeaJqSHG50Spw4kA
	wmzHY/eA9pQOrE4C0GEMkwvE326d6f0LKAFRSeK09ZqVu6uDAa2OhR8o6VV5k0bRGv0wZGr3GyJq+
	c7HIZe1XEvay1T9YowsNDLzhjTHkIu9Dpacd+e3HGaAu1Znh8YnZzGBxUnctYbBlnJ5iU3J9KZdo8
	tB1lM6rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2B5F-00000004U8T-06BZ;
	Mon, 16 Mar 2026 16:46:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2B5B-00000004U86-0JTL
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 16:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773679579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Io1wOnWbyy6FbSnvgXjKlJgQRm10c80hH1z01liIJ5c=;
	b=NmGy0xgtOZnKhfZFsiZuvoEZYQ8fd8VLmm4X78AXaPpH0bKP1qgWSUgDBOPI/yrXVT5mqt
	eku4f0UGIZgBlhiuNvqjVSxff5wnNBSTaZEtGjdge3HiC1ejMubWw3bdVNUQBfgpGCyo7J
	dgCJ+kV5YtUuhr9PGxGDIl69m/dR5dM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ha-PMKltOx-iOueqD-MUEA-1; Mon,
 16 Mar 2026 12:44:47 -0400
X-MC-Unique: ha-PMKltOx-iOueqD-MUEA-1
X-Mimecast-MFC-AGG-ID: ha-PMKltOx-iOueqD-MUEA_1773679486
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D766719560BB;
	Mon, 16 Mar 2026 16:44:45 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.106])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5ABF11955F19;
	Mon, 16 Mar 2026 16:44:43 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	hare@suse.de,
	sagi@grimberg.me,
	mlombard@arkamax.eu
Subject: [PATCH] nvmet-tcp: handle TCP_CLOSING state in nvmet_tcp_state_change
Date: Mon, 16 Mar 2026 17:44:41 +0100
Message-ID: <20260316164441.180393-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fltj_Vw_dmFmKg9BBmlB127Ytl8JYiiTQjhLRP_xhdw_1773679486
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_094621_181178_39BD4BD7 
X-CRM114-Status: UNSURE (   8.75  )
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

When an NVMe/TCP connection shuts down, the underlying
TCP socket can enter the TCP_CLOSING state (state 11).
Currently, the nvmet_tcp_state_change() callback does not
explicitly handle this state, which results in harmless but
noisy kernel warnings:

nvmet_tcp: queue 2 unhandled state 11

Add TCP_CLOSING to the switch statement alongside TCP_FIN_WAIT2 and
TCP_LAST_ACK to silently ignore the state transition.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..ce497843b979 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1667,6 +1667,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
 	switch (sk->sk_state) {
 	case TCP_FIN_WAIT2:
 	case TCP_LAST_ACK:
+	case TCP_CLOSING:
 		break;
 	case TCP_FIN_WAIT1:
 	case TCP_CLOSE_WAIT:
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DF103E2EB
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IpaqiZ4L9JXG5f4a/kVTdcQOABN/kHMySR080bVzLjc=; b=UaxnMYBeCD/pkfIGIbivBL9O07
	OP+mS3Hy3iXLRerWKWfoG3XNaai5/XaC98tDKH2Lq/QsoJ985auj9wLgqmT8PG2ra9idgMeIna3+L
	+UDcfa/KxA9uFgrSDtLgDOyhrhSXA8pkjjF3CTfJg4dyUEWpc69L3qokXMO3m4gl6PrE1mNNzoLB7
	sWy+L+yI8IxwVwl8j9PTGSy+n8pCSHjWJxP6KI5J8zHI8LqHXRzwg5xurKCoqB3/AVeIvLOrNcd+V
	cQr9xRfFGIaQ8bPp6BBoII4r0fUbzWhckLD5ZpUBcBxk4UWMKlFAtgDlJIOAFRZpBRhU0SFy2qX7J
	dnWPH/Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gHv-0000000E8x0-34X9;
	Thu, 12 Mar 2026 13:41:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gHl-0000000E8wC-3zOa
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 13:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773322868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IpaqiZ4L9JXG5f4a/kVTdcQOABN/kHMySR080bVzLjc=;
	b=OUciPcmyyTHTbHU737T2t1kNvJM5wsr3DTTbRDd9VYkqLUyoAzPhcQLXiSdGce8qGdcPt4
	fX2vT4qemWwXE75sGMrIRCD3Y4q5Jaa9okU2oWXYyMe1EyScfnZCLfhkGnbGiiHEeFmixf
	ZL8hQR/aHwDokA1UswKFbOEu6zNvIfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-NCtw3L58NjGL6qeHSNxZFw-1; Thu,
 12 Mar 2026 09:41:05 -0400
X-MC-Unique: NCtw3L58NjGL6qeHSNxZFw-1
X-Mimecast-MFC-AGG-ID: NCtw3L58NjGL6qeHSNxZFw_1773322863
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3592A195609F;
	Thu, 12 Mar 2026 13:41:03 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67EE919540C5;
	Thu, 12 Mar 2026 13:40:59 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH V2 0/2] nvmet-tcp: fix receive path error handling and state machine
Date: Thu, 12 Mar 2026 14:40:55 +0100
Message-ID: <20260312134057.110274-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ARbcv20c0RhP-uwA_ia4fETnLZ8VoVw-k1o4ujaZFLM_1773322863
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_064110_056012_6694163F 
X-CRM114-Status: UNSURE (   9.31  )
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

Patch 1 fixes a potential issue where network data could be read into an
uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns void,
meaning callers are unaware if an out-of-bounds PDU length or offset triggers
an early return. Consequently, callers blindly overwrite the queue state to
NVMET_TCP_RECV_DATA. This patch modifies the function to return an error code,
shifting the handling responsibility to the callers to ensure proper socket
teardown.

Patch 2 cleans up redundant, localized calls to nvmet_tcp_fatal_error() scattered
across the receive path. It delegates the responsibility of executing the fatal
error function to the top-level caller by bubbling up the error codes.

V2: some cosmetic changes to Patch 1, no functional changes.

Maurizio Lombardi (2):
  nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
  nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()

 drivers/nvme/target/tcp.c | 73 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

-- 
2.53.0



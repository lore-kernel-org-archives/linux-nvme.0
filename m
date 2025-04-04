Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE82CC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X7nwN9U1t9Ihg8BK6+MCwqn5JrELeiYcm69hAEEU8Tc=; b=yL0if6t5XwWTN8vJj2YoFEuRhA
	OorSQbDM5frjp7Lr/vCa6Bgh/LeKeJ7dcKWmOLZrQ1e/Qw+jK2vWTOaDdbf/ow+XqbRFoDBuleKWs
	u4YRk588HakSqhHkmDt/Oqbds1KBsd02I+rhXBdFtGkCvh/wpUGebJGQ9kNgY6uuLgXmhc32FA+tV
	rHQxTfksWAHm5DwaUpr5Ifq1U6ugomFrQbcWaLK3iI0zKZlkjrHrh1cyB+5XQ5uL0Q5GAdhqLCwgW
	E0ItjYkA4kvHj4IRprr2t2KwY9k9OwE2cXjxOIhCpvykEalFHJUhUu6RQj4c0p37oE/Cfs41DhvrG
	78bFrY+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPQ-0000000B8Xc-0WTh;
	Fri, 04 Apr 2025 08:28:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPN-0000000B8WK-0nCf
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 08:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7nwN9U1t9Ihg8BK6+MCwqn5JrELeiYcm69hAEEU8Tc=;
	b=OgGTqnwMpKvHzU54yxyr2WMe8zWfDkYH4uHkoHOKrQCLY+d3JNJmuz1ZquMO2yGqO5Butn
	olPtzaWmSiA9pTo5HQhdY2UvwL94Pv8Iy0jYg6SyQTAlsLeuZqaRVQiWsOJUk6ul3P0f4x
	XQ1Tv0swbqlgyAeklZcD1+WxfQL+QO8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-bf7wQuBNOkiOHzKkdn1bDg-1; Fri,
 04 Apr 2025 04:28:10 -0400
X-MC-Unique: bf7wQuBNOkiOHzKkdn1bDg-1
X-Mimecast-MFC-AGG-ID: bf7wQuBNOkiOHzKkdn1bDg_1743755288
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978E9180882E;
	Fri,  4 Apr 2025 08:28:07 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFBF519560AD;
	Fri,  4 Apr 2025 08:28:03 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu,
	zhang.guanghui@cestc.cn,
	loberman@redhat.com
Subject: [PATCH V4 0/2] Fix race conditions in the nvme-tcp driver
Date: Fri,  4 Apr 2025 10:27:59 +0200
Message-ID: <20250404082801.1614252-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dWL0JnD0emhxcxlSpQVQ_gGyXbGoCH7oKLQ8VXn54Y8_1743755288
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_012813_292041_CB143A94 
X-CRM114-Status: UNSURE (   8.83  )
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

Patch 1 fixes a race condition when the sockets get closed
while the controller is transitioning from CONNECTING to LIVE state.

Patch 2 fixes a command double completion when a send operation
fails despite the fact that the command has been received by the target.


v4: added patch 2/2

v3: Do not check for -EPIPE, just call nvme_tcp_error_recovery()

v2: commit message: clarify where the error recovery is started


Maurizio Lombardi (2):
  nvme-tcp: Prevent infinite loop if socket closes during CONNECTING
    state
  nvme-tcp: do not fail the request if send fails

 drivers/nvme/host/tcp.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

-- 
2.43.5



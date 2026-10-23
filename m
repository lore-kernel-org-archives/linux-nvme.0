Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CC606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=al2bpAf1;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XQFEWevA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZWWYXX7fL6nQSfOVGxkAL56aJANp0WiYob2iEw7E9qs=; b=al2bpAf1y9k25X4WhxfDXPEOBl
	Q828iz53xIrNWuQgF+KWNBu9XjRvdgfV7ACSTo9myWVNN5gCvcjCKlbJUX/ZoI7SrhbRhrr9JXe6q
	Rp6MopvUFcHkvji7l16Uko/DvNpF6lTNYIhMw2UG+FKDOTKGJa8oO0lDDFnI+3RYXm27I+dZpmhQs
	/hkbf6uP0sAyK2mBz1u6JsXYnmD07UkX0jWG4NKUefZqBm+ZvZ7Ns60sJkWovBZ6QNEXyMpV4PTAP
	sjMoF9bjMHZ9wPbn7G6BAI55f78XlSwFudBzkXFYpdGwbzTbBx6oN/JR5pFLr7PSkt3Th9+106DKv
	SGGQ4TOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKBuc-0000000G58I-1ctt;
	Fri, 23 Oct 2026 09:50:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKBuV-0000000G55C-3iAl
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 09:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792749002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZWWYXX7fL6nQSfOVGxkAL56aJANp0WiYob2iEw7E9qs=;
	b=XQFEWevAkYVOd02KIph95tOqlklLG8Kej6iyP3ZqPoEyZL9wusTUW2c1vpoiW9Uz3VuVKY
	8LU3haGI/mUVGMdysVBj+vdfq4kQc/f/fG9vDZs/0nOfCva8YHwbJQqf/ZIYMLzxPTKIu+
	t/qiUFg53ZAstpLHil3mwRh1B32b00I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-zXdvZCqON5-3Mo9lJd023Q-1; Fri,
 23 Oct 2026 05:48:12 -0400
X-MC-Unique: zXdvZCqON5-3Mo9lJd023Q-1
X-Mimecast-MFC-AGG-ID: zXdvZCqON5-3Mo9lJd023Q_1792748891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501151800755;
	Fri, 23 Oct 2026 09:48:10 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C9E01800444;
	Fri, 23 Oct 2026 09:48:07 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	axboe@kernel.dk,
	hch@lst.de,
	dwagner@suse.de
Subject: [PATCH 0/2] Fix for nvme quirks module parameter
Date: Fri, 23 Oct 2026 11:48:04 +0200
Message-ID: <20261023094806.944563-1-mlombard@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IizPe2UxvNQJxc6cmIqQw0CPlzQvQRQzdCCWZEMcuIo_1792748891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_025004_039737_08A6FB05 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first patch fixes a boot hang when nvme-pci is built-in in the
kernel, reported by Ramon Jesus Miranda here:
https://lore.kernel.org/linux-nvme/20261018155426.1299676-1-ramonjesusmiranda@gmail.com/

The second patch increases the quirks parameter's buffer.

Maurizio Lombardi (2):
  nvme-pci: fix early boot hang with nvme.quirks= parameter
  nvme-pci: increase quirks_param buffer size to 256 bytes

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.56.0



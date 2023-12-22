Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D7AC41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v06VrrsfHctZds3fJG5t3pLadpYyzJd4a5KSqkYcs14=; b=n/vN8oWhuooaqtsHGpHiKFS/WG
	rXXW551Hnug+6cLB1DhrkaoKhL/MpWUO47YyMUIuxNhXk8BUOooLL2m5c+PIc2t21aChDdUyuhMJ+
	uXGzzPkXWkKbp8GgC1ME6RyTXMJSgdqyDpX4QYaAMmkx4gfujf3MefJdLGmMKhxQKPoMh4D4kIEzZ
	kYhyQ3LZYq2gifwy64dwqGyOAMqkHU+xmLWXVeZ3cuEdPLU84VmGUNJou+vO6+L6KLJGrsqCrbwo8
	ix9E/644sgzt905vYcJDE4hfKUVtOosYhp9RdXS1tVaoPlLBg4yR9gU1fxNt+oXoBDs96fBbG5f6y
	F4s6HcbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHn-006DZZ-1H;
	Fri, 22 Dec 2023 15:18:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHk-006DZ6-0I
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 15:18:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703258277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v06VrrsfHctZds3fJG5t3pLadpYyzJd4a5KSqkYcs14=;
	b=GWF9DmfBaOJCcqoQCBMu7w1TStVpVcPxbjTuG3eOyIlt+mwKALkiGaVt51g4Vf3kivNRl+
	b/3dyQ4q203XtUn+r7Jy7WiLGRdRBUfnUTD60ZEoRlaoTVpISe4gp1OsohkXKjfLqIf2YI
	3dVqx6qbXmzg3CNSe6LqVEEF+d0K7Ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-9Q4UXb9sOyKlMQLDLBIwKQ-1; Fri, 22 Dec 2023 10:17:54 -0500
X-MC-Unique: 9Q4UXb9sOyKlMQLDLBIwKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8F02185A780;
	Fri, 22 Dec 2023 15:17:53 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1AEC2166B31;
	Fri, 22 Dec 2023 15:17:51 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	hch@lst.de,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH V2 0/3] Fix some kernel panics due to the host sending invalid PDUs
Date: Fri, 22 Dec 2023 16:17:47 +0100
Message-Id: <20231222151750.655751-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_071800_201546_B503A013 
X-CRM114-Status: UNSURE (   8.52  )
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

I used the reproducer that was published here:
https://lore.kernel.org/linux-nvme/89a927a6-2baf-434a-b1d5-50fb99beca73@grimberg.me/T/#m57f25abc944dc706125fed02cb99d86b56c5d36e

I didn't get the same call trace, however.

V2: Be sure the DATAL field is consistent with the packet size.
    Add a third patch that cleans up the error code path.

Maurizio Lombardi (3):
  nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU
    length
  nvmet-tcp: fix a crash in nvmet_req_complete()
  nvmet-tcp: remove boilerplate code

 drivers/nvme/target/tcp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.39.3



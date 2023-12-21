Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31092C46CD8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0W9H3CSu/V4EJVxf+9jB2/BSehUkHDoS/9QBKlvK/cw=; b=bQe0q9sDDXRzMPC1D/nQev+beu
	ydhFUqfWRwBcAmZ1iqJ4kAUaUdUzbYgndUd6ofB40vt/YphtwV0BUXh0MWTxeu8KoMvdPPWG479PD
	avjCfdp4RKLfnO0Un5rEVfIL74rP/Q+H/mDI3p8Zbl1D5JFPcqV46dc0imw9qXXWVfe9yhneHixmZ
	wtcuX0AaCR8yGPLXOcJwUj9Y1qAu206409TfYSk+TIgsFo11erPOgbFnvSrttSR/kRkHCvW7Xo2+n
	ZuT0sSH+W1oUmfjmb1+nqdiX6V97oD6RhbzyhuTIaAsxUgnKF1EGrhJyyVk0/CrFJTIQ1FmQdjQSQ
	7+VF5gRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGLy1-003WV6-1e;
	Thu, 21 Dec 2023 16:32:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGLxy-003WRo-2J
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 16:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703176329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0W9H3CSu/V4EJVxf+9jB2/BSehUkHDoS/9QBKlvK/cw=;
	b=XzYYW1Pxu6kAWDCkChTYyl92uyTiP9JPDB51JsEmsNlFG69m4tC1JIQQDISGNEckQXjCub
	KRwInnExZt2c/nsVcWFh4Wixf41hoi37CiVjfXrDcg4VRp/w7C6x/x9PW3weg6x2WEJHHu
	w5Vqg4TKUeJkvfokpHarcgC6jvzvu1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-NGo22v9tNgegku9GEwiVww-1; Thu, 21 Dec 2023 11:31:58 -0500
X-MC-Unique: NGo22v9tNgegku9GEwiVww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A241A832D2C;
	Thu, 21 Dec 2023 16:31:57 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A01A52026D66;
	Thu, 21 Dec 2023 16:31:55 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	hch@lst.de,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH 0/2] Fix some kernel panics due to the host sending invalid PDUs
Date: Thu, 21 Dec 2023 17:31:52 +0100
Message-Id: <20231221163154.605669-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_083210_825933_5F35F174 
X-CRM114-Status: UNSURE (   7.81  )
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

Maurizio Lombardi (2):
  nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU
    length
  nvmet-tcp: fix a crash in nvmet_req_complete()

 drivers/nvme/target/tcp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.39.3



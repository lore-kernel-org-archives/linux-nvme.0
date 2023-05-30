Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A60C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pe8varXcsYJct+7Kt2+peE/f+2D7cGSjb5CW31FfVK4=; b=KZEICWTNCyVPuwePGy6l43/eSf
	oGOUPvEAOAFtCAM0/GM9r5lHvzx40Q1H+XHlT+f5NFvYu6zqj0Gc8aEXigbLDGPh73XeF9Z4SZkAz
	a18N6BE/qEOKBWX6EDzn38651+QW7McOyvqgdxDy/ujpP4ZAeIokPE2cvEyAqLo+Zx+WgGrKmgVjl
	+ORkCNVJSk9nUMyb0wLMNEuG5HlHS2u3CKc8fRbRvQOxMSQ4HZF822WmPXThiM9gR6zSJOQhf8luM
	TI94nu0K7jcpxOjESWRx9v8oBMc5v+6M4KKlCIBGPdGF+iAbJP8OSeBZFZbYq8ZfJz5oqUY6Nn407
	UHcOEqYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vtX-00DDz1-0i;
	Tue, 30 May 2023 09:43:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vtS-00DDy3-27
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 09:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685439832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pe8varXcsYJct+7Kt2+peE/f+2D7cGSjb5CW31FfVK4=;
	b=i4kxihhlAD5wh39o4Au++6FsKWpEAtBVpgvIGDqdlGrM0wTWdCNM3nFpRRhXwJvEiXJleH
	vSvIdmtDeld/rSziicuo3gkeMuyGfxuqUEg3EHISW34t6wU5QfwxDdeElIoVmz/AC893/t
	ymEsE15h2EQaQdQFv6BgZgLNVe+T0Ec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-WnO3XKQtNHCTffxVNnokPw-1; Tue, 30 May 2023 05:43:50 -0400
X-MC-Unique: WnO3XKQtNHCTffxVNnokPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E96E2A59566;
	Tue, 30 May 2023 09:43:50 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBA740CFD08;
	Tue, 30 May 2023 09:43:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: add nvme_delete_dead_ctrl for avoiding io deadlock
Date: Tue, 30 May 2023 17:43:20 +0800
Message-Id: <20230530094322.258090-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_024354_787765_C6001EB5 
X-CRM114-Status: GOOD (  11.75  )
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

Hello,

The 1st patch adds nvme_delete_dead_ctrl().

The 2nd patch calls it after reconnection fails in tcp/rdma driver, and
fixes one io dead lock.

Ming Lei (2):
  nvme: add API of nvme_delete_dead_ctrl
  nvme: rdma/tcp: call nvme_delete_dead_ctrl for handling reconnect
    failure

 drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.40.1



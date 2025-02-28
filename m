Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACCC19F32
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mb26mU38SKiwkYcPSoVmGFcFJL8AA1v1BtKLUtjEM30=; b=mDGjEikb5nsNnofpdsOOAWjAQx
	pHevfNSk4vLf2Wa0XDPVhXbZcL+39Wnoj2JNToDO9h5KMFrgSPHvt2UuCfQ92CA+MAQ3h3Hgdn4dX
	AWZlUd26wPryMwXT2+CoRnuFQUXY9t7B8gKaWRgg/z5Q2zknZntbodOr6U8cbIcBr8mxVHEDsIgvo
	sBf1JuBRuiGf3JqGB/6uTHvHPuHuLVtTCIIQVI73pGP8UsrYFHeN/krb+T85pI0YchB6Mqccl9LyR
	K074cXrTNjh7tg5wywnY/YVaN6xqVD22mhyZFw003GC1AT0DRVwdR2box5ODFb1bJCpMLvPFDqHN+
	BT/KdaQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0j-00000009ZOS-3hoc;
	Fri, 28 Feb 2025 03:26:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0h-00000009ZNf-3T2d
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 03:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mb26mU38SKiwkYcPSoVmGFcFJL8AA1v1BtKLUtjEM30=;
	b=iJH435eZgUhu3deJZOGXOBxYcQ57ShXvuy/AKhP2iC2ICMM9JUgZLhuyPiozX3zGmG5OGF
	VXxl+2fQhPW61nufBSuTWgnqVj2L41kCdfh5tFKQKI1laeL+bgXSoYng9ZcKAHn/W7N9Q6
	i8d20Orsw6H9kfJ7ptoPWN9Ntp0Pymo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-JNoKCRgCN9m92Y-vFrUZXA-1; Thu,
 27 Feb 2025 22:25:52 -0500
X-MC-Unique: JNoKCRgCN9m92Y-vFrUZXA-1
X-Mimecast-MFC-AGG-ID: JNoKCRgCN9m92Y-vFrUZXA_1740713151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79CF41800876;
	Fri, 28 Feb 2025 03:25:50 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 059C8180098C;
	Fri, 28 Feb 2025 03:25:47 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH 0/4] nvme: make core.nvme_multipath configurable   
Date: Thu, 27 Feb 2025 22:25:37 -0500
Message-ID: <20250228032541.369804-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_192559_945617_222021BE 
X-CRM114-Status: UNSURE (   8.80  )
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

These patches propose an alternative to outright removing the multipath
module parameter. Rather than deleting this module parameter we control
its appearance with a new Kconfig option named NVME_MULTIPATH_PARAM

Note that the default kernel config settings produce a kernel
with no change in functionality. By default both NVME_MULTIPATH
and NVME_MULTIPATH_PARAM are enabled and there are no user visable
changes.

To remove the core.nvme_multipath parameter simply compile with
NVME_MULTIPATH_PARAM=n.

Hopefully this compromise gives everyone what they want.

Closes: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/

John Meneghini (4):
  nvme-multipath: change the NVME_MULTIPATH config option
  nvme-multipath: add the NVME_MULTIPATH_PARAM config option
  nvme: update the multipath warning in nvme_init_ns_head
  nvme: add mulitipath warning to nvme_alloc_ns

 drivers/nvme/host/Kconfig     | 28 ++++++++++++++++++++++++----
 drivers/nvme/host/core.c      | 19 ++++++++++++++++++-
 drivers/nvme/host/multipath.c |  3 ++-
 3 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.48.1



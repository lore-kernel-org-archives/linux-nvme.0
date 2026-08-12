Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C7FC5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lm41zW9D1y3E4PwZafbwiXqMQCx3MNP6JwnBey25G+k=; b=JYYykLZLLp8sJz88IeurUwWbCG
	0583GzKN0a8Z5R+S0W+Tsw/AM2g4Ras4ejkZk0Isjy0Oq18thTTBtmO7A+Q7HwOM2RMM3Zaf9gZQN
	CaUCpl6REgorOUZ5F4zMLty3EXU5BKQuRNKFz7ZHDN6xDS4TIJTjlmW9W6XurUnjnYg/WgJ7OrsUw
	LWxXICt0jhdhX8BJfZBss4iCkCJuYo7dRP0KNLPfB3pUBHJcICQpTnkwuFWHQRd1lw6HQ0vbdmWVy
	E71hshYd4I/peHVJWZsilHpOEsgb9tj7mReKcjjFmpbbKD4U63g3aQc2K3PxpDNZanNCDIfUCbFvY
	ibvIQHIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD11-0000000GidL-0fUk;
	Wed, 12 Aug 2026 17:45:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD0w-0000000Gibq-2tjx
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 17:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786556714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lm41zW9D1y3E4PwZafbwiXqMQCx3MNP6JwnBey25G+k=;
	b=SHMlOtMv0tUVhTC9wj2WoV/iBkJkRANrsCexc+UwSdaKIeduw+KMsOZzsHwfhvaxiDEtQI
	utkOSIkesI3ZAJThKMDM56T71hWN/ABQXRzzcleRVP8s3+RtUT5NG9iiwSuf4y4RKIlmGL
	9V+6/2nvAaE60h4Zn3Cu4uVV5WBBWjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-6E8z-0dTMc2bHr-BnevhVw-1; Wed,
 12 Aug 2026 13:45:10 -0400
X-MC-Unique: 6E8z-0dTMc2bHr-BnevhVw-1
X-Mimecast-MFC-AGG-ID: 6E8z-0dTMc2bHr-BnevhVw_1786556709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E19418009C8;
	Wed, 12 Aug 2026 17:45:08 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 469FB195DF98;
	Wed, 12 Aug 2026 17:45:06 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH blktests 0/2] Test multipath and marginal ports
Date: Wed, 12 Aug 2026 13:45:01 -0400
Message-ID: <20260812174503.3705830-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 9xdZFwaLyL9p9dTe2SVPnXZJf5NZBmcK9GlJdcuWyVM_1786556709
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_104519_664277_EFAF76E0 
X-CRM114-Status: UNSURE (   7.32  )
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

Tests for the upcoming nvme-fc: FPIN link integrity handling set.
It tests for various multipath and marginal port
scenarios, while confirming the port usage and state. The test is
intended to emulate receiving an FPIN event in a multipath environment.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
Link: https://github.com/linux-blktests/blktests/pull/264

Jesse Taube (2):
  nvme: Add _setup_nvmet_port_marginal
  nvme/070: Test multipath and marginal ports

 common/nvme        |  30 +++
 tests/nvme/070     | 521 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  43 ++++
 3 files changed, 594 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0



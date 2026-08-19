Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA27C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DVprECuFqi5/25eTasTEjoxbRyEm7VP4LBrO4h9TFwY=; b=2bclrYskoZvnv7uKkp4240h8lH
	R63TbzBpzUiHr5jlGisWHppqDUIgnavfPWAA//M9Gi2650MF373aTnyyBKFwBuRFNfRQhQi1FpvOZ
	0bocLmus2tZClhnhXUudrKAxot96L5Q2z+93vOZs99sBKphyi7SoqWcMvBLIuZXNIJ43VUb0rI1qE
	qgiYbG6TLFK5qDgWkD/r3MZwnw66O4N7myNmJpJ3O9j+3nccM4/rdqxvqtm1FhR1+nkvyPX/XTDKa
	dQXbIF5JeFgkfxabQjuVLb1fSdZ1DaaF9Dr+OEoAQ0XY3HZFs0Ko26+SDPPDsbTQjTy14GTfxL7RI
	KoiXoHSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwmWg-0000000AUnb-2KrW;
	Wed, 19 Aug 2026 20:04:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwmWd-0000000AUmc-31vo
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 20:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787169876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVprECuFqi5/25eTasTEjoxbRyEm7VP4LBrO4h9TFwY=;
	b=W1w5oXXOebs6JRCK6K0xibu7g1mzE04RGAOuv/BwICt4hXShJPRqz0of4s3OuYaWTCK0l6
	AJP1RIAGF73Pwm8lxlEuL4/Io3sHPSXU13QpAqTSDa72v4tsGczyLZ/JZ/lSafP/8jWqt2
	GIOHX+URnjN/438A+BPmsOC9jtbaTxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-K4lxCDZvMwiK5YpEUdT2bw-1; Wed,
 19 Aug 2026 16:04:32 -0400
X-MC-Unique: K4lxCDZvMwiK5YpEUdT2bw-1
X-Mimecast-MFC-AGG-ID: K4lxCDZvMwiK5YpEUdT2bw_1787169870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5992B180035C;
	Wed, 19 Aug 2026 20:04:29 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8AF2180049F;
	Wed, 19 Aug 2026 20:04:27 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH v2 0/2] Test multipath and marginal ports
Date: Wed, 19 Aug 2026 16:04:23 -0400
Message-ID: <20260819200425.194743-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MIVr0L6eLrpX796O8YEph_2sEave1PdZTwTeWI7FKY0_1787169870
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_130439_846530_D5A7EB32 
X-CRM114-Status: UNSURE (   8.09  )
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

 common/nvme        |  31 +++
 tests/nvme/070     | 613 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  43 ++++
 3 files changed, 687 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0



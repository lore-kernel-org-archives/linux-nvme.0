Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE7C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:01:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6282082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ocSkhaxP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XjHH6Nqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6282082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PreJmagkVjYcJDZhF9No8PwZ3D9qqTri7x7TygjPBrY=; b=ocSkhaxPfsjBmo
	af7ER7v4Y/AWZSaqy7n9iLEpXEdGwEHtDkC5Mcf0ZUgDbNJMdTFzXpgNDj9P1CDkl6BHegnybwODT
	iIiarcqvyJfocHJRsPH4C7erup+GGssqD/Zu9kiA8IYMiPdNNPQ4uNTGxlOqaLjMNtqHP1k3xN6W4
	XFSJtJBCl5W+YzgedgX41zXlXQyTX3wNaFYZKLr+1XQajFJ3FxuBdY0l7LINuHG3/60rRwKZbLPVf
	v6OA2frgBpi2ZsohtnAl2JYAcG0DORUtlRinEW4gZ6xI3uIm4wLq7v05DtOXynn+6kn4ULqmAHd9I
	02UnLPHBzU2cdUg+lG1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izA0P-0002gI-Jc; Wed, 05 Feb 2020 02:01:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izA0N-0002g1-Cw
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 02:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580868087; x=1612404087;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wYb2S2L8yaC7M1Lu5Zgxitm/3T7jX3UQfyM+Fb3SEUs=;
 b=XjHH6Nqvvtp8Jf7qqPJMKuojhw8Jb9V3pcPf7aNRzkxAfyKpbNXiq3TW
 7Grn4mRApFXQy8B/G/n9A68s7HyAj8FGPpShcH7InPEx30prU3BWyYUh2
 XOTmQLmsc+7ridvKNfPDZCl1xSdQat+zZ7grDH7mrL2ZLHxPIfdTWWcty
 4R5B1Q7n2XTW0wfX9u/fv9uDnZTp1Vb7jT59IpdZ+W0g2AW1X1mB9Twzr
 7I/oG65wOYIH9sZEDh3fMTPMPjZ0ELUmd8u7L1gYGFaD0aCVzPRgsQISs
 Y4MtMJbGqpPAOG0KaDj59wn/MatrO2dFcOCbfEbBeAUwpG4DP6p87C+8j Q==;
IronPort-SDR: IoXWUkhb8Bf2TQV4uPKdOQl1nEKmpS/TncUDwVyeVRh+TSaOOtaSv3/8FNR3jkF93u5oSKn2oI
 ro5a7HywiI+eTbKqkN9A1Tx2TvI2LmcsmulkH1QcGDcyWsvbmWluI2m1ibnQZ0Fb973HdWMRdp
 QYB+VdeYiMZsqeY8LlPAjwl47/N83rWZ953mgoz27tlzBkOoRK7sv0abYr0bQTrs+7EkPPbJlb
 Fa13SFzaGb1/IyAo4iVJmcCWNk2bpMtgVQm+6aUotXhPLdMQROXGnoSraJOb9jDT87LSjrm1Ea
 xOM=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="129112433"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 10:01:26 +0800
IronPort-SDR: 0dAApEP7fLGsTq72DWWYv2EjioFsl/OKXpE75p3FGVUBiUImexsuxT55rwWbxRxYGaRJPgo0P/
 PM5c1Wy7QzQp/vGX3K8TrGLkjlTiZIe6IqXolXU1FUrV/nbwGcxyQOMgwk6Mmz2IjGBvX+jnzp
 bewPruqZXRc5V/CHN2V8+icAzjllMsndHorUlyscJzkHho0OGvRwS4r8mTX9g6mhhwuVh2gqMT
 2TJbLb1IKypNo+m/zg3OoNJAXHyrCs2ci52q9RYWoruabt2GnuDZUkyYpq/SBnY5z2XyQNAuV2
 5zu8HcNqil+aZzf7vZPKOWBT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:54:28 -0800
IronPort-SDR: 4VM2k9zwupC9D5gk7IJDfYfo/G0ZZRDm3OU+8fdzrT+GjwUCCumc6tYolCANbdDIJoLyIDa3F7
 cqwIetevJRVJDwwSFXieSYR2gtXtKtoQc/1zozZAeVgdmEtOcBvMB4rc7tRvxxyLcaY4e3bZl5
 av122/GlYElJoZY42Xou0WdO7MjcpmLezp606tM6XyDwyNMH0LWqps2nauhGaPCfJBK0lFUruN
 ft4FNsIsKVYDCf8ZST+T+KpUaColDi9BI/lCMY5bOlit9HnOcUKvAB6D0VQkbOykZpCyzlQZZb
 KkU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 18:01:25 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: bdev-ns buffered-io and file-ns write-through
Date: Tue,  4 Feb 2020 18:01:18 -0800
Message-Id: <20200205020120.22210-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_180127_473539_1584E62A 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

These are last two patches which are based on the discussion with Mark
(CCd here) along with cntlid and mode.

This patch series adds a support for block device namespace to use
cache and file-backed namespace to use cache in write-through.

Please have a look at the respective commit logs for more details.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: allow block device to use buffered I/O
  nvmet: add file-backed ns write-through support

 drivers/nvme/target/configfs.c    | 72 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  7 ++-
 drivers/nvme/target/io-cmd-bdev.c |  3 ++
 drivers/nvme/target/io-cmd-file.c | 39 ++++++++++++-----
 drivers/nvme/target/nvmet.h       | 15 +++++++
 5 files changed, 125 insertions(+), 11 deletions(-)

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

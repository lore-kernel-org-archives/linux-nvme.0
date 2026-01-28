Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE1D3569E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kzf+X0aMeqFwMUti4RFjsg48EKFkh9MdoSGjttK3JhE=; b=sHrd7mzhO6HmHsGXeZQRvrTO2o
	61B3YHxVXtqywT72ags0GaWNvK9ZnX9Zr1UFI1RovV66VTfjpRj0WPCQQTpMGd61x16KNlHlE38jB
	nQasU+GQGyswS80oJ8ykccZ7cGT3KruKiv5gnAEDrUR/8sRBgwd3vx3qcUrD2OlXe1nF55K7/kuFW
	TfQbaxTZGeaos8Br0U+S6Hn7O9vbiynvNPCsQrYPmS3lK/LbUeiwKrcczYe1U2dXEjb9h8QOxGM4A
	dmhtkU6uPgdnrALO/rRoDkL1jjWMelmkYpPbVYDMAO4mYQrQ+c8vzM4ymoozDZFs5phhG8U8m6um8
	qhdqwW7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl2t7-0000000Fq10-2bur;
	Wed, 28 Jan 2026 10:35:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl2t5-0000000Fpzs-1y4b
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 10:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769596501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kzf+X0aMeqFwMUti4RFjsg48EKFkh9MdoSGjttK3JhE=;
	b=heCTFlHEGSFO6bAKyplQQ6k3GcTqKU/C5o+VlXQ565mljYcUEL+/Zg1dvMI1Ovbv0ZlKCH
	OrxtqVIZJ8O90y5xnYjNe6TcErwXZloq1ZFOTfGHoJEn9EHLXeJ8mviobI/z5KTqIGV5xn
	LYlS4WheF9V0pz+xnZUJFKGugZmPlqw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-ERiuMRoWMkiOUE3Iy_nISg-1; Wed,
 28 Jan 2026 05:33:26 -0500
X-MC-Unique: ERiuMRoWMkiOUE3Iy_nISg-1
X-Mimecast-MFC-AGG-ID: ERiuMRoWMkiOUE3Iy_nISg_1769596404
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C81B7180034D;
	Wed, 28 Jan 2026 10:33:23 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.140])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51B671956095;
	Wed, 28 Jan 2026 10:33:20 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH 0/1] Enable/Disable NVMe quirks via module parameter
Date: Wed, 28 Jan 2026 11:33:17 +0100
Message-ID: <20260128103318.76842-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nVOzWUNdSqNL3O5rLD4KxSvnHzxyqhwhozhk2DdCQ10_1769596404
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_023503_598988_398B69AD 
X-CRM114-Status: UNSURE (   8.86  )
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

Recently, some of our customers were very vocal about wanting an
easy way to enable or disable specific nvme quirks.

I recall that during the ALPSS conference this topic has been briefly
discussed, and it was proposed to use the generic PCI sysfs "new_id" entry
to manipulate the quirks.

However, in some cases a quirk may prevent the system from properly booting,
the kernel may hang or fail to mount the root
filesystem before the system reaches a state where new_id can be written,
this makes this solution not exactly user-friendly for end users.

In particular, boot-time hangs have been reported involving the
bogus_nid quirk.

Therefore, I have been asked to re-propose this module parameter approach
with a few modifications suggested by Daniel Wagner.


# dmesg | grep nvme
[    0.000000] Command line: root=/dev/vda1 console=ttyS0,115200n8 nvme.quirks=1b36:0010:^bogus_nxid
[    6.732692] nvme: unrecognized quirk bogus_nxid

# cat /sys/devices/pci0000:00/0000:00:05.0/nvme/nvme1/quirks
bogus_nid
                                                                                                                                                                                                                         
# dmesg | grep nvme
[    0.000000] Command line: root=/dev/vda1 console=ttyS0,115200n8 nvme.quirks=1b36:0010:^bogus_nid,no_apst
                                                                                                                                                                                                                         
# cat /sys/devices/pci0000:00/0000:00:05.0/nvme/nvme0/quirks                                                                                                                                             
no_apst

Maurizio Lombardi (1):
  nvme: add support for dynamic quirk configuration via module parameter

 .../admin-guide/kernel-parameters.txt         |  13 ++
 drivers/nvme/host/pci.c                       | 154 ++++++++++++++++++
 2 files changed, 167 insertions(+)

-- 
2.52.0



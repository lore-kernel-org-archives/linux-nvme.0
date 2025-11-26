Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FFD10F58
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DoS6Oj4etNgwsMajVTmJIqYHnPKCCag9vshgTAQJXtY=; b=BjthbfAuHbRJ752J09OU26N8OD
	puv5DnBhIaUg2d37zelm3SvPGbksCFx1bHwX6Ty3i4oG0L2bbChQ2QaJobqTrwmvBKYT1dbmVgb55
	ztTgAuDSSzC0hf3rcJmIJx4ujvEqlYNfk86kLQ7Kkt7DJjirI2MDwO8WLSFmstaLXJ1I7BnueNyXe
	Erg3551iYovJTCZ1eNYMCFDW5phUBG0D9WjJjykw//fPH2yaRH8GYRQZAHZYlR+nm2gPWoM6+XPxC
	ZU7PYTpSqscgBw5ijGHAKf6V1wo4tsvXRMpsFE+IhwbMZYg7WeIKFeSnNVVfrYA2YAPO8qJwqOk50
	hRm6RRnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWZ-0000000FJfX-0HCy;
	Wed, 26 Nov 2025 16:37:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWU-0000000FJez-0csB
	for linux-nvme@bombadil.infradead.org;
	Wed, 26 Nov 2025 16:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Content-Type:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DoS6Oj4etNgwsMajVTmJIqYHnPKCCag9vshgTAQJXtY=; b=DuJi0fm1A+VTkoUkXaM/Y7sW9M
	GLpmZ9fbfCMnOGpFSvTy+gGdcvd6BNsn4UZ4aCnNRG3CZ/9w4OmOjk1sYlbO70lY/KUcxa+oAVqKp
	mqv3yg4d+dYrDytnhImgehVQ4lqSI5oLXbbfyaf3GdT3y+EQjexJHWARxXh6+qz8sgwtbSVOhEd7k
	BcYD0C6XSjrdaOFDBQnz0m01O/ArvYIfVO+wXrWoZfnHYMXe0iUuJYtjhtFCAWLMzpegx9GKMabWD
	IH6sljLob80HfxwALegqKGplqrzRZBO2IY1AxfSPxVK/ah8z6j2bbwxSr/wCTvLTrq8z/OQACsMvz
	VGmxqIug==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOHeq-00000008PUd-2qsO
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 15:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764175056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DoS6Oj4etNgwsMajVTmJIqYHnPKCCag9vshgTAQJXtY=;
	b=ZDt2jAvBhiSKlqygNkSclDv7ZAPyeFZ4Yj4FApAV41VnufAnUdeuQnDVmUKSVGpdifdKDj
	gUk43NQbyHLZqdTqUsaX+F73+wP7Cjvaa/1p0wZfApuXOEPVbaj+dVLBJbTGQdkPAtbUzU
	2J9zZbamXqBJO0YcAwotpdhtiaAhrBs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764175056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DoS6Oj4etNgwsMajVTmJIqYHnPKCCag9vshgTAQJXtY=;
	b=ZDt2jAvBhiSKlqygNkSclDv7ZAPyeFZ4Yj4FApAV41VnufAnUdeuQnDVmUKSVGpdifdKDj
	gUk43NQbyHLZqdTqUsaX+F73+wP7Cjvaa/1p0wZfApuXOEPVbaj+dVLBJbTGQdkPAtbUzU
	2J9zZbamXqBJO0YcAwotpdhtiaAhrBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-nquCTKv3Ox2_N7An0300BA-1; Wed,
 26 Nov 2025 11:36:06 -0500
X-MC-Unique: nquCTKv3Ox2_N7An0300BA-1
X-Mimecast-MFC-AGG-ID: nquCTKv3Ox2_N7An0300BA_1764174964
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E366B18001FE;
	Wed, 26 Nov 2025 16:36:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9D3A18002A6;
	Wed, 26 Nov 2025 16:36:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/4] block: add IOC_PR_READ_KEYS and IOC_PR_READ_RESERVATION ioctls
Date: Wed, 26 Nov 2025 11:35:56 -0500
Message-ID: <20251126163600.583036-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_154216_900857_F5441628 
X-CRM114-Status: GOOD (  11.40  )
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

This series exposes struct pr_ops pr_read_keys() and pr_read_reservations() to
userspace as ioctls, making it possible to list registered reservation keys and
report the current reservation on a block device.

The new ioctls are needed by applications or cluster managers that rely on
inspecting the PR state. This is something that has been possible with SCSI-
and NVME-specific commands but not with the PR ioctls. I hope to move QEMU from
SG_IO to PR ioctls so that NVMe host block devices can be supported alongside
SCSI devices without protocol-specific commands.

These ioctls will also make troubleshooting possible with the blkpr(8)
util-linux tool, for which I have prepared a separate patch series.

Stefan Hajnoczi (4):
  scsi: sd: reject invalid pr_read_keys() num_keys values
  nvme: reject invalid pr_read_keys() num_keys values
  block: add IOC_PR_READ_KEYS ioctl
  block: add IOC_PR_READ_RESERVATION ioctl

 include/uapi/linux/pr.h | 14 ++++++++
 block/ioctl.c           | 79 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pr.c  |  5 +++
 drivers/scsi/sd.c       | 11 +++++-
 4 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.52.0



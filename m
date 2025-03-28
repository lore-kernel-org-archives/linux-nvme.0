Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA15C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vvXyo5yVP5Xrx3iYOp2pi8SOMma5L38fETbNZf6AtZQ=; b=Q0uK6lfLHqRnyJE5hfNPEpyVYf
	4a4QpmEWwkOs+WCI+iPBbIM2PeUHxQa2B5X5JV4bYFbHltywXt2nmWz1bZzdjuICjdLQnkB3zYlUi
	H/igiPMMwqgp/8ofuvTar02hGAd0KUFh6oRnhzqrlOnoqCitHFvH639W4flEjndyROhS359jb1zMP
	1pKK5b/b7wYZyN7W1kqiAWv2p1SUvHiOFRh4w5+bf0gOuF8FbUGAs4LKAwWV2TMZU0A6bDw6jUgCx
	ziWm4G1f5LzAUV1bnwUqdVYZrPK/Wa9YwYJik+yP2txX4TDIb8PH9E4ieDjJNToibfymJRnjiH7kf
	7/eLhnqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFZG-0000000EBnl-2pkR;
	Fri, 28 Mar 2025 19:40:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXS-0000000EBPC-330a
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvXyo5yVP5Xrx3iYOp2pi8SOMma5L38fETbNZf6AtZQ=;
	b=AfiE6xfv0W1Kv0yP6xmnITpH+3GvgawUbiuHKjyc7d3DkXdFJrHkvHAmq6omFz2DrMjzvs
	TJMm8aT/rQqKWcAKFA+EZ85IUdcZRmEtNoQit5zTp8MnuaXgVjzHYTOinIi9T3gDM/TQSA
	l0aZNd4cRNSkHd1A4Weu9UFJpxTwOJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-FbzvUHEANnKOGAf6mTawBA-1; Fri,
 28 Mar 2025 15:38:44 -0400
X-MC-Unique: FbzvUHEANnKOGAf6mTawBA-1
X-Mimecast-MFC-AGG-ID: FbzvUHEANnKOGAf6mTawBA_1743190723
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24BC8180899B;
	Fri, 28 Mar 2025 19:38:43 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.17.17.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A8DB1828A84;
	Fri, 28 Mar 2025 19:38:41 +0000 (UTC)
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
Subject: [PATCH v3 5/5] nvme: add NVME_ENABLE_MULTIPATH_PARAM for powerpc skiroot
Date: Fri, 28 Mar 2025 15:38:26 -0400
Message-ID: <20250328193826.356257-6-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-1-jmeneghi@redhat.com>
References: <20250328193826.356257-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_123846_831207_E5C7FA20 
X-CRM114-Status: UNSURE (   9.85  )
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

The add the new CONFIG_NVME_ENABLE_MULTIPATH_PARAM
to ensure there is no change in behavior when
CONFIG_NVME_MULTIPATH is true with skiroot_defconfig.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 arch/powerpc/configs/skiroot_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 9d44e6630908..85d58429a244 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -77,6 +77,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_NVME=m
 CONFIG_NVME_MULTIPATH=y
+CONFIG_NVME_ENABLE_MULTIPATH_PARAM=y
 CONFIG_EEPROM_AT24=m
 # CONFIG_CXL is not set
 # CONFIG_OCXL is not set
-- 
2.48.1



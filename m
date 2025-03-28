Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA49C36010
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ordwZdOD6eoKaKm56NyG4R5Cz/wGSJSQBSEaXU1EgwE=; b=coPo5kh8Jx1+LVUiRIr0ZFW/iR
	q5rlp6eWTcxxIijQ5XlKXs4F/53DwNkyJ+q3TQKMFx6xpQujkL+Us1lGCnYT8G7v3oTunx4uuxkax
	XJqF/Zen3wxJ4Gwvvd1V32+xlaYVaa9moFwnNBDPYKDbsk+kaTeCo3NUCn4XXj5ZcnLrUEB+JONOx
	8Q4g8izc0BFsG9MfPZb6ONXViG13Dx1Cv65YaqakBt+vNzm5TtUaURp0Czjkzh7nCo5AHIpZzb0Dl
	XMFJt1YnEMsv/juwfEf5OEb3YgizZ2HAu7/4HnkFNSsu6JYKwmeUNEi4BlkwgJG8dH5wfe7ZNQZHf
	q7+FRGwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFZF-0000000EBnO-49dm;
	Fri, 28 Mar 2025 19:40:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXW-0000000EBQq-24lB
	for linux-nvme@bombadil.infradead.org;
	Fri, 28 Mar 2025 19:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ordwZdOD6eoKaKm56NyG4R5Cz/wGSJSQBSEaXU1EgwE=; b=OeMd3uKuGurx1oy7kLm9FO7+xn
	gOJ9ipsTB0bAxKieNEGuqQ2D2wN8NbCwjGoPA+MxwKIW28aDUzVwTCW6I/mX4bW/AMer1h9Fici15
	jIRy+FCyXhqUVZmNskSf2C5bTC/am690zSgr2KxHfY1ttuOcZwVpJ/4fKolRg+Tb808sv3+wS5mqO
	fnL+c3nBsqLF0YTvW22yYMEhBZHATSsh0PdL1J0ZJwzB3y6XFNaW2eck+8ywtXs5cQmZzisrmtPB7
	x/LmEeeqUbeYFhU32hHJzOKp0UqhRNFOcRliV7bv0cKoCRqXJrItSZD+NzbCyIpKzlEbVo3/wvG4Y
	iCOQTAFw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXS-00000006E4n-1OBK
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ordwZdOD6eoKaKm56NyG4R5Cz/wGSJSQBSEaXU1EgwE=;
	b=dItCEMubTQvRuR8GzqYP7xCyZwCwaufRrmT1ZW6/sKi0+H1ltbFe8KAgX5cxoZ20P+LEoy
	we/5RewyZG48ZzQz8q4NuZMAnHBPApXN5auY/prhDbobbc+IdF9agADqTt47ZYJmm5eepl
	CWEOmQUlGSpaO7uuY7A2r5VFZOwQd0E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ordwZdOD6eoKaKm56NyG4R5Cz/wGSJSQBSEaXU1EgwE=;
	b=dItCEMubTQvRuR8GzqYP7xCyZwCwaufRrmT1ZW6/sKi0+H1ltbFe8KAgX5cxoZ20P+LEoy
	we/5RewyZG48ZzQz8q4NuZMAnHBPApXN5auY/prhDbobbc+IdF9agADqTt47ZYJmm5eepl
	CWEOmQUlGSpaO7uuY7A2r5VFZOwQd0E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-KzEFURfYPiK_LTWWhYBp9A-1; Fri,
 28 Mar 2025 15:38:42 -0400
X-MC-Unique: KzEFURfYPiK_LTWWhYBp9A-1
X-Mimecast-MFC-AGG-ID: KzEFURfYPiK_LTWWhYBp9A_1743190721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0FCD180025F;
	Fri, 28 Mar 2025 19:38:40 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.17.17.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF3F11828A92;
	Fri, 28 Mar 2025 19:38:38 +0000 (UTC)
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
Subject: [PATCH v3 4/5] nvme: add NVME_ENABLE_MULTIPATH_PARAM for loongarch
Date: Fri, 28 Mar 2025 15:38:25 -0400
Message-ID: <20250328193826.356257-5-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-1-jmeneghi@redhat.com>
References: <20250328193826.356257-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_193846_558090_25746028 
X-CRM114-Status: UNSURE (   8.87  )
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

The add the new CONFIG_NVME_ENABLE_MULTIPATH_PARAM to ensure there is no
change in behavior when CONFIG_NVME_MULTIPATH is true with loongson3
configs.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 73c77500ac46..1ba9ef835fd4 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -449,6 +449,7 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_RBD=m
 CONFIG_BLK_DEV_NVME=y
 CONFIG_NVME_MULTIPATH=y
+CONFIG_NVME_ENABLE_MULTIPATH_PARAM=y
 CONFIG_NVME_RDMA=m
 CONFIG_NVME_FC=m
 CONFIG_NVME_TCP=m
-- 
2.48.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC040C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Pk4SaNw6B9FR8NZRTRXnpof8q9+mgwthXuvYGPL0lJ0=; b=1xV/s045zT40d/zZH6f8gmW4y5
	C4WLMtBVpNoP7Fchu0H9QQRtQ/fke2W0yYFQ6iAicT73/HLUdzp36it2RHBrXwJIrALNo81j9fBD1
	bDQBefW5SPat4Y5l/JXsNGNymiJs46SqY+fuZPR2OreAnYHmCIPvdWP46sTAVP5sc7Zg1SGTCwsSg
	+53fmnDOX0ZKI8IRWx6oo9xlR9jCGxMKrGlniLqDBtUjNCRo/mYZnolqOFeNuOrIf9tOkTwzXWzG8
	WMo7/VQ0jkMfqu5VFXSKIh/cubWnh8tiT0aCi3/yUAir/iU8s1DFqYacTFsoqXm9aXv3qWqOuO8gw
	NSr6a71w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRNY-00000004Q9e-3PzK;
	Fri, 09 May 2025 17:19:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPTi-000000043XE-2kuK
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pk4SaNw6B9FR8NZRTRXnpof8q9+mgwthXuvYGPL0lJ0=;
	b=MWQnvHZGvQikigHKArrmAWzkVgCvdja9lXth5FlaMY/nq68Cbegh4uyO2TyMtetjLTd1Ai
	Rr/36rjs/Qu1Yo0xj0Dpsfs2Vq7jpXx5mGSmEfsW7tHDUhQjAUI/3LUWlZaA1ShDlH8WtY
	pMjbR7T7VxX0/ijGdSXh2Zv/uQl6xMk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-yedu3krHMjC_5rkAi0tPiA-1; Fri,
 09 May 2025 11:15:55 -0400
X-MC-Unique: yedu3krHMjC_5rkAi0tPiA-1
X-Mimecast-MFC-AGG-ID: yedu3krHMjC_5rkAi0tPiA_1746803753
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CB3D1955D82;
	Fri,  9 May 2025 15:15:53 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.64.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A83D30001A1;
	Fri,  9 May 2025 15:15:50 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: bgurney@redhat.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: jmeneghi@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH 0/2] nvme: check identifiers in order of precedence
Date: Fri,  9 May 2025 11:15:47 -0400
Message-ID: <20250509151547.20394-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EcBMLrCkYiHa6_r9-EOH0j6JAVKnH6_De7kxR5SrxDM_1746803753
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_081734_778399_214CB322 
X-CRM114-Status: GOOD (  10.61  )
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

After commit e2724cb9f0c40 ("nvme: fix the check for duplicate unique
identifiers"), some users are seeing a regression where namespaces on a
PCI-Express NVMe SSD supporting namespace management are failing to have
device nodes created, with the kernel reporting the error "duplicate IDs
in subsystem", despite having at least one unique identifier:

nvme0n1:nguid   : 36434430528018200025384100000001   
nvme0n2:nguid   : 36434430528018200025384100000002
nvme0n3:nguid   : 36434430528018200025384100000003   
nvme0n4:nguid   : 36434430528018200025384100000004
nvme0n5:nguid   : 36434430528018200025384100000005   

nvme0n1:eui64   : 00253898110036df
nvme0n2:eui64   : 00253898110036df
nvme0n3:eui64   : 00253898110036df
nvme0n4:eui64   : 00253898110036df
nvme0n5:eui64   : 00253898110036df

This patch set ensures that there is a unique identifier, in the order
of precedence specified by the NVMe specification (UUID, then NGUID,
then EUI64).  This avoids the issue that has been reported by customers,
on multiple drive models, where the old algorithm would impose too
stringent of a check, as many drives will report a unique NGUID value,
and a non-unique EUI64 value.

This patch set has been tested by an affected customer of Red Hat
Enterprise Linux, and was verified to have restored the creation of the
device nodes of NVMe namespaces on drives with the affected firmware.

Bryan Gurney (2):
  nvme: check duplicate unique identifiers in order
  nvme: print warning on non-unique namespace identifier

 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

-- 
2.49.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06012C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=trUwerbIPuEL8Oqo5uEzvDESvSj4+5C61iMMCfn1k3c=; b=aI61zVW0XaQITNpoEVuuqMLxRm
	BupPckCO6Qn0JBXfrFvrriUnCvSU3Q0Xf+dqHd5EcIrSTpJQNoXYTJvIG2CgelySRp+ky+aPHTRaX
	okF7300TU/g9z7OOV5CHRVOhFtUXBujA0u2w3IXnoneeAlqmCPWBB7qKTxRilBzOf5CI7EJWHmvYs
	Gx+0YZccERde5JrcqKri70qE33Lp17d/QS8F0dQIm5495ejffYRmPRi1JTKZy09LRqdVZy7ymr+le
	4zfdQIB/33qg+gnpIOMfVczfAHJNgijecucLMs4acfxkLqyjTzV3DCGWlRaRoilN5dMFkPHJYW42i
	kyrxR+UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwE1-00000009Xfd-1WfQ;
	Wed, 19 Mar 2025 16:25:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwDy-00000009Xef-2VLO
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 16:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742401496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trUwerbIPuEL8Oqo5uEzvDESvSj4+5C61iMMCfn1k3c=;
	b=Pxl90+2oYHR9bDhC75casy2ODDf9Hy+vzmsuRvKdw6GeWl9/dHPfFsQj4OvNIn3oHBVlsK
	V1iTqVzmH8uH+ArJscID+wdJb+gmzP3pvHQqICu2KAoRfQY9daIg/nZgI+3WVQprTF1H+t
	ndhMuPAI2Qapy41jW/UkXVP0jrH01FU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-qpYEb-7JPl21AfTUNZpwZg-1; Wed,
 19 Mar 2025 12:24:55 -0400
X-MC-Unique: qpYEb-7JPl21AfTUNZpwZg-1
X-Mimecast-MFC-AGG-ID: qpYEb-7JPl21AfTUNZpwZg_1742401494
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE6CF19560AB;
	Wed, 19 Mar 2025 16:24:53 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 277751956094;
	Wed, 19 Mar 2025 16:24:50 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hare@suse.com
Cc: sagi@grimberg.me,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH RFC 0/1] C2HTermReq support for nvmet-tcp
Date: Wed, 19 Mar 2025 17:24:48 +0100
Message-ID: <20250319162449.342649-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jy97NmFfuGhT1k_BDZEzOm-tT6HI8M-WDp7t06PLM0I_1742401494
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_092458_701465_838F80BF 
X-CRM114-Status: UNSURE (   9.87  )
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

Hello Hannes,

this patch adds support for C2HTermReq in
nvmet-tcp as you proposed here:
https://lore.kernel.org/linux-nvme/91041933-6a18-490c-8090-4e03d15d3cf3@suse.de/

Now, the question is how to make it possible to write a blktest script
to test this feature.

I am thinking of adding a function to drivers/nvme/host/fault_inject.c
that corrupts the digest in random packets to trigger a digest
error in the target driver, so the latter will send
a C2HTermReq PDU back to the host.
Does that sounds like a good idea?

Maurizio Lombardi (1):
  nvmet-tcp: add support for C2HTermReq

 drivers/nvme/target/tcp.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

-- 
2.43.5



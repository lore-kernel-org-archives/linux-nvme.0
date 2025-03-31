Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E91EC36011
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ujE/Jq2hB2Nmt+tXahrEFV/EOLD2+lFOyI8RwDHmoho=; b=wIjLHbBmKIikmAv6BKO6FtrAE6
	ajQTVlQGmfVQY9QiPVpgeVzJyKfn/Cy3k+V95PGpVsK3QVuZzIjUH1kftIpu0YVAHXSRECTLKC0Lu
	egv51A1H6V0pLJvqdji0a19bhLjwFi0pQrkrOibM7vpX0jiltY37WzrHqESn+soMOgZ3M61v2li2+
	79i0N7/j5xfEObmxYdha1LtnrIMMlG7EPNdU+oE5W/3P9KK3IzsJqDdESKxiPFuHi7YGRqqz9fwDE
	safIitkSdB1Ml4U1h7PLNbbdQJ3SM24HbkzMyhWx66i9ElYA97aDXAYQ1xSv7NTD93PE9JY9IS3Uz
	txtCD8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzI1y-00000000ysM-1qzq;
	Mon, 31 Mar 2025 16:30:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzI0e-00000000yid-3u3A
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 16:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743438550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ujE/Jq2hB2Nmt+tXahrEFV/EOLD2+lFOyI8RwDHmoho=;
	b=a4qxKAwDXG1MwwJhP9G2nL13Z6rEiEU7lkDpUjIydUKxjPefiAyv5JVkAEGf1dW9bSlT4O
	LJWItvKHowY+MKa6c4kobdPliBxmQyub2n3PqhzGZxhwmJKScywKnboXI9B4K3PtJS1VvU
	spN+XVrOj5uwY8uW03kd6N3NUM3kDu4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-5uiLHCrDOsu7MFaVvhqNMQ-1; Mon,
 31 Mar 2025 12:29:07 -0400
X-MC-Unique: 5uiLHCrDOsu7MFaVvhqNMQ-1
X-Mimecast-MFC-AGG-ID: 5uiLHCrDOsu7MFaVvhqNMQ_1743438546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B01180882E;
	Mon, 31 Mar 2025 16:29:05 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5526819560AD;
	Mon, 31 Mar 2025 16:29:00 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	mikhail.v.gavrilov@gmail.com,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH 0/1] Fix a regression in 6.13 kernel
Date: Mon, 31 Mar 2025 18:28:58 +0200
Message-ID: <20250331162859.1407725-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tskjO3xbtzhMgbSoSo70YW5jHWNSbdptsL9RFkSQoko_1743438546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_092913_042285_11721ADB 
X-CRM114-Status: GOOD (  10.56  )
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

Some time ago Mikhail Gavrilov reported a regression against kernel 6.13
introduced by commit beadf0088501d9dcf2 ("nvme-pci: reverse request order in nvme_queue_rqs")

https://lore.kernel.org/linux-nvme/CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com/

I was not able to reproduce the bug, but Mikhail reported that this patch
fixed it for him:
https://lore.kernel.org/linux-nvme/CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com/

I think the problem here is that nvme_write_sq_db() ends up                                                                                                
being called even when the rqlist is empty and this couldn't happen before                                                                                               
the changes introduced by beadf0088501d9dcf2

Maurizio Lombardi (1):
  nvme-pci: do not call nvme_write_sq_db() if the commands list is empty

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.5



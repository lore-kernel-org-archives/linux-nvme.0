Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09907C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D/p2RkQytKJi3MuPGrjVqdXhBuYp+ylwZe8ZbpZTahc=; b=bTis5BHUrBuO8XZ06xEyO3KIge
	pUL/SUCjVTqLMo02lxMxY7Ew/CDV5Mw52vJdoyAENXvkvndA9bKxo6D3vUXpqtZVXxhcyJAcxKr+r
	ha+M4hlklDeHSGoclnTVEuENx+tNvPqd5+6M06a0F0vNJivgcW9cSlDcui8CvLS7bAmsn+Zh9iZy0
	OU0rC7Rtfw0to2Fp1U/1PEto41f6sWg2CWsCZvWI1sOaVBcV7GyBJT+Hlq9OwUopFBNOrIbfHFknN
	5Niz1uOgqi6lm0HsGi2Go1kse75/hyS7e2iwE9UIxhxZ4YKINTIbYxzKTg2v3cg7KEfS08H0bqBff
	fXi331UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sABhK-00000006pIb-35je;
	Thu, 23 May 2024 16:53:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sABhH-00000006pHo-3rdQ
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 16:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716483222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=D/p2RkQytKJi3MuPGrjVqdXhBuYp+ylwZe8ZbpZTahc=;
	b=SDOi0bkCUKJ4pzKN/BJqTnu57jl+x8zeq3S79LWq6Sxxe+4vXrYMrE1Pa90nFH5dXmazrs
	zT1lwr3K3GewNg7+Bom7nhIrAUBtXqtilFniKNXvy0scr1j9kFzv8r6pBf4LM29CuLJIQu
	RHoQsVer0DESWVZCT992dFKWrpD039E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-uz8F4asBM92bX_NY5AMwIA-1; Thu, 23 May 2024 12:53:38 -0400
X-MC-Unique: uz8F4asBM92bX_NY5AMwIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37C66101A52C;
	Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2168C40C6EB7;
	Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 0E31530C1C33; Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 0D4943FB52;
	Thu, 23 May 2024 18:53:38 +0200 (CEST)
Date: Thu, 23 May 2024 18:53:38 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 0/2 v3] dm-crypt support for per-sector NVMe metadata
Message-ID: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_095344_055517_8884C8E5 
X-CRM114-Status: GOOD (  10.70  )
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

Hi

Here I'm resending the dm-crypt support for per-sector NVMe metadata. I 
made some changes to the first patch as suggested by Jens Axboe.

The first patch fixes a bug when splitting a bio with attached metadata.
The second patch enables dm-crypt to use NVMe metadata for authenticated 
encryption. dm-crypt can run directly on NVMe without using dm-integrity.

These patches increase write throughput twice, because there is no write 
to the dm-integrity journal.

An example how to use it (so far, there is no support in the userspace
cryptsetup tool):

# nvme format /dev/nvme1 -n 1 -lbaf=4
# dmsetup create cr --table '0 1048576 crypt
capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256
01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298
0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'

Mikulas



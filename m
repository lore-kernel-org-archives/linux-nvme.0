Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B11DC25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 15 May 2024 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g5fc8mcPKMWKuhRC4H98ePL+lLJSZdpFd80L6MUtTVs=; b=Ju+PSQHR33VRpBdU3KX/dBM9/P
	G4O/9WjGlycrPBQkcnmf4F+alFIYkakr/K9dcOTtHR+TbCsE+s6RcPvM82yV4cg9Tk1vxFSldeN4o
	UAkMWls4kIVt9pPBqyOAyPCHC91/9HeAZ0ahzfc//nURb4PtQ72dO3lGhpP/9dzbGyeQ3W4TadPD9
	NQVMypKPEA4So/+D1Vu8wuzzwgjN9Y3dXRwrJ1CcXi00uuhgo+9sXaDjhAe6vYj5J7Fqtiv11I+4Q
	LLpQYS9fr6Y4X1InI4SpjK475M10xU8moz5Ck0Nz0smqHD/2VEYKlzmxEvVj5ELQ7wnV0H5LhWpic
	BHpWzbGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7EfW-00000001eUc-1kfv;
	Wed, 15 May 2024 13:27:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7EfP-00000001eSg-3r86
	for linux-nvme@lists.infradead.org;
	Wed, 15 May 2024 13:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715779653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=g5fc8mcPKMWKuhRC4H98ePL+lLJSZdpFd80L6MUtTVs=;
	b=TZrm+h/MlmSz0UJ062UvdLT7rj91CthXdg0JDlV33gqZebpDmnGOhftqHwvs7KU0oHvEim
	Vfp2hzhTf2u7U0y7LBS6qQz1V+GUJWzC0e52+6QemLKHO9IEjoZczyoIR7/jxkn1i+OT0Y
	mEH1xa1CUobr0rhCnBg5QjvxFc3atOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-_pFjeoFPPYGUAvQmLQ8GsQ-1; Wed, 15 May 2024 09:27:27 -0400
X-MC-Unique: _pFjeoFPPYGUAvQmLQ8GsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36A918058C8;
	Wed, 15 May 2024 13:27:27 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D281C008BB;
	Wed, 15 May 2024 13:27:26 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D068D30C7280; Wed, 15 May 2024 13:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CECAF3FB52;
	Wed, 15 May 2024 15:27:26 +0200 (CEST)
Date: Wed, 15 May 2024 15:27:26 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [RFC PATCH 0/2] dm-crypt support for per-sector NVMe metadata
Message-ID: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240515_062736_056856_7427662B 
X-CRM114-Status: GOOD (  10.54  )
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

Some NVMe devices may be formatted with extra 64 bytes of metadata per 
sector.

Here I'm submitting for review dm-crypt patches that make it possible to 
use per-sector metadata for authenticated encryption. With these patches, 
dm-crypt can run directly on the top of a NVMe device, without using 
dm-integrity. These patches increase write throughput twice, because there 
is no write to the dm-integrity journal.

An example how to use it (so far, there is no support in the userspace 
cryptsetup tool):

# nvme format /dev/nvme1 -n 1 -lbaf=4
# dmsetup create cr --table '0 1048576 crypt 
capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256 
01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298 
0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'

Please review it - I'd like to know whether detecting the presence of 
per-sector metadata in crypt_integrity_ctr is correct whether it should be 
done differently.

Mikulas



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94786C25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7jTkoRBA8HmGYXL3GZDRe66mbmyWUIgPJcv/cvwBMA0=; b=Gp9gq6bFkmycQpuAEJ7KHWPleg
	vzfRvbA1eYn1XagnG2xwRacZfdyvMMvNKkgfrTqPg2McdaTyWGkeoZpc2B12tYOUSN+zd6xs5/gKZ
	frvnD2N9KCV4UCnczVbE+tTl5BYbNtP8Zf3TVoU0UpwrQB03w9HfnppqRKSJ4ZPVjjHLkryj5DwkC
	UXdsTJ06rGp/f+UPPtWRrvUGoEy9D2LFD4oBNzGRRas7Ju+DGVLmTh7F2daY9A/52RJ4Wgn4sBTbt
	VT0WW3wSw/3OYztejJkHKr2oSLMY4tN0rhWKZSR6ff0wDwqY8U0HgDDBx7MlvT5k604mvH0f5IjR4
	PSfg2JKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBcRZ-0000000Fd1b-0XHu;
	Mon, 27 May 2024 15:39:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBcRW-0000000Fd0s-0AvB
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 15:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7jTkoRBA8HmGYXL3GZDRe66mbmyWUIgPJcv/cvwBMA0=;
	b=ZdTLnq89I5WSEVsZQWiiU2828bvp37yRiTZKN+RwafQUPWOFkZdja6woO8WwGZ0EEpQwrf
	7MNoV70eBg6nR9geQHzJwpZn/Ew7iDtzASPyKXjxMpGFV2jUEFqrspVbnCJZ7sxcyd93Zm
	RKF3drdap+CF2HTA5eLZy01iIyOmKvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-IpRSvzNoO62M-rUA2ujB6Q-1; Mon, 27 May 2024 11:39:15 -0400
X-MC-Unique: IpRSvzNoO62M-rUA2ujB6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B06A85A58C;
	Mon, 27 May 2024 15:39:15 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13188200A381;
	Mon, 27 May 2024 15:39:15 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id F299B30C1C33; Mon, 27 May 2024 15:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id EF5453C542;
	Mon, 27 May 2024 17:39:14 +0200 (CEST)
Date: Mon, 27 May 2024 17:39:14 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 0/2 v4] dm-crypt support for per-sector NVMe metadata
Message-ID: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_083922_171775_9F6FC4A3 
X-CRM114-Status: GOOD (  10.14  )
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
made some changes to the first patch as suggested by Christoph Hellwig.

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



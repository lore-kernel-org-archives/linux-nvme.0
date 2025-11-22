Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC05CFC504
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 03:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jjkw7I36uekbrB3Ab3Kh8mBpfHiwM7PFy2Oe3WuWs0A=; b=r7AAa+CjuUaWDod85lmW8gURvF
	mHn4AF/fyDIGDvyMzIoZ9s+6mqnqrDzzaybbehl8VAJxfyW9vfI6zGx6WwNGjmNbSIUhPObGqeFa0
	ZK6me8S4xvd5poJ6uZCSWZgxnBUUpkzpCiXRrjycUPZ4FR+g0yHHeA85RODZFOOvrubWON5UMHGiM
	1WNo4PLN1Ey7qIRac81hcKQfNk2TuPn42pcmpRiv2ouzG+iVXRcCuqV5WFkS5QjMuHmlgdYDx1lLJ
	pfQq9a4OTKexwEURtBoLEfmgAtABVe53vkod7bSQU80H/ydXAnNrc9OstT1ALjYJzAbJIXFwMcNIR
	+Qtnim1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMePm-00000009ECL-35rB;
	Sat, 22 Nov 2025 03:35:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMePj-00000009EBZ-12f4
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 03:35:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763782552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jjkw7I36uekbrB3Ab3Kh8mBpfHiwM7PFy2Oe3WuWs0A=;
	b=A58KSmlIMk7j1oA5um6YFghzlPke5I//tpG3YlL9/C1ZGBJA5e4vJ+zPqcd0cF+MC7IpEA
	TQh6W3cDZLwtDWjVylh8tEYc+wxPsmBsBa+P1BfKHWiIGD6b6+QokCGIkXUuXKyvYkglVu
	luVlOoq+G+LEBl/s9X9yIoWsni6FBog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-1VuEGGSHOMylSb3CeDK9wg-1; Fri,
 21 Nov 2025 22:35:46 -0500
X-MC-Unique: 1VuEGGSHOMylSb3CeDK9wg-1
X-Mimecast-MFC-AGG-ID: 1VuEGGSHOMylSb3CeDK9wg_1763782544
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC2E1180049F;
	Sat, 22 Nov 2025 03:35:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11E371956045;
	Sat, 22 Nov 2025 03:35:35 +0000 (UTC)
Date: Sat, 22 Nov 2025 11:35:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSEvg8z9qxSwJmZn@fedora>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_193555_363649_9F75E924 
X-CRM114-Status: GOOD (  18.68  )
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

On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Hello everyone,
> 
> We have recently encountered a severe data loss issue on kernel version 4.19,
> and we suspect the same underlying problem may exist in the latest kernel versions.
> 
> Environment:
> *   **Architecture:** arm64
> *   **Page Size:** 64KB
> *   **Filesystem:** XFS with a 4KB block size
> 
> Scenario:
> The issue occurs while running a MySQL instance where one thread appends data
> to a log file, and a separate thread concurrently reads that file to perform
> CRC checks on its contents.
> 
> Problem Description:
> Occasionally, the reading thread detects data corruption. Specifically, it finds
> that stale data has been exposed in the middle of the file.
> 
> We have captured four instances of this corruption in our production environment.
> In each case, we observed a distinct pattern:
>     The corruption starts at an offset that aligns with the beginning of an XFS extent.
>     The corruption ends at an offset that is aligned to the system's `PAGE_SIZE` (64KB in our case).
> 
> Corruption Instances:
> 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> 
> After analysis, we believe the root cause is in the handling of chained bios, specifically
> related to out-of-order io completion.
> 
> Consider a bio chain where `bi_remaining` is decremented as each bio in the chain completes.
> For example,
> if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> bi_remaining count:
> 1->2->2

Right.

> if the bio completes in the reverse order, there will be a problem. 
> if bio 3 completes first, it will become:
> 1->2->1

Yes.

> then bio 2 completes:
> 1->1->0

No, it is supposed to be 1->1->1.

When bio 1 completes, it will become 0->0->0

bio3's `__bi_remaining` won't drop to zero until bio2's reaches
zero, and bio2 won't be done until bio1 is ended.

Please look at bio_endio():

void bio_endio(struct bio *bio)
{
again:
	if (!bio_remaining_done(bio))
		return;
	...
	if (bio->bi_end_io == bio_chain_endio) {
		bio = __bio_chain_endio(bio);
        goto again;
	}
	...
}


Thanks,
Ming



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA38C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CNafrKnk4FIq2+HqmIqGhvURcy9ujy5KvmOkvU/Cn1I=; b=4kHvjIE5eekGEu32E0h2ewGTn7
	ylcEgs2xEBlKIyxnZ/PNhH0BwB6bfhjzLMt68AOxKSCE/gyobNGHAR6zihOOA8qSCZUUREJYNO3Gr
	TWiDpFhEdVw9h9QCtftetH6U39IKOEM9z9tqcLt0PqqsTDkOWbu5Ld37a1VZIEpkVkWNSsflS02k9
	vJvCWnwBSwOLwAG97R4VGo6tQo429KIp2ZZ61KQxKKq+we+L+pRqziz/DRRVVoGiWME2SOCDjTgi7
	sc5EpSd0muXthLPeaFTcnokPxGiw7DzRUL3vlpLN6y8JG+Ug3kqbKK9PJChGCXBlImUncHFfjs1h4
	GjTfRy9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7WGe-000000047KB-1avB;
	Thu, 16 May 2024 08:15:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7WGb-000000047Il-0BYK
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 08:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNafrKnk4FIq2+HqmIqGhvURcy9ujy5KvmOkvU/Cn1I=;
	b=U4XhwvAGgMIZeFwAO2VpsLdS6HugY8dFD0yEwap9UpKho4D40lbiJxKS8sz5qnbnp3vt0v
	jXUQm89JZd9Fh5OoRl5XPEIh/AUgFOeJTT/OkE1jdnv0F4ic2u3J/oWnH0o27nW/sk4EnA
	kRrHKKWPTYBNosjuY9VTVoADNoyyg48=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-nExiO4DSOf2sOTvOJ2-zwA-1; Thu,
 16 May 2024 04:15:04 -0400
X-MC-Unique: nExiO4DSOf2sOTvOJ2-zwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B264329AA396;
	Thu, 16 May 2024 08:15:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70814561A;
	Thu, 16 May 2024 08:14:58 +0000 (UTC)
Date: Thu, 16 May 2024 16:14:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <ZkXAfmbtXzKGaouC@fedora>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_011509_273357_9C9E674F 
X-CRM114-Status: GOOD (  16.32  )
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

On Wed, May 15, 2024 at 03:28:11PM +0200, Mikulas Patocka wrote:
> If we allocate a bio that is larger than NVMe maximum request size, attach
> integrity metadata to it and send it to the NVMe subsystem, the integrity
> metadata will be corrupted.
> 
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the iterator of the first bio and advance the iterator of the
> second bio.
> 
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.

Wrt. NVMe, inside blk_mq_submit_bio(), bio_integrity_prep() is called after
bio is split, ->bi_integrity is actually allocated for every split bio, so I
am not sure if the issue is related with bio splitting. Or is it related
with DM over NVMe?

However, rq_integrity_vec() may not work correctly in case of bio merge.


Thanks, 
Ming



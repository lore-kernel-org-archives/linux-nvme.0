Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D85C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 01:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1C3Q/KwQSqG9yP6ISOd9Cb0ee81aaiJLrsTwyDo8cI=; b=XyGTdAt7eo8IGfBQV1oO7QKyEg
	+cqORsqeTPUzPrYOI0UsZyzUWzqfwtbGD9UEJ9tqiCArmS+IA9AXKfE4pLdJPdX+tlIP0yENpUCPx
	ks+UoSF2pAG0PHkYPUTP46HwXO1fuPtxXT6Wb7jAFtBAsp9vHeHPHncG1tl/8tN/JlHYeR+cpVA72
	7cNQwTE6TRnDRruc391+gn+e5pldR5HRwZUPjzOST9m+Y2Bt/Fc42ixysTlv+WVvf6cs8cqeImTE7
	ixx/LGJGGs1EO5gQcG0Gr3+rhY/0QN7Wcty+9SQ2V0ePBbB/rv8ApxQAsiMyB6zjPJZKV7r6+IDg6
	8L9Gjy3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAKVv-005ysY-0B;
	Tue, 05 Dec 2023 01:46:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAKVr-005yrn-1e
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 01:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701740772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1C3Q/KwQSqG9yP6ISOd9Cb0ee81aaiJLrsTwyDo8cI=;
	b=aHTsMDcm4xTFAoMYMlThRWdntol+2tPV5rqoHBqFlGxqThbz8VYhzVkoTTeoHecJ++cLpO
	TdDtbon7vcTpvxftT0i6w3St4kAFeqg9J581WomjBzAJB3vFENvQ3GmewimMD8eB8vPVq/
	jNTdZtT/yHdXwe+kKUDE6Yh9oWXTwic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-wLc8U6qJMbyT2DZnFWgRjQ-1; Mon, 04 Dec 2023 20:46:09 -0500
X-MC-Unique: wLc8U6qJMbyT2DZnFWgRjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 242C785A5B5;
	Tue,  5 Dec 2023 01:46:08 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB08C1596F;
	Tue,  5 Dec 2023 01:45:58 +0000 (UTC)
Date: Tue, 5 Dec 2023 09:45:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZW6A0R04Gk/04EHj@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <ZW05th/c0sNbM2Zf@fedora>
 <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com>
 <ZW3DracIEH7uTyEA@fedora>
 <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_174615_619285_4C51212D 
X-CRM114-Status: GOOD (  34.47  )
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

On Mon, Dec 04, 2023 at 01:13:55PM +0000, John Garry wrote:
> 
> > > 
> > > I added this here (as opposed to the caller), as I was not really worried
> > > about speeding up the failure path. Are you saying to call even earlier in
> > > submission path?
> > atomic_write_unit_min is one hardware property, and it should be checked
> > in blk_queue_atomic_write_unit_min_sectors() from beginning, then you
> > can avoid this check every other where.
> 
> ok, but we still need to ensure in the submission path that the block device
> actually supports atomic writes - this was the initial check.

Then you may add one helper bdev_support_atomic_write().

> 
> > 
> > > > > +	if (pos % atomic_write_unit_min_bytes)
> > > > > +		return false;
> > > > > +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> > > > > +		return false;
> > > > > +	if (!is_power_of_2(iov_iter_count(iter)))
> > > > > +		return false;
> > > > > +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> > > > > +		return false;
> > > > > +	if (pos % iov_iter_count(iter))
> > > > > +		return false;
> > > > I am a bit confused about relation between atomic_write_unit_max_bytes and
> > > > atomic_write_max_bytes.
> > > I think that naming could be improved. Or even just drop merging (and
> > > atomic_write_max_bytes concept) until we show it to improve performance.
> > > 
> > > So generally atomic_write_unit_max_bytes will be same as
> > > atomic_write_max_bytes, however it could be different if:
> > > a. request queue nr hw segments or other request queue limits needs to
> > > restrict atomic_write_unit_max_bytes
> > > b. atomic_write_unit_max_bytes does not need to be a power-of-2 and
> > > atomic_write_max_bytes does. So essentially:
> > > atomic_write_unit_max_bytes = rounddown_pow_of_2(atomic_write_max_bytes)
> > > 
> > plug merge often improves sequential IO perf, so if the hardware supports
> > this way, I think 'atomic_write_max_bytes' should be supported from the
> > beginning, such as:
> > 
> > - user space submits sequential N * (4k, 8k, 16k, ...) atomic writes, all can
> > be merged to single IO request, which is issued to driver.
> > 
> > Or
> > 
> > - user space submits sequential 4k, 4k, 8k, 16K, 32k, 64k atomic writes, all can
> > be merged to single IO request, which is issued to driver.
> 
> Right, we do expect userspace to use a fixed block size, but we give scope
> in the API to use variable size.

Maybe it is enough to just take atomic_write_unit_min_bytes
only, and allow length to be N * atomic_write_unit_min_bytes.

But it may violate atomic write boundary?

> 
> > 
> > The hardware should recognize unit size by start LBA, and check if length is
> > valid, so probably the interface might be relaxed to:
> > 
> > 1) start lba is unit aligned, and this unit is in the supported unit
> > range(power_2 in [unit_min, unit_max])
> > 
> > 2) length needs to be:
> > 
> > - N * this_unit_size
> > - <= atomic_write_max_bytes
> 
> Please note that we also need to consider:
> - any atomic write boundary (from NVMe)

Can you provide actual NVMe boundary value?

Firstly natural aligned write won't cross boundary, so boundary should
be >= write_unit_max, see blow code from patch 10/21:

+static bool bio_straddles_atomic_write_boundary(loff_t bi_sector,
+				unsigned int bi_size,
+				unsigned int boundary)
+{
+	loff_t start = bi_sector << SECTOR_SHIFT;
+	loff_t end = start + bi_size;
+	loff_t start_mod = start % boundary;
+	loff_t end_mod = end % boundary;
+
+	if (end - start > boundary)
+		return true;
+	if ((start_mod > end_mod) && (start_mod && end_mod))
+		return true;
+
+	return false;
+}
+

Then if the WRITE size is <= boundary, the above function should return
false, right? Looks like it is power_of(2) & aligned atomic_write_max_bytes?

> - virt boundary (from NVMe)

virt boundary is applied on bv_offset and bv_len, and NVMe's virt
bounary is (4k - 1), it shouldn't be one issue in reality.

> 
> And, as I mentioned elsewhere, I am still not 100% comfortable that we don't
> pay attention to regular max_sectors_kb...

max_sectors_kb should be bigger than atomic_write_max_bytes actually,
then what is your concern?



Thanks,
Ming



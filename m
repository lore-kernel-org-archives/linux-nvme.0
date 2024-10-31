Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44578D74960
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylLHvS3B4DMeBiTkFxRK6FWUuGg+33emd5MdRJEeN5U=; b=IhBtHwOefPlPsykxL+S9hCGaVn
	Ml3TDPiWx2e/cBgZteiiiEd1dJrILmWPwhw3CQBbik+Y+TcgGsPIafVth4FiAT/+bWRl4dp3avm1t
	O2YHy9+jDQJ+QPqVwND+VCrqv2R4Eh8g9vdnKrvY8ROetf1o2nSwz5kXwRZMdeM6Zl4HpGk/t/XY2
	3cgsA/l0QE/v09tD5rWXU/UGrk3FX0AK/0q4epRpcio7vIr2ADTIBdZu9kGVVMrixbcjo4V6pFIv8
	HdT7A6zrKPPzxcv3SZwvhh3Zm2tY9+9FqVaEWTx+dIhwylxqpQ2z0ClkpBQv4po3/05ir76LIOFFQ
	UOHKMlzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6JJ0-00000002B0l-0T3P;
	Thu, 31 Oct 2024 00:44:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6IxC-000000028os-26BB
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 00:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730334141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylLHvS3B4DMeBiTkFxRK6FWUuGg+33emd5MdRJEeN5U=;
	b=bKPfxDXDY0N/q599shzGsDe4qB7pfyv9dyUhpSbtiVIo/8OeS9BOgLp6PkvaP3xE6PDa+T
	+MfRyB3Qatd+8R8Kwdj3kUvZP9O6moVEEV9S34WFATFjSMvp/j3Iavy6Ozxu1ulbjweZzu
	nRvvnlQ9ErRMBcy2kn6slOt3iUIeq7o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-jexB4D0sO7-vMym4mJV5Dg-1; Wed,
 30 Oct 2024 20:22:17 -0400
X-MC-Unique: jexB4D0sO7-vMym4mJV5Dg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 388F71955F43;
	Thu, 31 Oct 2024 00:22:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B3E4196BB7E;
	Thu, 31 Oct 2024 00:22:07 +0000 (UTC)
Date: Thu, 31 Oct 2024 08:22:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	klara@kasm.eu
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZyLNqtmxsEt-VYIE@fedora>
References: <20241024050021.627350-1-hch@lst.de>
 <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com>
 <ZyLL-eXIntwBY5q2@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyLL-eXIntwBY5q2@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_172222_631571_87E93B44 
X-CRM114-Status: GOOD (  23.42  )
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

On Thu, Oct 31, 2024 at 08:14:49AM +0800, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 06:56:48PM +0100, Klara Modin wrote:
> > Hi,
> > 
> > On 2024-10-24 07:00, Christoph Hellwig wrote:
> > > From: Ming Lei <ming.lei@redhat.com>
> > > 
> > > The iov_iter_extract_pages interface allows to return physically
> > > discontiguous pages, as long as all but the first and last page
> > > in the array are page aligned and page size.  Rewrite
> > > iov_iter_extract_bvec_pages to take advantage of that instead of only
> > > returning ranges of physically contiguous pages.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > [hch: minor cleanups, new commit log]
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in next-20241030),
> > I'm unable to connect via nvme-tcp with this in the log:
> > 
> > nvme nvme1: failed to send request -5
> > nvme nvme1: Connect command failed: host path error
> > nvme nvme1: failed to connect queue: 0 ret=880
> > 
> > With the patch reverted it works as expected:
> > 
> > nvme nvme1: creating 24 I/O queues.
> > nvme nvme1: mapped 24/0/0 default/read/poll queues.
> > nvme nvme1: new ctrl: NQN
> > "nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr
> > [2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn:
> > nqn.2018-06.eu.kasm.int:parmesan
> 
> I can't reproduce it by running blktest 'nvme_trtype=tcp ./check nvme/'
> on both next tree & for-6.13/block.
> 
> Can you collect the following bpftrace log by running the script before
> connecting to nvme-tcp?

And please try the following patch:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9fc06f5fb748..c761f6db3cb4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
                i->bvec++;
                skip = 0;
        }
+       bi.bi_idx = 0;
        bi.bi_size = maxsize + skip;
        bi.bi_bvec_done = skip;



Thanks, 
Ming



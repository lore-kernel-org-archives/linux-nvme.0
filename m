Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B5EC678DB
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Mar 2023 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9A0w+OdpoRYxnV0rF0kJS5zDj5JrmFLVzkcGnyJoS6Q=; b=KYdgjns4hfvVVw3W9GzZuLYWjK
	elhKhMG3GLxSONS6Mx5dxEFVYDEldFByqBfBRjE9QWJlPw820TMnhVB8x5lwJ0AiU2ey7nVVaVQDv
	3Y8Q20YUNbi0fXXcgYPmiKU9OsbjEX78RecIoA27/w8zjV0f5PKydEhC5opgD7aEVBmihELVkwp0y
	CqV4GbO53usg2/9B+F2XNaaMR/4wU1sdoOWVQjAjV5D1v0QfbY1E95VfwQNCioB1oxZYuKlaOwn+u
	LwufPjSVocxtv6DFO0p/GjLWObBQoWjqhPqfV/QoNk3vopFy8vK/EHiNMCzDQW/sG22GcMNRJnsiZ
	5u8NKmmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYP2m-008lhM-Jz; Sat, 04 Mar 2023 10:23:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYP2j-008lgh-8r
	for linux-nvme@lists.infradead.org; Sat, 04 Mar 2023 10:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677925385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9A0w+OdpoRYxnV0rF0kJS5zDj5JrmFLVzkcGnyJoS6Q=;
	b=QS8+TK7nTkLYCygLKNR0Q/d9YN/Pupfy1DssmqOc6215WD3QSLB64Dfsfc+4S8KjJN2TF5
	QTZcRXrUPup0L8VOpDwXqLFrZYUChvRD+enbMMDg8v9ubao9vExuFkDrdARwUWI/SIYkZe
	HnA4H6thuUtNNsbv25d4wIvoNAfHo4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-v_Rc9NIhNoiDutOsdneNfg-1; Sat, 04 Mar 2023 05:23:01 -0500
X-MC-Unique: v_Rc9NIhNoiDutOsdneNfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D28A800050;
	Sat,  4 Mar 2023 10:23:00 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 662F52166B2B;
	Sat,  4 Mar 2023 10:22:55 +0000 (UTC)
Date: Sat, 4 Mar 2023 18:22:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <ZAMb+x/hKPjoFHS5@ovpn-8-18.pek2.redhat.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_022309_428348_4D35ACA3 
X-CRM114-Status: GOOD (  26.16  )
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

On Sat, Mar 04, 2023 at 09:00:28AM +0100, Hannes Reinecke wrote:
> On 3/4/23 00:13, Ming Lei wrote:
> > When investigating one customer report on warning in nvme_setup_discard,
> > we observed the controller(nvme/tcp) actually exposes
> > queue_max_discard_segments(req->q) == 1.
> > 
> > Obviously the current code can't handle this situation, since contiguity
> > merge like normal RW request is taken.
> > 
> > Fix the issue by building range from request sector/nr_sectors directly.
> > 
> > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
> >   1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c2730b116dc6..d4be525f8100 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> >   		range = page_address(ns->ctrl->discard_page);
> >   	}
> > -	__rq_for_each_bio(bio, req) {
> > -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > -
> > -		if (n < segments) {
> > -			range[n].cattr = cpu_to_le32(0);
> > -			range[n].nlb = cpu_to_le32(nlb);
> > -			range[n].slba = cpu_to_le64(slba);
> > +	if (queue_max_discard_segments(req->q) == 1) {
> > +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> > +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> > +
> > +		range[0].cattr = cpu_to_le32(0);
> > +		range[0].nlb = cpu_to_le32(nlb);
> > +		range[0].slba = cpu_to_le64(slba);
> > +		n = 1;
> > +	} else { > +		__rq_for_each_bio(bio, req) {
> > +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > +
> > +			if (n < segments) {
> > +				range[n].cattr = cpu_to_le32(0);
> > +				range[n].nlb = cpu_to_le32(nlb);
> > +				range[n].slba = cpu_to_le64(slba);
> > +			}
> > +			n++;
> >   		}
> > -		n++;
> >   	}
> >   	if (WARN_ON_ONCE(n != segments)) {
> Now _that_ is odd.
> Looks like 'req' is not formatted according to the 'max_discard_sectors'
> setting.
> But if that's the case, then this 'fix' would fail whenever
> 'max_discard_sectors' < 'max_hw_sectors', right?

No, it isn't the case.

> Shouldn't we rather modify the merge algorithm to check for
> max_discard_sectors for DISCARD requests, such that we never _have_
> mis-matched requests and this patch would be pointless?

But it is related with discard merge.

If queue_max_discard_segments() is 1, block layer merges discard
request/bios just like normal RW IO.

However, if queue_max_discard_segments() is > 1, block layer simply
'merges' all bios into one request, no matter if the LBA is adjacent
or not, and treat each bio as one discard segment, that is called
multi range discard too.

That is the reason why we have to treat queue_max_discard_segments() == 1
specially, and you can see same handling in virtio_blk.


Thanks,
Ming



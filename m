Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0EAC6FA99
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TzfEJeY7FxL9p6sA77ly5VjXLvDPcQ9oqQKL8nXj8XI=; b=N8BSYsEmgbJCW1sh6aQ0aqFANg
	XKj2A+oK/M07cj3tBf5KF+HhWtvZ3kdxkN79NmaG5Hb+rbeUTtP3zXqLTcc+hOCzlHuYkECX2GGwZ
	OQCsZYXNb6wJOS5/IXjf9D8o64PVcz74tMqpDjqwQ3iNLCrUXrgePydZ3C7Pbi5USvGzfO4739T9Y
	l+jMbGoqG3sQsNP67P4J/qoSCA1HFMP5qiG4uz74afzVORC7UYNVcRUQERGqBq9Z7DsE4SuZRUBbS
	19FmCCsCs3UQQmyAa5QMs9vUAgLLl7thfMEURwBi0/vzgdzdvGI/rU9stDRlepjYZstemw6PO1M3Y
	pgq+jIxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWD1-0004LA-Mb; Tue, 07 Mar 2023 12:14:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWCx-0004Kg-PF
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678191257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzfEJeY7FxL9p6sA77ly5VjXLvDPcQ9oqQKL8nXj8XI=;
	b=eP1K3q6BtfUtXLLAem1OKYt73ihf3aH3Wtu0PD9mlWvr2CI/I40EFTWFqmngeCSzkP8sAP
	sd0LWP5CN8mEH+sLL1DLX+/1xfXS2+ilxYV5jUF4vG0fjHQdnHZH1e64fRVknYgIZVcC4q
	9Xt6Z4tzOnCtRW5g9yubupcvYCcywmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-9LTdexiOPVKaGFFZ8og78w-1; Tue, 07 Mar 2023 07:14:16 -0500
X-MC-Unique: 9LTdexiOPVKaGFFZ8og78w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9185877CA4;
	Tue,  7 Mar 2023 12:14:15 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46ED240C10FA;
	Tue,  7 Mar 2023 12:14:11 +0000 (UTC)
Date: Tue, 7 Mar 2023 20:14:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_041419_953640_5DBF214F 
X-CRM114-Status: GOOD (  26.86  )
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

On Tue, Mar 07, 2023 at 01:39:27PM +0200, Sagi Grimberg wrote:
> 
> 
> On 3/6/23 23:49, Ming Lei wrote:
> > On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 3/4/23 01:13, Ming Lei wrote:
> > > > When investigating one customer report on warning in nvme_setup_discard,
> > > > we observed the controller(nvme/tcp) actually exposes
> > > > queue_max_discard_segments(req->q) == 1.
> > > > 
> > > > Obviously the current code can't handle this situation, since contiguity
> > > > merge like normal RW request is taken.
> > > > 
> > > > Fix the issue by building range from request sector/nr_sectors directly.
> > > > 
> > > > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
> > > >    1 file changed, 19 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index c2730b116dc6..d4be525f8100 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> > > >    		range = page_address(ns->ctrl->discard_page);
> > > >    	}
> > > > -	__rq_for_each_bio(bio, req) {
> > > > -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > -
> > > > -		if (n < segments) {
> > > > -			range[n].cattr = cpu_to_le32(0);
> > > > -			range[n].nlb = cpu_to_le32(nlb);
> > > > -			range[n].slba = cpu_to_le64(slba);
> > > > +	if (queue_max_discard_segments(req->q) == 1) {
> > > > +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> > > > +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> > > > +
> > > > +		range[0].cattr = cpu_to_le32(0);
> > > > +		range[0].nlb = cpu_to_le32(nlb);
> > > > +		range[0].slba = cpu_to_le64(slba);
> > > > +		n = 1;
> > > > +	} else {
> > > > +		__rq_for_each_bio(bio, req) {
> > > > +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > +
> > > > +			if (n < segments) {
> > > > +				range[n].cattr = cpu_to_le32(0);
> > > > +				range[n].nlb = cpu_to_le32(nlb);
> > > > +				range[n].slba = cpu_to_le64(slba);
> > > > +			}
> > > > +			n++;
> > > >    		}
> > > > -		n++;
> > > >    	}
> > > >    	if (WARN_ON_ONCE(n != segments)) {
> > > 
> > > 
> > > Maybe just set segments to min(blk_rq_nr_discard_segments(req),
> > > queue_max_discard_segments(req->q)) and let the existing code do
> > > its thing?
> > 
> > What is the existing code for applying min()?
> 
> Was referring to this:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3345f866178e..dbc402587431 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
> *ns, struct request *req,
>                 range = page_address(ns->ctrl->discard_page);
>         }
> 
> +       segments = min(segments, queue_max_discard_segments(req->q));

That can't work.

In case of queue_max_discard_segments(req->q) == 1, the request still
can have more than one bios since the normal merge is taken for discard
IOs.


Thanks,
Ming



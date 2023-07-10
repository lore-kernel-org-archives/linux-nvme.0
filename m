Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70184EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZdypXFkBjoBC9AdVCThdk80K7RU0xQwH/gJH94hZBE=; b=KtKzlTGQMJgDU0f9zgdzgu6PQz
	srW5W540P2+EIj3zhpySYoZQEXCG4Ply93p8lfLsP5R2ccKKZrZzJDSajA0WdVuM3jCB9vWukDf1c
	VEILrEPDlDQfBgAXIpVMoU7CuYsYZ8sLHqTjx9lXMH7Oz8Z3HbjzwO7d38aOVc5quu859bmT7QRGo
	scq7NoGp6OGvnDobIz9BSbT2NoqT5akVxe2bY6r87gtv2yonTJaNLw73HJzu+WgdVpaRVJECkgkPk
	Pf7jVQ8l/ZiaBKH1cF3AS+Ba/a6kiWNksHqiXba5ER//A0/I3z7r7rFNvOdEnrqvFQWzRS66FmIVT
	jOKZlT+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhAi-00AErf-1k;
	Mon, 10 Jul 2023 03:02:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhAf-00AEpw-1o
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 03:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688958159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZdypXFkBjoBC9AdVCThdk80K7RU0xQwH/gJH94hZBE=;
	b=TR1WzpMr2m5n55KxQo0Aagatx7k2VYVJoAXTQoUr71+7u/Y4zW9i9c+54jwgVAIZF3ofAe
	REIrO7vL/Q56d/pOpsvGpjlyxEIAiP4ylNZNRZd2uZR5YIUkzKHg6Z4RzlWM7LsjIWdqU3
	fj5K5DnxT6r+GfU8hRkdUfEoIIMWgBE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-Gq7u1Sm_NBKNVRcYvxzP4g-1; Sun, 09 Jul 2023 23:02:35 -0400
X-MC-Unique: Gq7u1Sm_NBKNVRcYvxzP4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB8F21C07243;
	Mon, 10 Jul 2023 03:02:34 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B605C200A7CA;
	Mon, 10 Jul 2023 03:02:30 +0000 (UTC)
Date: Mon, 10 Jul 2023 11:02:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_200241_695642_F2621AD9 
X-CRM114-Status: GOOD (  21.71  )
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

On Sun, Jul 09, 2023 at 10:38:29AM +0300, Sagi Grimberg wrote:
> 
> > > namespace's request queue is frozen and quiesced during error recovering,
> > > writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <-
> > > del_gendisk()
> > > can't move on, and causes IO hang. Removal could be from sysfs, hard
> > > unplug or error handling.
> > > 
> > > Fix this kind of issue by marking controller as DEAD if removal breaks
> > > error recovery.
> > > 
> > > This ways is reasonable too, because controller can't be recovered any
> > > more after being removed.
> > 
> > This looks fine to me Ming,
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > 
> > I still want your patches for tcp/rdma that move the freeze.
> > If you are not planning to send them, I swear I will :)
> 
> Ming, can you please send the tcp/rdma patches that move the
> freeze? As I said before, it addresses an existing issue with
> requests unnecessarily blocked on a frozen queue instead of
> failing over.

Any chance to fix the current issue in one easy(backportable) way[1] first?

All previous discussions on delay freeze[2] are generic, which apply on all
nvme drivers, not mention this error handling difference causes extra maintain
burden. I still suggest to convert all drivers in same way, and will work
along the approach[1] aiming for v6.6.


[1] https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
[2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc

Thanks,
Ming



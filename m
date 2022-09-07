Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB85ECAAA1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 02:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvUlhviNJqv0ROVB0Y+nBCL+zsEnp+XZl1ffc/KvcrQ=; b=evnJq4s9X9yVe9cubHrKRo+5iJ
	WkEfl4269AaiVl2iip64bHM4DagvlQvaI1DQQ7c27BBJctGS3dHbFUf01jJOold+0tExLdIaov9F5
	djYcPDLNgpE+Da0tA9Do6bWmFdy+kbKYuxrB9AQ0s+MxcUgC719B0fhC+92HK3lJdoUIdDIvDOsPe
	atmHEEwwjNFsyzoqorpf27KUHRXJqQ/2QFxCoFKu/yIxy5g/umXieT/xDjRuN5aztHK2rW7U50Rig
	F0KENe3bjGldXPi4xKm/VWJy0ZqaoDb1+GLq3ya1lIzN2TiTTTDIOtFm0wlZm/cIB+IReUbAlrKD8
	H+AwwPmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVkSS-001VLO-Jd; Wed, 07 Sep 2022 02:06:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVkSP-001VJK-Fg
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 02:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662516382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvUlhviNJqv0ROVB0Y+nBCL+zsEnp+XZl1ffc/KvcrQ=;
	b=N5Wn5w5dQzYq4LdTtyPb0J22oQhy2u4+U+kRlbR4bU5h3PnTo0QxwqMNo4YPUe+VKsb4xa
	Jg8VLKJp5vcdA0jW323eNrWehxBqhJChww2LLdRd2H8jaTadeOqEa8xXLcgdx0UiaEXrJL
	HGos5z26nU7HxJQBMWb8kQ+afkPDXNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-fcVhAKflOHijGckLt47apA-1; Tue, 06 Sep 2022 22:06:19 -0400
X-MC-Unique: fcVhAKflOHijGckLt47apA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3FD101A595;
	Wed,  7 Sep 2022 02:06:18 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1E152166B26;
	Wed,  7 Sep 2022 02:06:14 +0000 (UTC)
Date: Wed, 7 Sep 2022 10:06:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Message-ID: <Yxf8kfUKRQxASeb5@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
 <YxcIkV2slhTR9MHX@T590>
 <5656419a-6271-b387-3e75-4dcb70047545@huawei.com>
 <YxfmyvCRQiYBGkHI@T590>
 <099899de-5914-c59c-bc2b-1d4d35c68818@huawei.com>
MIME-Version: 1.0
In-Reply-To: <099899de-5914-c59c-bc2b-1d4d35c68818@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_190625_785734_C770ACFF 
X-CRM114-Status: GOOD (  32.86  )
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

On Wed, Sep 07, 2022 at 09:18:52AM +0800, Chao Leng wrote:
> 
> 
> On 2022/9/7 8:33, Ming Lei wrote:
> > On Tue, Sep 06, 2022 at 05:32:01PM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2022/9/6 16:45, Ming Lei wrote:
> > > > On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
> > > > > 
> > > > > 
> > > > > On 2022/8/21 16:47, Ming Lei wrote:
> > > > > > From: Keith Busch <kbusch@kernel.org>
> > > > > > 
> > > > > > In some corner cases[1], freeze wait and unfreeze API may be called on
> > > > > > unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
> > > > > > freeze APIs more reliably, then this kind of issues can be avoided.
> > > > > > And similar approach has been applied on stopping/quiescing nvme queues.
> > > > > This leads to another problem: the process that needs to be
> > > > > in the frozen state is not actually frozen.
> > > > > It's not safe.
> > > > 
> > > > The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
> > > > can be done only the flag is set. Not sure how it isn't safe.
> > > I thought that the use of NVME_NS_FREEZE was the same as NVME_NS_STOPPED.
> > > If just set_bit in nvme_start_freeze, it will cause another problem in
> > > below scenario.
> > > A: start freeze and set the bit;B:start freeze and set the bit;
> > > and then
> > > A:test and clear the bit, and unfreeze;B: test and skip;
> > > The queue will be frozen for ever.
> > 
> > One simple approach is to replace down_read(->namespaces_rwsem) with
> > down_write(->namespaces_rwsem) in nvme_start_freeze() and
> > nvme_unfreeze().
> > 
> > > 
> > > In addition, I think patch 2/2 can fix the bug well, patch 1/2 is not necessary.
> > > No matter how to use NVME_NS_FREEZE , it may cause problems.
> > > The freeze mechanism is perfect, and no additional protection mechanism is required.
> > 
> > block layer requires queue freeze and unfreeze APIs to be called in
> > pair strictly, that is why I add the 1st patch.
> From your bug analysis, the reason is that nvme_wait_freeze is called without nvme_start_freeze.
> patch 2/2 is already delete the nvme_wait_freeze.
> If there is another bug of unmatched freeze and unfreeze,
> can you describe the analysis of unmatched freeze and unfreeze?
> The current patch 1/2 will introduce the unmatched freeze and unfreeze rather than solved it.
> Maybe another patch is needed to fix the bug.

Please look at nvme_reset_work():
		...
		if (dev->online_queues < 2) {
			...
        } else {
                nvme_start_queues(&dev->ctrl);
				nvme_wait_freeze(&dev->ctrl);
                if (!dev->ctrl.tagset)
                        nvme_pci_alloc_tag_set(dev);
                else
                        nvme_pci_update_nr_queues(dev);
                nvme_dbbuf_set(dev);
                nvme_unfreeze(&dev->ctrl);
		}
		...

nvme_wait_freeze() is called on unfrozen queue, so io hang is caused.

If nvme_unfreeze() is called on unfrozen queue, WARN_ON_ONCE() in
__blk_mq_unfreeze_queue() will be triggered.



Thanks,
Ming



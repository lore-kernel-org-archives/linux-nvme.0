Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64399C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6LHo6un10Hww5UkITIYZqx0hJ95mxjwPuv4ZEQNJOo=; b=FB6XGsuSDRuvnzDe/HrTAVZSh8
	w9hWxc/p15YmXgdowm8n+OHvw6TPMMVNgEmj/2N0I8GWGVp/ECl6KnVDEmnw2P79g63IVLoeX/JXc
	1QDrSJ9rgDAPHDWAFvkaZh3ErworSmuW6UvpF0u49OqXicy3t7wmfNB8WUM9eh+1MlSupG62HipC5
	Qg3kTglJ6k6sQfygXY8j4ogfT/60e0TEa0emJ1XoDalblequfVubmEPMs+Lr59lBrPf78ozhZP+0Y
	lfscMSDO4URNiwKABCf7aQT06WkEun+UvsyMeFueZSAoUmYNONs234uZRhEJ4zy+txQY+3h2XDINc
	byBIFPzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEynF-00DXft-3i; Tue, 01 Feb 2022 19:26:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEynB-00DXej-Rr
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643743576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6LHo6un10Hww5UkITIYZqx0hJ95mxjwPuv4ZEQNJOo=;
 b=dYtVQIwWn4wlVyacLRuZbiwUkk21jpRpRETCjo/fwYHQcUh6n9uTV7DmEepW+jpppkKuzw
 PXg7KRGlE4xyYuRRNskW5l7foKswYvdyH32tAep9XSdkxrZqgZs7+UibS1IebKh5zUOtkO
 1kmz9xt8rtvl5hdW2V9LhUz2YbBAIyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-M3lC_SoeOUSu4g4fX1B8yw-1; Tue, 01 Feb 2022 14:26:13 -0500
X-MC-Unique: M3lC_SoeOUSu4g4fX1B8yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EAD1091DA0;
 Tue,  1 Feb 2022 19:26:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DEA5D6BA;
 Tue,  1 Feb 2022 19:25:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 211JPwaE023932; Tue, 1 Feb 2022 14:25:58 -0500
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 211JPwim023928; Tue, 1 Feb 2022 14:25:58 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Tue, 1 Feb 2022 14:25:58 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Bart Van Assche <bvanassche@acm.org>
cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] nvme: add copy offload support
In-Reply-To: <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
Message-ID: <alpine.LRH.2.02.2202011421320.21843@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_112617_999426_A8683A6A 
X-CRM114-Status: GOOD (  14.38  )
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



On Tue, 1 Feb 2022, Bart Van Assche wrote:

> On 2/1/22 10:33, Mikulas Patocka wrote:
> > +static inline blk_status_t nvme_setup_read_token(struct nvme_ns *ns, struct
> > request *req)
> > +{
> > +	struct bio *bio = req->bio;
> > +	struct nvme_copy_token *token =
> > page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;
> 
> Hmm ... shouldn't this function use bvec_kmap_local() instead of
> page_to_virt()?
> 
> Thanks,
> 
> Bart.

.bv_page is allocated only in blkdev_issue_copy with alloc_page. So, 
page_to_virt works.

But you are right that bvec_kmap_local may be nicer.

Mikulas



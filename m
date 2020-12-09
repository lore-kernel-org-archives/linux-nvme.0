Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145FC4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:23:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5076239E5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5076239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D05jiq+QTv/ZPytWlvf/TIl/5MJFpwUNPJ04QYlujSM=; b=pMizenxXg8ba32i53a8RizGpg
	YjUB8NgZrpW9LfEcZ4OB5MYxVnOcF3Z18PysGhUeU2O0635IaF/vZN4fyHIt1xQLG1JPPx4XctoLX
	49MK5TlZ5AMB1rXZgwq4U9DqrFmnKLgul/2TEENYuM3CN+mFivbjx1ytYrk7taeHbTUX1mVctqamT
	632r51pjreV4rwXnAtfFE9BH7YJQ85xmg7IOei4HMLiVuCqCNtLmPsd/1fKnzWanPAd9vcHeR/m9S
	Cn8THufi8kWdfbBqSnjsZfo0ZIv3ODMhuNOglq5Tc9Xz7DfhdYrebhsGtpbziZQQGJnLVPo5RSnxD
	pO+3sdNAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmoCt-0003Jo-AP; Wed, 09 Dec 2020 01:23:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmoCq-0003IK-Bw
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 01:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607477023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ks3Ply4N96m4k2H0dn1kKwtldUSUQfBTesh+Kzg2SfY=;
 b=Tw8sM9+hM2f7iJ5KgDLza4WdGVwL6z6GLtQ+ZfI4PoB0DTczEHGZ8sWt0OEwH/zJsFTlbu
 uEtPUEmYH1x7lK3Dlti6Wq8GzjR5HwyH5guHlhyPFV2oWhqyvMFvxOCpKo3/GsSJscXVsD
 zPaEwuL58Ka0KYjtet56oO5r5ymqLXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-8a_meGOmMGOcPRAitz_oJQ-1; Tue, 08 Dec 2020 20:23:39 -0500
X-MC-Unique: 8a_meGOmMGOcPRAitz_oJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BB41005513;
 Wed,  9 Dec 2020 01:23:37 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEBD660BE2;
 Wed,  9 Dec 2020 01:23:21 +0000 (UTC)
Date: Wed, 9 Dec 2020 09:23:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] block: propagate BLKROSET on the whole device to all
 partitions
Message-ID: <20201209012317.GC1217988@T590>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-5-hch@lst.de>
 <20201208102923.GD1202995@T590> <20201208105927.GB21762@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208105927.GB21762@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_202348_467292_2E2325AE 
X-CRM114-Status: GOOD (  17.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 11:59:27AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 08, 2020 at 06:29:23PM +0800, Ming Lei wrote:
> > > -		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
> > > +	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
> > >  }
> > >  EXPORT_SYMBOL(bdev_read_only);
> > 
> > I think this patch should be folded into previous one, otherwise
> > bdev_read_only(part) may return false even though ioctl(BLKROSET)
> > has been done on the whole disk.
> 
> The above is the existing behavior going back back very far, and I feel
> much more comfortable having a small self-contained patch that changes
> this behavior.
> 

OK, then looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69436C11F6A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DDB61CF6
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDB61CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cASMvF5J4Xn1ViLTDpBzOM226M2YENqHn4Q7FDq0i+s=; b=EXrkvLBYcP3Trv
	B1jLcpOZa+P3n3KQRMxQJ9bdsP6S046gB3UukXMT1qLZQ6B2Ua7AIRoa7Yneo0kXigMIkJowk0pAr
	qpSDYsfZiwOWDP32uJbh1vgPxrNb3uCrRqgSxrz1ndJu/sZlq66C2ioqwg4pkxkSTFMiGVHQfk6fa
	jveun5NE/w5E4FOnJKy41Hl4Si3M/mq5Wz+yR8pokkAeLVOVLGFy4zmH1onw8dcoUDnKX3LFRlgC7
	3eu0u/jHaSS9+sPbYg28VzzojePW1qoeYlfSsVTvQ8wEFapVwQFmcu8cosDR9mg+3PFqsVoGpqGgL
	jCucwEuzThs5HwPn6/1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyVvQ-00DLMb-5A; Wed, 30 Jun 2021 08:50:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyVt4-00DKWi-QW
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 08:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625042881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3BRgUmAkhzxR66VtSPc5n97wSxRw2/ltCg6mBskAIrE=;
 b=YIe9GaTtdy7tjG1c9Sx12QU0xShpdyU/41Se1M4JxOVN4np/Hq7VLGZUZ04SqEAQeSITVk
 H+F3IkVSJ2nTshI9DJ/f4B3CxGUatq2o+FhFM5E+L0QcWj37/OvQAT7FkuKco1A5Wd1g8M
 WxmfUvW5/aNPE2Z7Gk+hbMLS4KloLGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-dcquosp0M5yTB3x8-TK3gg-1; Wed, 30 Jun 2021 04:47:58 -0400
X-MC-Unique: dcquosp0M5yTB3x8-TK3gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33816A40C1;
 Wed, 30 Jun 2021 08:47:56 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2EC25C230;
 Wed, 30 Jun 2021 08:47:48 +0000 (UTC)
Date: Wed, 30 Jun 2021 16:47:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for
 fc/rdma/tcp/loop
Message-ID: <YNwvsNcTBu6yGW1o@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-3-ming.lei@redhat.com>
 <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_014803_026851_EEC038CF 
X-CRM114-Status: GOOD (  16.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 30, 2021 at 10:15:46AM +0200, Hannes Reinecke wrote:
> On 6/29/21 9:49 AM, Ming Lei wrote:
> > All the 4 host drivers don't use managed irq for completing request, so
> > it is correct to pass the flag to blk-mq.
> > 
> > Secondly with this flag, blk-mq will help us dispatch connect request
> > allocated via blk_mq_alloc_request_hctx() to driver even though all
> > CPU in the specified hctx's cpumask are offline.
> > 
> How is this supposed to work?
> To my understanding, only cpus in the hctx cpumask are eligible to send I/O.
> So if all of these CPUs are offline, who exactly is submitting I/O?
> More to the point, which CPU will be submitting the connect request?

Please see __blk_mq_delay_run_hw_queue(), which will pass WORK_CPU_UNBOUND 
to kblockd_mod_delayed_work_on() for this situation.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

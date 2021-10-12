Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7446C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E1D60527
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69E1D60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p2zKnuVv4/jGoNM5e4TR8KNjLzv28qzsqbbDFbLImEc=; b=PEt5J8OZ9kKvJa
	HqfRPvMXYUJATt+81wh6hxeSVP7S7dFDLV7y48RUB1R0ZRm5cdBBNGi3zhyl9uMSy/kCbwVXF3640
	dOnQmuS19sQGImypwEbYk4jKLqTkRmVcNLcgkSS/gFfhZwowuAj26sHu/fJ/PiW2RTbq4S6SYdI1v
	90qSxIWw6YlR2gzLiIghhm8LyAMin0JUjVeckOMqjKeUvIy3FBKUCsb+gG68DBDN3PHRvyPLzkpWS
	N8NBOyWit2JCmiE6POT4nRFd6Kt5JAXEupoWX5ylYOT3az8euiIW+SgqDGgdyDFzi39p7qqCFyw0x
	NuLEb9Y+zqpGigfpRm5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJIe-00DHYn-L3; Tue, 12 Oct 2021 15:02:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJIb-00DHY3-Fn
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:02:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634050954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5n0vZXzpKUr4bdvWBgiF2GxyHPbprOqb+7u3O+dEug=;
 b=OZXaj8MdraQzsfikS35WDWRJLzHZNmv7WK/bVKyH6/cUTxz4CnP+963Bx85R8bjPLg3jfO
 YeF7EPP7XfFddM3DxtqEp2ZfHtv1Y6XwHoau7AHYjqDtiN3P32Ct6F7YTDC1wndbGD5hjC
 o3t9LrLH9OCbKMBPalTkcFXFRIOKj7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-jiS4h6U3MFWVJ22ABzKX0Q-1; Tue, 12 Oct 2021 11:02:31 -0400
X-MC-Unique: jiS4h6U3MFWVJ22ABzKX0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856CF80158D;
 Tue, 12 Oct 2021 15:02:29 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CCE82B060;
 Tue, 12 Oct 2021 15:02:24 +0000 (UTC)
Date: Tue, 12 Oct 2021 23:01:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <YWWjXN3GEzypVFZ/@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012103620.GB29640@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080237_668072_B708ECD0 
X-CRM114-Status: GOOD (  20.03  )
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

On Tue, Oct 12, 2021 at 12:36:20PM +0200, Christoph Hellwig wrote:
> On Sat, Oct 09, 2021 at 11:47:11AM +0800, Ming Lei wrote:
> > The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> > stops and starts the queue unconditionally. And there can be concurrent
> > quiesce/unquiesce coming from different unrelated code paths, so
> > unquiesce may come unexpectedly and start queue too early.
> > 
> > Prepare for supporting concurrent quiesce/unquiesce from multiple
> > contexts, so that we can address the above issue.
> > 
> > NVMe has very complicated quiesce/unquiesce use pattern, add one atomic
> > bit for makeiing sure that blk-mq quiece/unquiesce is always called in
> > pair.
> 
> Can you explain the need for these bits a little more?  If they are
> unbalanced we should probably fix the root cause.
> 
> What issues did you see?

There are lots of unbalanced usage in nvme, such as

1) nvme pci:

- nvme_dev_disable() can be called more than one times before starting
reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().

2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
are never quiesced, and similar usage can be seen in tcp/fc/rdma too

Once the quiesce and unquiesce are run from difference context, it becomes
not easy to audit if the two is done in pair.



Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

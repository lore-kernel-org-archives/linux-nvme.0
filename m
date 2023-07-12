Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15ACEB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YdW3jXa75uZifOOTp5ZtJFJJaNTXIh3AfAYdiE+BpGY=; b=nIO6NVl/HH848ir5TSmeiOuGYg
	5XQEQGRbvvfl7j49fn+Jwt39cRNHg/j+nhKDAeF1hcIdSrwROlY7bKmluLUFq7pBLIHX1vIibdIzz
	j/6S3jNN100aJCPdecAfe+9HE5kisQjFpjXLhDV0nzu8s5kzfEz0wkey95wBZ1rBlIkV0RpH/2NVA
	jo35qzSX60AYV+kfcp4Be/G7FyaZcjgfeXYp+nx0naDtbvHMLx8ZMx6NKIbzVDnH9Lacsf1CdJxcc
	sLx2SULOag90+dwunuf4sO2/SC6fQG0/NF13FeZO5CyNrPpMctGk/JYHujN56KO6uxk1R1X3Vbt9O
	gQD8RL0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZhq-0003MT-0r;
	Wed, 12 Jul 2023 13:16:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZhn-0003M3-2b
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689167790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YdW3jXa75uZifOOTp5ZtJFJJaNTXIh3AfAYdiE+BpGY=;
	b=dKJZLP7DxLTsKvN8JsVmFc77S0l9p74HylJl6C3x7Fb2+1WreXifeLFkYVpBD/RjotZmFj
	il1vhP3HrzmuFNTwrn7mT7IJqwtliMGW3nGW0A9Qi1gJqorxH0gUs4oWCzB8V2zHrLUTw0
	WDRx3fQKU5V6EKXPz1b5kmyfrZbHCa8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-6xGLn3mlMKuJeIXdR53l4w-1; Wed, 12 Jul 2023 09:16:25 -0400
X-MC-Unique: 6xGLn3mlMKuJeIXdR53l4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E9C23C0C491;
	Wed, 12 Jul 2023 13:16:24 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F33FC4087C73;
	Wed, 12 Jul 2023 12:38:00 +0000 (UTC)
Date: Wed, 12 Jul 2023 21:16:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-2-ming.lei@redhat.com>
 <20230712130017.GA12417@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712130017.GA12417@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_061631_930329_67FB87C9 
X-CRM114-Status: GOOD (  19.46  )
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

On Wed, Jul 12, 2023 at 03:00:17PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 08:54:48PM +0800, Ming Lei wrote:
> > +/* Max nr_hw_queues for each hw queue type */
> > +unsigned int blk_mq_max_nr_hw_queues(void)
> > +{
> > +	if (is_kdump_kernel())
> > +		return 1;
> > +	return nr_cpu_ids;
> 
> Again, these is_kdump_kernel hacks don't make any sense.   The amount
> of maximum available CPU needs to come through a proper API, and we
> need to use it, not add hacks like this.
> 
> The only thing that makes sense here is to find the last CPU
> in cpu_possible_mask, and for kdump kernels to ensure that number
> is 1 or whatever low value they want.

It doesn't matter how many cpus are available, given at least one
cpu is online.

The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
return 1 for kdump kernel.

We have to tell driver that blk-mq only supports 1 queue for kdump
kernel.

Or:

Thomas, can we disable managed irq for kdump kernel and switch to
non-managed irq? Then we can avoid driver's change. I'd suggest
this way if it is possible.

Thanks,
Ming



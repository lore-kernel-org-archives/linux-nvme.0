Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C87C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C14460527
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C14460527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBm/xaVK32n7Fe1ypBg+xP+8XH313ZsXhuZmJ0wjgrc=; b=ORe7hPaDt0yAQu
	SmBjTOJmp8h45QLa1fSwDpjP/6DWzTLpWUFuU9Q++w/VSu505s80n/Ex/SP73u0gnCoOtuCv9Tje9
	khtChoz63aC6Jgz43+oXf4xEycNiERt4zLFwNv8eWABLSI5uX8vievHoJZjACX+7ugyp3GRdxLOAl
	RispXidacX6+5OqwTnRZAy1DbPs5G4VOTsaACj3MGVddRC1SlR3FRcQd6a/lLIrmKKq+nQ2tjUmST
	uU+csjMp7znY9JZLX+AEzm1UnrIGwGR0JPEu6uOblYGNNgDbwWnRkSp1K2xxMbAsK/mDaxBj0yKyg
	NwlOLp0XAu4R+jmmZp6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJNa-00DIO0-DA; Tue, 12 Oct 2021 15:07:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJNX-00DIN5-NX
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:07:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D336667373; Tue, 12 Oct 2021 17:07:41 +0200 (CEST)
Date: Tue, 12 Oct 2021 17:07:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <20211012150741.GA20571@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de> <YWWjXN3GEzypVFZ/@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YWWjXN3GEzypVFZ/@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080743_937909_2050235A 
X-CRM114-Status: GOOD (  16.20  )
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

On Tue, Oct 12, 2021 at 11:01:48PM +0800, Ming Lei wrote:
> There are lots of unbalanced usage in nvme, such as
> 
> 1) nvme pci:
> 
> - nvme_dev_disable() can be called more than one times before starting
> reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
> 
> 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
> are never quiesced, and similar usage can be seen in tcp/fc/rdma too
> 
> Once the quiesce and unquiesce are run from difference context, it becomes
> not easy to audit if the two is done in pair.

Yes, but I'm not sure a magic flag is really the solution here.
I think we need to work on our state machine here so that this is less
of a mess.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F7EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2O7OTXUeRoU92HpC9S8grafoZ034oHB9LUwzT8GPQm8=; b=d/vAqFWIBa5bD6PV+bioSjoC8Q
	vA0yJbhXx5YoOrZ9bRedLfZ8mSl0i+G8pnU6LU8gddADCmL2d/YO/BTbcRnyQDBVIIzEtqqPDONBH
	SY7ijgbIXiTw0mNvkYG9NEDy4WbIPzil7oJBXxAvsZRQAnztH8qp8sj2g/pkech1Fa5wV4qkyUlih
	ny6uSOONqnWb0SS+AJ/LrKWnMcKOoAyPc9LTUCxM7WIBOsmceOuy8OcTWydHzSFmeg0vJdZkGH5JW
	9SiBLPEWUGRe7/377zT8az+KYncRVY72FTWgrAsbe2ieveO7RcH7VSWAAbrP8oCNrd2Mo3DBIUfGs
	mpvrzalg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ2G7-00DCNX-0i;
	Tue, 11 Jul 2023 01:33:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ2G5-00DCML-0N
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 01:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689039217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2O7OTXUeRoU92HpC9S8grafoZ034oHB9LUwzT8GPQm8=;
	b=VPwBRk2S7rACcIjARQzYduZM6GuSLRInEA/Z4u5Cv55DtZTFK6SDUzS/FO97Za+8kABy6r
	W6/izgZ40bOTco++Aq5dWeNqeBqkKZ8eiKJwJzC4Ug9Y0ydqKQT9JhOXYC3RppzVgklRR3
	s744kRztDj4NwB3MwiE71v358I3xKYc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-O6L_ttexNva64r-mu9ol2Q-1; Mon, 10 Jul 2023 21:33:34 -0400
X-MC-Unique: O6L_ttexNva64r-mu9ol2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8616F38149A2;
	Tue, 11 Jul 2023 01:33:33 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF3FBC09A09;
	Tue, 11 Jul 2023 01:33:24 +0000 (UTC)
Date: Tue, 11 Jul 2023 09:33:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKyxXgJXk0XPBxe2@ovpn-8-26.pek2.redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
 <ZKw3H2cJzRPZa29N@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKw3H2cJzRPZa29N@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_183341_306506_120A6422 
X-CRM114-Status: GOOD (  23.20  )
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

On Mon, Jul 10, 2023 at 10:51:43AM -0600, Keith Busch wrote:
> On Mon, Jul 10, 2023 at 05:14:15PM +0800, Ming Lei wrote:
> > On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > > Take blk-mq's knowledge into account for calculating io queues.
> > > > 
> > > > Fix wrong queue mapping in case of kdump kernel.
> > > > 
> > > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > > still returns all CPUs.
> > > 
> > > That's simply broken.  Please fix the arch code to make sure
> > > it does not return a bogus num_possible_cpus value for these
> > 
> > That is documented in Documentation/admin-guide/kdump/kdump.rst.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> > simply keep one of CPU cores as online, and others as offline.
> > 
> > So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
> > kdump kernel.
> > 
> > > setups, otherwise you'll have to paper over it in all kind of
> > > drivers.
> > 
> > The issue is only triggered for drivers which use managed irq &
> > multiple hw queues.
> 
> Is the problem that the managed interrupt sets the effective irq
> affinity to an offline CPU? You mentioned observed timeouts; are you

Yes, the problem is that blk-mq only creates hctx0, so nvme-pci
translate it into hctx0's nvme_queue, this way is actually wrong, cause
blk-mq's view on queue topo isn't same with nvme's view.

> seeing the "completion polled" nvme message?

Yes, "completion polled" can be observed. Meantime the warning in
__irq_startup_managed() can be triggered from
nvme_timeout()->nvme_poll_irqdisable()->enable_irq().


Thanks,
Ming



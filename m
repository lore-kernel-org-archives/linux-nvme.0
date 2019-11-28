Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCAEC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:52:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE9320880
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUtCultH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsPWfjvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE9320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E0Wqx4WitCUsXLO7zprm5WhgTBuPr/fcFJUj1YwF7rk=; b=iUtCultHk3eHtJ
	MfFvD8/a64RYVeYEU6H632XvQ14WYDnqvpKnzImKHx22k/BQAiH7vmlO3T00LtEe4TydawUYpT0pD
	Rch4OxuPovXYTau4wPV4680n6fX6UpGOkObmsnigsx3Wrz86pdortbjdSyVAOLW2whmZKC1KW9T60
	grIJJeEZXbmx7d4YCHhAab5pLRRV7+GWHWxa0YOrQ2jqh15397gJ8e2Veu5epebJ+l+9y0vLsXlLP
	V9PQsAv1BF0DD1ksak5k9vYc9m4kB91rM4Sws9b0hmBLzmOddp+1uKz+ULLfRus5CE30umXUsqdvE
	+GKYprbIrL1xxpO/Qprw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaAqV-0001iy-DF; Thu, 28 Nov 2019 03:51:59 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaAqS-0001if-Pv
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 03:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574913115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dj5nQ1/5kgbLBxWEDy8CwR+Ra4hKBU5I0wE/S8wB/jc=;
 b=LsPWfjvIHj3TZX5u42SYXf+A1FHUHumEqf01mkZTOmyxnhkXBKE2UjsL2mysSuzsQjp6Xw
 whJWqtcZQOn2bNbOEb41RA3hUx9PmooLkhFqZFxntHa6p98+l/9IELJOO8vCMtmF+Ml6P1
 es2a1q5gp239GwC7NodKmr/kPUNrsog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-_jTyqZyeOIuxZZOd9pFZZQ-1; Wed, 27 Nov 2019 22:51:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9885107ACC4;
 Thu, 28 Nov 2019 03:51:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39A2B5C1B0;
 Thu, 28 Nov 2019 03:51:43 +0000 (UTC)
Date: Thu, 28 Nov 2019 11:51:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191128035139.GE3277@ming.t460p>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
 <11325d8e-e9f8-408e-18c3-182c69e90eab@grimberg.me>
 <20191128032843.GA1738@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191128032843.GA1738@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _jTyqZyeOIuxZZOd9pFZZQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_195156_915463_3C132387 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: bigeasy@linutronix.de, helgaas@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 12:28:43PM +0900, Keith Busch wrote:
> On Wed, Nov 27, 2019 at 06:46:55PM -0800, Sagi Grimberg wrote:
> > > For deeply queued workloads, the nvme controller may be posting
> > > new completions while the threaded interrupt handles previous
> > > completions. Since the interrupts are masked, we can spin for these
> > > completions for as long as new completions are being posted.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >   drivers/nvme/host/pci.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 571b33b69c5f..9ec0933eb120 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
> > >   	return ret;
> > >   }
> > > +static void nvme_irq_spin(int irq, void *data)
> > > +{
> > > +	while (nvme_irq(irq, data) != IRQ_NONE)
> > > +		cond_resched();
> > 
> > So the cond_resched should be fair to multiple devices mapped to the
> > same cpu core I assume.. did you happen to test it?
> 
> It should, but I'm having difficulty expressly testing that. Frequent
> spinning here needs a single queue mapped to multiple CPUs, such that
> one or more CPUs can constantly dispatch new requests. I've one test
> where this spin never exits for the entire duration of an fio execution,
> and /proc/interrupts confirms only 1 interrupt occured for many millions
> of IO.
> 
> When you have two or more devices with queues mapped to multiple CPUs,
> their threaded interrupt handler affinities will not share the same CPU.

They still may share same CPU if there are many enough NVMe drives, the
threaded interrupt handler actually takes the effective hard interrupt's
affinity, which still may point to same CPU, in case of:

	nr_nvme_drives * nr_hw_queues > nr_cpus


Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

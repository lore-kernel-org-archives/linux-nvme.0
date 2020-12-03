Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E47C64E7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 01:24:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8683C221FB
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 01:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8683C221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mw2wc1IkkRoyesOXUGPeuqrUymmOwZTcDDtsWZpyj7k=; b=aq4Yyc9SqnlHh6T7wR+zt4QY3
	xNv6OMs9BwGtu62S986glqZ+TVCw5uE5EFk978+se9HZMjNcblFXsVg77HIxqFaUGpknXz1rdnSnf
	TrZWvTFwiD1DbeKbWjfH73ccDyiOZU7UPPLFnDlv06tKD3CP/X5uXlCgjYnxRQjc5Sq2/oFb3lSnQ
	WC4uoCnaytfdYma+ujK0i/aIOP92vWFbM7WkuLtNiRUfKmpDVTqdIGFdjAOO4mhzfWMmjOb+aHr+2
	PdSk83qizTDxxQ34kwozR9Dxq+lmYxh/Aw1i26K8H3RfxLrVKCoG3e7l3DLUn8dHVYt/rHa7OPPJK
	lLj/k2bzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkdM5-0003Kc-U0; Thu, 03 Dec 2020 01:24:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkdM0-0003K0-IQ
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 01:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606958655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnB6KEGreP4BJbO64pikkiDEYWis3mZbnxN7CY98rMw=;
 b=Hz/gJs/1pzjZSBsNnhciV25dmV/dutIZ8iBVyx0z6F4xpi0lMfGerpoNeHnLeCK3vZ5JWd
 BUGP8uCLYLpez+7HyCEj1eM9zkCmhYztPccnjQyi03VLZQJ+GmtzoI7AohuR5yTBZD7PF/
 t2ebD7S7/LQd2olFzguq2pPqWSK6RQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-Dtml8vCjOzaToCuTRuXPMw-1; Wed, 02 Dec 2020 20:24:08 -0500
X-MC-Unique: Dtml8vCjOzaToCuTRuXPMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D932805BF1;
 Thu,  3 Dec 2020 01:24:06 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 123AC60BFA;
 Thu,  3 Dec 2020 01:23:59 +0000 (UTC)
Message-ID: <c34804b3a4db1701fab9e03078ce75a69d9b446e.camel@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
From: Qian Cai <qcai@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Date: Wed, 02 Dec 2020 20:23:58 -0500
In-Reply-To: <20201203005035.GA540033@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201130023606.GC230145@T590>
 <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
 <20201203005035.GA540033@T590>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_202416_683854_9817229F 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 John Garry <john.garry@huawei.com>, linux-nvme@lists.infradead.org,
 Kashyap Desai <kashyap.desai@broadcom.com>, linux-block@vger.kernel.org,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-12-03 at 08:50 +0800, Ming Lei wrote:
> On Wed, Dec 02, 2020 at 02:07:08PM -0500, Qian Cai wrote:
> > On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> > > Any chance to take a look? And this issue has been reported several
> > > times in RH internal test.
> > 
> > I suppose that you will need to rebase as it does not apply cleanly on
> > today's
> > linux-next.
> > 
> 
> I just apply the three patches against for-5.11/block, and they can be
> done cleanly.

Ah, sorry. It was a bit whitespace damages on my end. This did really fix the
megasas_raid boot hang here. Since 103fbf8e4020 ("scsi: megaraid_sas: Added
support for shared host tagset for cpuhotplug") is now in the mainline, it
probably makes sense to merge this patchset for v5.10 as well to avoid breakage.
Anyway,

Tested-by: Qian Cai <qcai@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

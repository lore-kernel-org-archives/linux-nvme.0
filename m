Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE5C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 01:11:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14686216C4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 01:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bnf43jqd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzSVP6Hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14686216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZtHq0hREQox/ejNaCkvSPuk9pnbgiqz5KJ6g1eAzEg0=; b=Bnf43jqdnGqIIAhBuHRP1LPc0
	JSKrko1t4KfxeutXFmLir9eYj2LVycppzA5uryxN5UvhUXOmCScDsPiu3aeOdABpPWN1OcYID4RAo
	zy+TfJmzVkR6hK+khoy4xdcDp1cGoXF+OeGNyoOr1f7Pzefsua5gxMcRqB5Wm8iNQXEesiH735HXm
	KTEePY4ihFobEqhYES+zDrVNulOVrWUz53WRJ1C+mTMWY3n6zYSboSwh4Y4l3NR1fT0ZjnAbgJivd
	EWxnFouuClT8lsiUJo9mgbPAULUkufhkNTCKavGQWanuZ3yVDD9NwHlQTDF1+DK8l/jp7IKsIeO+O
	Dy085EZww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdNct-0005rz-9j; Fri, 13 Nov 2020 01:11:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdNcr-0005rY-Ha
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 01:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605229900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFC6GmXGxNLsCv2kR+1bEWk/RI1lu80rZMe/SAoeXfs=;
 b=GzSVP6Hwbma+lAQPkQxuIx8wHd5vient8/Iq8/RRTMqrInw2bXGiUYZevTT0p8O2l0qjmr
 JWhtudUpNZjm1c7p/zWE4Cp/7DIrN7Hbg+JUiFA50Pz0IhqVKFlRxXcOxIC8qxZctGyVBc
 ZJvkna0p7Wb1v//bAEdDNUaSmCS/+bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Bd9YajE4McO-GneWj1aO_Q-1; Thu, 12 Nov 2020 20:11:37 -0500
X-MC-Unique: Bd9YajE4McO-GneWj1aO_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB3210066FB;
 Fri, 13 Nov 2020 01:11:35 +0000 (UTC)
Received: from T590 (ovpn-12-25.pek2.redhat.com [10.72.12.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A12CC5D9D5;
 Fri, 13 Nov 2020 01:11:23 +0000 (UTC)
Date: Fri, 13 Nov 2020 09:11:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
Message-ID: <20201113011118.GC1012796@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
 <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
 <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_201141_637051_00B2C9D6 
X-CRM114-Status: GOOD (  19.48  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Qian Cai <cai@redhat.com>,
 John Garry <john.garry@huawei.com>, linux-nvme@lists.infradead.org,
 Kashyap Desai <kashyap.desai@broadcom.com>, linux-block@vger.kernel.org,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 12, 2020 at 07:29:13AM -0800, Bart Van Assche wrote:
> On 11/12/20 7:12 AM, Bart Van Assche wrote:
> > On 11/11/20 11:55 PM, Ming Lei wrote:
> >> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> >>
> >> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> >> locking' by nvme-loop's lock class, no need to apply dynamically
> >> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> >> lockdep complaint triggered by request queue flushing").
> >>
> >> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
> >> is reported the whole probe may take more than half an hour.
> > 
> > The code touched by this patch is compiled out with locked disabled so
> > it is not clear to me how this patch could affect a probe delay for
> > megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
> > caused correctly?
> 
> (replying to my own email)
> 
> I found the answer in the descriptions of the previous patches of this
> series. I think this patch would benefit from a more complete patch
> description.

Hello Bart,

OK, I can add more words to this commit log.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

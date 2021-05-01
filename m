Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050BC433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 15:20:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF0161462
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 15:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF0161462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=idhqM7IxmpkDs9WPmtT7gy9gxjNPsSEgx8UmIZzS0RI=; b=hL3ubt1NmK5CRmXyYrbclTttc
	pwtxwmss3usJhAkYXG0enYZlpt9IaYMUnQLKNCcu7QiqTcmGFSmiV2GkyU3kmNB2vudGiJG7mj7JG
	ITL13lya0Si2ecnUBF4oOzsLKq/LnZJJTD3MSntzTdIjKC6kzSwG5nJA404lnzv2gcGyWyPKomZHh
	6FqqLH9fs/MaxJxSPBaQCT1uAdowE//7VoywnVXha8CHEuVXJ46ZjRFNil3L5ky+2Bc1ES6kyFF24
	q8cchV/BgISkpD+WWzzrJozALm2+jVeEuw2KP/+D/mOcR0Ov3+NFEKkoSijUXdOqEiLIoE4a6KCMK
	rmUmb6HYg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcrPH-00AGlP-Mt; Sat, 01 May 2021 15:19:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcrPC-00AGl7-Mg
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 15:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6rFHOewkqpfaAfcRGyC3A1F6e6B81+Bw3V/AJ/vMzXM=; b=U1xuipCxz9TRdZLWGubRkOOaMl
 HLF2VaPz+P8Vv4W3K4C31xzHIVXFzBP2bU3lIRl8efjl89H9cniNGqrCCrPqPzOdVH/XR8a8hMPvd
 APkqfk6BQK8Gx9RdPuhAZiFfn81ed61IlTivWzlSrUkyPLFMwKQ2WEERpgfTZCTFZDqAxouYus2Q0
 0dLazkSDIbbo03WExh5PqRNT5uJ7EotJMz0Xw8xZ3F4L/CnHbt4BN+PMxJSFY4XTgvSxk81lcTAnS
 O6a2Qkk3Q1PuEYKjOMKSvYYSzpPAPUqTDtpOS7J7/HV9rFppyLhRUXWlNoVDXA6X4DCQZQx5m8nsc
 a3QtsJPA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcrP9-0022Ww-BM
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 15:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619882377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rFHOewkqpfaAfcRGyC3A1F6e6B81+Bw3V/AJ/vMzXM=;
 b=ZnlMH9R8UjUxfmwv0B3yvRNxxM8r5MsmB5RmbYmKgX930WYt0mc40J2V+KtsAyCLNHZZSD
 LcruD8j+BQ0+eBwhRWW/kggwA0pqgMdlCqtvUJJ9LvnijytsW4gz/57kJim5IdrCBrOWTT
 Jyny1ONLvLLW6sy1t5v03azTe0Hu0jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-GYOaYCb-NWC70J2HhBvwiw-1; Sat, 01 May 2021 11:19:34 -0400
X-MC-Unique: GYOaYCb-NWC70J2HhBvwiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A2D5801107;
 Sat,  1 May 2021 15:19:33 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7202B1D0;
 Sat,  1 May 2021 15:19:29 +0000 (UTC)
Date: Sat, 1 May 2021 11:19:28 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210501151928.GA12518@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de> <20210420143852.GB14523@redhat.com>
 <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
 <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_081939_496991_8F6A3A14 
X-CRM114-Status: GOOD (  37.95  )
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

On Sat, May 01 2021 at  7:58am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 4/20/21 5:46 PM, Laurence Oberman wrote:
> [ .. ]
> >
> >Let me add some reasons why as primarily a support person that this is
> >important and try avoid another combative situation.
> >
> >Customers depend on managing device-mapper-multipath the way it is now
> >even with the advent of nvme-over-F/C. Years of administration and
> >management for multiple Enterprise O/S vendor customers (Suse/Red Hat,
> >Oracle) all depend on managing multipath access in a transparent way.
> >
> >I respect everybody's point of view here but native does change log
> >alerting and recovery and that is what will take time for customers to
> >adopt.
> >
> >It is going to take time for Enterprise customers to transition so all
> >we want is an option for them. At some point they will move to native
> >but we always like to keep in step with upstream as much as possible.
> >
> >Of course we could live with RHEL-only for while but that defeats our
> >intention to be as close to upstream as possible.
> >
> >If we could have this accepted upstream for now perhaps when customers
> >are ready to move to native only we could phase this out.
> >
> >Any technical reason why this would not fly is of course important to
> >consider but perhaps for now we have a parallel option until we dont.
> >
> Curiously, we (as in we as SLES developers) have found just the opposite.
> NVMe is a new technology, and out of necessity there will not be any
> existing installations where we have to be compatible with.
> We have switched to native NVMe multipathing with SLE15, and decided
> to educate customers that NVMe is a different concept than SCSI, and
> one shouldn't try treat both the same way.

As you well know: dm-multipath was first engineered to handle SCSI, and
it was too tightly coupled at the start, but the scsi_dh interface
provided sorely missing abstraction. With NVMe, dm-multipath was
further enhanced to not do work only needed for SCSI.

Seems SUSE has forgotten that dm-multipath has taken strides to properly
abstract away SCSI specific details, at least this patchset forgot it
(because proper layering/abstraction is too hard? that mantra is what
gave native NVMe multipath life BTW):
https://patchwork.kernel.org/project/dm-devel/list/?series=475271

Long story short, there is utility in dm-multipath being transport
agnostic with specialized protocol specific bits properly abstracted.

If you or others don't care about any of that anymore, that's fine! But
it doesn't mean others don't. Thankfully both can exist perfectly fine,
sadly that clearly isn't possible without absurd tribal fighting (at
least in the context of NVMe).

And to be clear Hannes: your quick review of this patchset couldn't have
been less helpful or informed. Yet it enabled NVMe maintainers to ignore
technical review (you gave them cover).

The lack of proper technical review of this patchset was astonishing but
hch's dysfunctional attack that took its place really _should_ concern
others. Seems it doesn't, must be nice to not have a dog in the fight
other than philosophical ideals that enable turning a blind eye.

> This was helped by the
> fact the SLE15 is a new release, so customers were accustomed to
> having to change bits and pieces in their infrastructure to support
> new releases.

Sounds like you either have very few customers and/or they don't use
layers that were engineered with dm-multipath being an integral layer
in the IO stack. That's fine, but that doesn't prove anything other
than your limited experience.

> Overall it worked reasonably well; we sure found plenty of bugs, but
> that was kind of expected, and for bad or worse nearly all of them
> turned out to be upstream issues. Which was good for us (nothing
> beats being able to blame things on upstream, if one is careful to
> not linger too much on the fact that one is part of upstream); and
> upstream these things will need to be fixed anyway.
> So we had a bit of a mixed experience, but customers seemed to be
> happy enough with this step.
> 
> Sorry about that :-)

Nothing to be sorry about, good on you and the others at SUSE
engineering for improving native NVMe multipathing. Red Hat supports it
too, so your and others' efforts are appreciated there.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

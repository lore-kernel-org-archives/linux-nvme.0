Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB4C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 15:48:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFD46100A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 15:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFD46100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nvbJjVzTJakL83LNfMPb6eYAtN+LX2Y5ZZC+n5GTZTA=; b=Xmg+0aEBg03T2fsCwB6Duqkr5
	p2yQubnS9jlc7FKSxyBs0zXf3hWDIe7vARJ/tTJb0sUt36IJ8K/g0sxwn6UyCrVEwSbqpvSmcgcen
	dFWwbsOei8RyWheGbcsV6vcv25Pd/UVlMiiydYDvhgyXkacTQR8Ij2TBjLPqpjOS494e62GgUpmb3
	Uh79/sFxN27c+U+xaytkDYsaVZD1JBtYeHEwB+KVI3w97qAcVeabf/He3Vi0yvXS8PDKrITcMBpWm
	r8TfeJfo0Bn7yXD9uHN7iqKooNKdcr8GSVHVjjQkJUMH8aZ6tBjl8IldrsTROtHOSd9GyeQ6N+CpB
	0y1eD8LLQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYsbi-00CW9c-7J; Tue, 20 Apr 2021 15:48:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYsbe-00CW9T-TM
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 15:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Mime-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=j1INruBx24Ua8mW5n6gn035HvblxXMh5qaFfcyHwj6A=; b=DYd3ufPMK/jBl6n0EW82wGhzBY
 N8NVH4sKqsMz7t/wuF+iKc4TFIjuNj6hr6bvVi02EFM1zFS5gZcwoysPqrEketaAmJ/YImfnxl8FK
 htrfsczpWZimkNrQd/oATLFojkaxd3/h8D1BuVPNgQhPqTrOguYZ3rnw3RDZiVb859R5g6pGkAP1v
 eFvAOHngtZ2OZca7v8qnOoJYlDD2BymGtYWu6PReuA8cPB4mKI6nVGsk7yBjSptzn+W/skLrPQ+fX
 2r47qzBIW3HFkvbCZQQEhnfM6sSD0KqeSkw2PiNpRQGB81ec49aqJN576Uq/jCJKtS64fACC84NxQ
 i+1Sv5vg==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYsbc-00CFS7-4S
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 15:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618933682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1INruBx24Ua8mW5n6gn035HvblxXMh5qaFfcyHwj6A=;
 b=D6YQGNQ36dvXYUsTEahclYyEPWnzJ8w6Wtc+K+inIdVQ5vp2zm2XX5J/qI9/b9EqF/tNe/
 M681tKPw4HEtq/6HT5/75UZiBm64q+O2Camsevpm9Em6KauYsM2McBYqjnZrpOsJVnlL7+
 Ux3WXCfws/yUYYsputIadJwd2xC2d9k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-tVBb8vQ0PT-N43QEnnwnuQ-1; Tue, 20 Apr 2021 11:46:28 -0400
X-MC-Unique: tVBb8vQ0PT-N43QEnnwnuQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 b20-20020a0cf0540000b02901a471b6ccbaso7191052qvl.22
 for <linux-nvme@lists.infradead.org>; Tue, 20 Apr 2021 08:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j1INruBx24Ua8mW5n6gn035HvblxXMh5qaFfcyHwj6A=;
 b=LIlabHFxy6X6DqKZP78KroD4wECRhZOIor/+1oxNrRPOewU5K1kn78lSEbsV0U7Img
 CzVcz53fHxGFIzuewnOZG5E9eviSaNCfK7DrlmmtZ0DDzd1L8qMEqPSCbiqmktwkbz7t
 Sm6MhA2ONPMHnC8KpsjieKcu6CEZyQGwHntN2v+2kTu/bi4zIKzrILzfOVMbyGTjzOke
 QWBgrobJAyP5ZxEE3AnCoWhhkGWuMLCQTa1E1uU0/DkMx1dY5ovGoL6Lgo/F9W9I2IWT
 B/GzDFD3QzUJbI2RYIUgVgWoAVqe8VFW+3jXgymoay64ErAY4ZNxhnZTygSxh6vyKGfE
 5xqQ==
X-Gm-Message-State: AOAM53067kG86vLUSgnECGJT+vsPvVmj5wHq6ZZk+kEjVW7LLEXcS+s4
 q41soOmrBjgzosYzDWjGL2zTHXoOjZrfRZkEwh0WLgs5sVVqnmEooSgVtx830cq5oZukeY+bitX
 /jjVo+jgrvVwHPDON4/YEvJg8Qdw=
X-Received: by 2002:a37:38f:: with SMTP id 137mr17412122qkd.498.1618933588210; 
 Tue, 20 Apr 2021 08:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6NYuKtuKMEt8biboxN/WNrnfdnbDSXSGpiw0EYoPPbYA8ddcMRMsZxP29zxNos+pDvYXujw==
X-Received: by 2002:a37:38f:: with SMTP id 137mr17412079qkd.498.1618933587905; 
 Tue, 20 Apr 2021 08:46:27 -0700 (PDT)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
 by smtp.gmail.com with ESMTPSA id k22sm12373407qkh.28.2021.04.20.08.46.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Apr 2021 08:46:27 -0700 (PDT)
Message-ID: <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
From: Laurence Oberman <loberman@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Tue, 20 Apr 2021 11:46:26 -0400
In-Reply-To: <20210420143852.GB14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de> <20210420143852.GB14523@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7)
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=loberman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_084804_287158_B4A7246E 
X-CRM114-Status: GOOD (  32.30  )
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

On Tue, 2021-04-20 at 10:38 -0400, Mike Snitzer wrote:
> On Tue, Apr 20 2021 at  5:37am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > RHEL9 is coming, would really prefer that these changes land
> > > upstream
> > > rather than carry them within RHEL.
> > 
> > We've told from the very beginning that dm-multipth on nvme is not
> > a support configuration.
> 
> You have some high quality revisionist history there. But other than
> pointing that out I'm not going to dwell on our past discussions on
> how
> NVMe multipathing would be.
> 
> > Red Hat decided to ignore that and live with the pain.
> 
> Red Hat supports both native nvme-multipath _and_ DM-multipath on
> NVMe.
> 
> The only "pain" I've been living with is trying to get you to be
> impartial and allow others to provide Linux multipathing as they see
> fit.
> 
> > Your major version change is a chance to fix this up on the Red Hat
> > side, not to resubmit bogus patches upstream.
> 
> Please spare me the vapid and baseless assertion about patches you
> refuse to review technically without political motivation.
> 
> > In other words: please get your house in order NOW.
> 
> My simple 3 patch submission was an attempt to do so. Reality is the
> Linux NVMe maintainers need to get their collective house in order.
> 
> Until sanity prevails these NVMe changes will be carried in RHEL. And
> if
> you go out of your way to cause trivial, or elaborate, conflicts now
> that you _know_ that changes that are being carried it will be
> handled
> without issue.
> 
> Sad this is where we are but it is what it is.
> 
> Linux is about choice that is founded upon need. Hostile action that
> unilaterally limits choice is antithetical to Linux and Open Source.
> 
> Mike
> 

Hello

Let me add some reasons why as primarily a support person that this is
important and try avoid another combative situation. 

Customers depend on managing device-mapper-multipath the way it is now
even with the advent of nvme-over-F/C. Years of administration and
management for multiple Enterprise O/S vendor customers (Suse/Red Hat,
Oracle) all depend on managing multipath access in a transparent way.

I respect everybody's point of view here but native does change log
alerting and recovery and that is what will take time for customers to
adopt. 

It is going to take time for Enterprise customers to transition so all
we want is an option for them. At some point they will move to native
but we always like to keep in step with upstream as much as possible.

Of course we could live with RHEL-only for while but that defeats our
intention to be as close to upstream as possible.

If we could have this accepted upstream for now perhaps when customers
are ready to move to native only we could phase this out.

Any technical reason why this would not fly is of course important to
consider but perhaps for now we have a parallel option until we dont.

With due respect to all concerned.

Laurence Oberman


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

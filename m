Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F8C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 12:33:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413126102A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 12:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 413126102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4bAPUIcPKFjRRD+4xvYJ3eOiJPtCOHiJaC3hZz+5eg=; b=xWgswdocdtzCvMmiIa55tkyrMg
	tdggV3QMDxx89tNRjmkwQWQVBK5JrwvJ5UIGXzGLyxpkhHZgNhQwDfhlCdTQZIkJ2ozstrVGdQioL
	k5goZ5SbEAg91guheU/U0+1MiWclosza7B/uLX0/kGITPOQm8QvikbJKhn5i0C4gk3lCq1A+rveSl
	lI+MIxqvtzd+xY8f2CsjbVgJ0mPAKfPKbsgkA4FD7i2tOHhycRXjGIY5JkFG8dDozItuKD1Ho3YXB
	EcAolA09cZV97FZMztkunA2u8SOwQB5HLuRSR5dyM6qPdInPuCrmiAukWxE/jkv4/glwzJFbSOxPV
	snPan3lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkmn8-005QPY-6y; Wed, 10 Nov 2021 12:33:26 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkmm5-005Ptn-25
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 12:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1636547535;
 bh=Z3YhinHc8QcbATN4epE+xiKzHYWvAPm6wVUqFFN14TI=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=vyJ+fGgyrDLFBqsvq/+O4TvOfAfQiSj4ADfAzC74KBvIJEM0dRIJaMijnlJjFJkPu
 9tLD4RbJFaE4DQ0DDuWDrQiJWFkkKlK6ZasenSU0UJ/ma8l0/viCM8ATS1jNI/mNpI
 QpS4MInhLSQSooQdoJPauMT1zWSFS2PRltDGbGh0=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 21726128094A;
 Wed, 10 Nov 2021 07:32:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id TXkaZrjrk1bF; Wed, 10 Nov 2021 07:32:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1636547534;
 bh=Z3YhinHc8QcbATN4epE+xiKzHYWvAPm6wVUqFFN14TI=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=xj2h/XZyfmg5xrko5DoctyB0RyZbyuwBIMn6le8dUK3PdcB8jUG1Yftn1vCkCzo3+
 vofbWN+lR7xJm9tLjWy2olqG49MqczbmlsTZBJ7LRAyrSuhtr7KqilAtwtVtkmAgQ3
 1wKGdv+UD2rcUHIeWzswvFabzECRQyE557vJGQrc=
Received: from jarvis.int.hansenpartnership.com (unknown
 [IPv6:2601:5c4:4300:c551::527])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E943128088B;
 Wed, 10 Nov 2021 07:32:14 -0500 (EST)
Message-ID: <4829537ded072df6fe596e7fd0387a790f1b87d0.camel@HansenPartnership.com>
Subject: Re: sorting out the freeze / quiesce mess
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nvme@lists.infradead.org
Date: Wed, 10 Nov 2021 07:32:13 -0500
In-Reply-To: <477f3098-39be-ad07-e2fb-3ef3309c4dce@suse.de>
References: <20211110091407.GA8396@lst.de>
 <477f3098-39be-ad07-e2fb-3ef3309c4dce@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_043221_167383_A6C06E1B 
X-CRM114-Status: GOOD (  22.98  )
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

On Wed, 2021-11-10 at 11:22 +0100, Hannes Reinecke wrote:
> On 11/10/21 10:14 AM, Christoph Hellwig wrote:
> > Hi Jens and Ming,
> > 
> > I've been looking into properly supporting queue freezing for bio
> > based
> > drivers (that is only release q_usage_counter on bio completion for
> > them).
> > And the deeper I look into the code the more I'm confused by us
> > having
> > the blk_mq_quiesce* interface in addition to
> > blk_freeze_queue.  What
> > is a good reason to do a quiesce separately from a freeze?
> > 
> IIRC the 'quiesce' interface was an abstraction from the SCSI
> 'quiesce'
> operation, where we had to stop all I/O except for TMFs and scanning.
> And 'freeze' was designed fro stopping all I/O.

Quiesce was a specific invention for SPI Domain Validation.  That's
where you try a specific set of patterns to the buffer and read them
back and try to jack up the transport parameters.  Pretty much every
transport does this type of retraining, but on all but SPI it's usually
hidden in hardware.

The point is you need to be able to stop all other I/O and then send
READ/WRITE_BUFFER commands to the device.

> But I'm not sure if that ever was the distinction, or if it still
> applies today.

As long as the SPI transport class exists, there'll be a distinction.
I'm not sure there's a use for quiesce beyond that.

> And yeah, I've been wondering myself.
> 
> Probably we should just kill the 'quiesce' stuff and see where we end
> up :-)

The SPI transport class would break.

James




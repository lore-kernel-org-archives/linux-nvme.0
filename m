Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DE2E92FC9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b2tQ3RBiSUcSSCDIGm1AqxO9GDksjubSbZBBLyz+/c8=; b=s1I9bCASTx5qpJCZBeFy/fvqeW
	w5JYsPHJqXtSJ902xhXMZCOQBpuLdK/HGkSEOeIXCTusNvswsvO3PD7qAp8CpCvGFXhly/Q+RdvCe
	/v0cPaFl0Z/Xx9colo/fSCV8vMqDTOR3UzEUEJ7IVsEXq5xPmgYvuM9WAhXCTO1XnA18gURpTyYr8
	ljHGe+ZwvNdpRQh6hW+lhZEwKe+YCtOjB+gVLYrfghMZpBZGOZbPmclJqtrw3AbZFwq8eT/ulLLNk
	EM11+KdMZE9loqYoTiy7KvXjKJchjqNu/WgF3a3PGGWUKofNQwkw2j9wE+t1+Y8OI38FK+6AD6KU6
	No7YYGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoWxM-004ZPV-39;
	Thu, 05 Oct 2023 22:36:32 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoWxJ-004ZON-15
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 22:36:30 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so1049753a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696545387; x=1697150187; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2tQ3RBiSUcSSCDIGm1AqxO9GDksjubSbZBBLyz+/c8=;
        b=qnt4mUm7Xo93hqVudlnTaJM9lX0vNlvp2/tlZ6HJN4uYTbJllY8FrFwC2s00bOOPxq
         VKcswEFgDshAOItfnGdlkSoHFh/8vhoTsfD4si8+OC5smYm8IYeDOsspLBia8L2ZX4I7
         WAz71SE6JhbJMmg4zZz7XKxJ6kqRBo1YEwH5IlQeXTpC3jTMYsEKJ6cGnyPeZUsPN7/A
         Pa+JMKwLooR0ujISBbr3iqVn1nmYvTzgnb79s/vKGUFvZk3LLUp2PQs862gtAu/j3mHf
         fO7Zwim4WZa2OXB2ST/ov4u7+nxGp8n0ergYxe7P8/s7kR7ydnTzsnAggyT3T2CDnnbL
         t8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545387; x=1697150187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2tQ3RBiSUcSSCDIGm1AqxO9GDksjubSbZBBLyz+/c8=;
        b=EV5I2Y+zSUUTI81EmT4HXIWsThI9WFePZl37ch678KK+o9ath4R9dp3afvJm8VFysC
         PjmBmIM+DnNXUeBmB02ri0J/AP+vbIiATmLMHn6308BnQSSxbf5Tw/YrB9ZNJfnu4y+t
         WwaugaDEN8io6cGT7Zr2jnIB6VveDI4e9HLaaWbKvbYo7hSojxmjwiXd2ZWMDf983xxr
         YjsTQdSU0DTE9qTXPDM7Zoomg5xuXQCQeQ71dX0YS/sz9w361XayYcy0MCAXeywMj3c4
         ibke6iDlcabojEv/z7nlpCrawjs2C2zE2/HL+HPJxD/hQMwUa57GZ4I8eM3+C+jpF+pw
         qRRA==
X-Gm-Message-State: AOJu0YzQvbK1hBIC2OJl5AbMnyIuE/sjS0y9gZCaJpWRSy6YCyUTV65R
	2ZfZrf02OElype/BNZaOSycU5A==
X-Google-Smtp-Source: AGHT+IHkj05WtFRnB1/6TCdC5uNJ+qJuxlAMKS08tzhEQ93tj2n+6Zd7zWsUmCjHAtuzu3cQRcYWSg==
X-Received: by 2002:a17:90a:2cc4:b0:271:7cd6:165d with SMTP id n62-20020a17090a2cc400b002717cd6165dmr6401433pjd.26.1696545387428;
        Thu, 05 Oct 2023 15:36:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a005e00b002776350b50dsm4406336pjb.29.2023.10.05.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:36:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qoWxD-009xqX-3D;
	Fri, 06 Oct 2023 09:36:24 +1100
Date: Fri, 6 Oct 2023 09:36:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR86Z1OcO52a4BtH@dread.disaster.area>
References: <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_153629_569196_8B3F6FF6 
X-CRM114-Status: GOOD (  19.86  )
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

On Thu, Oct 05, 2023 at 10:10:45AM -0700, Bart Van Assche wrote:
> On 10/4/23 11:17, Martin K. Petersen wrote:
> > 
> > Hi Bart!
> > 
> > > In other words, also for the above example it is guaranteed that
> > > writes of a single logical block (512 bytes) are atomic, no matter
> > > what value is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.
> > 
> > There is no formal guarantee that a disk drive sector read-modify-write
> > operation results in a readable sector after a power failure. We have
> > definitely seen blocks being mangled in the field.
> 
> Aren't block devices expected to use a capacitor that provides enough
> power to handle power failures cleanly?

Nope.

Any block device that says it operates in writeback cache mode (i.e.
almost every single consumer SATA and NVMe drive ever made) has a
volatile write back cache and so does not provide any power fail
data integrity guarantees. Simple to check, my less-than-1-yr-old
workstation tells me:

$ lspci |grep -i nvme
03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
$ cat /sys/block/nvme*n1/queue/write_cache
write back
write back
$

That they have volatile writeback caches....

> How about blacklisting block devices that mangle blocks if a power
> failure occurs? I think such block devices are not compatible with
> journaling filesystems nor with log-structured filesystems.

Statements like this from people working on storage hardware really
worry me. It demonstrates a lack of understanding of how filesystems
actually work, not to mention the fact that this architectural
problem (i.e. handling volatile device write caches correctly) was
solved in the Linux IO stack a couple of decades ago. This isn't
even 'state of the art' knowledge - this is foundational knowlege
that everyone working on storage should know.

The tl;dr summary is that filesystems will issue a cache flush
request (REQ_PREFLUSH) and/or write-through to stable storage
semantics (REQ_FUA) for any data, metadata or journal IO that has
data integrity and/or ordering requirements associated with it. The
block layer will then do the most optimal correct thing with that
request (e.g. ignore them for IO being directed at WC disabled
devices), but it guarantees the flush/fua semantics for those IOs
will be provided by all layers in the stack right down to the
persistent storage media itself. Hence all the filesystem has to do
is get it's IO and cache flush ordering correct, and everything
just works regardless of the underlying storage capabilities.

And, yes, any storage device with volatile caches that doesn't
implement cache flushes correctly is considered broken and will get
black listed....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


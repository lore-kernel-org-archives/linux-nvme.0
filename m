Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E4C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:02:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A4961056
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A4961056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tFEXnT0Lx3Dd0nlals/HrKDj8toDrtpg3AMJlQX+vpc=; b=WOvx/TRuytVbuCD8dibgbyo9A
	zpUuQhECFvik5myrtC4zzZJrPZSjKmSBwgjz2jP4zcZRuxrwafy1l+fake5wHHluOrTCfMBNqs/Xt
	y3rrwlM7IHdnJFxT2pokfxmjgnAz1S8J+0u77zKBz3hoeJ2sb+jVRvdmBFmPxdHVoEWr5uIS8hm/b
	J0Ml0WL6WS7Z2e4ZpJt7jHsrbXbYajmHh92TwlU7eDl3meUd3UVzEXEE75XgZ7nX06IYOZR5YgDPa
	Sx5dzK6RnkDXz6pLIPP5eAdHpOtrJ2W9X2eGjT2N7p3CHrW4MAxnJIXxGjKW34G03mmcGhWIvCMdF
	sx67Frm+Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRhyO-007bvY-7A; Wed, 31 Mar 2021 21:01:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRhyJ-007bu8-TZ
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 21:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617224510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VK3wZ2uZxurW5NHYBbFfGkqs4fcBNPjrFax0D4qhIZg=;
 b=QXqe5XsZKjyc2Tl6Qu5lMrUyo6Zfv5w0uObugro7Ea/54RJSYv/KHneI2eyjLrgHp9UX52
 p4Mi9grHnULeGMLpRnQAkzWpXCWygE9IAaOJV4eOYaMXGiiJfhphag1lsxmBfpU80jLx/1
 2UVfADNUjTSp0KkR9om0oxbhO2ePx30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-nqaMPqcBPYiIv5xBLk0AZQ-1; Wed, 31 Mar 2021 17:01:45 -0400
X-MC-Unique: nqaMPqcBPYiIv5xBLk0AZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E93501F8;
 Wed, 31 Mar 2021 21:01:43 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com
 [10.3.112.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7E059451;
 Wed, 31 Mar 2021 21:01:42 +0000 (UTC)
Message-ID: <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
From: "Ewan D. Milne" <emilne@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>
Date: Wed, 31 Mar 2021 17:01:41 -0400
In-Reply-To: <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_220152_533675_A7AAE464 
X-CRM114-Status: GOOD (  41.09  )
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

On Wed, 2021-03-31 at 09:11 +0200, Hannes Reinecke wrote:
> On 3/31/21 1:28 AM, Keith Busch wrote:
> > On Tue, Mar 30, 2021 at 10:34:25AM -0700, Sagi Grimberg wrote:
> > > 
> > > > > It is, but in this situation, the controller is sending a
> > > > > second
> > > > > completion that results in a use-after-free, which makes the
> > > > > transport irrelevant. Unless there is some other flow (which
> > > > > is
> > > > > unclear
> > > > > to me) that causes this which is a bug that needs to be fixed
> > > > > rather
> > > > > than hidden with a safeguard.
> > > > > 
> > > > 
> > > > The kernel should not crash regardless of any network traffic
> > > > that is
> > > > sent to the system.  It should not be possible to either
> > > > intentionally
> > > > of mistakenly contruct packets that will deny service in this
> > > > way.
> > > 
> > > This is not specific to nvme-tcp. I can build an rdma or pci
> > > controller
> > > that can trigger the same crash... I saw a similar patch from
> > > Hannes
> > > implemented in the scsi level, and not the individual scsi
> > > transports..
> > 
> > If scsi wants this too, this could be made generic at the blk-mq
> > level.
> > We just need to make something like blk_mq_tag_to_rq(), but return
> > NULL
> > if the request isn't started.
> >  
> > > I would also mention, that a crash is not even the scariest issue
> > > that
> > > we can see here, because if the request happened to be reused we
> > > are
> > > in the silent data corruption realm...
> > 
> > If this does happen, I think we have to come up with some way to
> > mitigate it. We're not utilizing the full 16 bits of the
> > command_id, so
> > maybe we can append something like a generation sequence number
> > that can
> > be checked for validity.
> > 
> 
> ... which will be near impossible.
> We can protect against crashing on invalid frames.
> We can _not_ protect against maliciously crafted packets referencing
> any
> random _existing_ tag; that's what TLS is for.
> 
> What we can do, though, is checking the 'state' field in the tcp
> request, and only allow completions for commands which are in a state
> allowing for completions.
> 
> Let's see if I can whip up a patch.

That would be great.  BTW in the crash dump I am looking at now, it
looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
blk_mq_tag_to_rq() returned a request struct that had not been used.
So I think we do need to check that the tag was actually allocated.

-Ewan

> 
> Cheers,
> 
> Hannes


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

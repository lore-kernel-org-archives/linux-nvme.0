Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6924C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:28:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F9561994
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F9561994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zrtoDWmO3DVaIwjue0SDLKeWPTAT+28rfiyMXPy9cOY=; b=UjjJBc6FkJmI0MV1OgJmUNzLj
	65nW3WKh2IXoXve88bn7O9PjLqCLT1ZrLi3kKV8iFmD97ampnqsv+tB2ObaBzFuLGW2hGjwusjTu1
	mpYVs6b1NOo6hwqT+V5rCylH52QF1npAff40gwTaXl1mkWAUmuuG4VRDE7hLO8XJ6kOo9F1GAMgIN
	KpoLBR5/b3cTTamLYgI4pKiBu6WPpfrD+mph4BdEunFpmanxIa0V8vBl57hfXveIRy+PZX7Y4m3NA
	l+ajgqEEp2v0z5eOUOz6QKNjzhjlzuQzIzyNtjD+gLo3riNL2L5sX/BMBkZZrM+ROzmP/RxU3G3wA
	KWeb5Qjtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNmg-0057Kd-Qt; Tue, 30 Mar 2021 23:28:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNmZ-0057JB-5K
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:28:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 320D1619C5;
 Tue, 30 Mar 2021 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617146895;
 bh=JKd1VbmOyIxeYYnhoR9PcFkCGIARvQmU3qkgyQeXv8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oVnxqmExzEUKexrN+MwPe7c5hHq04spz3fIULCOflsuql5m/Ri/Egsjj28bhJo9yI
 No5R3/f3rMxkMIPWhPaavTIAAXUCnEOq10zJQfmc09jexwwNzPYtQEing32+03PiDW
 CtxmKCkALSsLn0/3ERWxqFWRjhNcayjSjOul0kApt7odjU7YbyzSyJ96Ok1dr4smxM
 zk3miGcMU+Q2KwtgEC7QinlIEOHRrsThNf6m72kvZ7DCoZDJ2ts4ypib73/P3I6dAs
 oZ6yDTxzJEfVyt9e92cYbRWKPV7fZ0WW7+ABr1b1OFbX8wE+0q4zqaK0V74Xp89hBb
 Y6KCvZx+O26Xw==
Date: Tue, 30 Mar 2021 16:28:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_002824_030891_410A5B34 
X-CRM114-Status: GOOD (  24.80  )
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

On Tue, Mar 30, 2021 at 10:34:25AM -0700, Sagi Grimberg wrote:
> 
> > > It is, but in this situation, the controller is sending a second
> > > completion that results in a use-after-free, which makes the
> > > transport irrelevant. Unless there is some other flow (which is
> > > unclear
> > > to me) that causes this which is a bug that needs to be fixed rather
> > > than hidden with a safeguard.
> > > 
> > 
> > The kernel should not crash regardless of any network traffic that is
> > sent to the system.  It should not be possible to either intentionally
> > of mistakenly contruct packets that will deny service in this way.
> 
> This is not specific to nvme-tcp. I can build an rdma or pci controller
> that can trigger the same crash... I saw a similar patch from Hannes
> implemented in the scsi level, and not the individual scsi transports..

If scsi wants this too, this could be made generic at the blk-mq level.
We just need to make something like blk_mq_tag_to_rq(), but return NULL
if the request isn't started.
 
> I would also mention, that a crash is not even the scariest issue that
> we can see here, because if the request happened to be reused we are
> in the silent data corruption realm...

If this does happen, I think we have to come up with some way to
mitigate it. We're not utilizing the full 16 bits of the command_id, so
maybe we can append something like a generation sequence number that can
be checked for validity.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

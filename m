Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D6C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:15:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A81C613B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A81C613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LIUMsm+u4T4DEYSXT20roL9kzHrvn4OFV2SL+26Kkgs=; b=hkGd/zdl4g9Nsi5DNJvXXIIo3
	20ikdTk72WuueIFwWHccPnj5gUurPvxL0W+stkCOjq0Qdcodbi4I1D6zVzOs3EQh1Aa410DzGffeI
	GdpTmCxk+9oMoIjIaUYLrJmZaR7Q817rdiGcOSIh10V7y5Vc4Gtg0EgjY/7o6RCaMU6z2PG/7FZ+9
	aSr2Zwy/xaCbrRXUHfa3CiwWyIUN21FDNOh9dk0lA3mKJHekVvBMng4TMU1TaYAwl/WSNzNH/507F
	xOrtKVWS4x5T/5qfmxGgN5WK0z4FxRzm0tvAa4o3P7+HboFJ0cj7c4udO/6TmwpO8Csfw+Kk8kd0w
	cO49u/5uQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYr9N-00CJNJ-TW; Tue, 20 Apr 2021 14:14:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYr9K-00CJMn-8z
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AIL7k3zhKiWHB4mHYaCnDVdOq2vFuwyZH2cjPPxhRWw=; b=ojqTW1mKLdGwrZbKdPl08QWkOE
 V9lgheg4/f8d+UPz17EzXyf+mXjPGyTmyg0DWqT8Aez3+r9VWPm/2i0ZPaPXH47pvJLsbE8C2Rp6i
 TFEGitBt/OoDthMU2q/Rne5Iw8Aenerf4BpWIL03KJ+MsbmWmbC3ZSKJFP20Xl5T3xR7aN9jT/ctJ
 kS2ciQapX66ZFLzKF5aEOFpnxP7if3YtYuKZe8p4wXm4Fl70HtdlG9MiLKaAO7FC2P1ANBcNxIKH2
 M8gMqAzaZVRtPFtJ5OvY8ow+aov1j2TdeBEGiNjzw+HmdJdyDxMGShJ+KvAzA8KRkPUGRgdn0qeHv
 9DjQfwPg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYr9H-00CBRc-Jp
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:14:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 296B5613BF;
 Tue, 20 Apr 2021 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618928083;
 bh=wl9oNKFvslD5tK2B330RJ7zTcLZadyOt8ELvXaXMNzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X5yHsmp7TeJPnTHnIteVBUlIjrQSsWIOoMwNVrehXeysERb+CdKXY90lb7nO+NxsZ
 GN4y2tNC6sR51Q84mDxsTkerzzs8qr4SDJ24Szn6CIaY7TK3KWJ84g5/vmB3pBV7Qz
 QFAiV+w3nU9Vyvsw2ZrU4ovDnvGjrRm/qUL553rpKSIOyUaBe7pvrDMPkpaAR8DNcq
 zRW4SdJoglhipLa+NZStloFjqeLg07OY/HKTtZvGJLnv7Le4+4cIMen81V04rcgHCH
 xeecg2lzRn16TTdJm3JtrFKfKVMS4S8GJH94RSVeZVL0lggcqlL9Dh2T7JE1yexrmT
 KMdphx2m0Gozg==
Date: Tue, 20 Apr 2021 23:14:36 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_071443_712664_364C9BF8 
X-CRM114-Status: GOOD (  20.14  )
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

On Tue, Apr 20, 2021 at 03:19:10PM +0200, Hannes Reinecke wrote:
> On 4/20/21 10:05 AM, Christoph Hellwig wrote:
> > On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:
> > > With the proposed patch, the following messages appear:
> > > 
> > >   [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
> > >   [  227.516807] md/raid1:md0: Operation continuing on 1 devices.
> > 
> > So how is this going to work for e.g. a case where the device
> > disappear due to resets or fabrics connection problems?  This now
> > directly teards down the device.
> > 
> Yes, that is correct; the nshead will be removed once the last path is
> _removed_.

The end result is also how non-multipath nvme behaves, so I think that's
what users have come to expect.

> But key point here is that once the system finds itself in that
> situation it's impossible to recover, as the refcounts are messed.
> Even a manual connect call with the same parameter will _not_ restore
> operation, but rather result in a new namespace.

I haven't looked at this yet, but is it really not possible to restore
the original namespace upon the reestablished connection?

> So with this patch we change from stalled I/O (where the user has to
> reboot the machine to restore operation) to I/O errors (giving the user at
> least a _chance_ to recover).
> 
> I can easily consider adding a 'queue_if_no_path' option to allow I/O to be
> held even once all paths are disconnected, but that will be enother patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

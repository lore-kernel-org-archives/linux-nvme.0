Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97FCC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 14:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A14D20657
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hx92wvPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A14D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4rDFOXURQG1n+XTYEFZ7Oyr/BQHXGwoJNX/Rv+k8TE=; b=hx92wvPtKxiEFR
	Rd35PDQQXCGkmACy3OtRVbhasbrrI63rFR7khF4pXSMuVJF+8NByIujW9OpL38KKu66w/yp1kZQnN
	1w27fJF5bSkVzFDL9FJqacXb+ybcpZZ65A0ViF9GfrAznio4Np2Q92nnbdhpE0ukx1vcPwpr6NtgK
	Wf23GYiQAmA6Vs93h7wYsfIY8CxcZJKvIebbMyL+9/RtSqEZFR50y/9J3KpKm6+XEmO1EUwnUOoow
	qIyPNCa2hHGJhn2XJCZxKGFFgT8toJLF3mXm33fI9Fin19YsdP8O2xYZY2iRfzZpDUOL+l4XHmTXi
	IEc0/B+zmvHU2wmr6j5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jageY-0001ke-8F; Mon, 18 May 2020 14:22:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jageU-0001kB-RL
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 14:22:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8CCB3AE09;
 Mon, 18 May 2020 14:21:59 +0000 (UTC)
Date: Mon, 18 May 2020 16:21:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v2] nvmet: nvmet_async_events_process always free async
 event to avoid memleak
Message-ID: <20200518142156.jxxrwtethzn3vvsa@beryllium.lan>
References: <1589806918-9711-1-git-send-email-dmilburn@redhat.com>
 <20200518130733.5hfckxyskdom3dsv@beryllium.lan>
 <994479f6-0869-382a-c2b7-64991372c00e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <994479f6-0869-382a-c2b7-64991372c00e@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_072159_027591_F84B82DE 
X-CRM114-Status: GOOD (  15.96  )
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
Cc: hch@infradead.org, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi David,

> > > -	while (ctrl->nr_async_event_cmds) {
> > > +	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
> > > +		aen = list_first_entry(&ctrl->async_events,
> > > +				       struct nvmet_async_event, entry);
> > > +		list_del(&aen->entry);
> > > +		kfree(aen);
> > > +
> > 
> > nvmet_async_event_free() is called from nvmet_sq_destroy(). I thought
> > this function should free all resources. Wouldn't this leak some memory
> > if the condition gets false?
> > 
> 
> It doesn't look like you want to process the nvmet_req if
> ctrl->nr_async_event_cmds is 0, so making the test a ||
> may end up bad. It looks like nvmet_add_async_event grabs the
> ctrl->lock when adding an aen to the list, and it looks like
> this maybe happening when ctrl->lock is let go before a
> nvmet_req_complete().

I admit, I don't really grasp all the details. My concern is that either
nr_async_event_cmds == 0 and the list is empty or
nr_async_event_cmds != 0 and the list is not empty. If it is guaranteed
that those variables are always in sync your change is correct. A more
defensive way would be do have free the list and the array separately.

Thanks,
Daniel

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

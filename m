Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC1CC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 05:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1ZAxNHZlZ6K2N9FB9tgL9h5bP7B/mgaYK9UqOmCPIA=; b=1AysFPr+eGsdXXFuLbx6KRfsPx
	Qch1Vj5o+75dsFbJXbPo5zkxaLWAKVWGL3Sp0MhONNnBrNMB7sE5Ra/3VCojJsNQhM+sDXOLniZTN
	l8uc+CuIB4JEHic9KOV33A/KXXCoQsWZrR2Bl7+VtkApL92zVIjHgAo1YTVm4Vjn5s8u/PW4oSjhq
	QcTZTJUArqovjvT3DCo1xNOBIX4eyvBecZWiiRMpMQU2/i4ETOz1NXHrrADeP+aFQAbMk52sUesU/
	Xieau+KLbarn4xkp+0XZQHdN+/+BId2SHgDLEfkImmqR7ca7YUtZZE35+nZ4nCY2+IaF92maMLScg
	4QZIQvJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onCrV-003x5O-DQ; Tue, 25 Oct 2022 05:52:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onCrS-003x4l-Om
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 05:52:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AAD81FD9B;
	Tue, 25 Oct 2022 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666677142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1ZAxNHZlZ6K2N9FB9tgL9h5bP7B/mgaYK9UqOmCPIA=;
	b=pp8ipjDX5bTwJ9uc3p1pZTv2LbyjX+duJNxj7w8BhDUyt2mUaS46LZkgARurwlpjVAMjgb
	6AENCJz7s02t1xEzwPCSTBhQtBpAXM/p/m9SKDua+9vdwYa3sWM027Efsr5K+7jQAtJEIG
	KPCOWp/Q6XtXmqwGgxhIcY+RLPyd4Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666677142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w1ZAxNHZlZ6K2N9FB9tgL9h5bP7B/mgaYK9UqOmCPIA=;
	b=bihSSjVieQgJYv3niRKeLNeF5Btx13w4g7+wpnHwGiXY9Hi2f8c0qKd1bUG2c9xDzDgGUi
	Trb94opGcNX9idBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CB0C1351F;
	Tue, 25 Oct 2022 05:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id L5B9CpZ5V2MGUgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Oct 2022 05:52:22 +0000
Date: Tue, 25 Oct 2022 07:52:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Message-ID: <20221025055221.vhv3wyyp5bas5ru7@carbon.lan>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_225227_033470_31F8135C 
X-CRM114-Status: GOOD (  24.29  )
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

On Tue, Oct 25, 2022 at 12:54:43AM +0000, Chaitanya Kulkarni wrote:
> On 10/24/22 08:03, Daniel Wagner wrote:
> > Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
> > large amounts of requests.
> > 
> > Cc: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> > 
> > IMO, this patch might still be a good idea to add. At least in my test
> > setup where I only have one ethernet port it makes a big difference
> > when accessing the system via ssh. When nvme-tcp is pushing a lot of
> > data via the network, the ssh session is completely blocked by the
> > storage traffic. With it, the ssh session stays responsive. >
> 
> I'm not sure whether it is possible but is there a way to gather
> some form of quantitative data and present it here to we all know
> exactly which aspect is improving by this patch in context of
> "ssd session is completely blocked" ?

Before starting a fio test run, the remote shell works fine and when fio
runs, no keystroke gets echoed until the fio stops again. Obviously,
this is heavily depending on the workload. So my observation is that
limiting an unbound send loop prevents a 'fair' usage of the bandwidth.

> > +	unsigned long deadline = jiffies + msecs_to_jiffies(1);
> 
> We need to provide some flexibility to set this value as one specified
> value may not work with all the setups and H/W.

Note, this is the identically approach we have in nvme_tcp_io_work()
already. So nothing new. Though I was wondering too why 1 jiffy.

> Can we make it tunable and not statically coded ?

I would really like to avoid having a tunable knob like a sysfs
entry. None will get it right. That means this would need to be
algorithm which auto adapts, though I don't have any good idea how this
algorithm should operate. Any ideas?



Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293BBC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:54:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8261613C8
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8261613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Eu6eUpc4oMzfJexPkU1dQ0ckK4rSoWR47x6DHP8Fn1A=; b=a6xVd/x8TmnKQMDK7DZLVBmgE
	cNcn0E34jgz96N05r+tEz7JbzzCs/2K8KO8uDFKigfAluRUkDiyc+jTGcKh9rWUlIBkOl2ufQDrCD
	BNt1hjzg9U0b4RwEAr1dpatfYLuX9/Ij9h1gpEObLXWj9WecswQcmQBzZu1xZ57nt+rEa9bwZalbB
	W3t1Hp6+SUPd+cB2/KspO3SmOtdvdxItRf0cyP+pB1cvLQGvyS65sy9OKV18K+lrIyYBljzbh0z7a
	8yK5at+K31rmhDnKJQXsgwXfBBK7oUPS0sjDpZILD290YmeUXJeciwVeMKgP1JLb0HCmxpJQu2TuX
	Ym/qLXWAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTmg-0029d0-Jt; Tue, 27 Apr 2021 19:54:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTmd-0029cW-Jb
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=UU+HHD1NBGz6r7F+2OcKRwBgdkVaYixMO3Nrir0+ZUA=; b=LD4b3op8CPtfixGpQ4dzJ3RhZO
 +ox2ANdBHtdYluORSFZdVq3AhEGdErjp+ezj74K++pi6nOE5gxr4YVNUL9CTVqyp8elP7+AXvtEB/
 9ull20oYqLEjXOf9NcuUe4X5dhDfahWYDf1kDB00gLaQ6a//OldX/i+nM3ThdH5parDF3i1RA2Sx4
 O6mbo9SzO3DJN2hGocxXpGh9RvZXhfFj+aOgxpgZv63WtMSA+ConYSLKwya9umeVwFDALGbcmAS+T
 kSbzZPzl6V6K9wrSfOa54+/r7jeDADFEeG1U5akCHcTk4L03vC4nPJ9K4Ofnjk5B2x00rei2s66ok
 ebHTKE/g==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTma-00GxPb-UD
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:54:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619553244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UU+HHD1NBGz6r7F+2OcKRwBgdkVaYixMO3Nrir0+ZUA=;
 b=DUYGCi2Pl2LipOe6CCm3LEmroKkFMxHWQe2BuVTJAlQBad2Hcnqgx2CFmbN06wdfDF65it
 +rgVGwXd2l+7P6jHrsXV0/QQwJ2ndyrQhoo34Fe5nkQDPNxQ0+A4t23/WdlRSPd0jW8IW+
 eQxlgMf1wM7OdaF+omS+rOwjwMC5b2k=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 37B47AD22;
 Tue, 27 Apr 2021 19:54:04 +0000 (UTC)
Message-ID: <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao
 Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org,  stable@vger.kernel.org
Date: Tue, 27 Apr 2021 21:54:02 +0200
In-Reply-To: <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
 <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_125409_174910_A1355737 
X-CRM114-Status: GOOD (  17.68  )
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

On Tue, 2021-04-27 at 20:05 +0200, Hannes Reinecke wrote:
> On 4/27/21 6:25 PM, Christoph Hellwig wrote:
> > On Tue, Apr 27, 2021 at 11:33:04AM +0200, Hannes Reinecke wrote:
> > > As indicated in my previous mail, please change the description.
> > > We have
> > > since established a actual reason (duplicate calls to
> > > add_timer()), so
> > > please list it here.
> > 
> > So what happens if the offending add_timer is changed to mod_timer?
> > 
> I guess that should be fine, as the boilerplate said it can act
> as a safe version of add_timer.
> 
> But that would just solve the crash upon add_timer().

The code doesn't use add_timer(), only mod_timer() and
del_timer_sync(). And we didn't observe a crash upon add_timer(). What
we observed was that a timer had been enqueued multiple times, and the
kernel crashes in expire_timers()->detach_timer(), when it encounters
an already detached entry in the timer list.

Regards,
Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

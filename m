Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C4AC55189
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 09:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1E22073A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 09:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p//8pOvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1E22073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bhl/RWSBDG5C2ESjW0ItGcnBzjm5z6B3weCmPBOoVqk=; b=p//8pOvuuDd3wa
	YtDPAlDCMqk78YLTPm/kFeo30/p2gpBFTEaW5riKFnRg1VhyxrorfvFYsnXtTtH2qBa0sKAnRrpHk
	InHr0/mdU/vqddhMYANLQNqkLHSZX9Bfk8892BfJ6mZZy+gpYlNoNb1MFHsYKlfWIGJQE5g88pOkG
	o2cKjIW7BH9RzNA+vyr9znUrIOvPLHmr299vmier95uVk6oLtctKcn9A47sqP53Qf8BKkQeMQ6Ow6
	oPjdRlwC+23wZaasaRYR3efB3DiDErsGqLo9XnEpyejdYrsPRKxTxtxgbmkR4rdurDVH5ftZcHVml
	ty+IzFhNdoK0Ki9misxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRBch-0006xg-NV; Wed, 22 Apr 2020 09:24:51 +0000
Received: from mx2.didiglobal.com ([111.202.154.82] helo=bsf02.didichuxing.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRBcd-0006vu-PR
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 09:24:50 +0000
X-ASG-Debug-ID: 1587547476-0e4108595b2fbc10001-VMfPqL
Received: from mail.didiglobal.com (localhost [172.20.36.192]) by
 bsf02.didichuxing.com with ESMTP id l3EygbKGDkwUp7ux;
 Wed, 22 Apr 2020 17:24:36 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 17:24:35 +0800
Date: Wed, 22 Apr 2020 17:24:27 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
Message-ID: <20200422092416.GA12930@192.168.3.9>
X-ASG-Orig-Subj: Re: [PATCH] nvme: align io queue count with allocted
 nvme_queue in nvme_probe
References: <20200410095719.GA4393@192.168.3.9>
 <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
 <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
 <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
 <CAA70yB7bkeSwQVjJ5rjGS3HxZtkraUY1FX9ZMHXH8FO6a-8omw@mail.gmail.com>
 <df0fa3a0-7764-bc1f-711d-d264fc4f444f@mellanox.com>
 <20200422083747.GA26915@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422083747.GA26915@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.192]
X-Barracuda-Start-Time: 1587547476
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2041
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81340
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_022448_346008_B38C6729 
X-CRM114-Status: GOOD (  19.62  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Weiping Zhang <zwp10758@gmail.com>,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 22, 2020 at 01:37:47AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 03:59:12PM +0300, Max Gurtovoy wrote:
> > > > write_queues and poll queues shouldn't be writable IMO.
> > > > 
> > > I think we can keep it writeable, the user case is that setup as many io
> > > queues as possible when load nvme module, then change queue count
> > > for each tag set map dynamically.
> > 
> > We can keep it writable but I prefer not change the controller initial queue
> > count after reset controller operation.
> > 
> > So we can keep dev->write_queues and dev->poll_queues count for that.
> > 
> > You can use the writable param in case you aim to hotplug a new device and
> > you want it to probe with less/more queues.
> > 
> > IMO this feature should've somehow configured using nvme-cli as we do with
> > fabrics controllers that we never change this values after initial
> > connection.
> > 
> > Keith/Christoph,
> > 
> > what is the right approach in your opinion ?
> 
> The problem with PCIe is that we only have a per-controller interface
> once the controller is probed.  So a global paramter that can be
> changed, but only is sampled once at probe time seems the easiest to
> me.  We could also allow a per-controller sysfs file that only takes
> effect after a reset, which seems a little nicer, but adds a lot of
> boilerplate for just being a little nicer, so I'm not entirely sure
> if it is worth the effort.
Hi Christoph,

Because in the real user case, the number of each type queue may
not very suitable, it needs a ability to adjust them without hotplug.

If so, the nvme_dev needs record how many write/poll
queues saved in nvme_probe, and then use them in reset flow.

struct nvme_dev {
...
	unsigned int write_queues;
	unsigned int poll_queues;
}


How about add sysfs file
/sys/block/nvme0n1/device/io_queues_reload

and then check it in nvme_setup_io_queues, if it's true,
use module paramter, otherwise use parameters saved in nvme_probe.

Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF894C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 16:45:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565D023A84
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 16:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565D023A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rftPd7ZCHoXjKU3vfDz53Zc/qjtKgvHHYRXih67Yjfo=; b=DV769G04A2b9LbSsjUhnAo6bz
	2w5ce2a1PSompJijGttt3d7pXI0s85YVVc1vfHgHnA9K1So1fB8KRXLEUbp9Ea7/Lxn6qQ5Nkk+wr
	vtjJ1MPtpcjTM4Xg6AYDnqfDiDfdUmWNcCXez9KmF0O0C73ZKpZcAHV4r69yJPaW2gqoi0RGwytza
	De3N9Q2G4GDGB+IN3wd+3jqq24QxtDpanTWNbgHCjv3C7md8kPhUjzzTeRLyPEru7Q14uuSgcKbAd
	jw2GZCvKWSISP9kKUGJ3zxgjOEfFv5NXiIKaqTOwt3E5/38BdvF0X8jJD3WbQkpjTWCGmtc0wG+uE
	OTtBUGwHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2zYY-0008Dr-2R; Fri, 22 Jan 2021 16:45:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2zYV-0008DT-5B
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 16:45:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 547A123A84;
 Fri, 22 Jan 2021 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611333902;
 bh=54tDMbrGlQvNsQZaaqFXy1COMHOr+jR+h5QmsLy12a8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dbVJrnrguh+KL9w/PA4Md52Z6YSbDJCICI535RSrRc6TCk+DTt+fY31eibsqFwkU2
 q7bODaWTj/ZMC1jRvW0tVC/aV3y3xKZieO8U3a9hSU7idvlNa4t/UylFkxXLYkv14p
 uco3gSLZ2GlzIT/+nOgIfuBo+8UlP6Z8wgLS9Mi3Wr3JZ4iOfZ3oQNZmrzoZO77iGa
 UhnxVMMPmnf6DyN9sar1hJgpAYSzDKhoJ/Qp89+e3nuM6gkel8MaGriBoCLHCocdxg
 aqGQ8uwRVTdwfrObumGaNjUhT0qJ53oXbYI/TZIB5Rz1OlCC7YgaxPh2/dQjzPoN6P
 guOfAwJLptO6Q==
Date: Sat, 23 Jan 2021 01:44:54 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
Message-ID: <20210122164454.GA4392@redsun51.ssa.fujisawa.hgst.com>
References: <20210121095021.22807-1-hare@suse.de>
 <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
 <f374b032-cd26-4552-b613-228449f4971d@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f374b032-cd26-4552-b613-228449f4971d@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_114503_284855_793881D5 
X-CRM114-Status: GOOD (  21.37  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 22, 2021 at 05:35:35PM +0100, Hannes Reinecke wrote:
> On 1/21/21 9:14 PM, Keith Busch wrote:
> > On Thu, Jan 21, 2021 at 10:50:21AM +0100, Hannes Reinecke wrote:
> > > If the call to nvme_set_queue_count() fails with a status we should
> > > not ignore it but rather pass it on to the caller.
> > > It's then up to the transport to decide whether to ignore it
> > > (like PCI does) or to reset the connection (as would be appropriate
> > > for fabrics).
> > 
> > Instead of checking the error, wouldn't checking the number of created
> > queues be sufficient? What handling difference do you expect to occur
> > between getting a success with 0 queues, vs getting an error?
> > 
> The difference is that an error will (re-)start recovery, 0 queues won't.
> But the problem here is that nvme_set_queue_count() is being called during
> reconnection, ie during the recovery process itself.
> And this command is returned with a timeout, which in any other case is
> being treated as a fatal error. Plus we have been sending this command on
> the admin queue, so a timeout on the admin queue pretty much _is_  a fatal
> error. So we should be terminating the current recovery and reconnect. None
> of that will happen if we return '0' queues.

You should already be getting an error return status if a timeout occurs
for nvme_set_queue_count(), specifically -EINTR. Are you getting success
for some reason?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF542C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 21:26:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8809B64F8A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 21:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8809B64F8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t+t7lV7Ufkhi4z752X8u5q8abaPcrUrsxL5u6NM74AI=; b=bAAFr9ZPeB+ke+XbT82FArIoT
	9yjzIiq031vhS100O6iQ9s34D5X7nQ5JPoCSpIZ6G1EW9xYH4N7E/dHKT0kO8cQNuOPB7moG5W0Mu
	Vzpss6AAYs9jJqQcGNifBA+ljW28vxUMobp+xNUqCtuZfWKOUOgRR/zdkIkxlkN4sppeKJvn3TyKS
	HBZjmZfQyCubXubUYCZVuu0EroMPbYie9IglIGVlTLBgSN1pBOO9VZVh7wIpTLUCgRUjhXzvmWpIe
	fomrtIGIkHQiSgJ6woCKGWd3YP+RSMADF1gVtoOXcAZpE08yA+ZR46uQL1m+ypizocWAPjgOovIU4
	gr2iqwmkQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMHCe-001tfF-RU; Tue, 16 Mar 2021 21:26:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMHCV-001tea-Ha
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 21:26:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8843764E76;
 Tue, 16 Mar 2021 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615929962;
 bh=PdI+lA2osna6QcTINMGtkuD0FmzZ+9C8Q69VE+m8rKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uMZyqBNDGVuiaRmMZQ6VEtFrJTvRXfUpZPxXZbMU6jDni+1dGrSLnRxciFXQ8FtbG
 0dUcTZRDdCX80KJI1B0kgDF42jeuB+ictjlfEofDP/76pK5a2hxt8kiN1EFMcMFCeN
 iUL1P5pvAEo45oH7r5wpOKBxhPlZlxh8lEhPMhsoeaEbtUolTUHInInshUFsm1LA1F
 DNSlFTCzqtjS3Zxonow1gBy+bgBHcZUhR3uzpY2EpYSMexZL86o5SnoTFy4EdkqcRs
 i13RbEbHOF1vEg4uxvUdUT0X/MUo60cwRc+blb4CelVHhWLpNHIDy+oWKYweQQGbSh
 MaO7cvuYzTNCg==
Date: Tue, 16 Mar 2021 14:25:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: James Smart <jsmart2021@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
Message-ID: <20210316212559.GA4161557@dhcp-10-100-145-180.wdc.com>
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
 <20210316020229.GA35099@C02WT3WMHTD6>
 <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
 <63ed162c-77a7-105f-5f29-47fcd32f57cd@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63ed162c-77a7-105f-5f29-47fcd32f57cd@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_212603_974249_2DF85DE3 
X-CRM114-Status: GOOD (  35.77  )
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

On Tue, Mar 16, 2021 at 01:57:16PM -0700, James Smart wrote:
> On 3/15/2021 10:08 PM, Sagi Grimberg wrote:
> > 
> > > > > > > > A crash happens when set
> > > > > > > > feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
> > > > > > > > over rdma(roce) reconnection, the reason is use
> > > > > > > > the queue which is not
> > > > > > > > alloced.
> > > > > > > > 
> > > > > > > > If queue is not live, should not allow queue request.
> > > > > > > 
> > > > > > > Can you describe exactly the scenario here? What is the state
> > > > > > > here? LIVE? or DELETING?
> > > > > > If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
> > > > > > the target return 0 io queues, nvme_set_queue_count will return 0,
> > > > > > and then reconnection will continue and success. The
> > > > > > state of controller
> > > > > > is LIVE. The request will continue to deliver by call ->queue_rq(),
> > > > > > and then crash happens.
> > > > > 
> > > > > Thinking about this again, we should absolutely fail the reconnection
> > > > > when we are unable to set any I/O queues, it is just wrong to
> > > > > keep this controller alive...
> > > > Keith think keeping the controller alive for diagnose is better.
> > > > This is the patch which failed the connection.
> > > > https://lore.kernel.org/linux-nvme/20210223072602.3196-1-lengchao@huawei.com/
> > > > 
> > > > 
> > > > Now we have 2 choice:
> > > > 1.failed the connection when unable to set any I/O queues.
> > > > 2.do not allow queue request when queue is not live.
> > > 
> > > Okay, so there are different views on how to handles this. I
> > > personally find
> > > in-band administration for a misbehaving device is a good thing to
> > > have, but I
> > > won't 'nak' if the consensus from the people using this is for the
> > > other way.
> > 
> > While I understand that this can be useful, I've seen it do more harm
> > than good. It is really puzzling to people when the controller state
> > reflected is live (and even optimized) and no I/O is making progress for
> > unknown reason. And logs are rarely accessed in these cases.
> > 
> > I am also opting for failing it and rescheduling a reconnect.
> 
> Agree with Sagi. We also hit this issue a long time ago and I made the same
> change (commit 834d3710a093a) that Sagi is suggesting:  if the prior
> controller instance had io queues, but the new/reconnected controller fails
> to create io queues, then the controller create is failed and a reconnect is
> scheduled.

Okay, fair enough.

One more question: if the controller is in such a bad way that it will
never create IO queues without additional intervention, will this
behavior have the driver schedule reconnect indefinitely?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

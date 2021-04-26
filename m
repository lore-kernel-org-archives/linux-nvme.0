Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA14C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 10:07:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089D461159
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 10:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089D461159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wa4nyrQ507zKi1ANCfARERIBmPsAwxvCLaeTnuZTx4E=; b=H8sK0amdqvkVayskTGwjqFpUn
	9Al05Z0ZynEEICAy0QxJpah+91ptzpN95516kl0ugB6opmRhsK9JHyyXMpvtRAH04aH6Ev9tKSKXy
	EnfnTSvDIpoF4XT8ge/5ikb0ioNHnZ507vuxWU6gek/ZWbdOIPIWrMFsF185+Pbl8auQOlB73jekc
	1SEiuFYXIeHeJ1v0yGolgMZWNkAAt5Oxj223iY/dDfHJ16VLT9HTTlYGQZinvRqcQQqI+VMAVWmjP
	s0TdohN1hzGnZxqOQhiCtft4PJ2WckzVHR5dhkNGyP/ao4PmrsY+PNBWbrkoG9/g8A52SQQp2Y2XL
	C/+3/WEuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lay8r-007NS3-7C; Mon, 26 Apr 2021 10:07:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lay8n-007NRo-8R
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 10:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=Q6KHKd/yxyT4UjmebuoM1gKVcVwj2O0HemguL4nDq9o=; b=fIjMhfHoS0GHX2UFSyTGV60w73
 19S7cAmmIpkXHBEWJaMNWVxgSWCs+gyozuQqOsvSosRLZUFFmnQEAG+Hqc/n5hQqQdgfQTmckIg/I
 m3HaK4H5jROfsA82J0Vyf4dRLTbKref375GzoIxlMSeJUnSuHWjtfrlbuWzzeMmPX4tiAyazrhF4W
 +YVQhGLk8kG2lU6Tg3vMNrXs1VFsbKfjlGNDqe0PsQfxnda808vEqqlQBMDHu9IYpmilf2OIQEz0Q
 ZcXzc3oXrI40isMhE6KM6wyg/6tx64Poydvu76aKDTc2P2xtlw2Gv/3+1X+iLRwOZgfEHjSJEtXIQ
 QaF6h2cw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lay8k-00FssG-AM
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 10:06:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C4736B183;
 Mon, 26 Apr 2021 10:06:52 +0000 (UTC)
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chao Leng <lengchao@huawei.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210423133835.25479-1-mwilck@suse.com>
 <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
 <181b5a7c61e31abff2f4d0102281c0e0f96a7832.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
Message-ID: <326f89f6-9365-0593-6ae3-a3cc19f73cbc@suse.de>
Date: Mon, 26 Apr 2021 12:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <181b5a7c61e31abff2f4d0102281c0e0f96a7832.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_030654_679787_B8C66BD8 
X-CRM114-Status: GOOD (  26.90  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/26/21 11:34 AM, Martin Wilck wrote:
> On Sun, 2021-04-25 at 13:34 +0200, Hannes Reinecke wrote:
>> On 4/23/21 3:38 PM, mwilck@suse.com=A0wrote:
>>> From: Martin Wilck <mwilck@suse.com>
>>>
>>> We have observed a few crashes run_timer_softirq(), where a broken
>>> timer_list struct belonging to an anatt_timer was encountered. The
>>> broken
>>> structures look like this, and we see actually multiple ones attached
>>> to
>>> the same timer base:
>>>
>>> crash> struct timer_list 0xffff92471bcfdc90
>>> struct timer_list {
>>> =A0=A0 entry =3D {
>>> =A0=A0=A0=A0 next =3D 0xdead000000000122,=A0 // LIST_POISON2
>>> =A0=A0=A0=A0 pprev =3D 0x0
>>> =A0=A0 },
>>> =A0=A0 expires =3D 4296022933,
>>> =A0=A0 function =3D 0xffffffffc06de5e0 <nvme_anatt_timeout>,
>>> =A0=A0 flags =3D 20
>>> }
>>>
>>> If such a timer is encountered in run_timer_softirq(), the kernel
>>> crashes. The test scenario was an I/O load test with lots of NVMe
>>> controllers, some of which were removed and re-added on the storage
>>> side.
>>>
>> ...
>>
>> But isn't this the result of detach_timer()? IE this suspiciously looks
>> like perfectly normal operation; is you look at expire_timers() we're
>> first calling 'detach_timer()' before calling the timer function, ie =

>> every crash in the timer function would have this signature.
>> And, incidentally, so would any timer function which does not crash.
>>
>> Sorry to kill your analysis ...
> =

> No problem, I realized this myself, and actually mentioned it in the
> commit description. OTOH, this timer is only modified in very few
> places, and all but nvme_mpath_init() use the proper APIs for modifying
> or deleting timers, so the initialization of a (possibly still) running
> timer is the only suspect, afaics.
> =

> My personal theory is that the corruption might happen in several
> steps, the first step being timer_setup() mofiying fields of a pending
> timer. But I couldn't figure it out completely, and found it too hand-
> waving to mention in the commit description.
> =

>> This doesn't mean that the patch isn't valid (in the sense that it =

>> resolve the issue), but we definitely will need to work on root cause
>> analysis.
> =

> I'd be grateful for any help figuring out the missing bits.
> =

No, the problem lies in the pecularities of NVMe error recovery.

The crucial point here is that during error recovery all I/O is aborted,
but after that the queue is _NOT_ stopped.
So it's perfectly legal to send I/O even if the controller is not fully
LIVE. And if _this_ I/O fails then we'll find ourselves in lots of
interesting situations.

I guess the problem lies with nvme_init_identify().

We're calling nvme_mpath_init() (which will start the ANATT timer), but
issue some more I/O afterwards.
If any of _that_ I/O fails, an error is registered with the caller (eg
in nvme_tcp_configure_admin_queue(), _but_ the ANATT timer continues to
run. Then we'll be calling nvme_tcp_reconnect_or_remove() and delete the
controller. Completely oblivious to the running ANATT timer.
Which will get quite unhappy once it triggers as the controller
structure from which the timer was started is done for.

So with this analysis an alternative fix would be to move
nvme_path_init() right at the end of nvme_init_identify(), such that
we'll never get into the situation where nvme_init_identify() fails yet
the ANATT timer is running.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 N=FCrnberg
GF: F. Imend=F6rffer, HRB 36809 (AG N=FCrnberg)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

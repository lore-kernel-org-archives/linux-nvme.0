Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF28C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:35:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECD861413
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECD861413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UKgGLCXy3RvlzhboCg69LYl3Ni4dk4VesEJo4pAh2K0=; b=cC/clNb/RKJ3Wd/c6FICMmDD6
	3USzrdNIxqyF/dLDXWYKb6nCVXADz0Nx9HT9D5iMGQRw71T2jXfAiY/rVVJr8X/kP80wrEOCvMvtI
	kcLqtn/idJ6fJFN5JuEheSrWSK3KIwySh+rM0da/B4pKLCGJgPjiaZfnj0rUlcaUfxSrFMiS515Zl
	L/YZuA0wrdVrdgqHRK5q3hAor89w6RwCaD+I65edvEkLB4ngH/IBcshc5/geTviNBBLEmSftY2DHo
	yDzCaKW/NMNTTs6WruPrwoonaUdzZY9NEj10zoqzJjuCt7/qxr3LHlTEQD/yIAUWFn2dV/kLYT7lh
	345XP+3Ow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdnF-002vxb-Ba; Wed, 28 Apr 2021 06:35:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdn8-002vxT-AM
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=dvSbRc87/oh6/XM5Mnan5Samo0RKSSMCEB2ggvyCoWc=; b=lXWTmKTOU7s8UDXAdY2PAQPgiw
 Vl7OuLP4JrbRbJ9SEfUuC7MpmPMn6OykhX3EJlDs/OpiqORQWHJx2P26Ss1rZBqqOBOt6cR4Z2yZj
 0h3kW3tuxjRbnngrdDYjDW9Jp+z03LkduthHD7UdNw3SbpZGHeoqMn0JksT/RE3HXsvHLOi5UKFwP
 d58o6EbUXM8a6NjKRltOWOJASnh+OlcmdRQ686+FcFVnSBaFCQDqtmgzr7ADNAsZRvP1g6A/WyjND
 UMCLBXaYq+8kMKs1RBk2X/5B09+555xT6xsKCw42goz+79ZhtL9tRUpWVIVx/TEBR9CK+UPjFZBAX
 nlwuJTXg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdn5-00HDUJ-EZ
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:35:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78641AF3B;
 Wed, 28 Apr 2021 06:35:17 +0000 (UTC)
To: Martin Wilck <mwilck@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
 <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
 <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <8b61d0f8-f47f-8e03-5385-c48b0e7be187@suse.de>
Date: Wed, 28 Apr 2021 08:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_233519_655479_E74F6FE3 
X-CRM114-Status: GOOD (  19.53  )
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

On 4/27/21 9:54 PM, Martin Wilck wrote:
> On Tue, 2021-04-27 at 20:05 +0200, Hannes Reinecke wrote:
>> On 4/27/21 6:25 PM, Christoph Hellwig wrote:
>>> On Tue, Apr 27, 2021 at 11:33:04AM +0200, Hannes Reinecke wrote:
>>>> As indicated in my previous mail, please change the description.
>>>> We have
>>>> since established a actual reason (duplicate calls to
>>>> add_timer()), so
>>>> please list it here.
>>>
>>> So what happens if the offending add_timer is changed to mod_timer?
>>>
>> I guess that should be fine, as the boilerplate said it can act
>> as a safe version of add_timer.
>>
>> But that would just solve the crash upon add_timer().
> =

> The code doesn't use add_timer(), only mod_timer() and
> del_timer_sync(). And we didn't observe a crash upon add_timer(). What
> we observed was that a timer had been enqueued multiple times, and the
> kernel crashes in expire_timers()->detach_timer(), when it encounters
> an already detached entry in the timer list.
> =

nvme_mpath_init() doesn't use add_timer, but it uses timer_setup(). And
calling that on an already pending timer is even worse :-)

And my point is that the anatt timer is not stopped at the end of
nvme_init_identify() if any of the calls to

nvme_configure_apst()
nvme_configure_timestamp()
nvme_configure_directives()
nvme_configure_acre()

returns with an error. If they do the controller is reset, causing
eg nvme_tcp_configure_admin_queue() to be called, which will be
calling timer_setup() with the original timer still running.
If the (original) timer triggers _after_ that time we have the crash.

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

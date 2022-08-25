Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA28C28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAGhCjedbV88BEmXYOWWiP/muXYh404/6AX3gJ1q0io=; b=FyzF3N6ioRehRNQei6SYUGh0hO
	AqHLLtrpduE3bKPRUbXKXItfry6/9Krbk6jgYHd8/kQVrcAIPcl8hi8mZGI53ydtIj50QG/gxhIKo
	hByCIqmJkJArZVHbYcU/BLIYE1yQKteJ2wOsmCfJ2yW0CYudjazN/GASuKpTMOxijmXakqujM68DU
	siZgW37yWazhoKEXjKetl7YhZaVL0tz781+HaliySIxJ53ZZPcJbKXgNDFum9qB1DrbJ/kvyhplo2
	3F0ZVmtulU3XaPZe2J5brDMOk828p283fWEl/46WTkVDbNv1piLf3foFmUbRNTSa59g2Khpz1Rq6C
	Covt1yoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6K5-007rav-4G; Thu, 25 Aug 2022 06:26:37 +0000
Received: from out0.migadu.com ([94.23.1.103])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6K1-007rX8-Gq
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 06:26:35 +0000
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1661408787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAGhCjedbV88BEmXYOWWiP/muXYh404/6AX3gJ1q0io=;
	b=uIMILQZbIKWmq5LnxnVeHzj4XfNWKjhZp4V0L3CXEpJp2qC0satRipFXu5m+Oc4sm8k9hB
	g+N0yMQHmx/nwyPHsoYoRNVML9avpE0cmuuiBA73EJ8UmqC5vW1zwvGnRYX+RslznJT4Qo
	LMvwclUZitLGVbzLqoJrpa2A35eEqUk=
To: "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
 Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "bvanassche@acm.org" <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <a4490b74-146e-809c-c969-aebc5835e2e2@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <a4412795-8079-025e-6d6c-ecf18cad2e4a@linux.dev>
Date: Thu, 25 Aug 2022 14:26:21 +0800
MIME-Version: 1.0
In-Reply-To: <a4490b74-146e-809c-c969-aebc5835e2e2@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_232634_081278_11A78A80 
X-CRM114-Status: GOOD (  14.86  )
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



On 8/25/22 1:59 PM, yangx.jy@fujitsu.com wrote:
> On 2022/5/25 19:01, Sagi Grimberg wrote:
>> iirc this was reported before, based on my analysis lockdep is giving
>> a false alarm here. The reason is that the id_priv->handler_mutex cannot
>> be the same for both cm_id that is handling the connect and the cm_id
>> that is handling the rdma_destroy_id because rdma_destroy_id call
>> is always called on a already disconnected cm_id, so this deadlock
>> lockdep is complaining about cannot happen.
> Hi Jason, Bart and Sagi,
>
> I also think it is actually a false positive.  The cm_id handling the
> connection and the cm_id calling rdma_destroy_id() cannot be the same
> one, right?

I am wondering if it is the same as the thread.

https://lore.kernel.org/linux-rdma/CAMGffEm22sP-oKK0D9=vOw77nbS05iwG7MC3DTVB0CyzVFhtXg@mail.gmail.com/

>> I'm not sure how to settle this.
> Do you have any suggestion to remove the false positive by refactoring
> the related RDMA/CM code. Sorry, I didn't know how to do it for now.

The simplest way is to call lockdep_off in case it is false alarm to 
avoid the
debugging effort, but not everyone likes the idea.

https://elixir.bootlin.com/linux/v6.0-rc2/C/ident/lockdep_off

Thanks,
Guoqing


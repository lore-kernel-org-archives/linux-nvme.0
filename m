Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8582AC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIWz78PXI7EvKN4ruQoCnzZz8BZ4fRFfgiYMqQWccK0=; b=e90mG1VoQDRW24WUfjw4XBEW/c
	PiLh80u6z9oVV+eZcFXuKDOdTSnCilka1/PFvNmY3w4bQDQ6UV6j7t4YU7rYK1F0yzRjdNfXXg/gB
	EjhtkGgQ3v82heCV+paJLua02RcIePkEK6uovWRjHVyGHgF0eAZ4/f3/x6uaCv7olDzTonoP08QBu
	IEINgvk6c5D28aeoqzx8V2HaEg55xEK8dJuIC/bsKmPV/Eg0B/1pJ711EEqZ2E0e1pqO6CFW/XJ3p
	MNJm7ng+IDs4ffeh2sPif+BvFuuUJ1xtHBWEyjsu4p1RmMcIQCoQMptA46lQECQfrlZdc1lgyHs/x
	sHqnCBQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njjmU-0022IQ-Ap; Wed, 27 Apr 2022 15:40:42 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njjmI-0022GY-1Q; Wed, 27 Apr 2022 15:40:31 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id BB1C332001FC;
 Wed, 27 Apr 2022 11:40:27 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Wed, 27 Apr 2022 11:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1651074027; x=1651160427; bh=lI
 Wz78PXI7EvKN4ruQoCnzZz8BZ4fRFfgiYMqQWccK0=; b=RmY9+5eB5Vq++BL8o+
 VTpJ/iDtxGEOKbZCVf5L9Dl7J8kDgqcQ5NgDkGeu7PFLnZFTMEqr8Igp5PQoiRCf
 k/LUhEfpnP6bcWP3Tp7pLS6ZXZrxJpFQkR42672be7Tt0N2FEinFXijbhFB86KAE
 Pg7UWBpkPTLYYGIKe+GGmV9Vc6H85+Z2cJASz5GydnbIhFn+QnVZdAwjQOOG5FVZ
 hQ5rQs/f9vS5CllLbUfFoeCiNTHcBHzjlub59x0fYhG0i8ZigbmkxxLHXx78+aWG
 udpFvkIX0ldB1QGoTAYf3JZh5b/+s0TQt7NMSAGlHgqLtF3FIUt15jbJAdrLYhXc
 lPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651074027; x=
 1651160427; bh=lIWz78PXI7EvKN4ruQoCnzZz8BZ4fRFfgiYMqQWccK0=; b=n
 kiS0LOiIp8Z8bSpVnvLzNjqYZ2HpMZXUwaUluGM810L5cbAdbhgG+scxzStn4q5j
 XykjtVrdxHj8ICZGNCQblIk9VmJ0g8BAYNMcWRlV9OQa09D1X1FXPxL31+CWSAH/
 cz6lZRXxNumweJleksDpQQrhx+iXGXEJbV4jtsDiDpMnYM8zeR/XNknNQmGxp7Nx
 FyEjH2n98z1jL3NseqzsOX5ALHLUPJWs6G5QMNbEEjsSF5OL2MkVdlTcX8GR136x
 KkOY7kX6WNvedpDzEemMUw9KePilF1f2AFx7Pw8Cj4ZYjUHCS7PgJuIevNC6J9s0
 BASKitzX8JL8ZCCMALTuQ==
X-ME-Sender: <xms:6mNpYkdGwy6wqaWrPpLxCF9nP3aJokd_AGLugP9ORTRsFup6IaRQFw>
 <xme:6mNpYmPSsv1ByunrT5DX2TRJti0RzB498vc3cthg7c-MoUjs3GPD_OuHH_FG-jYzg
 RoVJ4ml7ZpP3KyZiHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdekkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
 veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:6mNpYljezHIxLz1T3ljEI0yTgeJ94PKw11pdL0O-6kpuXrxHuqqPEg>
 <xmx:6mNpYp8nAX-RmTfq0IcoBHyJW0Amoief1Ti9_63zx00TOsReStiphg>
 <xmx:6mNpYgt97sFg30IXXBZDFQq3txcVMd_sEA2r_L3uwgPcL6pakvyGxQ>
 <xmx:62NpYhFnXEuXJrd4act2W5PBc08Qa0Q3jC-LettFmjNwGGtOM9sRfA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E67EC27400F9; Wed, 27 Apr 2022 11:40:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <cd6c9623-60c6-44dc-8ff3-addfb31efd6d@www.fastmail.com>
In-Reply-To: <YmhdVJgd6DGRHPXd@kbusch-mbp.dhcp.thefacebook.com>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-7-sven@svenpeter.dev>
 <YmhdVJgd6DGRHPXd@kbusch-mbp.dhcp.thefacebook.com>
Date: Wed, 27 Apr 2022 17:40:06 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, "Janne Grunau" <j@jannau.net>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_084030_168843_8EC15685 
X-CRM114-Status: GOOD (  13.24  )
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



On Tue, Apr 26, 2022, at 23:00, Keith Busch wrote:
> On Tue, Apr 26, 2022 at 10:15:39PM +0200, Sven Peter wrote:
>> +static enum blk_eh_timer_return apple_nvme_timeout(struct request *req,
>> +						   bool reserved)
>> +{
>> +	struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +	struct apple_nvme_queue *q = iod->q;
>> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
>> +	unsigned long flags;
>> +	u32 csts = readl(anv->mmio_nvme + NVME_REG_CSTS);
>> +
>> +	if (anv->ctrl.state != NVME_CTRL_LIVE) {
>> +		/*
>> +		 * From rdma.c:
>> +		 * If we are resetting, connecting or deleting we should
>> +		 * complete immediately because we may block controller
>> +		 * teardown or setup sequence
>> +		 * - ctrl disable/shutdown fabrics requests
>> +		 * - connect requests
>> +		 * - initialization admin requests
>> +		 * - I/O requests that entered after unquiescing and
>> +		 *   the controller stopped responding
>> +		 *
>> +		 * All other requests should be cancelled by the error
>> +		 * recovery work, so it's fine that we fail it here.
>> +		 */
>> +		dev_warn(anv->dev,
>> +			 "I/O %d(aq:%d) timeout while not in live state\n",
>> +			 req->tag, q->is_adminq);
>> +		if (blk_mq_request_started(req) &&
>> +		    !blk_mq_request_completed(req)) {
>> +			nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>> +			blk_mq_complete_request(req);
>
> I think you need a 'nvme_req(req)->flags |= NVME_REQ_CANCELLED' here to get the
> expected -EINTR for any admin command timeouts during a reset. Without it, the
> resetting task is going to think it got a real response from the controller.

Makes sense, will add it.


Sven


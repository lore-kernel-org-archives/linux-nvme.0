Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E219C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 16:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A60861946
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A60861946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2YFt0Um0gDMhncgCj/U7liAaj2UDBodUl/+VLyRt52s=; b=kcbkMq5h+le/R9
	5bzB8A7Q57S0OZsAh4c//k8MUX7U1TuuxbhqyHNlW2HJ9xAK0Ou2n6IVyUqeGAGBeCGInsGlt8/TI
	qSQLYfOmmIvM2uFVtNnG6xAIyVlUuOWuomcbir0dp+9VbR11hzW/3BcIElq0MQQiHaD1YtYWtFVFL
	VKUWTbL6zEnsx2CazslQpVA1ehK2vDXBYs7Lg8DPZUUO66vlKSYBded6PVZCzGK4nQGKLgs/a1DDg
	GFJTrNEwxAEwuYD0iTSdhAtOA3z14VRJ7AMqKLTsQyOQJVCIjFeVWaaJa4iW2vvJkGy6y4IRp4u5M
	RowyYTWczpkxg7n/JzMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0RY3-009VOM-7r; Mon, 05 Jul 2021 16:34:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0RXz-009VNC-Ng
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 16:34:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BEF7D203A4;
 Mon,  5 Jul 2021 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625502840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkPXIuH/RB2D0QQyUgwo3tt0LzV1ZF0yIHcY5Q7RSRA=;
 b=dhQONS9SP70K9gmKDN1/3brZ6Ws7J1+ecCqYz1p2GG0YG03FI4IH6fHwbmokt1r7ya3LId
 AUAuMzuTQ1/kI9JaHFTNlp8unvQ08SuWzPI4I6hDly31837s4vo/g+/oW2PHbrvdh9MEHq
 ZmGICP3Tky5YTT10yU+K0fySIxa8VhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625502840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkPXIuH/RB2D0QQyUgwo3tt0LzV1ZF0yIHcY5Q7RSRA=;
 b=GGH+zTrRWKqliCGxDTsieZ7pw98QA3b+Ipk/dEoTlWDBiCIN9d3s6+/5TX9pX0HKT9m8iL
 Gp8GOJBB2wgUfdCw==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 98709A3BA8;
 Mon,  5 Jul 2021 16:34:00 +0000 (UTC)
Date: Mon, 5 Jul 2021 18:34:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210705162519.qqlklisxcsiopflw@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNp50pmlzN6M0kNX@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_093415_965664_E33DE742 
X-CRM114-Status: GOOD (  14.17  )
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

On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> Can you investigate a bit on why there is the hang? FC shouldn't use
> managed IRQ, so the interrupt won't be shutdown.

So far, I was not able to figure out why this hangs. In my test setup I
don't have to do any I/O, I just toggle the remote port.

  grep busy /sys/kernel/debug/block/*/hctx*/tags | grep -v busy=0

and this seems to confirm, no I/O in flight.

So I started to look at the q_usage_counter. The obvious observational
is that counter is not 0. The least bit is set, thus we are in atomic
mode. 

(gdb) p/x *((struct request_queue*)0xffff8ac992fbef20)->q_usage_counter->data
$10 = {
  count = {
    counter = 0x8000000000000001
  }, 
  release = 0xffffffffa02e78b0, 
  confirm_switch = 0x0, 
  force_atomic = 0x0, 
  allow_reinit = 0x1, 
  rcu = {
    next = 0x0, 
    func = 0x0
  }, 
  ref = 0xffff8ac992fbef30
}

I am a bit confused about the percpu-refcount API. My naive
interpretation is that when we are in atomic mode percpu_ref_is_zero()
can't be used. But this seems rather strange. I must miss something.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524EC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 08:53:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D82A60F93
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 08:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D82A60F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=msE7/L3PDzevYJDjjUNi/GaQXObByNbvn1ZVruIL7q0=; b=CQZ6ZNt4Gikb4J
	2mEhF/1BRwl+QN9kPMNzgghQhurkcZuX0tb9TyE8p/SpAFjFaXUlbaXxB9yHKuekEUoYpfRTfguof
	FCpti/y1RzLbb9By7QiSRqU9ZHY1rDZY8eWgzddsUwE9ZaEUbZKqp9jN2cBibvnlfsBuez+Em/is3
	yRP9IDwD27s5FTqGy8MKdUKhc5t7ShOjjiI2Z7Ba68YHp3oLHD6nm19A34xwAEPQqWYdYOaOFM6fS
	lM95kvhCq7UdnUvSNtcUuL3CTlTMLJhsDkgs2a2hC/WRifG9j0sEzUubi7JVuFKwKF7geRV6rucpT
	pbKt6ZydhWB4HX572Ttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD11m-00HWDV-9d; Mon, 09 Aug 2021 08:52:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD11i-00HWCx-L6
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 08:52:56 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE09E21F38;
 Mon,  9 Aug 2021 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628499170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bepQzvatgJLao+zb9C6j+oevlY4gKiK09Ngv42kE38g=;
 b=kl3QYAu24ESZk9XuMhHwyyKyrTXhxm8d0J0sTv1O9QwbpBj8HvMUuDZxbbwJ1M73InnMDP
 RLlFN9ZDGq9tSKeE5BYnLUSOZh6HOwEaaw4F5uqfGDiaOFoIYKra4nOVs2pLS1XcjvDXem
 x+DZPpgPZJKRMjCFq7UbW3wHc+KL/aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628499170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bepQzvatgJLao+zb9C6j+oevlY4gKiK09Ngv42kE38g=;
 b=R/7gyERwwF+oUn9XMq+YISSU0gyMc3Q8Y/uui8tCDQ/t7fzbAFA5xUMh7ItG4RUzm14vBz
 +lb5sbg8zLTp9BAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D3C23132AB;
 Mon,  9 Aug 2021 08:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id C/auM+LsEGFqKgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 08:52:50 +0000
Date: Mon, 9 Aug 2021 10:52:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210809085250.xguvx5qiv2gxcoqk@carbon>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_015254_912295_776A77FC 
X-CRM114-Status: GOOD (  24.78  )
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

Hi Sagi,

On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
> > -	ret = nvme_tcp_start_io_queues(ctrl);
> > -	if (ret)
> > -		goto out_cleanup_connect_q;
> > -
> > -	if (!new) {
> > -		nvme_start_queues(ctrl);
> > +	} else if (prior_q_cnt != ctrl->queue_count) {
> 
> So if the queue count did not change we don't wait to make sure
> the queue g_usage_counter ref made it to zero? What guarantees that it
> did?

Hmm, good point. we should always call nvme_wait_freeze_timeout()
for !new queues. Is this what you are implying?


> >   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
> >   			/*
> >   			 * If we timed out waiting for freeze we are likely to
> > @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
> >   		nvme_unfreeze(ctrl);
> >   	}
> > +	ret = nvme_tcp_start_io_queues(ctrl);
> > +	if (ret)
> > +		goto out_cleanup_connect_q;
> > +
> 
> Did you test this with both heavy I/O, reset loop and ifdown/ifup
> loop?

Not sure if this classifies as heavy I/O (on 80 CPU machine)

fio --rw=readwrite --name=test --filename=/dev/nvme16n1 --size=50M \
    --direct=1 --bs=4k --numjobs=40 --group_reporting --runtime=4h \
    --time_based

and then I installed iptables rules to block the traffic on the
controller side. With this test it is pretty easily to get
the host hanging. Let me know what test you would like to see
from me. I am glad to try to get them running.

> If we unquiesce and unfreeze before we start the queues the pending I/Os
> may resume before the connect and not allow the connect to make forward
> progress.

So the unfreeze should happen after the connect call? What about the
newly created queues? Do they not suffer from the same problem? Isn't
the NVME_TCP_Q_LIVE flag not enough?

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

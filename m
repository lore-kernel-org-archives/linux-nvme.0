Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47F5CCA47B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YT6F0R/tYGFQNTaQHzJFTxGvrdFWvfza3EuYjz5mT/Q=; b=29yYDF1ogmYnsw7QwTzAkFHaGI
	zDhOpl+v3YIjSHhf5dYCEA4h/re+TIGnOZ0r+545tH8ov1yMaZ73FTgCyHTuuGphWvmftTCH1uGUo
	0aOVbc+X78ooiS6on5DUtQEqAwhH2rxIRwzgv8A/n81XrpAGT2Fmv1N20tKyMWT/fhOj2CcdbHlGH
	9bmKFY4+iCxOTgphBeOVg1ntpSPtmwF2YEywHJIm9xszgtfMvHrL+7TenNoi0egMlFq3N4GecXuow
	NUxes9b1SC/c0Uj4xsLFpCDT/UM77k4kZso+/MxeSoaypuTtSGVXJnd8MQjjLfN6moa+vyE3wNdg3
	n1fjifxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0ZR-00FaD6-Ty; Thu, 14 Jul 2022 15:16:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0ZO-00Fa8O-7S
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 15:16:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF0834CD1;
	Thu, 14 Jul 2022 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657811756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT6F0R/tYGFQNTaQHzJFTxGvrdFWvfza3EuYjz5mT/Q=;
	b=tfcL96TB/5ct/LL/4vKK7K/2d+X5R3pwCnrGm0X2TiHOgcp5VUbbmibvjtzXrUWZjjpT3E
	yyIo9UTToP3t6atsPmSkULLvjkY5hlATAHogWG+t1OclJRIghiq2qcLGb+bD/631Boe7uH
	2lfU4Wn+qGtxyXg0470MdildNn/NDu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657811756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT6F0R/tYGFQNTaQHzJFTxGvrdFWvfza3EuYjz5mT/Q=;
	b=DvRF+RG6ahEb0ez9qbvh1IoaML+Pz6xiGWO7aA0Pu1D6T8t7ovfm0OA9987yW+kjEdJAR7
	OSkJfukHsmAxpsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93DEE13A61;
	Thu, 14 Jul 2022 15:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Q55kIiwz0GLPSAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 14 Jul 2022 15:15:56 +0000
Message-ID: <cdf87a27-0981-f51f-3900-f601f4dc49a7@suse.de>
Date: Thu, 14 Jul 2022 17:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714122703.67621-1-hare@suse.de>
 <49be3b16-9c99-460b-e321-c2727c159d9c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <49be3b16-9c99-460b-e321-c2727c159d9c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_081602_437952_3F4B4DF3 
X-CRM114-Status: GOOD (  22.95  )
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

On 7/14/22 16:42, Sagi Grimberg wrote:
> 
>> When the connection unexpectedly closes we must not start error
>> recovery right away, as the controller might not have registered
>> the connection failure and so retrying commands directly will
>> might lead to data corruption.
>> So wait for KATO before starting error recovery to be on the safe
>> side; chances are the commands will time out before that anyway.
> 
> We can't just blindly adding kato to the error recovery because that
> by definition creates a intrinsic delay for I/O failover. There is
> absolutely no reason what-so-ever to do that. kato can be arbitrarily
> long.
> 
Yes, true. But the controller might need to register the connection 
timeout and do some cleanup action afterwards, for which KATO is the 
only value we have currently.

> If the controller needs this delay, then it should signal this
> somehow in its capabilities. This is not something that we can just
> blindly do. So this needs to go through the TWG.
> 
... as you might be aware, this is discussed at the TWG.
There even is a TPAR 4129 which deals with precisely this issue.
But consensus is that an immediate retry on path failure is dangerous, 
as the controller might not have detected the path failure yet, and will 
wait for at least KATO before declaring a path dead and start recovery 
actions, potentially clearing out stale/stuck commands.
And retry on another path during that time is dangerous.

And yes, we do have customers who have seen this in real life.

> Also, how come this is TCP specific anyway? This talks about a
> controller that has a dangling inflight command that he cannot fence
> yet hence cannot serve failover I/O. RDMA should have the same thing.
> 
The crucial bit here is the 'nvme_tcp_state_change()' callback, which 
will trigger recovery as soon as it detects a connection failure.

RDMA doesn't have a direct equivalent here, and I'm not that deep into 
RDMA details to know if the RDMA_CM_EVENT_DISCONNECTED is synchronized 
with the remote side. If it is, we're fine. If not, we'll have the same 
issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


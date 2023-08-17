Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD99C2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxMby1AcxwFY6sSz3veRP4Iq3RZHC1CqYJP4+FgT8sQ=; b=LnM/kXL62+df7E1uIiTA3wIEkr
	EbtcXqy12NIybBknWrxYCCI0GWwwWd50S7JSZtSjVygA+OdJjq/t1xs7dzqpBGUVOBPvKsXpwrnhU
	m2rG/8HEkKLYKn8+ZQHVSztNMagYl+xImP0/j9LlxVDEUGi+XOxIF508pc8G3yyAeYnE7QETwI7X3
	2m2TiWpJBR4rqk6PtaX14hxGxxQlvrMbK4gwtawiWtZwAEOMxLqb866kQezGq2NPcguqmsNmlQZtM
	AO50yLlF6Cj9K+C+o+HhKCWHuOd2ehBYT2IktwW4vuyCq27tnl4AENGLg7+QMlqFZXlNeiSeP+tAH
	gZurF7yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWbJ1-006HZW-10;
	Thu, 17 Aug 2023 11:36:47 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWbIy-006HZA-1I
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 11:36:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F132A1F891;
	Thu, 17 Aug 2023 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692272202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxMby1AcxwFY6sSz3veRP4Iq3RZHC1CqYJP4+FgT8sQ=;
	b=ukfvFmz26DVD6E89hB8KEUQ4DtsRAIFquHA0W5LfM77+yHqfx1OgS0p5zPOvI9B+5qWajb
	VJ8A2rdgn9J0mmIjsuduYITDSG1xmtiR2Th2pl/s+cd62POcGSpro8VSKTgmTVL2xqcTer
	DneIHxF3yE6bYXx6bcLp1ZVLGedt120=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692272202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxMby1AcxwFY6sSz3veRP4Iq3RZHC1CqYJP4+FgT8sQ=;
	b=/1bZq52wlHq6w7jRykcVXqeslVgIilh0nzU+8OwL/aNSK5AWF0cAeqboVENCjsCLge3XbP
	GnRTojuXEAFM8nBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D27291358B;
	Thu, 17 Aug 2023 11:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Y07dMUoG3mScQAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 17 Aug 2023 11:36:42 +0000
Message-ID: <b2e12d07-c894-8af4-9433-8308939a96a5@suse.de>
Date: Thu, 17 Aug 2023 13:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet-tcp: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230810132006.129365-1-hare@suse.de>
 <05b7479a-5243-00fb-4a5a-a063bce65378@grimberg.me>
 <48e9b2a7-fcaf-acfe-0819-3a484bf90dc3@suse.de>
 <effe2141-2f4b-ef06-786b-4344509c1271@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <effe2141-2f4b-ef06-786b-4344509c1271@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_043644_604497_99743FCE 
X-CRM114-Status: GOOD (  19.69  )
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

On 8/17/23 13:20, Sagi Grimberg wrote:
> 
>>> On 8/10/23 16:20, Hannes Reinecke wrote:
>>>> nvmet_tcp_install_queue() is driven from the ->io_work workqueue
>>>> function, but will call flush_workqueue() which might trigger
>>>> ->release_work() which in itself calls flush_work on ->io_work.
>>>>
>>>> To avoid that check for pending queue in disconnecting status,
>>>> and return 'controller busy' until all disconnects are completed.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/target/tcp.c | 14 ++++++++++++--
>>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>> index f131b504aa01..97d07488072d 100644
>>>> --- a/drivers/nvme/target/tcp.c
>>>> +++ b/drivers/nvme/target/tcp.c
>>>> @@ -1845,8 +1845,18 @@ static u16 nvmet_tcp_install_queue(struct 
>>>> nvmet_sq *sq)
>>>>           container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>>>       if (sq->qid == 0) {
>>>> -        /* Let inflight controller teardown complete */
>>>> -        flush_workqueue(nvmet_wq);
>>>> +        struct nvmet_tcp_queue *q;
>>>> +        int pending = 0;
>>>> +
>>>> +        mutex_lock(&nvmet_tcp_queue_mutex);
>>>> +        list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
>>>> +            if (q->state == NVMET_TCP_Q_DISCONNECTING)
>>>> +                pending++;
>>>> +        }
>>>> +        mutex_unlock(&nvmet_tcp_queue_mutex);
>>>> +        /* Retry for pending controller teardown */
>>>> +        if (pending)
>>>> +            return NVME_SC_CONNECT_CTRL_BUSY;
>>>
>>> Overall I'm fine with the approach.
>>>
>>> That will most likely be the case for a controller reset or a "reset
>>> storm". Maybe it is better to keep it at some reasonably allowed pending
>>> to say 10 or something... The whole point is to not let the removals
>>> accumulate and continue creating new ones...
>>>
>>> Can you please test this with a host that does a loop like:
>>> while true; do nvme reset /dev/nvme0; done
>>>
>>> And let it run for some time...
>>> Or even better create a test that does this for 100 iterations
>>> or a log/short variants of this?
>>>
>>> The same would be needed by nvmet-rdma btw.
>>
>> Retested with the reset loop; no issues found after 327 iterations.
> 
> Interesting, did the host see a NVME_SC_CONNECT_CTRL_BUSY  during the
> test?

Nope.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman



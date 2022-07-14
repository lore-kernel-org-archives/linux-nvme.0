Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57E3C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQfjk/EiRJBS7ZWYy3LrZbVQbXUMlddYbJiR+9/1tRM=; b=lddGrf3kV5zwJrL6NDNRy/CAka
	Xw3Q0u0+EImP9ioXPCE4bWlFkBQ5OAOrCA0vA7YfB4luU0uIvneJok8nl12kOMuUKVrIyQApfbR1V
	CXyk8NSo4ZNaDZU8kVztTBb/OL4fXcgNgf613+JtogcejfU98TrwN5ff9xY+M6BPLKXyb/Pqw5P3F
	9FWbq8Fl3YSITlEToxFa7eLTsDhz1EiVljJk8Cu50h9XC2BFrTQDUuz8YNlSilldPlFhy+Oo9QeE2
	JWoHSSfHnQ+QKGS/o91WOyCWYZlkP80HLZHVnv6GwV1I6/lejdCDDHyxAyPPTlLXC6l8fpJ3BWvTE
	44fa1Ucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0ao-00FatP-Po; Thu, 14 Jul 2022 15:17:30 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC0al-00Fan7-T1
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 15:17:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD72F34CD6;
	Thu, 14 Jul 2022 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657811838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQfjk/EiRJBS7ZWYy3LrZbVQbXUMlddYbJiR+9/1tRM=;
	b=HogBBsgR9SrrmQ3HlsE2p7yFFwoPKIScDtlnufd0EcJeZbH0nnijA4Ojkn7+qPrcOuJGlB
	xft6e9k4IjEEP3/ucup42ldXudNa1qk9qLDUlgweMrCAeJ7ufnQw3NuRNCv+KqoabK/wy1
	L352xIfV73umgfHA0UDdJHgNr6TesMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657811838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQfjk/EiRJBS7ZWYy3LrZbVQbXUMlddYbJiR+9/1tRM=;
	b=JxH0UlWynoVJRzoFq+RAOEUnji2cysrArE+Jy+BqZWJc17WqV2n9TzZqlCFGUbunX0Bz9Z
	0o4mQkzXu2YwEYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9104413A61;
	Thu, 14 Jul 2022 15:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ykB6In4z0GJJSQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 14 Jul 2022 15:17:18 +0000
Message-ID: <15429c01-5274-0cfc-e7a7-465980c294a8@suse.de>
Date: Thu, 14 Jul 2022 17:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-tcp: short-circuit connect retries
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714124133.68598-1-hare@suse.de>
 <20220714124133.68598-2-hare@suse.de>
 <922264f1-3a76-aefa-8e5f-2e41a2130b22@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <922264f1-3a76-aefa-8e5f-2e41a2130b22@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_081728_115566_C5911552 
X-CRM114-Status: GOOD (  23.37  )
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

On 7/14/22 16:35, Sagi Grimberg wrote:
> 
>> When a reconnect attempt fails with a non-retryable status
>> (eg when the subsystem has been unprovisioned) there hardly
>> is any reason to retry the reconnect attempt.
>> So pass the actual error status to nvme_tcp_reconnect_or_remove()
>> and short-circuit retries if the DNR bit is set.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 70096a2e8762..4220c1ad6b29 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2065,8 +2065,10 @@ static void nvme_tcp_teardown_io_queues(struct 
>> nvme_ctrl *ctrl,
>>       nvme_tcp_destroy_io_queues(ctrl, remove);
>>   }
>> -static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>> +static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl, int 
>> status)
>>   {
>> +    bool recon = true;
>> +
>>       /* If we are resetting/deleting then do nothing */
>>       if (ctrl->state != NVME_CTRL_CONNECTING) {
>>           WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>> @@ -2074,7 +2076,12 @@ static void nvme_tcp_reconnect_or_remove(struct 
>> nvme_ctrl *ctrl)
>>           return;
>>       }
>> -    if (nvmf_should_reconnect(ctrl)) {
>> +    if (status > 0 && (status & NVME_SC_DNR)) {
>> +        dev_info(ctrl->device, "reconnect failure %d\n", status);
>> +        recon = false;
>> +    }
>> +
> 
> Why should we call this if we need to remove for sure?
> I suggest we just change the call-site.
> 
>> +    if (recon && nvmf_should_reconnect(ctrl)) {
>>           dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
>>               ctrl->opts->reconnect_delay);
>>           queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
>> @@ -2162,10 +2169,12 @@ static void 
>> nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>       struct nvme_tcp_ctrl *tcp_ctrl = 
>> container_of(to_delayed_work(work),
>>               struct nvme_tcp_ctrl, connect_work);
>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>> +    int ret;
>>       ++ctrl->nr_reconnects;
>> -    if (nvme_tcp_setup_ctrl(ctrl, false))
>> +    ret = nvme_tcp_setup_ctrl(ctrl, false);
>> +    if (ret)
>>           goto requeue;
> 
>      status = nvme_tcp_setup_ctrl(ctrl, false);
>      if (!status) {
>          dev_info(ctrl->device,
>              "Successfully reconnected (%d attempt)\n",
>                          ctrl->nr_reconnects);
>          ctrl->nr_reconnects = 0;
>      } else {
>          dev_info(ctrl->device,
>              "Failed reconnect attempt %d (%d)\n",
>                  ctrl->nr_reconnects, status);
>          if (status > 0 && (status & NVME_SC_DNR)) {
>              dev_info(ctrl->device,
>                  "Removing controller...\n");
>              nvme_delete_ctrl(ctrl);
>          } else {
>              nvme_tcp_reconnect_or_remove(ctrl);
>          }
>      }
> }
> 
Good point.

>>       dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>> @@ -2178,7 +2187,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct 
>> work_struct *work)
>>   requeue:
>>       dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>>               ctrl->nr_reconnects);
>> -    nvme_tcp_reconnect_or_remove(ctrl);
>> +    nvme_tcp_reconnect_or_remove(ctrl, ret);
>>   }
>>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>> @@ -2203,7 +2212,7 @@ static void nvme_tcp_error_recovery_work(struct 
>> work_struct *work)
>>           return;
>>       }
>> -    nvme_tcp_reconnect_or_remove(ctrl);
>> +    nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
> 
> This emphasizes that this is a redundant parameter.
> 

Ok, will be reworking it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


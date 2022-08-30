Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880DBECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYJrHsavbk1kKhmGt65X+AqesHEHIcO48GERxmlQ92A=; b=NrDpVfZm+SzRHCxtmaxvR3FQrz
	12JcwN3t+TaUszNpP/Dj2Ve5vU0fG7N7kPsD1M2khPNAICFG4/NWEEb/PUurYQtCbSWP4ZHsbz55l
	rGjgXS3ibaezHSOw6+jY/2u0dU3ciqmWiG1GW06Kc0MFCKy3fz1KWm9TptdVqaMS2NTHb+ZSslSh2
	uhFLCzXxB5thcb1fyGNAh3aKxK9lET4WI6sFksrm1UeeEsSCDl+XkYuUO9LoA6Li7l6NthyU0BNI7
	KiZiECVVfv2io6rGZYQ9SLnIILwZ3qq5/fMJYnfw7YDSyl4LFiAehD4vQBF44lt7+qlfVF5SJfntl
	UJKnzEuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT2NW-0002oY-4W; Tue, 30 Aug 2022 14:38:10 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT2NT-0002nT-RM
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 14:38:09 +0000
Received: by mail-qk1-x733.google.com with SMTP id f4so8526088qkl.7
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iYJrHsavbk1kKhmGt65X+AqesHEHIcO48GERxmlQ92A=;
        b=bfgaeR+jHsi8LU58OHbWO0qHqki9tFv1bqh9tNz/VLY/stnERJ4DdzORmsPy9rULYe
         UoWzeu5iULXeDqxPGdQ+k4AWQGroS55PMuakWM4ueQLddkKMkI9iAOqVLesCrkbnUtXp
         Kj/P+YrY5hoLBZv9D+UgmM8woONw/WvCwelxs9NOSmBhN/rQri33vebD95ST0EnGaIqo
         P3WOz/qNe8WjmpVYMTrPSY5vZ9oZ4rA9a+3/cch79CESSQYSeS22XgSKzoUmZZQ05bJ0
         KTDdM8WAUKWorXEglbRgqkGn9h0qrGxR87wQf4LY9ACnO+BLlQuITIkUt3SpX0sjCBJ2
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iYJrHsavbk1kKhmGt65X+AqesHEHIcO48GERxmlQ92A=;
        b=UunCy/Lb+vVrk44atnEtJyR22Ca/XX6RjFxsCEXzKBR9ZLMpBP8N/Ozr44JN5G0+IB
         rbDAKsbpWo2WRZx+VOT4H8IWLn7OwUJZ3BwHxbXEpSzsorOqzTUA4pWId2EPj1NBbqw5
         IjC7Eepdi/2EPfKoAIQRK/bnWcYMhzCDfugud2IZwIpX2/q4W/DIrSi+LOWgbFaqWHbB
         g36pp0spGeZlkU77fWzOUPXJAIF6mlHWKgjBWkAeQ6+KJXUzHoqYmzzzuVtg8byMuiW9
         LlGJ039bc5o+Npx2/nF2hRgnlSjLiL87Dn3f/ik/ijHc72UwT0qe3GOo8fuw2Wqyy56H
         k1yw==
X-Gm-Message-State: ACgBeo2+gxc+U5RVJhi1VsSFNkygf3dAEK3v93aiWq16nGTGg0s0dAM7
	O96vy8gqVE/KRALNQuxSVQ4=
X-Google-Smtp-Source: AA6agR4wEaCsMURA3vTn43qM2XuwCRXmUW5nrO6/UA+28MUxRZ7cdIgjaTXRJMDvHF592xBCD9JI8Q==
X-Received: by 2002:a37:88b:0:b0:6be:5a57:34fa with SMTP id 133-20020a37088b000000b006be5a5734famr12336952qki.606.1661870285598;
        Tue, 30 Aug 2022 07:38:05 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id i7-20020ae9ee07000000b006a6ab259261sm7969832qkg.29.2022.08.30.07.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 07:38:05 -0700 (PDT)
Message-ID: <b302a927-8806-5b7c-6cb9-d8be834855d4@gmail.com>
Date: Tue, 30 Aug 2022 07:38:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
 <c5af9904-48f2-93b8-404a-4dc23c63b7c7@gmail.com>
 <0779654e-3945-ad08-a18a-1c195b8dfbe0@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <0779654e-3945-ad08-a18a-1c195b8dfbe0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_073807_907947_F80900F7 
X-CRM114-Status: GOOD (  28.67  )
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

On 8/30/2022 12:57 AM, Sagi Grimberg wrote:
> 
>>> One does wonder: what about FC?
>>> Does it suffer from the same problems?
>>>
>>> Cheers,
>>>
>>> Hannes
>>
>>
>> Yep, wondering too. I don't think so... FC does do this differently.
>>
>> We don't realloc io queues nor tag_sets.  We reuse the allocations and 
>> tag_set originally created in the 1st successful association for the 
>> controller.
>>
>> On reconnect, we set the queue count, then call 
>> blk_mq_update_nr_hw_queues() if it changed before we get into the 
>> loops to change queue states.
> 
> That is the same as tcp/rdma. We don't realloc tagsets or queues, we
> just reinitialize the queues based on the queue_count.

yeah - true.

> 
>> So FC's call to update nr_hw_queues() is much earlier than rdma/tcp 
>> today.
> 
> The only difference is that you don't freeze the request queues when
> tearing down the controller, so you can allocate/start all the queues in
> one go.

This is related to the way FC has to actually do things on the wire to 
terminate I/O's before we can call outstanding i/o dead, and while on 
the wire doing so... they needed to be unfrozen for other paths to hit 
reject states.

When I look at the mods: I still think it comes down to when the 
transports do the update.  Rdma/TCP's mods are specifically that 
start_io_queues, which loops on (the now changed) queue_count, has to be 
called before update nr_hw_queues is called to update it on the tag_set. 
The patch reverts the initial call limit to whats in the (existing 
pre-change) tag_set. And adds a post call to start all queues in the now 
revised tag_set

FC as it doesn't call a loop routine, updates the tag set before getting 
in trouble.

> 
> In pci/rdma/tcp, we start by freezing the request queues to address a 
> hang that happens with multiple queue-maps (default/read/poll).
> See 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic").
> 
> I don't think that fc supports multiple queue maps, but in case the

Nope we don't. Isn't as meaningful based on the way the transport works.

> number of queue changes, blk_mq_update_nr_hw_queues() will still attempt
> to freeze the request queues, which may lead to a hang if some requests
> may not be able to complete (because the queues are quiesced at this
> time). However, I see that fc starts the queues in the end of
> nvme_fc_delete_association (which is a bit strange because the same can
> be achieved by passing start_queues=true to
> __nvme_fc_abort_outstanding_ios.

Yep - code fragmented a little over time.


> But that is the main difference, tcp/rdma does not start the queues when
> tearing down a controller in a reset, only after we re-establish the 
> queues. I think this was needed to support a non-mpath configurations,
> where IOs do not failover. Maybe that is a legacy thing now for fabrics 
> though...

agree. thus the ordering difference vs update.

-- james



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF3C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ctLOsAvNTCrPVR0RzPrWYoRLZ+Rdgjkl2fjWMEZZ24=; b=lYx6/mneWs22GmfQ88YHw1bp6U
	7wHUOZzIvPd/gLMyYjRQ485CzmC/WGt1YrsR5cKryNqH7sjDVB9n+nTfTCzFB4108mE7eGimkl4ZR
	BpUe5Ul7CEhIr3o0TasMqP6ItGOjOkK/JzoGoAzFlkVT2TgF5CYEY21Kjh5Q6iH+nSmtpZhMz2gxO
	LAgzmR92/L+tKmthOJ5mr+0kutDzHnc3efMckPWQAc+bNEVgN91Q/+xkfETFnHnOtWFOAdaq+iGQZ
	tFTJFln3xTG014gB8dh7zzvadfi9PHqjkK5wxXcvaNyVelaJ1qKU3OBu4E63bRxaNPepJ0FZbUdrW
	g4peM50w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCO8u-00000005EDJ-1U2A;
	Wed, 29 May 2024 18:35:20 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCO8s-00000005ECk-081K
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 18:35:19 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-43fe05d6bc9so7711581cf.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717007715; x=1717612515; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ctLOsAvNTCrPVR0RzPrWYoRLZ+Rdgjkl2fjWMEZZ24=;
        b=Lby1LqhkF4FewYvmyksBhTOUryRVqeYBgFL41wZu5MeBdhxXKPsb5ZgMo0d+Rzkpd4
         4f+Ic38vyt/Qyf+rvOfRTN8xWNbdgc5n8EKoqGHlNeLqJGsHeR1lG5TuaFyTWfH9HHbF
         uFRVSOh6HeauM8K5w3hKeYZVjri63lhBdnhtHWvZwDBi1LaiFzVR9dHGC32YJw5c0Ubi
         Q/BMprGK1AtIntCCJW8ez6uXoBjY7Ilow5BGYontMoObgJ7Ku21UsE+k7wutIvaIQD3V
         Y6B+uTOryPPfs2gsgXwWIJ1CX/h571t+N49025155AK2E/yeU+BUBz3dOrhIl2j4GVNj
         Q5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007715; x=1717612515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ctLOsAvNTCrPVR0RzPrWYoRLZ+Rdgjkl2fjWMEZZ24=;
        b=wBdD/clv1zNq0jVyeaBLyFj4YyNJ/UYR9XHSfHzUi15X8GkPCGGT8CZTw980sJmeYR
         uaY9XSqva98QZ9e/Md0AJRaiSBtHJyeuibC/F6kAY/6YnpBfdxdHItYWZg3yL9CbALpe
         NLk8BsxnrimDqds8Nge/9NU7mMhyjzsDCZmuKvR1uoKZ8c48zW8MgWFZJ30KlxPrBy2m
         PjOwkeNESCAsn/jZVv6y7hTQi5h2Z6VMm3CD6VJ/GhPirMWJnl2B1FZRF6QWjbcbO0em
         HOCmFihN67CClVmQb7AxhKG2UWfHESOzR74j7VrCwpWEWgHDHhpkKNa4aKVW30vMn17K
         9tjw==
X-Forwarded-Encrypted: i=1; AJvYcCV2X8A3tViOgjWP7YyLAow+dAEK6krfS1O+eIzZ/N561TXXQfQMfAs49F93wnjkwv1Nt0eIjWWC7FJs8odVxgA3C7jE0qqwo5ugeqD0XRk=
X-Gm-Message-State: AOJu0YyT8K076IPFpV1p9xKHtfdsdY7So/Gaz6eF+osBdhVqFS9gfDfw
	2qta2nAFj5eBrpoRP1JprEMJ1T5PIGVH7jazHUqVXoDaLFzOif9N
X-Google-Smtp-Source: AGHT+IHOnbMshHhJgWYUf7haYF6Y8giHM7Ab85y45whR5EgGhbBc1/W0vyBDpWEe4ishQbS++lmOlA==
X-Received: by 2002:ac8:5a43:0:b0:43a:a255:cf3 with SMTP id d75a77b69052e-43fe93221e2mr666651cf.63.1717007715447;
        Wed, 29 May 2024 11:35:15 -0700 (PDT)
Received: from [10.69.43.60] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb5db77f7sm52141701cf.78.2024.05.29.11.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:35:15 -0700 (PDT)
Message-ID: <ddf19632-cd3c-42e6-9d6f-cfe27b861752@gmail.com>
Date: Wed, 29 May 2024 11:35:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nvme-fcloop: implement 'host_traddr'
From: James Smart <jsmart2021@gmail.com>
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Justin Tee <justintee8345@gmail.com>
References: <20240527051525.762-1-dwagner@suse.de>
 <20240527051525.762-7-dwagner@suse.de>
 <fc2e7d24-d838-410f-aa8c-d10ee69af10b@gmail.com>
Content-Language: en-US
In-Reply-To: <fc2e7d24-d838-410f-aa8c-d10ee69af10b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_113518_100549_AC88E38F 
X-CRM114-Status: GOOD (  25.82  )
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

On 5/28/2024 3:32 PM, James Smart wrote:
> On 5/26/2024 10:15 PM, Daniel Wagner wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Implement the 'host_traddr' callback to display the host transport
>> address for nvmet debugfs.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   drivers/nvme/target/fcloop.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
>> index 913cd2ec7a6f..e1abb27927ff 100644
>> --- a/drivers/nvme/target/fcloop.c
>> +++ b/drivers/nvme/target/fcloop.c
>> @@ -492,6 +492,16 @@ fcloop_t2h_host_release(void *hosthandle)
>>       /* host handle ignored for now */
>>   }
>> +static int
>> +fcloop_t2h_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
>> +{
>> +    struct fcloop_rport *rport = hosthandle;
>> +
>> +    *wwnn = rport->lport->localport->node_name;
>> +    *wwpn = rport->lport->localport->port_name;
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Simulate reception of RSCN and converting it to a initiator 
>> transport
>>    * call to rescan a remote port.
>> @@ -1074,6 +1084,7 @@ static struct nvmet_fc_target_template 
>> tgttemplate = {
>>       .ls_req            = fcloop_t2h_ls_req,
>>       .ls_abort        = fcloop_t2h_ls_abort,
>>       .host_release        = fcloop_t2h_host_release,
>> +    .host_traddr        = fcloop_t2h_host_traddr,
>>       .max_hw_queues        = FCLOOP_HW_QUEUES,
>>       .max_sgl_segments    = FCLOOP_SGL_SEGS,
>>       .max_dif_sgl_segments    = FCLOOP_SGL_SEGS,
> 
> Daniel,
> 
> I found it odd that you had to modify fcloop, but now see what the issue 
> is.  We should have had the WWN of the initiator passed to the fc tgt 
> transport at the same time hosthandle was first passed. There's several 
> ways to do this, such as the one you coded or modifying the ls_rcv call. 
> Downside to these are they change the template or calling routines and 
> breaks the driver/os binary api in an os that picks them up.
> 
> I'd like to look at doing this a little differently. Change hosthandle, 
> instead of pointing to a void, points to a host structure, with the host 
> structure containing WWPN, WWNN, and N_Port_ID. We can set a 
> target_features bit to know if the structure is a void or a host struct. 
> This keeps the driver/os api in place.  I'll put something together.
> 
> Thoughts ?
> 
> -- james
> 

It's a little involved in the hba driver to do what I was suggesting. So 
I think the easiest is what was proposed.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


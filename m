Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A65C64EC4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffBfNnev8PbYkiw3fpNlV2MQ2/g1nCyOGRxRz8scZXo=; b=0iTd8m6hp2bE3TJadhEh0MwMG/
	gEmEI6Df2YN4XEpYKVucRTkL893sxZi89qoij+9gIYVE7ZL0y9ORN9o6d8VRW2OAHsihdTfX/iNck
	NpoHjfUR/x2WLrJ/VzAXW0DPfc/lnCllKGjOaCtr8inRRO9yaaV7XySzc4CATy7Hb9nYx9/WUFzXG
	PqkpNzE2fEFhQCug4l5jIxjONEduiaie3HGoCncHfth38A/QJfv6RSTC/vAvzm31DUCp9nVUQhqA+
	t7/Kk22zFFaAhTLXrPCbp31pV1z3js8ph+mzxqL9+5d+B8lbT8rOihx0tv9Ts3XTZhz0IXZfpj39C
	jK0eqCgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZvUA-005eQF-Hz; Wed, 08 Mar 2023 15:13:46 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZvU7-005eOV-LF
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 15:13:45 +0000
Received: by mail-pl1-x62e.google.com with SMTP id a9so17923100plh.11
        for <linux-nvme@lists.infradead.org>; Wed, 08 Mar 2023 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678288421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffBfNnev8PbYkiw3fpNlV2MQ2/g1nCyOGRxRz8scZXo=;
        b=DQ+tqp0nJDZuPXKPNu1tyb1KWXzLGGY/Vfg264BDSp+Abce5DWBLxYR7Sx2oIk3oqb
         4D5kNslymmMoI3ryFQ/hK8vjEOEuMScnGNKlbc0JoVT+pCxAslhBVncH3WrVpvaEbMFD
         BgurI/GBjo9AG2H7AJ5JMEPXDtpRyOK8qC+FGZ4pDzQP3A9wxBZLtuBNsGlNIkEJHK6g
         CK5w+KekNfDvQf/fp2u8mu8nByeZQJj9vMzqDzDDAIkDwCVVt12CIWHPkLmf1rYP5aBa
         MuDgpQS1RE9nI5Fpdmy+709J9OtfzcHEVj6exvyBuuNgbbTyUMUoBTjOePHnKtt6GycE
         fQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffBfNnev8PbYkiw3fpNlV2MQ2/g1nCyOGRxRz8scZXo=;
        b=OBM6mNX7YK7M0jlzAyxlH5cnDnyf2QrYhCVUKQQWJ7HBtkaI8/gyxvOJGzpbHEKghq
         hRoZXLYWtLpsdcMszP60vkhgzAA+GXBc/n6zVzrFIOQiBD0TePNFE/EIFgH946JBLMY0
         Veurb/bNselgDLm4ToYX+h86+vBsZYYBrWh4gRhvTl3PA7ZCRqv7orvyTQV3nMq2Kyzw
         IoBSgVmuCL/CuPfG95VjSAI1erpUIvNi6uwCV0uJaMJdUMlaGotIvCzcp5pPh/S4UOfy
         yHrxk37W6141bJRwL35hpmeGY5tyX4sKu//2OvViWtrkrKq6UbMr3/a1ckckF/1WL7Kw
         n1mQ==
X-Gm-Message-State: AO0yUKWLy/nBbuX+S1j58IvL+NLWXjPivJ8qhP9Pw4e5WBHhq5JOxbu1
	NhDQOXeALTgrpJ0G2Nr4dD4=
X-Google-Smtp-Source: AK7set86CKsi0uvqtJGCVqqQg0UVoQkRxEudfGk2klm2BTOfjOJgDGG/GOHRRbG3Om6bwatWtHahoA==
X-Received: by 2002:a17:90a:6acf:b0:236:6e4f:bc1e with SMTP id b15-20020a17090a6acf00b002366e4fbc1emr19257440pjm.49.1678288420705;
        Wed, 08 Mar 2023 07:13:40 -0800 (PST)
Received: from [10.230.128.89] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090aaa8f00b002343e59709asm10637105pjq.46.2023.03.08.07.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:13:40 -0800 (PST)
Message-ID: <d6afe56f-556c-05f4-0300-df1e168d6ff2@gmail.com>
Date: Wed, 8 Mar 2023 07:13:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
 <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
 <ce404c97-2716-9572-22de-3935c23757dc@gmail.com>
 <c2d61f14-e505-5e71-ca46-63b318095d23@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <c2d61f14-e505-5e71-ca46-63b318095d23@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_071343_720951_BDA0FE28 
X-CRM114-Status: GOOD (  24.83  )
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

On 3/8/2023 3:38 AM, Sagi Grimberg wrote:
> 
> 
> On 3/8/23 00:09, James Smart wrote:
>> On 3/7/2023 4:28 AM, Daniel Wagner wrote:
>>> On Tue, Mar 07, 2023 at 11:26:12AM +0200, Sagi Grimberg wrote:
>>>> I think we should make all transports to unify setup/teardown sequences
>>>> (i.e. including pcie and fc). Otherwise we are not gaining much.
>>>
>>> Not sure about pcie but I haven't really looked at it. The state 
>>> machine is
>>> really handling all the fabrics specific queue handling.
>>>
>>> Ideally, fc would use the same state machine. Though the current code 
>>> base is
>>> differs quiet significantly but I can try to convert it too.
>>
>> I'll certainly help for FC.
>>
>> The 2 main hurdles are our differences around:
>> a) the new flag - which I replaced in the fc calling setup and a state 
>> flag. Shouldn't be much of an issue. We just need to look at 
>> when/where the tagsets are allocated (and embedding into admin queue 
>> setup isn't necessarily best).
> 
> Does fc create an I/O tagset on every reconnect? Doesn't appear
> that it is removed on every disconnect... I'm a bit confused.

No. It maintains a flag (ioq_live) that is set after first time it 
creates the io queues. This flag replaces the "new" argument. In 
controller connect, after admin/init/aen_init, it uses the flag to
select either a routine that either initially sizes and creates the io 
tag_set or a routine that resizes and blk_mq_update's the io tag set.

fc should have the same functionality as rdma/tcp. the calling sequence 
is just a little different.

> 
>> b) the init_ctrl - I don't have the initial connect inline to the 
>> init_ctrl call - I push it out to the normal "reconnect" path so that 
>> everything, initial connect and all reconnects, use the same 
>> routine/work element. Also says the transport will retry the initial 
>> connect if there's a failure on the initial attempt. To keep the app 
>> happy, init_ctrl will wait for the 1st connect attempt to finish 
>> before returning.   Don't know how rdma/tcp feels about it, but I 
>> found it a much better solution and cleanup became cleaner.
> 
> Don't see a major difference, I personally find the initial setup
> different than a reconnect so its simpler to do them separately.
> 
> Can these two differences change for unification of the transports?

Will I change them to match rdma/tcp ?

The "new" flag isn't a big deal, but I prefer not passing a flag around. 
It was a straight-forward change.

The initial connect - no, I won't change fc. It originally was the same 
as rdma/tcp. But the separate the init create path was causing headaches 
with immediate/parallel errors and reconnect. The code ended up being 
duplicate and competing and it was affecting the way ref-counting was 
being done. It became much cleaner when it was reorganized to reuse the 
existing reconnect path.  Took a lot of time and testing to reach where 
it is.

I don't know how much time/testing has gone into rdma/tcp for injected 
errors, or immediately connectivity loss. FC also can't just stop if the 
initial connect fails (e.g. one of first fabric commands fails due to 
injected error). As everything is automated via sysadm and driven by 
events from host adapters, if we stopped after 1 connect attempt the 
storage wouldn't show up. Having the reconnect path exist even for 
initial connect was beneficial.

However, there's a lot of commonality we can address outside of this.

> 
> I would also like to get rid of the new flag, and just break these
> sequences to different routines.

-- james



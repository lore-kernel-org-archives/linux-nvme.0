Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEBCC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5OHKczBwEN2aSdja3aatxPc+AcOcxLZ/vyrtt6MTQ0E=; b=qv0No38rDTgk1HgnYy0srX5hdZ
	jGVIunpwziMs3RSFp6eg+zvmTjkDjjXR5EnCz5lYFH/tQzpx1G2eur3W502Tc9FEqL1LTG6tElyB0
	w2eG8P7CR5rkxMGjVvv685t5PkaNzTe8kjy/kZ8PtElosTenzkCgrdTgp55gtQhmBm7Aq11GS7Gdc
	PrRJ6kc4+9g94fMCi+ToAWSPlNgMSyOmxPv/pTHI5bZck145gf48UnzNvlz3xR2WP7NWXHPfpIlsd
	NYePn3BjuOFhOJQ2FkPNi7+R6+L+c8+PjqHsx0rmA5IoqNyX4gqxzxx53Fr2V3eXXQD+7t8Ntcr9z
	MruUxB7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgG1-00FMiZ-1j;
	Tue, 19 Dec 2023 20:00:01 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgFy-00FMhL-1O
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 19:59:59 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c192f488cso9633255e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 11:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015987; x=1703620787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OHKczBwEN2aSdja3aatxPc+AcOcxLZ/vyrtt6MTQ0E=;
        b=CAIGC2DEjdQLDmt/eL0eLXKg5EvbUuIVKzygOoqmwlUY29nnfAA4lM6CyV4eJHFbq1
         MWJQsN+S+tnfefYqWhlvGlurQ7qiWr+pflIQxvwRui44R2jfEjq3i2d1IM5baH+YkWR4
         rFSw1ox9ul0ykVXJUVnwW41ya9wzPHK63GTjttgL9ujZfvai/B4/hB6+EEYiHwZjliAG
         3M1sBgGO+gFMXhoEDafB2L9vwF36G+1LImzqPaVLHd+4XYNFLAlgmZ5PUIZkT0NcgopC
         s8O3YaLGY8dIKbQZZCxzMfCl1cO2U+LkKY9kecYyneG5Z4T8MJ7gUe4krkkh1tfFZpka
         NC0A==
X-Gm-Message-State: AOJu0YzC2L+3mQjghA0Qrbj+nzBf0rP/2X2MLFr43gDpaXQAols5yX/s
	URa+YL93brpXny1z01ft9KA=
X-Google-Smtp-Source: AGHT+IHur0oUc0ShrpjXt3gHpYyumdcJ/F9Uvb2kiWaiW1USfNtIAEYru/NVA01aKHvt2e216sDxzw==
X-Received: by 2002:a05:600c:5110:b0:40c:6e2a:35e9 with SMTP id o16-20020a05600c511000b0040c6e2a35e9mr9042662wms.0.1703015987079;
        Tue, 19 Dec 2023 11:59:47 -0800 (PST)
Received: from [10.100.102.67] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b0040c4afa027csm4054284wmb.13.2023.12.19.11.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 11:59:46 -0800 (PST)
Message-ID: <c566399b-04cb-4aea-beb8-230dbdc9ebf9@grimberg.me>
Date: Tue, 19 Dec 2023 21:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
 <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_115958_464796_CE908960 
X-CRM114-Status: GOOD (  13.44  )
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



On 12/19/23 19:24, Max Gurtovoy wrote:
>
>
> On 18/12/2023 18:04, Sagi Grimberg wrote:
>>
>>>> Is anything else in the identify wrong, or is it just these
>>>> fabrics fields?
>>>
>>> So what I am seeing on the wire are a few fabrics commands (connect, 
>>> get
>>> property) followed by the nvme id ctrl command (opcode 0x6).
>>>
>>>   nvmet: nvmet_req_init:962
>>>   nvmet: nvmet_parse_admin_cmd:1011
>>>   nvmet: nvmet_parse_discovery_cmd:359 opcode 6
>>>
>>> This calls then nvmet_execute_disc_identify, so adding
>>>
>>> --- a/drivers/nvme/target/discovery.c
>>> +++ b/drivers/nvme/target/discovery.c
>>> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct 
>>> nvmet_req *req)
>>>   {
>>>          struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>          struct nvme_id_ctrl *id;
>>> +       u32 cmd_capsule_size;
>>>          u16 status = 0;
>>>
>>>          if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
>>> @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct 
>>> nvmet_req *req)
>>>                  id->sgls |= cpu_to_le32(1 << 2);
>>>          if (req->port->inline_data_size)
>>>                  id->sgls |= cpu_to_le32(1 << 20);
>>> +       /*
>>> +        * Max command capsule size is sqe + in-capsule data size.
>>> +        * Disable in-capsule data for Metadata capable controllers.
>>> +        */
>>> +       cmd_capsule_size = sizeof(struct nvme_command);
>>> +       if (!ctrl->pi_support)
>>> +               cmd_capsule_size += req->port->inline_data_size;
>>> +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
>>
>> Yes, this is the culprit. Nice that it exposed a bug.
>>
>> There is no in-capsule data for discovery controllers afaict.
>
> Also, the discovery controllers can't support PI AFAIK.

Indeed, we should simply set it to sizeof(struct nvme_command) / 16.

It is true that for tcp transport we should add additional 8192 which
is mandatory for nvme-tcp. But that can be done in an incremental patch.


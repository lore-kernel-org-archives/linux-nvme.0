Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D61FCD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RD6NjiL/jy5bN6nqx44Jhs0tnVfi5J87s8QVwMQkqM=; b=XiZH6bhb5UFnAtbi02McvfQsnY
	kK7AhVyeuhFvmEsJm9ZWAGJU8mIb76tRmcUtGc3EbM0QWRJ3Ck4XvQYz/MJntuQr1De4Mw0+e/p+Z
	e3gKNLt6LROzDqQGHNhufRkjlOEr2hEx3bYrmIqUxaoET26ibcPbQIUj8tmcQqcUhbx0XzYOo3X66
	TW/9U7xzohFReSyvquDoYycRcyuugFYpqKYnTQzHIFDkLZcd1zWePPVHQ2c/fTP60QEEiMhry0hfG
	rIf0NOdxJ1Mh6L4J6F8BfP2yk+CGjQ4nvX1largQUoS7cZx4x5ZsDt0zvCRwLTk1NOsfJ/89LKLPd
	YLFvsd2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6xr-00000004h5j-3FRc;
	Tue, 26 Mar 2024 13:35:43 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6xn-00000004h3X-282d
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:35:42 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so4701672b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460132; x=1712064932; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RD6NjiL/jy5bN6nqx44Jhs0tnVfi5J87s8QVwMQkqM=;
        b=eGgbM96T/Lo+IPJvI8mIXxgmsVouDgm4ZnHPbpUiLKn4Br+lQnlehfhPRnQ4pr5dao
         Z34TMAOWHXaHVeXcyeu4Sl2bKf3uKaFkjptm5QjsL2efyCsihOO4mC4WpmhSxyRzYymX
         CVpdie/SsKgq29t6LECjNdjDAJFOIeom8JPlTzY8EwO3hQGxu5Beck1adAFZavrNpSJh
         bV00m/KSoPQCwOqewcU6vu4hzJRDVzWu0sUzVbfBXjp9ylzZXg6zOEiR5Hqotd4M7JwZ
         h8/KCsL2YKdOgFaoSEl1+GY51gqKKoK4IzLKVvc7evL3WA+/csqzxsswhX+gYnqi132L
         p+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460132; x=1712064932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RD6NjiL/jy5bN6nqx44Jhs0tnVfi5J87s8QVwMQkqM=;
        b=DrJE6julaMiJMGpBJLdRM1m1OmWrQoIndewXHTSATWA3K9+CxWCzTmSodjp4HWcJHq
         gw4x8a5weAH3K4nrT3Xz1HEWdsVZB7ZAX+avkOjDUZyqUHjENGpNShdXXoSEL+7XRETl
         yNW9qgdRB5Bweu/7wJzKqSNZJ8eXm6fdmKd3gocNfc5t4nWgzLmc8nBSDr2C6OTs82tq
         nSvd2wpmF9a+mG7MftvLJQHSEY5GwhMO0NJgqGOYr8BM+kyiVLvUcySZUCBI6LJvozyb
         USoef/9VJQgeUOjW0mwXKySQQBtJZEm1hEeBE0T2Et9a78JchBQUrJLuyvDMru7T+gaR
         RxMg==
X-Forwarded-Encrypted: i=1; AJvYcCXOKygJJBpnqaD5lCzsZZB1BehSr/qv9cSOGR76yBscbJ8otyknmNolcFjw4AcFPNO1DqzYYa0vmmk4biDGOVBVrOBWXGtEuYHYkEsiPqY=
X-Gm-Message-State: AOJu0Yw2EEFLzEuU5cO4lQ38MnzELjeIcnQOY6rqVpd/CygO8cqF+uKQ
	aCU40qRvA0frPqRXWnV8WNQ1qukupKA+j5g45+MveSQt7iGGl7ComCf6Y/Ss
X-Google-Smtp-Source: AGHT+IFBcMVb0NqpQ4mMdehgQfMxASIrSja1UtdJk1clsv0SzlpfrwYgD0p861oIiDY5RTetQuwIsg==
X-Received: by 2002:a05:6a20:7501:b0:1a3:5c61:5ec2 with SMTP id r1-20020a056a20750100b001a35c615ec2mr8354950pzd.16.1711460132416;
        Tue, 26 Mar 2024 06:35:32 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:ad8c:fe86:c9db:d9cb? ([240b:10:2720:5500:ad8c:fe86:c9db:d9cb])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b006e5a3db5875sm6147324pfm.13.2024.03.26.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:35:32 -0700 (PDT)
Message-ID: <6a8db18b-eb09-450f-b7b2-a927cccf6639@gmail.com>
Date: Tue, 26 Mar 2024 22:35:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240325154503.11510-1-ikegami.t@gmail.com>
 <b7eb8b26-70bd-438f-90c6-e8165440be5a@grimberg.me>
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <b7eb8b26-70bd-438f-90c6-e8165440be5a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_063540_549915_0058821A 
X-CRM114-Status: GOOD (  13.10  )
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


On 2024/03/26 17:20, Sagi Grimberg wrote:
>
>
> On 25/03/2024 17:45, Tokunori Ikegami wrote:
>> Currently nvme_identify_ns() sets the data to NULL if failed.
>
> Where? Nothing sets id to NULL in nvme_identify_n(), what am I missing?

It is set as below.

https://github.com/torvalds/linux/blame/master/drivers/nvme/host/core.c#L1542

>> Also the data is not freed if the function returned failure.
>
> Where? I think you may be looking at a different code base?

The ns_update_nuse() returns without the free if the ns_update_nuse() 
failure as below and the ns_head_update_nuse() also same.

https://github.com/torvalds/linux/blame/master/drivers/nvme/host/sysfs.c#L224
>
> -- 
> int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>                         struct nvme_id_ns **id)
> {
>         ....
>         error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, 
> sizeof(**id));
>         if (error) {
>                 dev_warn(ctrl->device, "Identify namespace failed 
> (%d)\n", error);
>                 kfree(*id);
>         }
>         return error;
> }
>
> I don't see how this patch makes sense...

I mean the id pointer should be initialized to NULL before the 
nvme_identify_ns() call. Currently above both the NULL setting and the 
failure return without the free the double error issue resolved but 
looks ideally initialize the data to NULL.




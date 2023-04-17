Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F434C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/B1DIQ4G+ExycW+/gR3mus18QKSxpH8JiHV+2U3tGo=; b=zzZzocQloHnRPfgefmbAKuFJrB
	dW8U61mCecBnuk/TWajNMd0hvK4ydLN2bQFwt+6vtR9vX84z+o8fYO5rbh9dC+Oi8P486kdzNIuyi
	qFnleT48QjeiToiVbgT5So9MTe8scwMy1tp4oJkIAaVqF8h3gVjnnkgeWUt4A5alalSrRlnNqMeZo
	HNeyEmldyZBX76vEET8jcIQUF5pG4YPM9bBGvO4wLyxMf3VqHsmw3VBGNMEQLS7wuxVkEZCLcyO3X
	ywDPr77JjrI26jGgv90DHADI9z4YObv9h4IVQcAGNrMMiPXECDsFiDeg1SVb3cJ+DLufh2rvCWq2F
	u5+dGzQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQpR-00Gtzl-0o;
	Mon, 17 Apr 2023 15:31:41 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQpP-00GtyL-0P
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:31:40 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso7372175e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745494; x=1684337494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/B1DIQ4G+ExycW+/gR3mus18QKSxpH8JiHV+2U3tGo=;
        b=IOvGhyMwz8GhQjUonNGGMAgAamsLjXMOnElAoQH1HPHmYoLbxL6M3tlXdGfLo5IElq
         qiwKrWJFiwGey3xXKUiPwlgVK3QPP2EEDmcaPleuk6Gdzi1t7tPyXMZNaoaFDItGw4cV
         CRze/ptNJwx+8NGIq5vAKKYOxgS9JTCT8oJqtby8QWwloh3RY6TgCPqfdUTU+cANBE+o
         3b8B2MySJBWlfjGxDexRXvZdJS0sJuKAsBq9BmCg4jfpNuWCSb0jiPjUR1dOnnrxotwV
         C0SwKq6dg/WR0QejDPBzmUe/uyUs5dPc4rUgqcPE8RwEFt0RJTO3/qUK6kwojBoydq67
         rRWg==
X-Gm-Message-State: AAQBX9fAajSe5sh09NSIs0EjBq5nWJQXcvhNwYWK01wM17vROVYC3gsC
	3eMYDsYOtJLmUAcCZmGN7pM9QlBhLXc=
X-Google-Smtp-Source: AKy350Yk3blXdCY5+7BRzbp7JGNdf6n86ey2FvPMcvLXxXzmJKJpLjigpe14LFIq8fwf7rwMFFnssw==
X-Received: by 2002:a05:600c:1d1d:b0:3ed:793d:9dd6 with SMTP id l29-20020a05600c1d1d00b003ed793d9dd6mr8341701wms.1.1681745494224;
        Mon, 17 Apr 2023 08:31:34 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003ef64affec7sm12171134wmr.22.2023.04.17.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:31:33 -0700 (PDT)
Message-ID: <298e74a7-4560-ac01-ad40-24019057b9bb@grimberg.me>
Date: Mon, 17 Apr 2023 18:31:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <73d59afa-d385-2616-fc74-13ad3bfe49be@grimberg.me>
 <4e9b3f94-b059-b225-9fa6-68178ebda990@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4e9b3f94-b059-b225-9fa6-68178ebda990@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_083139_166236_6D1C0BAF 
X-CRM114-Status: GOOD (  12.15  )
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


>>>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>>   {
>>>       int ret;
>>> +    key_serial_t psk_id = 0;
>>> +
>>> +    if (ctrl->opts->tls) {
>>> +        psk_id = nvme_tls_psk_default(NULL,
>>> +                          ctrl->opts->host->nqn,
>>> +                          ctrl->opts->subsysnqn);
>>> +        if (!psk_id) {
>>> +            dev_err(ctrl->device, "no valid PSK found\n");
>>> +            ret = -ENOKEY;
>>> +            goto out_free_queue;
>>> +        }
>>> +    }
>>> -    ret = nvme_tcp_alloc_queue(ctrl, 0);
>>> +    ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>>>       if (ret)
>>> -        return ret;
>>> +        goto out_free_queue;
>>>       ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>>>       if (ret)
>>> @@ -1778,9 +1887,15 @@ static int nvme_tcp_alloc_admin_queue(struct 
>>> nvme_ctrl *ctrl)
>>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>>   {
>>>       int i, ret;
>>> +    key_serial_t psk_id;
>>> +    if (!ctrl->tls_key) {
>>> +        dev_err(ctrl->device, "no PSK negotiated\n");
>>> +        return -ENOKEY;
>>> +    }
>>
>> is ctrl->tls_key always set? Looks like this is the expectation.
>>
> 
> It needs to be set when TLS is enabled for the admin queue.
> Otherwise no.

Then aren't you missing also and statement with (ctrl->opts->tls) ?


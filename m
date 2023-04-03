Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948A9C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFuwslfLoE4sWWAJFNDYX7LQkV0lImtB/4fbY+D4Hno=; b=V+h3phEJo5nixZkMEhEPTDCnNk
	CjrIndC+X0wudGlMV4gdajbvll7hVoJ/H8j2eryH4r10bI50/pUN2e1Ua0P892dJ6liTq0bLlcXZT
	Pg+fvCuWQIJWQvdIBuQzkMRWrF6w4y54sQzakdyjKuV3n6NvqqGrwCBjclCSs03GhozTbC4ZKluiC
	XGJtEJW6AoD1oQ2nqr8ZrQ3XdwzaoGlot2g+1S0WthCNA8lF5/JOsFfxqy2V/TFQ+fbvoF5I6lTIM
	4EDFeLZyGMJmjn/lMVLGuEqWwquYl7rm5UDeiZuRt3pIjYiCmXqS90DW7fD31DZOjH5A3iDn6kZ7L
	/wzwneUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJL1-00FHE6-2B;
	Mon, 03 Apr 2023 12:31:07 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJKz-00FHDf-17
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:31:06 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-2d17b1b21f1so504426f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFuwslfLoE4sWWAJFNDYX7LQkV0lImtB/4fbY+D4Hno=;
        b=yAjBuQAPr/InIMrMaemvNocQhxgerS6+C53auQ/zKFpxe1pLcZyX6hcP9lMmn8kUF1
         /kCUs155tfluBex8NxVha7ej4luM4QK3W4pft2ATx6Wl0CsHLmOCUqKTvSKwB3PbqTyE
         XTBqlClUG3sUrinWKhEeHan+NONHTlFE5p6PdYQnZVvgBnegLmc0tYKfHBSg0KY1DRuT
         zPHrlEJ0cCOLP1o84ja7Z8Ec4TfQslXjEQXckychG7LsWYs5gUeF993nE9Ue34OCIqY7
         oyyKjf2ffZemi0SZ21qkra2tkfQ2RLWfSC3O049d0BFJRI1/ZQ2OELMSZgeF33JxHLEV
         +DZA==
X-Gm-Message-State: AAQBX9eI8jb9dTy3Nj0qCsQeWx3ehbePmWb4oIZ4CFb8qiOl3+4yDOXG
	D8KAiboP2nwfbX7Dv/QMmfk=
X-Google-Smtp-Source: AKy350Z/c4EM4LwyfamIrBtIcJ1qZp3nqYS5CtOf/zcd2n2D7lJXJsVTJPhDTyEQT7fVJnuWfDlNaA==
X-Received: by 2002:a05:600c:3108:b0:3ee:1c42:6582 with SMTP id g8-20020a05600c310800b003ee1c426582mr11843421wmo.3.1680525063536;
        Mon, 03 Apr 2023 05:31:03 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003ee42696acesm11933648wmj.16.2023.04.03.05.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:31:03 -0700 (PDT)
Message-ID: <2e63aeab-6384-e10a-40d7-bbe305bba51a@grimberg.me>
Date: Mon, 3 Apr 2023 15:31:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/18] nvmet: make TCP sectype settable via configfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-14-hare@suse.de>
 <6fe0b3db-d60d-822f-b03a-acf697e50ff2@grimberg.me>
 <0c2240f0-27cc-ba19-16d8-8aac0399dda5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0c2240f0-27cc-ba19-16d8-8aac0399dda5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_053105_385261_ACC4021F 
X-CRM114-Status: GOOD (  13.43  )
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


>>> Add a new configfs attribute 'addr_tsas' to make the TCP sectype
>>> settable via configfs.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/configfs.c | 67 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/nvme/target/configfs.c 
>>> b/drivers/nvme/target/configfs.c
>>> index 907143870da5..ca66ee6dc153 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -303,6 +303,11 @@ static void nvmet_port_init_tsas_rdma(struct 
>>> nvmet_port *port)
>>>       port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
>>>   }
>>> +static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int 
>>> sectype)
>>> +{
>>> +    port->disc_addr.tsas.tcp.sectype = sectype;
>>> +}
>>> +
>>>   static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>>>           const char *page, size_t count)
>>>   {
>>> @@ -325,11 +330,72 @@ static ssize_t nvmet_addr_trtype_store(struct 
>>> config_item *item,
>>>       port->disc_addr.trtype = nvmet_transport[i].type;
>>>       if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
>>>           nvmet_port_init_tsas_rdma(port);
>>> +    else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
>>> +        nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
>>>       return count;
>>>   }
>>>   CONFIGFS_ATTR(nvmet_, addr_trtype);
>>> +static const struct nvmet_type_name_map nvmet_addr_tsas_tcp[] = {
>>> +    { NVMF_TCP_SECTYPE_NONE,    "none" },
>>> +    { NVMF_TCP_SECTYPE_TLS13,    "tls1.3" },
>>> +};
>>> +
>>> +static const struct nvmet_type_name_map nvmet_addr_tsas_rdma[] = {
>>> +    { NVMF_RDMA_QPTYPE_CONNECTED,    "connected" },
>>> +    { NVMF_RDMA_QPTYPE_DATAGRAM,    "datagram"  },
>>> +};
>>> +
>>> +static ssize_t nvmet_addr_tsas_show(struct config_item *item,
>>> +        char *page)
>>> +{
>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>> +    int i;
>>> +
>>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
>>> +        for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
>>> +            if (port->disc_addr.tsas.tcp.sectype == 
>>> nvmet_addr_tsas_tcp[i].type)
>>> +                return sprintf(page, "%s\n", 
>>> nvmet_addr_tsas_tcp[i].name);
>>> +        }
>>> +        return sprintf(page, "reserved\n");
>>
>> What is reserved?
>>
> All other values?

Yes, you should just consolidate it outside the if-else instead of "not
required" (which is a treq value iirc).


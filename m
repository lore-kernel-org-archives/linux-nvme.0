Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B32C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3O+fD9w5JJOLz6WDLps0JCyPSQtsDkjmTzs6tjbSx0=; b=pK5GGlg8keA3iDSAmuSfepS5LR
	k9GgHXDRt5FHylqfTmOD005VDnJQiJxyUR1y98ciHwQCTP+/JFSg64+dyg6wCJpC8DMMWUPJ+QgYl
	ExyYXxh3D9uUBSJt3jdpzp3oIpQwqlyrFT0SdN2yUeq8iyDNQy0JbaFEYr4bQ7vCksgow4q9HYKKF
	F9Ly4JQtFBA6f3K1KE3WLHiKo1/rJEIfTr/kZ9EwJICvNJCa6uXG1AF9JybyfJLdbNk6fGdocMJ3V
	lRv1LNVejNox6xLfPTdFawQ+Py/HevAjonOTPDMQusN1vFfn25Ox4+LGZK84jOKdXIwDyjUOvNSIa
	01lKI+nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9rs-00Gm28-22; Mon, 22 Nov 2021 14:00:24 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9rl-00Gm0x-4b
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 14:00:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 b184-20020a1c1bc1000000b0033140bf8dd5so13630440wmb.5
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 06:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P3O+fD9w5JJOLz6WDLps0JCyPSQtsDkjmTzs6tjbSx0=;
 b=7KS46uAtlabLrIsYNViabIUBg3/l8w35SgdpR8pevTAZRLLsaue6pSf85D4CUjX3Fg
 +YCdwpMx6rI4wNyvbh2lBFwrvXxk+qIfHGBbkKht4wIQW5TWlkafdkPy1/GQynOEFwrg
 EJe/ma5Xlc82XQT6DssLs1FMFqyNtJwdopQs6XzeKQy0oMmlG8JZN3BnqWjnyhvcJ7W0
 pGzp1MQuNUxFZJzCV+enL+56Z71MZcxEkF/vfzgb+kohqoe2Ee8rD+XEz+Md9Ortf5Zj
 DZU/3c1QiKgRnpAV8X4yGrN9Jo53NVXbsOQcABhgRk4Nm+bv6WejY+SFACts/Sy+/5yl
 9vjg==
X-Gm-Message-State: AOAM5323aFrDGdC7tECE9sDMutrA9Uy5iaeRH4JntYBA827ZD17NgdCJ
 0wPuZNZuvmvAXU57ZkfPYHg=
X-Google-Smtp-Source: ABdhPJzZUCpqXdycf1RfqUNonaCY+6vCaMe0pQwfc5my7tic5qJhas+uT3YkP5pM9EYwT13CEZNA9Q==
X-Received: by 2002:a05:600c:3505:: with SMTP id
 h5mr29420683wmq.22.1637589615254; 
 Mon, 22 Nov 2021 06:00:15 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n4sm11102168wri.41.2021.11.22.06.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 06:00:14 -0800 (PST)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-11-hare@suse.de>
 <762ce404-9035-30ca-078d-eb0b36223e4c@grimberg.me>
 <313b19d2-ea54-ce1c-f9cb-3f1fb6743787@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <891fe077-40d3-5bad-52fb-f0ee6f6107b6@grimberg.me>
Date: Mon, 22 Nov 2021 16:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <313b19d2-ea54-ce1c-f9cb-3f1fb6743787@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_060017_239503_132F3EE3 
X-CRM114-Status: GOOD (  17.67  )
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



On 11/22/21 3:21 PM, Hannes Reinecke wrote:
> On 11/22/21 12:59 PM, Sagi Grimberg wrote:
>>
>>> +void nvmet_execute_auth_send(struct nvmet_req *req)
>>> +{
>>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>> +    struct nvmf_auth_dhchap_success2_data *data;
>>> +    void *d;
>>> +    u32 tl;
>>> +    u16 status = 0;
>>> +
>>> +    if (req->cmd->auth_send.secp !=
>>> NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>> +        req->error_loc =
>>> +            offsetof(struct nvmf_auth_send_command, secp);
>>> +        goto done;
>>> +    }
>>> +    if (req->cmd->auth_send.spsp0 != 0x01) {
>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>> +        req->error_loc =
>>> +            offsetof(struct nvmf_auth_send_command, spsp0);
>>> +        goto done;
>>> +    }
>>> +    if (req->cmd->auth_send.spsp1 != 0x01) {
>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>> +        req->error_loc =
>>> +            offsetof(struct nvmf_auth_send_command, spsp1);
>>> +        goto done;
>>> +    }
>>> +    tl = le32_to_cpu(req->cmd->auth_send.tl);
>>> +    if (!tl) {
>>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>> +        req->error_loc =
>>> +            offsetof(struct nvmf_auth_send_command, tl);
>>> +        goto done;
>>> +    }
>>> +    if (!nvmet_check_transfer_len(req, tl)) {
>>> +        pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
>>> +        return;
>>> +    }
>>> +
>>> +    d = kmalloc(tl, GFP_KERNEL);
>>> +    if (!d) {
>>> +        status = NVME_SC_INTERNAL;
>>> +        goto done;
>>> +    }
>>> +
>>> +    status = nvmet_copy_from_sgl(req, 0, d, tl);
>>> +    if (status) {
>>> +        kfree(d);
>>> +        goto done;
>>> +    }
>>> +
>>> +    data = d;
>>> +    pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
>>> +         ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
>>> +         req->sq->dhchap_step);
>>> +    if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
>>> +        data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
>>> +        goto done_failure1;
>>> +    if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
>>> +        if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
>>> +            /* Restart negotiation */
>>> +            pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
>>> +                 ctrl->cntlid, req->sq->qid);
>>> +            if (!req->sq->qid) {
>>> +                status = nvmet_setup_auth(ctrl);
>>
>> Aren't you leaking memory here?
> 
> I've checked, and I _think_ everything is in order.
> Any particular concerns?
> ( 'd' is free at 'done_kfree', and we never exit without going through
> it AFAICS).
> Have I missed something?

You are calling nvmet_setup_auth for re-authentication, who is calling
nvmet_destroy_auth to free the controller auth stuff?

Don't you need something like:
--
		if (!req->sq->qid) {
			nvmet_destroy_auth(ctrl);
			status = nvmet_setup_auth(ctrl);
			...
		}
--


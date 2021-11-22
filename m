Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C8AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tab8mExZ4oTzUdTEjDqIXzkFcjph0WsizEVVVTROgis=; b=2a6LYfDxy8yDSHVCSdVHcSooFH
	4j+IwaQxyZRIXlOi/6FL/wLJgZTNCJ7KAAQ2uLYPJGgXtkhGShPOT0Y8g5nreoEDBG3sOTR6t2Fh8
	xn4fKtvBzC+VW4nGcsMckHxi4ysB78WM5uDSd7eoPgJYPTRNffzGSE708M4KXmFr1DqeBPFeYStB5
	FbrMs3g5iagTnPdVvLAsaYW8Lj5onG3aK7giPhuc+ZR2uRCjUdH4uaHPePxAjX37RPZA4xkdV/gpZ
	LeSFeh8JZjmkP36BMnnwJRxN7bopwBMh2EPk/aXfWXe5+hZg/bh+uHLnKb4cSwseSu93JgQa+9kR/
	yX45ly5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpAWi-00GuOX-Mn; Mon, 22 Nov 2021 14:42:36 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpAWg-00GuNK-TU
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 14:42:36 +0000
Received: by mail-wr1-f44.google.com with SMTP id b12so33145487wrh.4
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 06:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tab8mExZ4oTzUdTEjDqIXzkFcjph0WsizEVVVTROgis=;
 b=izFEJ1FTEhoZF5nr1MU90ZpPH4FlBG+9vlq9OTYOiXPbvJRWXibCKNMsz0jCj68G1+
 bCQo0xif2Qw26nAj3kjmJTquOM4D5YCJYaxeoxcFLj5h2ON9AlYVmzYCStKq5T928qIe
 EqP+Z67RLnDE4GQCySNlitGn+gfZLKZneGPJfAEx3ytGiCtAP+lmsIZY87Want4VL9GU
 PQR8LPiBnAbe/AJjf/SYCtCPO68r/Jfg2N9lb5EglUyWr02dr2wRkn47occCuNWvqXSg
 CNywoh6QeqqLiigMFXQqI+a0iDrwV57O6xUrqJjObluZCLL/vmWg2fErfID2yr1TSeFs
 mo9w==
X-Gm-Message-State: AOAM530FKTMOlQ2LM5+7LeXwTEimNyw1t/DLo+lZzabLPQoA5Au8oTCp
 7xvCxlq3/0q3FkfyXEuN2EurFlET6wA=
X-Google-Smtp-Source: ABdhPJzhe4LUi9JF5/JCKAk4hOYblFdqDcuNS3UMg1ZRm8HqJjCxdg7N8Yggn37NqN02WKtojc2qjA==
X-Received: by 2002:adf:f00a:: with SMTP id j10mr38438893wro.339.1637592152840; 
 Mon, 22 Nov 2021 06:42:32 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a9sm8610879wrt.66.2021.11.22.06.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 06:42:32 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
To: Varun Prakash <varun@chelsio.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <1637575953-3143-1-git-send-email-varun@chelsio.com>
 <76c6cd6b-8846-a9c9-d0b7-00405fe63740@grimberg.me>
 <20211122143425.GA1716@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a895412-d02f-2286-e901-eba5e6c8f6a9@grimberg.me>
Date: Mon, 22 Nov 2021 16:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122143425.GA1716@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_064234_984958_EFEDCAED 
X-CRM114-Status: GOOD (  12.37  )
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


>>> @@ -2321,6 +2327,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>>>   	req->data_sent = 0;
>>>   	req->pdu_len = 0;
>>>   	req->pdu_sent = 0;
>>> +	req->h2cdata_left = 0;
>>> +	req->h2cdata_offset = 0;
>>> +	req->h2cdata_ttag = 0;
>>
>> This doesn't hurt anything, but it also redundant AFAICT no? these are
>> only referenced in nvme_tcp_setup_h2c_data_pdu which is called from
>> nvme_tcp_handle_r2t, which is setting these right before the call...
> 
> if (req->h2cdata_left) check will also execute for inline data, can it
> have a garbage value if driver does not set it to 0?

Right, that one needs to reset.


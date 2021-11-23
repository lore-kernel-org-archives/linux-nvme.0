Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HT/ZUTKyEAz5ex2GuqzzrncfIp8V6F2pZsGlVdkWSqM=; b=bwHIIUHcHfpG8IEa7C8novYWVy
	kYHbyRUJLs0QppeV+AzwwNlyQwwSVUzslVz15n3BX5g6In0EFcEx/Je+PTdS6B3YzqODBM+zL9NF1
	IbDSAQJ8PedFUAI6zLPd3SECszRgbk8zfnRivij5dqy9ve6aOktSTVRw9P+vBlUWCp+mgyXJzAtAw
	2J4xIj3j8kmpt7fA4dLOsOY4PH060h92zZfVlz3oZPPPnBS0bmK4Y82hybGATLP733VMNswrEx6MV
	xb4LK8extGSNFOblLHvzuV17ZycLfCjrfOxqlAy37Vu4L/kwS34vcmKCxKTRt+WDeO5orvbWEKx3l
	4xG3Izsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpbyV-003OKn-9J; Tue, 23 Nov 2021 20:01:07 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpbyS-003OJa-Cv
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 20:01:05 +0000
Received: by mail-ed1-f51.google.com with SMTP id l25so80063683eda.11
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 12:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HT/ZUTKyEAz5ex2GuqzzrncfIp8V6F2pZsGlVdkWSqM=;
 b=yy7JKTYwTyTgnhID5ZyXCPc0O8I2DsvLeQrG7RnAKOs3nxjuF93Igtc9NzuUvV60/6
 KLNzC0l/qW7GuVrwYt+w8yXlZ5S2dstj57VeS9N8TGERyM1MB3kXbqnhM/h1gTaeFacz
 BVvq/jto9bayBe5WwDqCmcJFChpgPRbfDIu2kuM/tWWGSKNYzZTtfkTTWd0eRooYw7Wm
 q09zG9fGEmU5jZqMwUyohzssP383AcnL4HBGOT48cwOPfbgo+L9F1FxXd6dee8Dt1pER
 PzYL22CuzJoNkWcow1bUwNb4eCFDlvlPSfz88UOebJE3JE75aaJiTewkammCgLSCf65Y
 L0qA==
X-Gm-Message-State: AOAM5331tmQgsnAPC1mTOWzPCic+HWXKD1PTmixzzT7vFrUsZXBAjpop
 eMTmZte0+p8YQ0v7g+dHhu7TEx0kTcI=
X-Google-Smtp-Source: ABdhPJw+Pf1znflYccjAvfSQnYmmUzFVOTe3LDxYWVEY4GGt3cokr3rZyDBh0jOSOZdeOdzB9OGZJA==
X-Received: by 2002:a17:906:f856:: with SMTP id
 ks22mr10833514ejb.367.1637697661250; 
 Tue, 23 Nov 2021 12:01:01 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id hb10sm5889231ejc.9.2021.11.23.12.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 12:01:00 -0800 (PST)
Subject: Re: [PATCH v3 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <1637665162-3609-1-git-send-email-varun@chelsio.com>
 <3b3a65a7-0885-0dc9-e78f-ac8a8c04a646@grimberg.me>
 <20211123154117.GA1714@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e90a1dff-39f8-89d9-261d-b8163dd73e21@grimberg.me>
Date: Tue, 23 Nov 2021 22:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123154117.GA1714@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_120104_481478_08FDF711 
X-CRM114-Status: GOOD (  12.58  )
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


>>> @@ -633,14 +640,19 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>>>   		return -EPROTO;
>>>   	}
>>> -	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
>>> +	if (unlikely(r2t_offset < req->data_sent)) {
>>>   		dev_err(queue->ctrl->ctrl.device,
>>>   			"req %d unexpected r2t offset %u (expected %zu)\n",
>>> -			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
>>> +			rq->tag, r2t_offset, req->data_sent);
>>>   		return -EPROTO;
>>>   	}
>>> -	nvme_tcp_setup_h2c_data_pdu(req, pdu);
>>> +	req->pdu_len = 0;
>>
>> Why do you need to set this here? it is set in the initial command
>> execution...
> 
> This is needed for multiple R2T case.

ok, makes sense.


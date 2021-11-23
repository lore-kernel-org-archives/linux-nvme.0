Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D527CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMQn0+qNmrRtAwi9KuB6LlMvjiDz18bsZtiLixkkLP0=; b=oxaglKb/KfOoUonqYjJK3C2dG4
	bztL++dH5Qf6kWccbqCQZkgBl8+TnEzBEO/sDeAIrKNpX3EOPHXKqW65+NjUCt030vsp1AjKSG1CM
	ychB39EPBvuMZKO8KBCzDI4ZFc6gQRTSXDsZZDa+t9Py2Ta7vXe+Ov1+5OZ2nikYxpAEgibEux1jB
	EvtpPIfZTKqgYY9+iOykjOinoLik2Mjr04SCCzzRY4EkKeUa98QKUlwWhdyt/jPbdDyo8kVzydX5w
	V3jTc9/OCjTMbPhB/B+C/a4pEI7S5Q1lpu6i4O10+9RA+uKiR6j0ABj14uH3wq/Z8Iw5qQ5NEVXgW
	4Y8lkc1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRng-001QsC-0L; Tue, 23 Nov 2021 09:09:16 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRnb-001QrD-SC
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 09:09:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id b12so37682300wrh.4
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 01:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tMQn0+qNmrRtAwi9KuB6LlMvjiDz18bsZtiLixkkLP0=;
 b=WvBcnN63Z/VsGlrAsdt/ZSW/HyUJK/y0M+VHHxv39YTfCuF2KbwQB8ehsKnmnetIXv
 yqgePdNLd2gnx5ijseOIJh+VD0AIColyMFoGUUUhqTSzcnYmpPNFU2HuDtkcjofaGguO
 4kF+6pvv+W/HXzuyaNxkkzpx9x7wS/N0Id7hq8n+xgyXfvCOmY447C0akIi1uvPdzqLQ
 xHQ92GXesXr1LgcDAZTbSErXWPHQ1ETCDgVoVI8FGG282Gmgg1Hev5aGFP7fpRhipvWJ
 T8lxlRZ1KLK+X7FeWDEnHlNSMHqRVM4nMFSJmbeYTBrW8+nfdM63ngBK15UhmhpHfnas
 2mlw==
X-Gm-Message-State: AOAM5323FmIOdFTsr+f6sKTRPUbHyqox0tjWsrLJ+qN7yYFkLeKmyc/w
 edKl9FdTjeo5bKB4xA9hDX/hXf8AUWI=
X-Google-Smtp-Source: ABdhPJyqUJosfH4pOe87V/Y88yDA1A63wrytIosEg2m+iNKSO3/8Y1l5J+XAIk+BtpLiWbeIhyQVag==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr5366283wrp.37.1637658549818; 
 Tue, 23 Nov 2021 01:09:09 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o10sm13945429wri.15.2021.11.23.01.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 01:09:09 -0800 (PST)
Subject: Re: [PATCH v2 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <1637576743-3341-1-git-send-email-varun@chelsio.com>
 <f6e46674-5856-1f0d-045c-6ced393bda70@grimberg.me>
 <20211123083346.GA1704@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9045e751-3bec-a070-bd40-ce2a45ac0074@grimberg.me>
Date: Tue, 23 Nov 2021 11:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123083346.GA1704@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_010911_949972_44120E85 
X-CRM114-Status: GOOD (  15.07  )
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


>>> @@ -933,6 +934,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>>>   {
>>>   	struct nvme_tcp_queue *queue = req->queue;
>>>   	int req_data_len = req->data_len;
>>> +	u32 h2cdata_left = req->h2cdata_left;
>>
>> No need for the local variable, the reference only happens when the
>> pdu data transfer is completed.
> 
> As this function also executes for inline data it is possible that completion
> gets processed and request gets allocated for new cmd before
> if (req->h2cdata_left) check, nvme_tcp_setup_cmd_pdu() will set
> req->h2cdata_left to 0 so it will work but it does not look correct
> to me. IMO we should use local variable here.

I see. that's fine then.


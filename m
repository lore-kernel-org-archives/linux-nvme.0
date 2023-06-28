Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D3EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5dy/snupWusVgt8K7W1fmwHwH0XFytwxYaVysivZUM=; b=zY5AFqP2vXPAODpG10imY1j7Rs
	gNkdGRaMxWa2blOXK5NOeTCJ9gYdoJYhVKndVnOiAWpjgHQ9tJ9JFbNoxDuQ4SVgwdpd6p3VpXjAl
	jYVmoESzpn+/0fSNlHWTGZetMhR0HjU3Sjap51XOvjcuIqQzNGM7FgDDbpp9+goDgYJJKVQahwVjn
	fGauyh2mvUyEdL+fUI/s/zcxuahcRllHROn5vnfxoATlV7w2iG+iW/W8X6Ew03bADzFTKIVlmvlA6
	gGV0MYE+mOAeb6TsjRTZC4qAt2Uhleuob2Ch2XIT2nA4Nqc9NxLW+Iwq8rf21SSI2z30aRNTk5So6
	aEFPy0PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPZj-00F3qA-1D;
	Wed, 28 Jun 2023 07:26:51 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPZg-00F3pD-2V
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 07:26:50 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-313ec24b36bso897375f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 00:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687937207; x=1690529207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5dy/snupWusVgt8K7W1fmwHwH0XFytwxYaVysivZUM=;
        b=CWpPgzfwu5HD31f7fJ49mvUi2Ljd3rwb8j5s5e9Y+DBmm2PlMRkqRijtzwnYj3djC9
         SbPTyVmjoixYeASnMA+s5Ol71KPePawWmPl7IWL90Y6pTYSBY9FlHXOx3ojiq0Szigs/
         s/H5FSqRO3dF9nJY2bj/QCD7BIf9xQPNKNViUMWEw8tggklaLe/NqThOH3qmOHt7u/9Q
         SdJdIJhVu6RAhBIP5m08Yrqzg+mFD8XW4xpm8FVw9f28iYGXPFxTFObmIdJfOmNHNkDe
         P6YHN8SGkAA0PEw8f66janlwp9j/mNQ68GthnMC0vKkL1e6qoXOzSIv2t0TnGQKMvpFK
         /2mQ==
X-Gm-Message-State: AC+VfDyGcCDqgMlCPWSxV1n3qEuCP9q7dywCtJLMMYHcR8BOsVAUR6Rs
	GZuzs5qSDsoXBsP7/I6tJtE=
X-Google-Smtp-Source: ACHHUZ71HPWMi/rIIXTPpBkJON+LAtSPBEZCRmJ2TdlAezlDWLOY7PVHRTOBRmUmK6KcvNFPa3pROg==
X-Received: by 2002:a5d:4007:0:b0:313:e8b7:d0f9 with SMTP id n7-20020a5d4007000000b00313e8b7d0f9mr3638170wrp.4.1687937206597;
        Wed, 28 Jun 2023 00:26:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003127a21e986sm12360177wrt.104.2023.06.28.00.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 00:26:45 -0700 (PDT)
Message-ID: <5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me>
Date: Wed, 28 Jun 2023 10:26:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_002648_817445_650826D5 
X-CRM114-Status: GOOD (  21.53  )
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


>>> Yeah, but you can't remove the gap at all with start_freeze, that said
>>> the current code has to live with the situation of new mapping change
>>> and old request with old mapping.
>>>
>>> Actually I considered to handle this kind of situation before, one approach
>>> is to reuse the bio steal logic taken in nvme mpath:
>>>
>>> 1) for FS IO, re-submit bios, meantime free request
>>>
>>> 2) for PT request, simply fail it
>>>
>>> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
>>> always set for PT request, but not see any better approach for handling
>>> PT request.
>>
>> I think that's acceptable for PT requests, or any request that doesn't
>> have a bio. I tried something similiar a while back that was almost
>> working, but I neither never posted it, or it's in that window when
>> infradead lost all the emails. :(
> 
> If you are fine to fail PT request, I'd suggest to handle the
> problem in the following way:
> 
> 1) moving freeze into reset
> 
> 2) during resetting
> 
> - freeze NS queues
> - unquiesce NS queues
> - nvme_wait_freeze()
> - update_nr_hw_queues
> - unfreeze NS queues
> 
> 3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> 
> - if the request is FS IO with data, re-submit all bios of this request,
>    and free the request
> 
> - otherwise, fail the request
> 
> With this way, not only freeze is paired with unfreeze. More
> importantly, it becomes not possible to trigger new timeout during
> handling NVME_CTRL_CONNECTING, then fallback to ctrl removal can
> be avoided.
> 
> Any comment on this approach?

As aid, for tcp/rdma I agree with this approach. No need to worry
about the non-mpath case, I don't think it is really used anyway
nowadays.


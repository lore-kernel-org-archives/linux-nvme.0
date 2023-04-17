Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D40C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ptZ/THg+jTetYYDNVb/iJ09pj0p17BXD3NkPPLMsHk=; b=gm25Kz1UzJgMaVx5FwIMItoJRL
	wg4OCf3ayFkmzDXIvd8sOAhcCLSn6VGoTw8tjYYukmte7GkFfv/0J0GRs0RC8gCfS8wpk5KRqRw+x
	q2w8bzSP3nYtsxWDItEycOWHiqc4FE5VKe09N58FY9okvVB8RYx/r7X0TrVKWRrXQa9bxpAyBlzIs
	m7YZJcVZxOC1BGrTfQsD1u2zeUxsWIJzukIW1NDJ2cSGyvMBQi+Ey1UpXkIj8kTwkb0CSY8sBL6IE
	vlDcN2tq+sSGXcA7IRYqOPNsyYMVmdhcHHzQ1y/GEJqnnDIfpiVvDvp2KI7CWGrpSxo4oWFcPM5aa
	BG6TTRfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQmB-00Gt3W-0w;
	Mon, 17 Apr 2023 15:28:19 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQm8-00Gt0d-2O
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:28:17 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-2f94fe993edso134666f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745294; x=1684337294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ptZ/THg+jTetYYDNVb/iJ09pj0p17BXD3NkPPLMsHk=;
        b=lRlQ9qyzAs6/cBMT/iy5Z2xFQ6Q9LuHjWF9UOKSWfkts7NHuw1TG3lDdP34yODgnfJ
         Qbfr/ZvQdCkmsQgSC84oUZTc4uNpgywxPBiTPxx/9SxFXWHbwL7VxCz9Q+vrvOjMh00x
         TXJg/PkYDVUXJWc9hGoW2VGPN+jquBy/hz517auhGYwsS+SFxmd7F9bqCpNtPxgSrMKv
         9ueX4R1HeAaHvMl54Zc2nNKDnIkOS/exbcJu2nXL/MEijRJGrJalsJtc3ihIaYfxn2MK
         YgtrZkQv69d/LQzvlsgJjaVZkUkd38NUlMaPOMl44LydLaSA5F0g7SeDDTo7/OkOjR+/
         Qzog==
X-Gm-Message-State: AAQBX9e9+ZUOBZbAp37dErXZUyS6KLXQi9IHeFi2pSXf08ojVoI9ssJ9
	gwsmKY4gKpL7kwx8iA3GKG8=
X-Google-Smtp-Source: AKy350ZmJvKfWvjaoZGeHpO9VtQWlc/uxKRhhJh+8BIt3MwoCS5pI8L1A1VDuzjPlFo4ApGySJFdfg==
X-Received: by 2002:adf:f802:0:b0:2cf:df6d:6063 with SMTP id s2-20020adff802000000b002cfdf6d6063mr7050064wrp.2.1681745293849;
        Mon, 17 Apr 2023 08:28:13 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g2-20020a05600c000200b003f0aa490336sm11571527wmc.26.2023.04.17.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:28:13 -0700 (PDT)
Message-ID: <5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
Date: Mon, 17 Apr 2023 18:28:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-9-hare@suse.de>
 <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
 <654702da-246a-934c-14e4-7b179c46ed98@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <654702da-246a-934c-14e4-7b179c46ed98@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_082816_775558_F3B79B89 
X-CRM114-Status: GOOD (  15.97  )
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


>> nak from me.
>>
>>> MSG_SENDPAGE_NOTLAST was introduced with commit 35f9c09fe9c7
>>> ("tcp: tcp_sendpages() should call tcp_push() once") to fix issues
>>> with the ->sendfile() call, and the implication seems to be that
>>> the flag should be strictly internal to sendfile.
>>
>> no, the use case was to allow sendpage consumers to build larger
>> tso packets for large payloads (splice being the primary one), nvme-tcp
>> also benefits from it (as do others), just like sendfile.
>>
>>> Hence we shouldn't be setting it on nvme-tcp, and anyway doing
>>> so will cause TLS sending invalid data.
>>
>> That is something else. I don't recall the full details on the
>> discussion with Jakub, but it was not my intention to strike
>> it altogether, just remove it if !sendpage_ok.
>>
> But then we're running afoul with tls_sw_do_sendpage(), which uses 
> MSG_SENDPAGE_NOTLAST as a record indicator. Forwarding 
> MSG_SENDPAGE_NOTLAST to tls results in incorrect TLS records on the wire 
> and a transmission stall.
> 
> Took me days to figure that out.
> 
> If you have a better idea, I'm all ears.

So sendfile is unsupported over kTLS? Or is there some special
case for it in the upper layer?

Jakub?


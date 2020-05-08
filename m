Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB3C38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:38:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EA8206D5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LM8cfdIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EA8206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vsexh842F5nGdT1jUUwxE7mmA/xKr4ccO6aHZEztIE0=; b=LM8cfdIu8jHQ1IU+G6eOXaB+N
	Z8IKfyfno3RiuAGHEazKKfiEiQ0HnfQmcQtw73uRyPw+MNI9EZnCmX4dhDqQp843AX1Qpr2OcWPu7
	kK9ohOlQRjPRukxFjynK+AWwukQPGGIKACjEdSWWB3nnuNcba9CiWSXgEhQuVKg4EXfhlsM6rKbDE
	3fVXWfx+9e1AsFpY9yueIratAhmGr7AZx2X6ECee36rjefGpnS66ohIy2/reyUMxMtSDzQyd6Hv+/
	AVP/JDH+grE/zmorzKa0Ji5PSqyMc3T3p1evbRb7Bpe2meB56xFM+Pn0XjDwfPsIk83dvvP3AVbg+
	LERoCGcpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWxaa-0000BI-3u; Fri, 08 May 2020 07:38:32 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWxaX-0000AT-NB
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 07:38:31 +0000
Received: by mail-wr1-f66.google.com with SMTP id e16so674785wra.7
 for <linux-nvme@lists.infradead.org>; Fri, 08 May 2020 00:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6os0C2kR0pfj1PCv5xkpFgF7Nh9mKRMw3ZZCDz7c/k=;
 b=dmFhincPnQFX8CxgGLyHOZDv+DPPyj04nz2kHXXlKWznF3Ifb7NFi9YlTUc5U4zdSl
 Zaq+0pezAbD/R1GGsqQFxXF1CL/BIrMZ7mq6uujvdEwCN9fgs/vQvv2Hw+P09avc6ESg
 E2Pw6LQz/V0+PCEHsQsacUh7mR68OwU700MkkA6FgYl4ForgoH92jVyAQJhtcAo+msMT
 SAdKlw3lwY/5R7J3h0mcaVgUAOcNmqmuJfwIszzt37aMP6RtoUhgdGaQ5GufptgIgNzt
 2Y6NUbSmGCqWWsA39CaUPzTNULCl49nxaSOSM77NoPAsKoEo+l1Qd9S/Lsmb9s4MZDGd
 Mraw==
X-Gm-Message-State: AGi0PuYhm5rdLusBXQgtqLNuVoZ+6v4L6c+n+kOswFJPWMCtH4L7kXy2
 JA+1IIYNAhPrq981zwfDpSWZzIBh
X-Google-Smtp-Source: APiQypKvEmSal5C9GtQlCKk7EAGVTwolQBjV6NfQvhB1Ppw7c4l5Z6/y032B7sLmoDpz31XkVPyi4A==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr1285714wrw.93.1588923507947; 
 Fri, 08 May 2020 00:38:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6507:baa2:4de7:40e9?
 ([2601:647:4802:9070:6507:baa2:4de7:40e9])
 by smtp.gmail.com with ESMTPSA id f7sm1528869wrt.10.2020.05.08.00.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 00:38:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when
 we have more to send
To: Christoph Hellwig <hch@lst.de>
References: <20200505052002.14924-1-sagi@grimberg.me>
 <20200505060907.GA3995@lst.de>
 <f0f28e18-c432-8343-f7a7-79cb3159b43c@grimberg.me>
 <20200505102354.GB15038@lst.de>
 <6abf2183-ea1e-d1e0-360c-5d74b75c3690@grimberg.me>
 <20200506042734.GA9542@lst.de>
 <ced17f23-0bfc-d076-7c20-ad02c1b54786@grimberg.me>
 <20200508073534.GA682@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6b2006e5-ee30-220f-8da7-c4a95a9a8a83@grimberg.me>
Date: Fri, 8 May 2020 00:38:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508073534.GA682@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_003829_753937_0CDEC4FD 
X-CRM114-Status: GOOD (  13.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Anil Vasudevan <anil.vasudevan@intel.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> What I mean is that nvmet_try_send_data and nvmet_try_send_ddgst may set
>>>>> neither MS_MORE nor MSG_EOR.  Is that intentional?
>>>>
>>>> nvmet_try_send_data should set MSG_EOR if it doesn't have more to send
>>>> and also nvmet_try_send_ddgst. So its not intentional.
>>>
>>> Ok.  Can you send it with a little helper like I suggested (probably one
>>> each for host and target) that ensures the right flags are set
>>> everywhere?
>>
>> I think its actually better without the helper. MSG_SENDPAGE_NOTLAST is
>> designed only for sendpage and not for sendmsg which we use for ddgst
>> (although the net stack code appears to ignore, but still) and when we
>> send a pdu header that has data, we dont need the condition because its
>> not last for sure.
>>
>> So the helpers capture ~60% of the call-sites... seems to me like its
>> better off without them at the moment. WDYT?
> 
> Ok.  Are going to resend with the nvmet_try_send_data fix thrown in?

Don't want to overload more logical changes on the patch itself, I'll
send a patch separately, these should be good to go...

Thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

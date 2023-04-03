Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1ADC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7litT2ku0CKU9M7PH5y/5Y+4vyCKFBTn5xjvf/oTZA=; b=SCuOfQEUD6YDl0fXP4gKPx0i5k
	Q0BO1tAkhLScEwSoM5rxdkoLBTPqPpy9QOqWzV+gjs5sCa8A8kJ6GDefnrdYj1isQFrIL2lbAv5Ko
	FJJ3vYBO3+asW6yP4T3Hx2BRIR21F9FQmFNvLCzIrm0UB1ENfEQ8IcOk9SVMTtqCk/LV4sPswuXMo
	PUalSph+aP0xLaxwgAOtJJvXsDOnXHBesFKtPgnaOISBHfodCW0sHvB05IwIuRXUCt9BPHdiWywjy
	VHwWNbeKp8705OLyxPr5V+pEAvL2E1gz/hGWP1nTIYypqJucTUVVDVsk8qAoATsmkLPcq/fsImXbp
	vXBYp5qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMSo-00FrQB-0N;
	Mon, 03 Apr 2023 15:51:22 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMSk-00FrNc-0d
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 15:51:20 +0000
Received: by mail-wm1-f54.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso20176141wmb.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 08:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537071; x=1683129071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7litT2ku0CKU9M7PH5y/5Y+4vyCKFBTn5xjvf/oTZA=;
        b=gx9DCGoBBbZMht1NuuGdpvgzdra6Xm59VSYFQexuO9IxBY+uWkNe/0PhFpbz065gjO
         n7UD6Ghnov+n4d7zXSpBOFmiHsEFE2pvLPTvwfT1k3fNd2aJL+raU2j4EhofjHiq+tQa
         HUqytHPR0DnXBxUvTO3VC40DHdBRUtPF/Wbr3yo22q9Temveufs+vCVSu+z4A2hyU0NE
         TDth4YAiaYyutEV0Zy9CsrbXRK7oFdo+/uvphWIxqDYl1g48F6EpcnMc6t8BILFQfo/O
         CmmbCiCwqYS9E8tF5hGF1zY/gCh/pM8oHsnW3w0eu8Py5T7XFA3nRy/tpY9j2OBsa0L/
         vCjg==
X-Gm-Message-State: AAQBX9dmiHEiRyzUwzC0o2UGiQMH3vRsvmuq0TwkyBhQR4MX2Z6WpcWz
	2b9DzqWyYD7cmoZ/WLi/XKU=
X-Google-Smtp-Source: AKy350axQSLF/hDT9cyBm7N2x/F0vRpfgcI7KPkQaOL3AJPv/qmBdqmepUfbm4XQU7KMQjLPYkQ17A==
X-Received: by 2002:a05:600c:1c82:b0:3ed:d2ae:9adb with SMTP id k2-20020a05600c1c8200b003edd2ae9adbmr37206wms.0.1680537071615;
        Mon, 03 Apr 2023 08:51:11 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bc059000000b003ede06f3178sm12420692wmc.31.2023.04.03.08.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:51:11 -0700 (PDT)
Message-ID: <c7a07e1d-b300-dd1d-1be6-311666387820@grimberg.me>
Date: Mon, 3 Apr 2023 18:51:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Boris Pismenny <borisp@nvidia.com>, john.fastabend@gmail.com,
 Paolo Abeni <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-11-hare@suse.de>
 <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
 <20230330224920.3a47fec9@kernel.org>
 <7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
 <44fe87ba-e873-fa05-d294-d29d5e6dd4b5@grimberg.me>
 <20230403075946.26ad71ee@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230403075946.26ad71ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_085118_229257_41C9CD45 
X-CRM114-Status: GOOD (  16.32  )
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


>>>> Some of the flags are call specific, others may be internal to the
>>>> networking stack (e.g. the DECRYPTED flag). Old protocols didn't do
>>>> any validation because people coded more haphazardly in the 90s.
>>>> This lack of validation is a major source of technical debt :(
>>>
>>> A-ha. So what is the plan?
>>> Should the stack validate flags?
>>> And should the rules for validating be the same for all protocols?
>>
>> MSG_SENDPAGE_NOTLAST is not an internal flag, I thought it was
>> essentially similar semantics to MSG_MORE but for sendpage. It'd
>> be great if this can be allowed in tls (again, at the very least
>> don't fail but continue as if it wasn't passed).
> 
> .. but.. MSG_SENDPAGE_NOTLAST is supported in TLS, isn't it?
> Why are we talking about it?

Ah, right.

What I'm assuming that Hannes is tripping on is that tls does
not accept when this flag is sent to sock_no_sendpage, which
is simply calling sendmsg. TLS will not accept this flag when
passed to sendmsg IIUC.

Today the rough logic in nvme send path is:

	if (more_coming(queue)) {
		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
	} else {
		flags = MSG_EOR;
	}

	if (!sendpage_ok(page)) {
		kernel_sendpage();
	} else {
		sock_no_sendpage();
	}

This pattern (note that sock_no_sednpage was added later following bug
reports where nvme attempted to sendpage a slab allocated page), is
perfectly acceptable with normal sockets, but not with TLS.

So there are two options:
1. have tls accept MSG_SENDPAGE_NOTLAST in sendmsg (called from
    sock_no_sendpage)
2. Make nvme set MSG_SENDPAGE_NOTLAST only when calling
    kernel_sendpage and clear it when calling sock_no_sendpage

If you say that MSG_SENDPAGE_NOTLAST must be cleared when calling
sock_no_sendpage and it is a bug that it isn't enforced for normal tcp
sockets, then we need to change nvme, but I did not find
any documentation that indicates it, and right now, normal sockets
behave differently than tls sockets (wrt this flag in particular).

Hope this clarifies.


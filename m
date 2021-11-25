Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEDAC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1H1/OqzWONOwkmnXRSgAJv5ASwvwk/7xQAco2zbWHo=; b=V7F0ql2Z5yCWnED/fDRX+umUIR
	Qm2hZymlvAmap2P0v5V1HkF1FX4Cj4J+oo7qPPmDypLk/TKQUEoAWug41s4g5sscDLtRkanlhoSlI
	vPpoK0baaTIagapENOaMMl2q7bYGJfaQBReEyydaVpTo7hA9+vNio/lwGEgJrkiQ3kWPXQT8bp7hA
	HTolifSyNwcdrDg3aCisi9JAZErMw08mGr5DpHjMt861zXnYu8QplLpDECXHtuZDiZaWmtGfsU5k7
	NTSri1CSRg04xv/7BFL6XUWjhnow13wPngnNLylz8sCUUpcXQAhjP9PIchWkhcyzwK7Dvq5dKmAAm
	b+9KCQQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqHAa-0089u7-3O; Thu, 25 Nov 2021 16:00:20 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqHAM-0089hx-ID
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 16:00:08 +0000
Received: by mail-il1-x135.google.com with SMTP id t8so6283754ilu.8
 for <linux-nvme@lists.infradead.org>; Thu, 25 Nov 2021 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W1H1/OqzWONOwkmnXRSgAJv5ASwvwk/7xQAco2zbWHo=;
 b=XwaR+PwrvisMARVt1o6TSNK2p/Khrsc0ZfcfF0nb7xykVxfQ1MMwUDtLSEMqBYq8MM
 Ld3ZTi/Wz0rxYUwnmqwsRGCA2lpZInWU+X4IYL+4uOaHknzqo1OuoiYueVZzlxz3qefq
 IZ16ukK7esv4b1ICSRngpjOXkQf4wbHlm/63Wr3dkFSfngKsv4hQDgLQuXSFH3bun+yB
 NkfbI7sdsiE5MtBXSNDsg39cJ2GgtHu6pRV06mHkpGuRvuK/XtfXwlQp86e7E5TebReB
 YW6ln7vndswlc8vQBTg0gVBGMJgNXckiY6Dv6tQHvu8joBeENaRxyWz6nLocUowBQiY+
 y6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W1H1/OqzWONOwkmnXRSgAJv5ASwvwk/7xQAco2zbWHo=;
 b=tU5oeMp3GVTWVgIcUTdRqJERmmIp28BB8WJpjmQnAEjnfuLhX2s77hGJ8xapxDh/KC
 w9C+E6XwHUHpOKB8XK5CaO7KOL8jNMKGdVddOqIk53pIv766QIuQh2L4EshQ3XBRE0hK
 dhNZHVKxAGdhixtQO5wwDKjLLPAv738VZJYe2JM/ioU9KywUV4Y2W2Ir/RTK8FVbRl9C
 pEQjZbHQ4Nu02O/ixw+neQkbblHubg/khTZLXvV2TBa58UzyMWPP2z+znuLq63ma8Kdd
 J4xPpGlGIegi5bBh8dDDw4X2CdQZMce5iTgJNZxCULpzsoeJiL1VCDAlXPyoWVwecJ99
 Ry7Q==
X-Gm-Message-State: AOAM530NUn194d+typ7lBBRgyfNhfEvUUOEXttQiHqRFgAWf4DgFXW0Z
 f3PjyJ0JFo+ntbSWOBA0FfcxGk7rIzTWDNi6
X-Google-Smtp-Source: ABdhPJx/leFzevbJKm39V27GTB1Oc+k6/sVr/7S6H/KUHJwP7sTZSdamwZ1Q62CT8XyRv8TctjIBvg==
X-Received: by 2002:a92:da0f:: with SMTP id z15mr23607377ilm.151.1637856000854; 
 Thu, 25 Nov 2021 08:00:00 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id o1sm1627267ilj.41.2021.11.25.07.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Nov 2021 08:00:00 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YZ+X/qGC6/w3bp2c@infradead.org>
 <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
 <YZ+mI9a1Jd2/zNkh@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d933bfa-eeec-2b9a-ab91-aa1140a41f62@kernel.dk>
Date: Thu, 25 Nov 2021 08:59:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ+mI9a1Jd2/zNkh@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_080006_656899_E00CFFCC 
X-CRM114-Status: GOOD (  15.53  )
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

On 11/25/21 8:05 AM, Christoph Hellwig wrote:
> On Thu, Nov 25, 2021 at 07:55:38AM -0700, Jens Axboe wrote:
>> On 11/25/21 7:04 AM, Christoph Hellwig wrote:
>>>  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
>>>  drivers/nvme/host/fabrics.c       |  3 ++
>>>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
>>>  drivers/nvme/target/io-cmd-file.c |  2 ++
>>>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
>>>  5 files changed, 93 insertions(+), 46 deletions(-)
>>
>> This doesn't match what I get:
>>
>>  drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
>>  drivers/nvme/host/fabrics.c       |  3 +++
>>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
>>  drivers/nvme/target/io-cmd-file.c |  4 ++-
>>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
>>  5 files changed, 94 insertions(+), 47 deletions(-)
>>
>> Hmm?
> 
> Looks like the diffstt doesn't include the the requested reformatting
> in io-cmd-file.c.  But I have no idea why.

Funky... I pulled it and pushed it out, just double check if it looks
consistent with what you expect.

-- 
Jens Axboe



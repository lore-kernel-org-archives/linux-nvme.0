Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DD5C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuxBsu4VDMAPgQORabQ3hLPzi0PvLOfECIVt9tqDIPc=; b=i1I13EI/Kjuq7ZjZ/FZWism9qS
	qr9j0ch0Z6omJTBjcu0ktO2NJ1M3kW27iEPdnSauSJoyHvtdbKKbSPO4NG3qKfQnomFvt1uY8PJwX
	7jhxxuA4Nyw7MA9RrecqhgfOPWv3atLlvltzKM5SY1bmb9WHoK8EOCcQTbFp1Spdp0IpT70im5ZrO
	3KtuXn8NUH7F2ubFS+IVQnHPlPpK/pDcbRI6GvH457igOUFxY2qnyOw5lE0APdJLVZXCM50t2jTMf
	2TsAO2uvMUgbzVwNlfJdPxhhKbw21xlIErzuWs/XCc+Jh7LeuaRf+4QkbxNjds0juZKJeNEwevsEw
	ze7PvDHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01gM-009I8s-Ev; Tue, 29 Nov 2022 14:33:58 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01gK-009I5u-2y
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:33:57 +0000
Received: by mail-pf1-x435.google.com with SMTP id x66so13864736pfx.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuxBsu4VDMAPgQORabQ3hLPzi0PvLOfECIVt9tqDIPc=;
        b=5fbQ/o8HN1uU9Il6X/LoLok2YjQCD3iAUzjAwva8u2Bewi7xDO1eAgXOehjqnG89Vj
         Pm4lJytLY4HLzDTxDQ57abFDn0FcRz7AX4j3J/t2xwcY5eehmHpqxvSK8qNSkYM2A1qL
         ZaALy9wnNsf8drMUlQxrEuSZPwM+tpLba4E1LJOjUsxkQJn+d6wlhrHwcE2U4LHYyN5G
         Ya///j9EpjNnfwrpUqqRMVhx7mygFI/2nWAz9f483CvEih2E5bIJLKij11WLssGjYYm3
         76xopDdej5vs9Bvkir9tHFdhagiFnWYdcfTwTy+0UQMEbX7ozDMCRKXhFX+r5emBZADB
         +K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuxBsu4VDMAPgQORabQ3hLPzi0PvLOfECIVt9tqDIPc=;
        b=GdTPlwJPvri1i1U+/uRjp71Eyp5JE+NoRwNYBBd+8EiW7GZygGe985/wBS65xl9Q+H
         gc1eyCLTF7qkSFKCMv79McfaS+AQoKac+25exYx248Og+z5bZwhI4Snt6TibmjxqU3Fo
         2mTYswyS6UcEQnt3SiYexK9UMIzC56a1O/Ltm20fxc0ZtxBa/BK8EJHl+/bNQTdFUd+Y
         083FskUCeOQcV/pMfEGevqnmjN8Rtb40ei/0jAliwon/tmkFD+w8VP/sRC9sh/rNrJ8l
         POuoFI4DAuQoJtsGNRs4dswZhu578woENxVVHrUrWdM7WgPDSk9HLmgPNiokPovTEFEc
         Fnlg==
X-Gm-Message-State: ANoB5plWmS0m6pMHgkVQsw5iEy/+OhEk83fI33gWkbinvVzDcoHdYrqJ
	fpcFy5B+ZMZppQeyVDjEhXHe2P/o9JDrZKf3
X-Google-Smtp-Source: AA0mqf4cAOnifTIeAsmfaAuLmOW0hFwCVqdZbuyJ5wPVOT+Ju8/bLnxagpvq1GBkii7dmlo0kMDu/A==
X-Received: by 2002:a65:5543:0:b0:477:dc7f:bf24 with SMTP id t3-20020a655543000000b00477dc7fbf24mr20910314pgr.555.1669732432842;
        Tue, 29 Nov 2022 06:33:52 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b001745662d568sm2818626plk.278.2022.11.29.06.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:33:52 -0800 (PST)
Message-ID: <9f45de57-353a-08c9-5d7f-57d7acc67b18@kernel.dk>
Date: Tue, 29 Nov 2022 07:33:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221003094344.242593-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_063356_150664_017AAD6E 
X-CRM114-Status: GOOD (  13.80  )
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

On 10/3/22 3:43 AM, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete).
> 
> When the IO starts, we account the request for multipath IO stats using
> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
> in the middle of the request.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe




Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B40C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lw2dwC8/t0Q2Vk2CKqNQ1B41NfKsBUvN5BhZuRFJV8g=; b=sfdLSKLYxZ/ZOqwfj2jPIY7hfY
	7iou6vOle1svvql6TfiTpncB65+RAprjTJfnZ2g+LDOfCXdlw+BAJA13+5IpzXpx7IX163rxS7sv7
	ezRZtI18xqnyLcoS6MpY8RlJiDEdzbs7mCsbfnhzQsX7uDwwelt7tH28F7ixCFoFbD3i1KYFw3h/q
	I2YFEmIxKSu+mZmQkq44Rol4yS8oJmk6KKmeUlQCW744jL9uqouOSEFMtxFD46vTW4WG+5EOGJTGH
	QxQnTvqVBlrP85pO+m+2x4EH8eRwykso3vdvyPvnVPOuZJf+wykKopTIib+VtLwsY6l8RaAAJxGuQ
	NpqLFBug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAWoy-005JYR-Ra; Wed, 28 Dec 2022 13:50:16 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAWon-005JV0-PZ
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 13:50:11 +0000
Received: by mail-wm1-f52.google.com with SMTP id ay40so11287840wmb.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Dec 2022 05:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw2dwC8/t0Q2Vk2CKqNQ1B41NfKsBUvN5BhZuRFJV8g=;
        b=EVIBFJUnkbo0UcswKBvNMEKKNahVZaIZRzXdHbxuezwCOXDRRm0+MdnyPsow4LD/An
         zdl+270tcepPbXcachzyFMBLjYDEh+pqBF5jYc1ozW45/nQbp8a6KqofbXNkoK0XZiiR
         8ADG6X5JrCIPucvPI7zaTmGrYgQmY+Rc/q7LwFC5fFQBdl4wcQt8tWRb00tE8EpW+ziM
         7OZUc0VR0p76/WiRZrjW1b0SYH4Q4ZyH1sRCjxkOADyFNK8KkxIgrloAXoq4bvZpMy1T
         j4bRt2jxhQZpBCRQ2FjXPsoo0c2ZHqeWBLdM//FFa4Hi2sSoQS3JWiuIiKac7FLAbEiQ
         1lRQ==
X-Gm-Message-State: AFqh2krFjTncbIN26rUwuS9wgfqm9bPoDi9THPDFfoISezVw6sGWSDgc
	ny9TyhExfNaWoC8Mh4LBqWXkzn7unrY=
X-Google-Smtp-Source: AMrXdXuhe2Z0eLDNm6l/lAjsM8RAWly8vQnCHC9ICA82zd6OT8LIv7zqH9MjVngi7zX+yccWvy3hGw==
X-Received: by 2002:a05:600c:3485:b0:3d0:761b:f86 with SMTP id a5-20020a05600c348500b003d0761b0f86mr17659159wmq.28.1672235401452;
        Wed, 28 Dec 2022 05:50:01 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm28467015wms.11.2022.12.28.05.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 05:50:00 -0800 (PST)
Message-ID: <013abe7a-99a6-4ccd-cb62-ed28bbbc61e8@grimberg.me>
Date: Wed, 28 Dec 2022 15:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-6-hch@lst.de>
 <74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me>
 <20221227165754.GA7716@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221227165754.GA7716@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_055006_569085_87EDB8CD 
X-CRM114-Status: GOOD (  13.30  )
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


>>> +		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
>>> +			effects |= nvme_known_nvm_effects(opcode);
>>>    		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
>>>    			dev_warn_once(ctrl->device,
>>> -				"IO command:%02x has unhandled effects:%08x\n",
>>> +				"IO command:%02x has unusual effects:%08x\n",
>>>    				opcode, effects);
>>> -		return 0;
>>> -	}
>>>    -	if (ctrl->effects)
>>> -		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
>>> -	effects |= nvme_known_admin_effects(opcode);
>>> +		/*
>>> +		 * NVME_CMD_EFFECTS_CSE_MASK causes a freeze all I/O queues,
>>> +		 * which would deadlock when done on an I/O command.  Note that
>>> +		 * We already warn about an unusual effect above.
>>> +		 */
>>
>> I think it would be helpful to warn that we are masking it out? The
>> warning above does not directly relate to the cse mask, but rather anthing
>> outside of NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC ?
> 
> Well, all these effects are unusual for I/O commands, and all the
> effects really are hints to the host.  But if you think we can do
> better, can you send an incremental fixup?  We'll need to get
> these fixes in ASAP to fix the gapping security hole, or just
> revert the unprivileged passthrough for 6.2.

That's fine, No need to hold this for 6.2


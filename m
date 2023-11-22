Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD26EC072A2
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ziLR05YIx1r62isXzLrBu7JOOcJX+hqwhS06gWzmbg=; b=oAGrlqtJPxNcJGznB3Eud6Bxaf
	fvPhvCJ6jH/67lsAysUcSNWyDH8Rp2homgP0z9MBxc+RptoAigoRMKOxPDNUWJPT1e2mX4dKyNMam
	ST+jbeYHkOdAuwMPXCuMIaRAD7eu/FI/sNnFVrFX2NDUASwMYsXPSiOBa0v2FY+pE4R3xUZWfFPFC
	Gc3IHvC2noaDu29XjrWXImyZexVe8Tq07mwl53hYEvi4mIhH9EQR4tY4/MFVPllO5GBF0cpIWVTSU
	oIO9BjmHU8HkxTtT97feDxkUheiji78KglaKjHkbTnJQExMBdqi+qAhbVcjiIi0udoCjtSLnS9dyj
	Sw9rvIgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5iPD-0011k8-1V;
	Wed, 22 Nov 2023 08:16:19 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5iPA-0011jZ-0S
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 08:16:17 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso1385246f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Nov 2023 00:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640973; x=1701245773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ziLR05YIx1r62isXzLrBu7JOOcJX+hqwhS06gWzmbg=;
        b=KuS+tRAlZHf2Fb7Vtt7naFFGbsHvUJqnrMymfwCV0x+ZAQNFKkrOvSzUWjceWi4Uhn
         7sj/53pO/NIzjyf+6kwDachRtojKCzACrq1pv19QtQROh+OVMJkIZ5jIBRxM0y6/vgr2
         NEvmaJm1V9JSQuaNQV7M3vkFkuSrRDND7jE+MeMOGhDOgQaFKY4jLt+JWfPXsGrpmEgz
         znYIU3KuwJtRQ5hBsVOz8UNU0lwpa4Mnfc59P6r0qm9szooNVwtTn8OJ08hPoFMcwZR7
         ASffV9Y2oVmPNxtsH3IpgdnKspjevkonzZ1w+e8Xpt3tN2jsUaoj55by/ryKk9R811Jg
         LSiw==
X-Gm-Message-State: AOJu0YyukrEOugSkE36arwSn2f6L5b669hrwKgFj2rKvHkUiS7rLd+ot
	PEWYsvBc0Ai6Okl0xQgpMLR8eZkQ6qo=
X-Google-Smtp-Source: AGHT+IH2HuJ4PeFu+755KSp58z0JpoNT2Feq8wum7ttizJHVfy+PJvgoVOxoqfGiawOwhwu3suj1Ug==
X-Received: by 2002:a05:600c:600f:b0:40b:2078:b8e4 with SMTP id az15-20020a05600c600f00b0040b2078b8e4mr1233366wmb.1.1700640972801;
        Wed, 22 Nov 2023 00:16:12 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b004068de50c64sm1327439wmc.46.2023.11.22.00.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 00:16:11 -0800 (PST)
Message-ID: <cb505cf1-598b-4e81-8f5b-2240e1ee6cc0@grimberg.me>
Date: Wed, 22 Nov 2023 10:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move nvme_stop_keep_alive() back to original
 position
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20231121080103.23355-1-hare@suse.de>
 <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
 <87313f89-cdd5-4511-87c3-816f545c4e60@suse.de> <ZVzuEX4_nXf3B82h@kbusch-mbp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZVzuEX4_nXf3B82h@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_001616_181320_3FCB9C5F 
X-CRM114-Status: GOOD (  12.65  )
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


>>>> Stopping keep-alive not only stops the keep-alive workqueue,
>>>> but also needs to be synchronized with I/O termination as we
>>>> must not send a keep-alive command after all I/O had been
>>>> terminated.
>>>> So to avoid any regressions move the call to stop_keep_alive()
>>>> back to its original position and ensure that keep-alive is
>>>> correctly stopped failing to setup the admin queue.
>>>>
>>>> Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
>>>
>>> It should be folded in I guess. I suggest to either suggest an
>>> alternative phrasing of the patch or resend an alternative patch
>>> set.
>>>
>> Well, the original patch has already been merged to the nvme-6.7 tree,
>> so I've attached the 'Fixes' tag.
>> But let me know how you'd like to play it.
> 
> It's not just in nvme-6.7; it's merged upstream too. We can't squash it
> now, so is it okay to apply this update as-is for the next pull request?
> I'm going to send the next one out tomorrow before US holiday.

Right, I didn't reach the PR email that was sent. Lets send the patch
as is. You can add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


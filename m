Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1739BC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PIz1tzmMOUQbPkNfW2Uw27clUkmdEpzg1cGypJGe3g=; b=HkgFHJ4bv9o4skuLoF5KvF7/BX
	PC66m2wXh9EjqZeUIZ1EGzuLPEvqdlCWjDBOsUgAxLrsAJ8FM0cmMV3ZJrEd/OFM7oEGOt/KGkHt5
	MmWdLfFe9u8WkoEIkxVpBwjwAPf7S95TBHg59UyelvJ0x2t33liYQ0P33cpGHdzX1wYOUzmV1cEXU
	plfWgOrqxecnrt8B/LvFgkR4nfJZYjiqqCq4IuXLefzu9OqziR15dw7RCr6pP5HvTousIxTBHuTip
	F7YuIQy7oBw9p6fHWJULXdqaF9Okm9VG/VCPazFAMTAE1x3ZVAHtQvK0Q1F8cDqjduScnVL0op/P6
	vvhIdUyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLlxf-001OcH-GT; Sun, 20 Feb 2022 13:09:11 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLlxd-001Obb-KX
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 13:09:10 +0000
Received: by mail-wr1-f49.google.com with SMTP id o24so22495138wro.3
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 05:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/PIz1tzmMOUQbPkNfW2Uw27clUkmdEpzg1cGypJGe3g=;
 b=bBkLm8lCTelIEBp8LSAgSldTytwCFC+od00cGFl9K1X1pohjnUADqQX6JHNa4n/4oJ
 SB1erS1Df2lq/h3uT+hplNN5x4lUZDz8RqpfrsdZvJdJ9J9tZynOyb8M3BLuaMW5JvIb
 tO0LxLN5E4ln/QtOuYYF2upGQJWwzZpdpDxu9rRBN0KFv9ubkIofJGqvBReXOBdHN1Uq
 LUkQ8fMNwg5Me1lGjsJutL/o4WlqmNmslSifbcZ5XUC0/l6C9f5ZoJua0yH4GMO/dgms
 15rb+KPLOGCqiZHve8PTndVdjE48z9rKfDLw06lDo4RhoKMZBXPi2ktRBqhCgWiAkxbm
 mcjA==
X-Gm-Message-State: AOAM530FUUWnzx0J3nmL8lc1kPIneyjtzpT+Yz+RdaC4eTjkkDQn7uxs
 KzWypejNEu8DF6Rc7l7noJOacWt6ffs=
X-Google-Smtp-Source: ABdhPJxHokMErjOzNjOm2cLpNQzOzj0CfrBnH8zhWpDTs6Vnh7wtC/SCMSYxDzckLRJd8quRPAg+Wg==
X-Received: by 2002:adf:f448:0:b0:1e3:2bfe:8e5 with SMTP id
 f8-20020adff448000000b001e32bfe08e5mr12160249wrp.130.1645362548116; 
 Sun, 20 Feb 2022 05:09:08 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t2sm28954710wrr.55.2022.02.20.05.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 05:09:07 -0800 (PST)
Message-ID: <1d1522c6-7f6b-7023-9e66-a05ac5a5a0be@grimberg.me>
Date: Sun, 20 Feb 2022 15:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Herbert Xu <herbert@gondor.apana.org.au>, Niolai Stange <nstange@suse.com>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211213080853.GA21223@lst.de>
 <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
 <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
 <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
 <483836f5-f850-6eac-8c38-3f03db3189ab@grimberg.me>
 <0c4613ff-ba30-c812-a6e9-1954d77b1d1b@suse.de>
 <ad9af172-4b7b-4206-feab-8ab54ba7cfe5@grimberg.me>
 <e2ccd5bf-c13f-8660-c4c0-31a1053846ed@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e2ccd5bf-c13f-8660-c4c0-31a1053846ed@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_050909_706668_D2B5F54E 
X-CRM114-Status: GOOD (  16.08  )
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


>>>>>>> Question is how to continue from here; I can easily rebase my 
>>>>>>> patchset
>>>>>>> and send it relative to Nicolais patches. But then we'll be bound to
>>>>>>> the acceptance of those patches, so I'm not quite sure if that's the
>>>>>>> best way to proceed.
>>>>>>
>>>>>> Don't know if we have a choice here... What is the alternative you 
>>>>>> are
>>>>>> proposing?
>>>>>
>>>>> That's the thing, I don't really have a good alternative, either.
>>>>> It's just that I have so no idea about the crypto subsystem, and
>>>>> consequently wouldn't know how long we need to wait...
>>>>>
>>>>> But yeah, Nicolais patchset is far superior to my attempts, so I'd be
>>>>> happy to ditch my preliminary attempts there.
>>>>
>>>> Can we get a sense from the crypto folks to the state of Nicolais
>>>> patchset?
>>>
>>> According to Nicolai things look good, rules seem to be that it'll be
>>> accepted if it has positive reviews (which it has) and no-one objected
>>> (which no-one did).
>>> Other than that one would have to ask the maintainer.
>>> Herbert?
>>
>> Any updates on this?
> 
> Sigh.
> 
> Herbert suggested reworking the patch, and make ffdhe a separate 
> algorithm (instead of having enums to specify the values for the 
> existing DH algorithm).
> Discussion is ongoing :-(

Hannes and co,

Do you know what is the state of this dependency? Or when should
we expect to revisit this patch set?


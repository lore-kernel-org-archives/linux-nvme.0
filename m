Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2DC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 14:54:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2875761027
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2875761027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxVOQvmWInSG5RgqJLxEPnjAIgFMYKFXL4HVLyzaiFc=; b=ykQ6dvIxZPES5Yjw4Un0rQTLtq
	15wp8Igq5KyUPkupa8mzWCKJ1QMWuFjLDaihJtRBVbaa5qYdYbHr/PrvyFE9s6X82fhGebsiMBuSU
	MfILCuERcsD7RqxVREkb9rebnWxKj0kxKknxXrAHrc7sbSvYKC4NRVF6ggizp0sDWS9YmVs1W4BwB
	3gnI+hQfvD5F5Ccj/adEu56l0nK55GK/Z1Hn655MJ7ONSZndjZhKcMNlcXqgLKo+u86Rlw/Nc4CLH
	RR4kYjp5O/XF9N6H0HZXxH08gEoeyKA+xn4vDRXux3t8MbgrJscvJkTPh4I+PkTGf2+ueSFYhaQKH
	10tU6K0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmGtq-00Dm30-Nq; Sun, 14 Nov 2021 14:54:30 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmGtn-00Dm2e-Qm
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 14:54:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id u1so25282713wru.13
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 06:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JxVOQvmWInSG5RgqJLxEPnjAIgFMYKFXL4HVLyzaiFc=;
 b=cslGd5ZqPfR0Bf8T+JRmAvrzDZnLFadG6vc9I2IZ3ffttBPhWxft9O4KzmG7pkEceO
 dzLm9dSBZnsL6ZAA7IfvjW7nN7mzy9Kh+DRHuczAszQZBzDl3adLZtyP29/qTkVjp4GI
 pgDASEPu4FvzxdLogmHU+0d4irVIetOxfszqgZo9yLxjVkx/AHfyHr6OfRz4gGW1wZhO
 nALk3AXkw95KVbWa+mdFsMkGB0NpxA5xFbdEIGR1cgWVjdr7l6tvqnRvX/U5OgK2rTV+
 mg5NkfY9hDEMzG5ZKt2C4ASfcU4/u3W7/OQBKiQE/SdKynSj3+bjB4NfD1EEG9DKrrft
 vJ7Q==
X-Gm-Message-State: AOAM531rm/m53AKGcob++BCvpNkcRBj1TXyVfxMsBqXwjkUCDbAzyNgK
 l9VeeE7PyyOjbhs4KFloq8ec+tFce8c=
X-Google-Smtp-Source: ABdhPJylfkWTLL2fjmqikPDmNwEGNaZaCcO216bCuMNxMJmQkKItfEqrKVX6pfnWR0oUcob7b68OJA==
X-Received: by 2002:a5d:6d01:: with SMTP id e1mr39507053wrq.157.1636901666160; 
 Sun, 14 Nov 2021 06:54:26 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h18sm12292323wre.46.2021.11.14.06.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 06:54:25 -0800 (PST)
Subject: Re: [PATCH libnvme] Implement 'dhchap_key' host and controller
 attributes
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20211112130053.97493-1-hare@suse.de>
 <550af202-0a01-63dc-0c71-ee893d880cad@grimberg.me>
 <32923fc4-a5e0-2731-cc06-da2211e5be69@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37ba905a-21f8-6b0c-21c8-a19b58b90549@grimberg.me>
Date: Sun, 14 Nov 2021 16:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <32923fc4-a5e0-2731-cc06-da2211e5be69@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_065427_911726_6CE9886F 
X-CRM114-Status: GOOD (  22.11  )
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



On 11/14/21 3:38 PM, Hannes Reinecke wrote:
> On 11/14/21 11:38 AM, Sagi Grimberg wrote:
>>> Implement a 'dhchap_key' attribute for the nvme_host structure to
>>> support the 'dhchap_secret' connection argument, and a
>>> 'dhchap_key' attribute for the nvme_controller structure to support
>>> the 'dhchap_ctrl_secret' connection argument.
>>
>> Hannes, can you add an example of a json entry to the change log?
>> Ideally there is some sort of documentation on what is the
>> format and how to populate the config file?
>>
>> It is unclear to me how the user is supposed to work with it.
>> Is there a dump config functionality like we discussed before?
> 
> I would rather keep the json functionality separate from this.
> Yes, I know that we really need json functionality to make it usable, 
> but then the same could be said for other options, too.

You add this code:
+	attr_obj = json_object_object_get(host_obj, "dhchap_key");
+	if (attr_obj)
+		nvme_host_set_dhchap_key(h, json_object_get_string(attr_obj));

Hence I ask, how is it populated? and how is the json formatted?

> 
> And the problem here is that we'll need to coordinate libnvme and 
> nvme-cli updates to get the whole thing to build, so I'd rather keep the 
> json update separate from this one.

Huh, nvme-cli access this config anywhere?

I ask myself how can someone understand what on earth this json looks
like, how to generate it, and how it is used. Don't get me wrong,
I think its great that a parse-able json config exists, but it is
completely undocumented which makes me wonder who uses it at all.


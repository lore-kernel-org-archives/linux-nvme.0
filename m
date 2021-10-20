Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81686C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:53:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DBA61130
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31DBA61130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1Ogbz5IQIChgBTgv7msvywaXkeGfTFlymWLZSn88O8=; b=p87wC3jGedUYC9YKx7by9UjcF+
	fA6AbODsq2dZZy4z+c4oJTH/jwRJ2mEZEPKe0wwUcsQ/JUH7VSsSFfT3A5FpSu0ebiBAEG/bcd9jI
	tCLSgsIRaXnd6dLWB/1iGmkXhERFmOEL48szSRw4ZQ+dLjCRqSpaGHM0dmlwOHrahX2cvnXQkddtv
	zzl+6scqeHbvdMYLomXNZ2EP9R+IbSQiQLZE8ilV4LGh/s75DSN68tpGoWOsMcOeHmHuCFiZgnh68
	nKbj9NXDph9tXjECiFFRl5xbgU7LJb90GVrMHp0JQdV+qAUX0cr//HhlwPrzsyf2C95lLVMQ67aR4
	z9IgbkaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdFmB-005Lh8-8x; Wed, 20 Oct 2021 17:53:19 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdFm8-005Lgn-9g
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 17:53:17 +0000
Received: by mail-wr1-f50.google.com with SMTP id i12so55236wrb.7
 for <linux-nvme@lists.infradead.org>; Wed, 20 Oct 2021 10:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1Ogbz5IQIChgBTgv7msvywaXkeGfTFlymWLZSn88O8=;
 b=78E2lVlu6CP/0ixPLL5qK/LzDpQxyF1H9S4KdqMqdiKlRAn/pX3J+ciBlbGQBtwFK1
 Ci+jc2lyW/oK5CfXum7s+ORBQ96xsPaSt7FaaDFTj8ea1yjVq5NLBzmJeVxNQyrJ9TFO
 HoLgWMsJHs9YCokWu4KCYbDdAm+QDpKHAZIe9uSkq+BlGhyx4NZL27+3wOS9eesdJsiw
 Eu5o9zIW3QdjZPlvSJj8BY7D6wlAQDC6Ttid0GEaK2OU6DC4NIvXsNW9GZQD4+wYGiPd
 qLERXOXpdPT53GcGelnqhRU626b4apJrlp8W0rRTO6gBtL/REE/X2A8I0XFj/FO57YLp
 IyOg==
X-Gm-Message-State: AOAM533PTmwnUpERoKUp7FcmcjbFY6s1px5irG4VJRwN1401OwObCSml
 /yRFogqY8u8nZMR65GwlArQ=
X-Google-Smtp-Source: ABdhPJzU5iqjsSabW3L+dJThvr7VgAX0RGIFf2OEGmHf2cBK+CjnUzPIaG3AWY/oCO78PpzBXNae/w==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr934806wrq.6.1634752393645;
 Wed, 20 Oct 2021 10:53:13 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y191sm6644418wmc.36.2021.10.20.10.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 10:53:13 -0700 (PDT)
Subject: Re: [PATCH] nvmet_tcp: fix header digest verification
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20211019113307.31852-1-amit.engel@dell.com>
 <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
 <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a71a194-c715-a38d-6b3e-560eae714451@grimberg.me>
Date: Wed, 20 Oct 2021 20:53:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_105316_395522_13AFCB05 
X-CRM114-Status: GOOD (  11.70  )
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


> One of our tests found that
> With the current code,
> recv_digest == exp_digest even if the pdu header digest is being modified (synthetically)
> For example:
> In case that pdu header digest is changed to 0xffffffff, recv == exp == 0xfffffff, and nvmet_tcp_verify_hdgst returns 0 - which is wrong

Not sure I follow. Can you describe in which case the passed offset !=
hdr->hlen?


> Internal Use - Confidential

Is this confidential?


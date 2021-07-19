Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F49C636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:24:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1906610A5
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1906610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1paWXfHW8JLtDhdjcAMwe3VtYYuoFZWW+SXcrDWLJlI=; b=eE485q6wOnqaiHX2QkLkCtB0yA
	GT/jbLFPrVlIj/mqZO70jLDjo+KzIFbEunOPZvzVY/J9EWXrih4cQOOeRDEA47nrAyH4SonAmLqDX
	QVhwdXitSgVKkXcffpDMPaUhJqDgkpRxq3mI6JY8xPphjYLUCY6LoG7XIOKD+0N+Z8/ejpnIKRwfB
	xCf/jEE9RgLuchM1+kcCI/YQbaqI4dlxTzlWdXW655YWqmH8dJGDQsbmDnON/kkEPmJuZcYJN/g4C
	9TP+byNmHRB3RS21+tBmPkyCxqAhE7P1gMOQoeCdO19nE/zmRiw5Az+Jr3rPru6O6/tQFAhlmbY1w
	FCbleq+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5PUn-0094M6-4T; Mon, 19 Jul 2021 09:23:29 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5PUk-0094L7-MV
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:23:28 +0000
Received: by mail-pf1-f175.google.com with SMTP id u126so8224480pfb.8
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 02:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=puHlGDARRKbSpOH7EGqRKL60GpYMbcmkXPxSTYDDiuw=;
 b=PY6KZoKy7Aqg/NR1S9FzODL7oVGuN7GB2SFXxA+7OlQ2D/R+DHaiNIOWZP+k4JxDW0
 3xgUQ5/l9j2UYDyCSsMjdcEr97FipsVzEI15VigrCEQ6O/sazKGp9/9L6yzRi2D83imZ
 nuO6wmH5EyMKaXEtEMVMp1JXjumJcYLFcPWxcyvEB6m65gK0KTx0rokoO/dhCFALaFZQ
 ojVyNGsLqToUohQ/xRdjiKEIU+5cfEllrbsQe0vlgfglr1BB4WBf1S05fNT1p5ZgnUpA
 YWIVWLXONKv+n1DfZ1PjHJTpY/nDB9aBLo4EBkYe31VUj59yvpQwLAj4HY2Bi/T9q+yS
 iF2w==
X-Gm-Message-State: AOAM531u46jvuO/L620iswqatgRFcIGk+8xHGAQkUUzpPsboNl3swGSC
 SYd52BgSSYyFLOvJEzIRAvw=
X-Google-Smtp-Source: ABdhPJxjn+oa7V92P0qr18bpUnLbzboWRXrQE8pmhZpsJ3xLgnGfDN0qpo5rVoFrh0tQLM9mWoaWYg==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id
 b10-20020a056a000a8ab029030ca10b3e3fmr24830768pfl.40.1626686604790; 
 Mon, 19 Jul 2021 02:23:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2ce3:950:ff23:e549?
 ([2601:647:4802:9070:2ce3:950:ff23:e549])
 by smtp.gmail.com with ESMTPSA id l6sm19238862pff.74.2021.07.19.02.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 02:23:24 -0700 (PDT)
Subject: Re: [PATCH 11/11] nvme: add non-standard ECDH and curve25517
 algorithms
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ac44322-5c89-da94-b540-6086d2a32bc2@grimberg.me>
Date: Mon, 19 Jul 2021 02:23:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-12-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_022326_785665_F104F4EF 
X-CRM114-Status: GOOD (  12.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> TLS 1.3 specifies ECDH and curve25517 in addition to the FFDHE
> groups, and these are already implemented in the kernel.

So?

> So add support for these non-standard groups for NVMe in-band
> authentication to validate the augmented challenge implementation.

Why? why should users come to expect controllers to support it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65F061C14
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A65F061C14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=De6xSUE+LU+xS+pNQP/APrgEdESSAyaHS36taCZ9EPg=; b=efct5zS6WelPOEvr25x1pV0MDr
	nO6kZ8xJdfg25CX1oO0dPsXnSpczdRu38P0tePrRnBc+vNL4nv6wI4Bx/k3DPvnc4FrUGfRZx4Th0
	2WfYixXMuurWptYcCem+/prv4ygij1j85KEmJ0uglML++xEzkhtdc6YvvT6ALHXtULQxTf0L3LGIk
	vEidao3jdjcFlobN0dWJYtQW5bVLrwJdSmdTpzXbKEw0t7USwzZupkKjkBYb5icKMrvItj/Kfeib4
	rVTJLowg+vKg4TQ/Mix/5G7iAcnWkTdo1guI0TKe0fJWAGBQXxCSYEdEVbimb1lMIVVgX4DbgaRdR
	bGUB6cjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvpX-001EBI-S2; Tue, 16 Nov 2021 10:36:47 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvov-001Dyz-Pr
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:36:11 +0000
Received: by mail-wr1-f45.google.com with SMTP id b12so36637868wrh.4
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 02:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=De6xSUE+LU+xS+pNQP/APrgEdESSAyaHS36taCZ9EPg=;
 b=MLIMJercBvUlkJcmdAW7AKkCWgABxXYNpt1R7MuYE7pLujtZ9YoslD+eeY4Hykpb23
 uTeykyHqQVZD2GsTidpYUWFlAUKSSjoeJ0zWH4m32Q9dgSNWL99NfB6I+j4fp/ZKq1Vs
 fXqVwvJlWO8Tyru2DQm6udzBLAciK+oUlPhXBRnOQ/oVf4RNGcDgBwLQIoNB53+h4oEg
 Ot4MzXJZnnEZ+6nrvuMPPzFJVbmsWCyfMSv57PwyYxctNqUf56c+qrZMDXgtQmrEOlks
 uP5bKLk9SbHaLzAtn/dBO9e+A1kCW2Cgkc/JU6WrylowlmAvL93bp2Vx3WympD/lDdOt
 bqmw==
X-Gm-Message-State: AOAM533/Red5iVFAfst+qZ/EQy4HUKDszDW69d0D20mdPQOx/dfhCTjl
 m6r+UhZ8LEEtkeFzQsDH/x8=
X-Google-Smtp-Source: ABdhPJz+6JROlPCUQQny1UM9sV3wR7GPDdBIm5LlK1urNESPZWmjegorY0QVcsQRKYzSYwj+i39XQg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr7869901wrd.105.1637058968343; 
 Tue, 16 Nov 2021 02:36:08 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d9sm16930432wre.52.2021.11.16.02.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 02:36:08 -0800 (PST)
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
 <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
 <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
 <50095ec8-3825-efa5-98bb-76b0f0fdc21e@grimberg.me>
 <31088486-0134-0dad-b052-32fd3ce2d1cf@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c894ac7-cf8e-4052-d56e-b8b08ead9092@grimberg.me>
Date: Tue, 16 Nov 2021 12:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <31088486-0134-0dad-b052-32fd3ce2d1cf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_023609_893416_7D490CC2 
X-CRM114-Status: GOOD (  17.99  )
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


>> Hannes, was the issue on the host side or the controller side?
>>
> The issue was actually on the host side.
> 
>> I'm a little lost into what was the actual fix...
> 
> The basic fix was this:
> 
> @@ -927,13 +944,17 @@ static int nvme_auth_dhchap_host_response(struct
> nvme_ctrl
>   *ctrl,
> 
>          if (!chap->host_response) {
>                  chap->host_response =
> nvme_auth_transform_key(ctrl->dhchap_key,
> -                                       ctrl->dhchap_key_len, chap->hash_id,
> +                                       ctrl->dhchap_key_len,
> +                                       ctrl->dhchap_key_hash,
>                                          ctrl->opts->host->nqn);
>                  if (IS_ERR(chap->host_response)) {
>                          ret = PTR_ERR(chap->host_response);
>                          chap->host_response = NULL;
>                          return ret;
>                  }
> 
> 
> (minus the linebreaks, of course).
> 'chap->hash_id' is the hash selected by the initial negotiation, which
> is wrong as we should have used the hash function selected by the key
> itself.

Makes sense. thanks.


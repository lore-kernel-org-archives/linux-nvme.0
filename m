Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3041C43217
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:21:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C586861213
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C586861213
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=39/tbBu1IlmckKWf4wtgLOBa8i
	UKxy4DMnLPmVbyg+RGnRE5HypCQuoSkeGrOMPqyj4MlwTOQugWOo4s+IH2PNG5/kFKu3P0fc/2mwm
	xdnFap9aMGyhqxjfFoGa+cn1I0QpfadhWCHN6YzCSr7cUkesz2dWLL/cXntskbhvQKmd0TBVNm5IS
	U+JW0ctVA37IHyDdjdEYt+HlsNq2r/T0gYieim/OlVagOckDckfGeoRCk4C0fquEzt7qr+shWUJjX
	PhRNzGYcSVN/f71NDpYAh1WqRMDkp8b5Tr7PAE9KtxP9m5hg+0zFF5Zh7xWk9Hd22nPDevFdYicbJ
	XHhHW3VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPltN-001luZ-Rp; Mon, 13 Sep 2021 13:21:01 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPlrP-001ksU-Eu
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 13:19:01 +0000
Received: by mail-wr1-f48.google.com with SMTP id t18so14707797wrb.0
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 06:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=1z2GHIogFk+Bj47Gwydqw+xAAwzpvisypoZioLLGcvNZdF5QJWAyKC1NQx2Icfd0t2
 jEHquJdeqxk/+vMrEh9j5glRzuIfQQytMutD5yXvYsCR8nSuA2YI4S6wGPHmY9mlALlo
 YeA8rAj7hvbdUA3FzB7tf5MQrXvgABPRs78rBtowWx4+J/LrjglAK8ij2Y5QO2nfkfIi
 xe1GG77fSfcf1ZjXxKtV2bx8fcRHek3gUen6kylIgtrOCPhY8M8dJ3Qm84foQ6EJsIAp
 lNIfsuZ+qEvgGRTKvUemzubSBDqaB40bN1uNWmUh5j0w+u+mYYf9bXQNMj56btj4nqls
 OvWw==
X-Gm-Message-State: AOAM531d53f36nC7H0DfgUSog3p9sAsmiUN1O8Vl/zzpbfp2moJfkdPw
 WOa5NFJ1zWONL4OEKv7vt9RcPFMJuQE=
X-Google-Smtp-Source: ABdhPJw2d5dXfozJxJm2IyGT+H5eizuZ+3PAbEMkEPVx7Q9k62RIRgZNJ2H975OkMKk9p3L2jhM79w==
X-Received: by 2002:a5d:58cf:: with SMTP id o15mr12336494wrf.312.1631539127731; 
 Mon, 13 Sep 2021 06:18:47 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id u13sm7325808wrt.41.2021.09.13.06.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 06:18:47 -0700 (PDT)
Subject: Re: [PATCH 06/12] nvme-fabrics: decode 'authentication required'
 connect error
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f6460f5-14a6-83b7-1b2d-8453c74b7ad4@grimberg.me>
Date: Mon, 13 Sep 2021 16:18:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-7-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_061859_599652_A68DB37A 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

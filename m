Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFAC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e32OIRPz2OJ/Vys15rVql4Hke1eBX2uBJdn+sofi7QQ=; b=yGC1A94F2AXpN0UZMEo+SxpCCh
	UncAPAcsd4cBMpicDiasjltfc4nLZpceIbL4u8QNQDqLzpbriAILY7cQ5Ei2jeLzITaqMHLny/edM
	z7fupmwyxQMP+pCepvjQm4YNwtHn8y9ULjYYz/IWAJR7TxN6zk0hq8Yndj1M60Rpxz4TgzloDBoq7
	FhHUnzH0rjvFRKuUXXzyXD7XaauKjMpZgB0as2lGxIxz4JBFD9yeOi6bkrKMuqDN1uhMZe20wo9cF
	3p6ztcVg8QLX7k3FH9RgjDWllTCrCryTpTps6JQw4pK4GG8pdsHNo7pSt4fD5Ct/I3DjVWMPETmUH
	kuS607FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPaP-00Es11-2x;
	Wed, 13 Dec 2023 13:47:41 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPaN-00Es05-0J
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:47:40 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1cc518c5bbso220196666b.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475254; x=1703080054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e32OIRPz2OJ/Vys15rVql4Hke1eBX2uBJdn+sofi7QQ=;
        b=a6TLM4yhohQC4M0IJyKUfnFqepdZUkfIM749UTo6/73KX8K/TMm+CjOQ4cybW0Gx0d
         bic5loDh8QKw++T2ChpTC+8X5hdblW+FL9a9e1haz2AA/3v43w1oWWa+nAlzBVaRajks
         fv3XpKV4FpUwZwQH7eiYVNbd0EIxno96JW3t260/J0QOTeYeT1EQNzi4FEEoCfaa4DHo
         UZhRLJqu77RNVF3ckMyqjUA/eVWXG2PnHotlRQYWuyVHNgd4MB+V6QvR3CY1YfiMhzu0
         v9chOXQK4J7UBuAvNJgtuR1AcGjcCtZCq8kYqpuaDGDN8LRQigREyzYM5JOWCBE8AIHD
         jbpQ==
X-Gm-Message-State: AOJu0Yx1hiKeR/6lfAyQ9SZwMmuDwhJboNJEzA5sNTtM6enBSkzNRRyd
	HXEpIIvCv5KiL0m8s0KuPX4Scrt2q3A=
X-Google-Smtp-Source: AGHT+IFNjLwcsJSqByN1kIgpcCXwBWk4i+QYoGLfCZ55dmS7ecEUuuqhIvZoMuwe/KR6t25aB7jbWA==
X-Received: by 2002:a17:906:ba86:b0:9f2:3e76:5d39 with SMTP id cu6-20020a170906ba8600b009f23e765d39mr9073767ejd.0.1702475254187;
        Wed, 13 Dec 2023 05:47:34 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a1b7769f834sm7702467ejc.81.2023.12.13.05.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:47:33 -0800 (PST)
Message-ID: <2d19ea22-8630-4a8b-9e58-1a6a54fd9b9e@grimberg.me>
Date: Wed, 13 Dec 2023 15:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvmet: remove cntlid_min and cntlid_max check in
 nvmet_alloc_ctrl
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-4-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702449172-8920-4-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_054739_130646_C24A151C 
X-CRM114-Status: UNSURE (   5.20  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think it can be folded into the last patch.
But anyways,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71633FF885A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hhFdLKwBaNyrByV11QV516Ln36
	3GXV2CF7ryn9QH7udmhwjQpF/foPh8KPagz8PWGH+K/eQqRZkQIUY+fFtkRKEBxK/+sjgGprm7/Cw
	oF1YAWSuvMbGfn6pu2arwAnZDM22vTNqzst+QDiUbnhybKtE2bEZKU2cBuE6bEtVdYrQiUn4xf1kp
	u+NrDMsMdSsfXdmllNNemIkRCqn24R56dT29V9yyx6w2iU4TgbpVqbG3xnCuooF+YngGcMIm10yMQ
	zMtrSTV0giYn3n2yN4peBq25jsrBMNHb+ns6/6ic83tpTHLvVXpKAofG95GeIBCpslcv4zCwrdlM8
	I1VPvN2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPBt-0000000DpS8-20MM;
	Fri, 24 Apr 2026 22:40:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPBq-0000000DpRQ-38Sp
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:40:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so6670244f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777070401; x=1777675201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=X1GGKCKbT41pwz9JeD9DTRfJR5EXwHNercHDMfxVxoaigT30XVU728nJ2bJTW3vquP
         lLgGwdIUVTve8HlZn9gNATTdOs4ytxLNcZo0GzZkklOL+mb69h91pgR697OwsPWcKAbW
         Z5xzIkDYeNWTAHqAC8crPQ3o4LwPisNh9aWWzqcpR4Sd8jVKkjMTHqienwoaYl0xfRZc
         KarlwDMax5XwEaoO1snrR+wudt3VRfrBUnbRqpc1oZLBFR8rm31HyOGjr01yeZ9QiV8I
         jWMHKRvxk09NzgRjcn2NjjA2bbzk8KJ07+Oo8oQqLCCkxAzBIxR65NwXNkQ1WWLDqAxz
         /RnA==
X-Forwarded-Encrypted: i=1; AFNElJ9qe8R65oCEngx074SxWyoQu1lOIsI4py1gOJeBxVAlSjfRzca54js5E746q+2pu/yud8YqgV8Iei4z@lists.infradead.org
X-Gm-Message-State: AOJu0YxAMO71pTMG+mYPsotU8iHxBJcsYmYtFtKzOizaY88bye2RKmEW
	QvNl7FOlmDoP0m2IKD0BCKswxvhYJwz6/cqXPPdpq+nVYNQXZZKoEyqi
X-Gm-Gg: AeBDiev8/GczyX2y9+Zh2IWVJOrSLEMuBK9xQQ0jvm2woiKHYt4R+5ohIpNX3ctqtZ7
	yVdvsYlDgvn8PBihliJZqrhAZ4iPawpFtIuuKsV9am8Txur7pBZLhnxrg0e5OJEoazxTHAh1ybU
	1gKf29gO7X0VRmZrFpup+31hbpRVQ/OlPlWwhCsOJGVI4GcjPWNk+MqQGGEkaRPrmwLQTILQ8ac
	L+9JnSMOButxC4aRsBAt1QjUY/SVgvTs9gCHVroWTe2LoxLr5HVa7fElTozPZyi7lyFmoy5fDrA
	I9CKop7Ar8RCMDj1LrnNNDlHJQcXb40acljarWzLHOcrG7ZynR9+CxOj52Um2cYEeGqszqCsG6q
	0rdM05GAHV7a6nXBBebb7UNqbLtavVUMRM+Wp0IDkvNTyq0Z5qhgOPIpCOQ1B/8hv2/BkbyZXhi
	IO9ExvYy88xJLowFHjDwrhohEn/stSZu0pv+A3sKnESm1cATmwULFCYUdxoYbECbscdUqg
X-Received: by 2002:a05:6000:240e:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-43fe3e0d2e3mr52061125f8f.24.1777070400837;
        Fri, 24 Apr 2026 15:40:00 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm64106244f8f.0.2026.04.24.15.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:40:00 -0700 (PDT)
Message-ID: <9ae09c33-dbee-4eab-a238-9c78e6416ab4@grimberg.me>
Date: Sat, 25 Apr 2026 01:39:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
To: Thorsten Blum <thorsten.blum@linux.dev>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154002_803184_38683CBD 
X-CRM114-Status: UNSURE (   5.73  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


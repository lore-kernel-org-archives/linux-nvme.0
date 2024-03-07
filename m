Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C58C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=J2iXG+1eQl2bZqc3SnW1yKPtkr
	hKPfITx+uhNqH/DrItpsoa9XmOHRcJoENrL4Lja3xXPwfmgbFopiCtEbIpMF/rg4okgxM2FqXuBW1
	OIpDsvkaHV84/0ouweKD18megw8ZqB5KCJMlRApTNqEpJTKssEKzeGkQ4h/b0Aqk9k7KCfg9vVpQ2
	eAMVJ5lyhSzR/bWU+jgz+GrHCH5J+o4cJT3G3cMEia7SHUdRWPfVo4YQ1WcDppnn3kU/NuQYYiflZ
	xhGchjVMICb3WDsrWOUQPhWTosKWkI3ggl0W6Mk4yP8Hcmhd7ZARH0P/Z24l9XtBBVy5y0kw4hDfJ
	yB3HKJjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBDN-000000048Sq-2aBj;
	Thu, 07 Mar 2024 10:43:05 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBDK-000000048RS-1mHP
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:43:04 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d855caf7dso178043f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808180; x=1710412980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=r6h8oEMtsrJHWq2f3PmmQPOMpcic3mcVgc9M32bZgALlFirJkkvzZ4OONfNY72s3MV
         t7hm651hSXiGB68EeOTD9JReBNhvnfTflajhSBu4FKPggEglLJLxOa8h/Cmz0Q8q4Uvo
         2eq5ILqe49o9c/YroIQBEtOxqyi3br45Hl+0BQeKxVwCC3cYnu6pRLdl7Hf8Or22/DOo
         BTqu5lCDpYVKpy+UuNiorzO9Rm6L310rx4vntbR4l+UuQsQ2BikNaGg3hl8huoSVwQq1
         eueVmpPEDODeiS263jK0MAM/8W4M3L+nmXarmoxmvpwQcnAxpLK9zcrAwy7cV4Ibt+rY
         qF5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+VLIfMxA+f3F4Meek6ITo4taw3C5QGDrPBjbaA6kd7SOom1uIef4/4mw8qzNLaNezQUlb+qn+7jPIDqNvqRwaRul8A7Km1abYhY8G3pU=
X-Gm-Message-State: AOJu0YxOk91UFVnJcTUl7Rb8yccVXVkcSb9QegzX1rnxzapTSKJ0taBv
	S607IDjXrM8qG7aPBrhy/MJoTAUoIcDkQGxklGddvIMXDdv2Qyx5t5NArR3V
X-Google-Smtp-Source: AGHT+IEBS9GUlyOMEKGLijKjkYCUaBKZYJoOHIHjlmDlYA7IWWdnKDPIqSYtn08GWyGo+9tGYYW81A==
X-Received: by 2002:a05:600c:1d0f:b0:412:f82b:9cb8 with SMTP id l15-20020a05600c1d0f00b00412f82b9cb8mr1153988wms.4.1709808179748;
        Thu, 07 Mar 2024 02:42:59 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b0041308e57a28sm2264467wmq.23.2024.03.07.02.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:42:59 -0800 (PST)
Message-ID: <c320f946-29e8-402d-8936-aa685a66b1e0@grimberg.me>
Date: Thu, 7 Mar 2024 12:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] nvme: add nvme_auth_generate_psk()
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-3-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_024302_474397_474E1064 
X-CRM114-Status: UNSURE (   5.39  )
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


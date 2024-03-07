Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B3EC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=BobUfBHN3gKsq0oYBPenEr5/wR
	PPATJ3JpTklNy5MurAR2PBvg1HNGpWNUGg3EPwdsSmKuI89f9jsabnbdet3sjLJlP9G2sQFJlP0YJ
	dR8wDm8FUEAf3jCraHWjxiM9ndra8jd5zKLFHgqBBM0gXiVdK7jvLmKuKJx5HLJduK4TH/RXGb3Gp
	Y+Yep59oty/pYd4gIFnYqrWZjn1/qMSBflKY44oqBEX4IIR8GuOV6l0eilrtviOsRO7YLiKarHqXd
	ch+UnTyK6oJc9x9zcXZpxCwiW23TEq3AAP9BKJQitl8xONG5TrjBR9OPnCslxbJqKAU2braZZDZnr
	wl2bdDzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riABH-00000003stW-34S5;
	Thu, 07 Mar 2024 09:36:51 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riABF-00000003ss4-04xa
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:36:50 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33dc6df042aso155246f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804207; x=1710409007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mRhsdhlOVL3pT4wVzZ2YfJNCBqR2MCvtGl+gYe30pQRzUd+M5MM6K48DDu2Ku/m69s
         DQz9hZy0g1wA8QQNVyfbCDyPtPQqUoc6dJK+3TlmSpaoivBQ91v8qaGKyQEM40fHWzr0
         qx4EeLVgxzR5Ptgd6ZkGGZ8xSy8w2rfe9NRQSw2GSVXz4VqEVXgJXhYUzwtqZBMVuJns
         hqEqsNkBhFCXpkavRi63tWrFTOLGcWzmVNUzhRqH3QEQnYd/oltXevX+7JJfJwCUHbAn
         VyIkmSPoymuFjOdOTahZURvuFGd3YJUTSNKf1dkA+KZLwKRQaOpMK92hXzJJ/b62tq4x
         b/Bw==
X-Gm-Message-State: AOJu0Yyn3SI2AISIk87HSfT4MtGESKGaRsTILsuCB9qGSy+xm6oZHp2L
	mhVZGYWYsUGT7JtlUZhkBW/SX+YxDXtB6hBwpnirK3spcxFUfdAR
X-Google-Smtp-Source: AGHT+IFpqA3lfIBSXXzP8oVmdQd1wsK5ORyl7HBjsSwHxPTVFRhBGryLbZ3XTVlFoehMK2uK/kIT9g==
X-Received: by 2002:adf:a3c2:0:b0:33e:65ea:cb8c with SMTP id m2-20020adfa3c2000000b0033e65eacb8cmr591611wrb.7.1709804207040;
        Thu, 07 Mar 2024 01:36:47 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm7451170wry.66.2024.03.07.01.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:46 -0800 (PST)
Message-ID: <e27b6cfe-215e-4d15-a2ff-3a6b8ce63c20@grimberg.me>
Date: Thu, 7 Mar 2024 11:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvmet: add tracing of authentication commands
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
 <20240228083755.125259-2-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228083755.125259-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_013649_069627_95AF0788 
X-CRM114-Status: UNSURE (   4.85  )
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


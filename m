Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143D4C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0NLGMHVHEh+93F0qlhkt0Awhid
	eFkmSEgOHtpYC28PYOtnFCv+WniXsBEpWgnt4dSq99P0JRiFWX1e8a26+z1yv9MLuwlgBZs5KpZFG
	/2RzjTcRjNHR4kMpRFiDAOi7S81zh/lPy4AYPgzber5CMk/0T3jdeqbFAOtMf62SSbuGhh5VAAge5
	cKw4DehzK5u4jIBRva6Yu6QXD15cvDIWrNbTkiDMGKEAMJVxkPX8cqqXNTdbrtrRQlAYo/CYs7WgX
	m4VdweeD37JzPX/e+TJJKfGAk7ZgQHmnMiSvt3Nw7HC1BbMdKIt33wjDdqYIT2ALumakOMkoyLfk0
	khqeGZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8jQ-00000003Xn5-2aEJ;
	Thu, 07 Mar 2024 08:04:00 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8jN-00000003XlJ-10k5
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:03:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33dc6df042aso131769f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798635; x=1710403435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fD8Q0QM6yG7+JO2Lx8NT2dhaWwOND0102j/9YOnuJ0eEYFPcnAnnDUIV7MO+Fbo0Is
         e0EXQ4ISvs2rzWJ5ReyzP+sR2JCLCc4XLb0mMY0pi5/Y3mv/1kjd6HFAvmtE1hTALXa3
         SIXn/WC7bcQh5t/QglCSFgxBJOuzRpIXMOmUzeCKe3jKmyRgRxqIszGECQDuoSyoNpeD
         ZfNq6LSCs/ib9TdbcLKcz0GoympTSWZDFx4rtCOXtOwTFimeauFLkPXt6UTrUvmzwlNJ
         GoCzq1vrZV0wTLg/F6epC/n7MdYJTinNispC+SBMkkWU6TAL+26X238CcGLcZJb3wke2
         RrGg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Tfv4+HO2yf06AZQVTsKsAcWkiw+LM7mMoW5qycXbNLIHkHiULkA5f+lPRVHuFlNZB7koeCfcDB7SblUf4Sojc7EYj2JhrNy9wLMt+zk=
X-Gm-Message-State: AOJu0YxQpxv4+QIygwBIcQYfY7U2psqv+2K77H6WwEb0KihN4cPKSrnf
	rtBPmFoUnXfcCwIrLMrhYQSn9DA+6BlI4upeS142uUVwfmpMIHMg
X-Google-Smtp-Source: AGHT+IGOJutbcrLPIeu+rZNV47GiLqAisbOstY4rrggXfsY2AcWXeGJKwS1ZmdG3oocSdIvCNcDWqQ==
X-Received: by 2002:a05:600c:354d:b0:412:c327:4064 with SMTP id i13-20020a05600c354d00b00412c3274064mr821324wmq.3.1709798635457;
        Thu, 07 Mar 2024 00:03:55 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm18884841wrq.50.2024.03.07.00.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:03:55 -0800 (PST)
Message-ID: <ea8b889f-7091-4e69-83c0-1cd151c2616f@grimberg.me>
Date: Thu, 7 Mar 2024 10:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: export and use previously added helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20240212042641.227821-1-kch@nvidia.com>
 <20240212042641.227821-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240212042641.227821-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000357_312875_E04FCD81 
X-CRM114-Status: UNSURE (   4.99  )
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



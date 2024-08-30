Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D6CA0EC5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2024 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2zovi4zitGl+8YdGAs2McfSPnB
	jMy6BBG2VcnKKjiA8AF4+2pEofO+/UG3VtiYadp7Cjj5hALNhxQaijrfMLU/rqSgLRtRjDZzcGlUx
	M2UjXv3RrR7jbapJnrO0zUn8yQz6GhgG2V/lnccwT81JFPocVPvawDgrRb+FQzlYiCkTi0F0PlUvg
	laCnG6o9i7HSPSbdHS/DXkuqfNtXX9XwO/tP/jaGZ0AOh8mG1rechq+a8z2Y+l1uZFT6cJYLwuayY
	7GlwLhTsz9jeN8dY6ffg3mDT7/zpipdl19lqBg12eb94dixgEPVocjdu2IVALPnGSVHc93aqx9f8S
	YyiVb6hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjyVD-00000005huW-2LYq;
	Fri, 30 Aug 2024 10:05:11 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjyTV-00000005hI4-1Y8C
	for linux-nvme@lists.infradead.org;
	Fri, 30 Aug 2024 10:03:26 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371936541caso1032964f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2024 03:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012203; x=1725617003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ru4mtER7e3UJV12KIv0e+I3HBXePUrcf++X0kxlgmLIEKkfsgHWN6KxVLkKZ007low
         +OjXxjvvQCiBwEcKBrcEprcSfkbtceUT1kC9AEvVM17Tu9ZUkSpRPRw+y1j1A9uIFVl0
         CpQUQ9JAXleexDCdEWbCIiqaKcppkx/2+iVJTdKF7ZlRTgu//oYGvl0ODp+x/0pMMXH1
         EDxszRiT7M4sYaEju/dDHrlnxvrjOMpI4yjmQ76T6hkRl/YvyWDYbDlrfckRPz7p0Cnv
         /Hgu9H+YamjoGcAzZ3MT4OZaT95/6mqc1NYZ1Qa2Kl1FWoA0C0KS1Gp9Uj/kUWTQuJjw
         bQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUCO0cfaMmm6zOP+NXTyCKZO41BEMvFtaQzMi+69gzvDJ17G7vyC5x5yMVkBlN6xKFcnD/EordquoAz@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7ik9v/wg5oTkCZmHmZ2dVJ/u4yjeoVr0ZCSUQfECiev/+uAMU
	xevdBH2yw23KN7avLz8Tig9n/4wRJM1LP5ui/LIQHyzhxjOLFYrV
X-Google-Smtp-Source: AGHT+IG/2DE9GsyoE4hJTe/rMqF13lGHhIHmXiwelaL6jLif3Y0/YrW/1+jRHDq0DYbZf17RAWa5Hg==
X-Received: by 2002:a5d:4bca:0:b0:371:8ed6:663f with SMTP id ffacd0b85a97d-3749b55821fmr3908479f8f.37.1725012202550;
        Fri, 30 Aug 2024 03:03:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abea3sm75930875e9.28.2024.08.30.03.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:03:22 -0700 (PDT)
Message-ID: <c6b58ff9-94bc-4870-bb0e-2add491628d1@grimberg.me>
Date: Fri, 30 Aug 2024 13:03:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet: Identify-Active Namespace ID List command
 should reject invalid nsid
To: Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org, kbusch@meta.com
References: <20240829095214.48915-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240829095214.48915-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_030325_426054_3AFDEE91 
X-CRM114-Status: UNSURE (   4.97  )
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


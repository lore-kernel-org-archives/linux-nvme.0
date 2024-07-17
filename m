Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745E2C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpq0ePGHil5HP+WdLwvVw003SIP3oBTgYHtERYXDIJE=; b=pwRDM8eM7W6+cHUwTGNAeYgfEx
	OR+0pCn0ecb7kZb2DbrXVC6uWPsxBOpqHy+12AKlZE3zhHk4u39ydD3kLtz2KI+RsFTB+wWyZU4lp
	1fnYjh6D6hy52CxLhcxv3UBsiw6QoTxHm1OpemnDB8qw0owIJE5mMfLtX761WfvzduPvc6HF9nZlO
	BuS96ICi0Zyw2EbCIrhrXzU/yPe8Q4IRaaaRli3fqUAR6CdSq96s7de51yF0EQb0PAlxYXODLQLCg
	SiDs79PSK8U1NLzTelGIUUc0iN1uGPftCQKTtyV0w3rFDyjPja7y40bRwkYQj6Mss0qPLblybDhgt
	LhGfJ9kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDC4-0000000F7oK-0XXp;
	Wed, 17 Jul 2024 22:32:16 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDC0-0000000F7mm-3FTV
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:32:14 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-426593b99daso242575e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255531; x=1721860331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpq0ePGHil5HP+WdLwvVw003SIP3oBTgYHtERYXDIJE=;
        b=KYKjuJ3jSmaGNT2xPr9SKbe3KF9C5EwkVvZqgN9P7LPX2lwCu6dZ+LyLYjsSYj/PtT
         b+cG6tveL7HzR6j9e6NH99oqC0LohgkkM+HkgIf/pxZEZrjUk8YLskbuAV32v3hPMB9L
         Q4ihrKoBxoY7DAnguQDg8p7taUli1PKGPWVQHm8Tp1qN6sVWtShTU0ytJAohh1FdR831
         WhSzPObK7yzjzRpagVE2beMHWaAnZAa0Wh5oaR3Ljy/Nmn9zBmmCLFNGcORWmM9q1jzL
         m+B2uzlQ45LQ/7AgmZHL7Jai7tgbyuIdD5sB3MVjBfMFvIRkEIpxXSamdZxDGFtzffC/
         HkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMd93KOfvUHjcoMPBe1llFegDRU7HABphzCYG7S96xsH97h2kcP2D5bHIzuNpAG3fen6yFIoGqWRT3AHz45alDiDN8UD2HMBnI9JBdIW4=
X-Gm-Message-State: AOJu0YzXdFcbyB4S4UPZfu9601zs7hQ8FbM3z/uWoD7qcC/q1D0vDAJ4
	nNgt1L4Wryc119R3zX9r0DF5Rxhl5qH0bUfYifhLP6t74GxOlfDO
X-Google-Smtp-Source: AGHT+IFlBdDzwi9vdJFbeZwJ5MicWl4hUliTxAx68aN4joekgZAMR7T6gKSkSBGr5QjNN0NhvLjXkQ==
X-Received: by 2002:a5d:4d8c:0:b0:368:4c38:9c93 with SMTP id ffacd0b85a97d-3684c389f56mr246907f8f.8.1721255530828;
        Wed, 17 Jul 2024 15:32:10 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368460f8d57sm1036071f8f.40.2024.07.17.15.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:32:10 -0700 (PDT)
Message-ID: <946eb071-fd15-4df8-b0f7-5dce17964e15@grimberg.me>
Date: Thu, 18 Jul 2024 01:32:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] nvme-fabrics: reset admin connection for secure
 concatenation
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-14-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-14-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_153212_929551_D5554BC9 
X-CRM114-Status: UNSURE (   5.61  )
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

Nice,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


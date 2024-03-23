Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D784C54E67
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Aso17JZlmLDw4sq8PVhY9KWT0i
	EFhZqcZzS2H2A4gffXEzQc2cSqF930Lx0EdFKpQAykcxc2W891Nx9F5ZK8+6WKUuyscVZ2F7FTwmX
	/VmcOylEK9Njhws6KdeV758sdQzC25BwIdn2OzzarFuITc+tsw3fmdpU8E5IZTyDwvBBA2R1a6vde
	GTRHDJGpIXacez/EGHaIa4gFb3WdAVhbhgL7D9Lm/vqkMQtrFi+yHW2LL/8GfQ3cihC0kXFVBVAYW
	YAiZFFc2wkGgCQUXcdnwFKXxdjwN+bgPs79tzX/PK2GMrVqvfwNS/br0iZMLFmKeu6EMiPsPrTzx4
	0ZD083Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro83U-0000000B7un-3rta;
	Sat, 23 Mar 2024 20:33:28 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro83R-0000000B7tl-1sfT
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:33:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341bba83366so348752f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711226004; x=1711830804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PXUVi68VzmUOM40ERsNLgG2wmGvNNryRS/FypHYmDy16zKe2kAFSE/al+BFiMgc+fh
         jhBLXhpRDLQZwz6b9ShdOv3E8ur8XXPGBQJi0gJg0n1bUKWYKll0s+9p2vcDZv2RqWOx
         qQXNtqu88GQYqSgBcpp1mzfhgwW2YyvZ3zeD+Or3JQ3ejmO1SZF6W52L/3dldNcDHgty
         1KaRPtY2KjI7bAFt57E9E9ScbuFUh/n8s3FABPRh1N6ZlOguP7zoocJ4PA3dZOs/XuOh
         9AkKdLpSooBdPumZ/yTm44PgF9NWyWNzMIu/UBS60D7Lywkg+pCuRDuW/lIDj5ISmYhL
         bXgg==
X-Gm-Message-State: AOJu0YyP56dqoEdxCqf8+R6dIkdE1gsvTbKrq7wVWjGYiBv6lwc27sNa
	kDbupMlKfUQ7KMuPQ5A9XE75wdhGmH4wKf243a/UUFXHhpkhrVy1
X-Google-Smtp-Source: AGHT+IG9JxJR6Zqc0O8gCr7u7BRMcWLkatExyqZUSWK3TA9kwMcyOyrsAx2bWuo5M02HO75WiqFY+Q==
X-Received: by 2002:adf:ea0a:0:b0:341:8f18:db39 with SMTP id q10-20020adfea0a000000b003418f18db39mr1855250wrm.1.1711226003933;
        Sat, 23 Mar 2024 13:33:23 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id cc19-20020a5d5c13000000b0033ed8643638sm4215012wrb.106.2024.03.23.13.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:33:23 -0700 (PDT)
Message-ID: <f08b0d31-59e0-41e5-83ef-f0601190fc43@grimberg.me>
Date: Sat, 23 Mar 2024 22:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: don't inherit LBA-related fields for the
 multipath node
Content-Language: he-IL, en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
References: <20240321210819.1246749-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240321210819.1246749-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_133325_782613_16ADFB42 
X-CRM114-Status: UNSURE (   4.74  )
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


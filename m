Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD4BD3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dxCb3bDtYS0Uuj8z/5tz1YDF37
	vUFoL+5KTCE04mChFxOEBAAwQCsC9TRz6JxwF6dLAwX/ErlLZ1AzSXMGIE8Ha/7K0PdJWsKmSVQoR
	IlKfNdWH3k47IGpPg14K48JJvE4QvkWpkZN7A698g6hwofTnFsRP+zd7kkBQ4UikWQWn6dOZ8V+Jt
	JDEV7aoTy8ZdCRS6pb5lLfYXmJW32PirD8MqvoWV6ywZ/JJv4OkJ/tV12jGCPmQdutZd2PKPN24H2
	wrePp525ySXashDfDMVeyyuuISMa2u192iScGzZ7tPROm4BWqYEBmq14l3GV76B1vzfiOTIkBaJBp
	kkzJCPlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dbw-00000005V4Q-2Ews;
	Sun, 20 Oct 2024 21:37:16 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dbt-00000005V40-13hQ
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:37:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so42102605e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729460231; x=1730065031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mjZM64Mpicu+j7+e2cu1SNng/OotNMWh6Ho7NTNI/IxSQBODJ1W4LFMD3nnzIzOCfY
         wTnr8d37m1JBXnl1FQXGi8WEtH6DxDRJZ4kww9Lk5r08yeUayocUuTVDFs+kkl7HYe6A
         JFJPVYnTFWKg1sCbvD3FDLFCjpMX5uVksCrZa3o6t9TVeX6XhMIzFwNCXIMuaWIDVl6i
         WKzmHW/SKvGcel0C3qO941SF00ASKkYtOlMu1tgV09F3efCgLgBBO3B6kB6ZaVw5XZax
         jy0EHPz0SriwrFNcN8Lbsne1f242gRyEPJ6Yv87PQZm8cx0ziHj2+MrTKdo1/jgdtTwP
         fcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvu17vOmjvzG3EBVFGY8HVhG2HOltfEojpXT7Hspo5x1Lrl+lhT3zR2O70icXGvUuln776JOnK22Ia@lists.infradead.org
X-Gm-Message-State: AOJu0YwBRw6s16SJGpaUnb8ju4AP9ghms36LUZx2NT4JlAsG5cNbgSFD
	JU1y/Vn4ru1DoNMoUDdrPGeLghOijhpawdJTBcwJPdOHYEHeLqT6
X-Google-Smtp-Source: AGHT+IEgOBqP/yvUt8O1cqf8buTpIpkOKscZ4YG7inVsxZOxlZWI/Huf6E3Th4FIPtYwTIU3wJmROg==
X-Received: by 2002:a05:600c:474e:b0:431:5c7b:e939 with SMTP id 5b1f17b1804b1-4316164160amr81911325e9.18.1729460231207;
        Sun, 20 Oct 2024 14:37:11 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cb918sm34831125e9.41.2024.10.20.14.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:37:10 -0700 (PDT)
Message-ID: <052b45b7-44a3-4a68-bbd3-91c96fae704f@grimberg.me>
Date: Mon, 21 Oct 2024 00:37:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] nvme-loop: flush off pending I/O while shutting
 down loop controller
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241016030339.54029-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_143713_298217_DE103240 
X-CRM114-Status: UNSURE (   4.03  )
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


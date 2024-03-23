Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD1C54E67
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dzFAQVPdsHWYiL9EiGc+oVbyFQ
	40dFskUwI1l3P6MFRZos75RTp5WgodgHhAKJyTj6c+GyX4cmI57uCSL+tQbSiCyLLfnt6kV88eIXa
	YhC85w9+yeiZp3W2FFJOMNac4AOOoAXfCZTtOTPB1jOudc4hxsD110A5XXv5PDN+Kj7pOsViK6b6G
	h3ULbKAO5Y6zAZdf58x/7xjHI5+dFDyPcA6KLSTopCDwcp/IB8rCBtHP61M7kz6YYzkboH6th0prj
	FUzhP1LHTO7jyq5vulguUJnQrIZCvRngGgBJP+5bgPkIpSYnmdLeegfY4pKh24dKS/zFNVWsLpaD2
	ttGAQ3wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7yC-0000000B6y2-2Vlv;
	Sat, 23 Mar 2024 20:28:00 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7yA-0000000B6wp-295k
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:27:59 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ec94c7ca1so214433f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225676; x=1711830476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rNjfNeVYthbXPwdItLrbNfwwVHCJzH86U7wde0CvknDo0K9bgCpjCVctija4NBR5Zd
         03vpUisRXbVzeHH8Ha8SLB0/Qw4FLjFOvaHYkXtLS1HjktrJfxbkkw91t2vZ3Iy4iD4K
         Ci77VFcxyf8dv5w8mrlTVGCxGXqkgvr4nqzQlRQsWM8nquKeytGzguurScpHlYJzbWxi
         IfOWyXFiSZBtp667pWqdcxZU4t3RWEGVQmDDmWz+2BBGonWAKn5IHmXxbOJGoSLCGqMG
         RRZzFamwtAPyuvwJG+8mEXZYlld3vbrxzH0kSZdARTA7eTCC1aqLxn85eR2aQuvysDlk
         /7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWb4vS25hzTp1WqWyAvWpV90dh3/y9nqqMwjt/FGniA18LT9bgBCjMlUwOtRalxS5NsxaWFfzo5d7Cq0gmH2Jy+Hnpi2guGV+vRVQS3214=
X-Gm-Message-State: AOJu0YwPn77qtKsqNIa6JjcbKaXAp0kDPgOmac9oqLbOBdPx6Bvv6asz
	PNreYPff4cyWXRIlKyYg857Vwb0F1kYQV7hJKr6GaTNt8ovRDimB
X-Google-Smtp-Source: AGHT+IEZewr5VdlhTZ08AYVkRHluD4p7rBq65UgcI4jb3PkPagWWx5iUnntPUB1IshH9S9+5EBydQA==
X-Received: by 2002:a05:600c:3c92:b0:414:7ed9:d5c8 with SMTP id bg18-20020a05600c3c9200b004147ed9d5c8mr2145300wmb.0.1711225676473;
        Sat, 23 Mar 2024 13:27:56 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05600c1e2200b0041480c36bc6sm2714888wmb.27.2024.03.23.13.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:27:56 -0700 (PDT)
Message-ID: <3248f528-f82f-4796-a04e-cba40adc1fb6@grimberg.me>
Date: Sat, 23 Mar 2024 22:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] nvmet-rdma: implement host_traddr()
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-5-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070333.3820-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_132758_568501_1AB3B875 
X-CRM114-Status: UNSURE (   5.12  )
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


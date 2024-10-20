Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A21D3C935
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JzaJrFEITAUo2gw6aGAM1XkMXg
	YPWyL0Wr8fthzx4yA71sNn/auVf8WYbrlIA/87xQixq+Oa3a7RzN5E2OGnGHzG8vaDLdr1/rJNv3g
	wE4fEvfaF/Cy9nmqX93ib2BpSLPlyrF+4gRTZCwWE3vIWZGhf6SpjyhG3oep1K12kj7jUFiz8eLIH
	/O6U0oZ3kYeWct43C5V6kCMgkEnv/SPCARHqmVDGfBzIrzw/swIIeuD89fMuuGc7VyrlNvoqpgYTt
	KWm0M/9yJhx/SAabIq+mErv/KyUat9nZswgZ4aK0oH5jf0zX+7/0g/e1/tRJpTp6pA9gCrSL0uiwU
	pjO2scYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fWD-00000005dUn-2u5k;
	Sun, 20 Oct 2024 23:39:29 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fWB-00000005dTw-34Lx
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:39:28 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so37179315e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467566; x=1730072366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WfK2Hw4jWgT9w/8oFNOBzQ8eUXtJd2RaArbRdC1kJMJUSLknWWL+EwAwDt6BDTKhex
         CbabT4ejXl3crVPaFXKyJzL1IAF3RiiKM+P+buZsyMymjQzVGboiIgzoTqk2Lep22cnB
         fgOWRYtBPPUXJlRLF9m3gxOi5nhe7xpNOjaY70huM5NHAAZQcet15wtXKqngn0cFqiTX
         ljZmgBRthodkcx4anCETaGEc8be9YZ1Csyh00KsvXtrIh6mMRyUC6wPnUMqHD+HOcPWj
         TLnNblgE3oR1RE43TJbrt+vNdKdch405PPsUw4tQ0eVa6EUqmbbMH2Rso62dYH1Qcfpe
         ziHA==
X-Forwarded-Encrypted: i=1; AJvYcCUbaHulUV2EMD7IhPvZDiolTUFyuRMxamcvieKHwd124fO3ZtuOV6ytALUG96BXtLLQYbxnDtb8SrYQ@lists.infradead.org
X-Gm-Message-State: AOJu0YxIQN4WABAkoXojmLc9M8mcvBP2QdNWkpeB4BE9VEj+PZFuE9P1
	cF3kRDooENkdAAyUEJWbVUzICEeL9M9nP6P85PZ9Ii0C/iCb7Y7Q
X-Google-Smtp-Source: AGHT+IFpVNllhZAWz5TUc76GhwnmWRVrtSnyaBlhlg/sxGtJ6nQTF4y13owMK30lo4MZeptn/KvoAg==
X-Received: by 2002:a05:600c:3103:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-4316166c23dmr75617705e9.21.1729467565821;
        Sun, 20 Oct 2024 16:39:25 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cbe7dsm37849675e9.39.2024.10.20.16.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:39:25 -0700 (PDT)
Message-ID: <0ccb4c31-f049-4911-a22a-59490ad2b3f0@grimberg.me>
Date: Mon, 21 Oct 2024 02:39:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: defer partition scanning
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20241015143136.810779-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241015143136.810779-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_163927_778613_A6454AE7 
X-CRM114-Status: UNSURE (   4.05  )
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


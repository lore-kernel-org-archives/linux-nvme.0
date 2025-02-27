Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16A4C021BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WXd2exNDTdTCl3hUaewQrG9gEZ
	uxVZFmuxtWsDr7tCA9yAYEKp27xv26gc68cRmms6iYkrycBSV3zXkniBBvHdN24pKAnSjPeIbniqq
	R79XBa8dZw9KRivvzwZxghyP1P0cE9IUJuanG0N1WI5v9l4i2L3mAr/HqVD4wyUWS+FI8mBZC2Op9
	3W8+WTsnXyvIwmYjK7cAVPQN/DmZrrko3CVAeKUbiFG8E/WooCTQ2fsN3Bslpw6rYc7NS8pzrYudx
	aJ7IJhePXotlQSUqVZy30dk3zapwo1mASryV297HjkjWbNp+kAtk2z/waqywdilxrWtiuzHKKpiA0
	9YmSSg9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnamT-00000006wjT-0yjI;
	Thu, 27 Feb 2025 10:06:13 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnamD-00000006wfk-2pax
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 10:05:58 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so378325f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 02:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650756; x=1741255556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Zi+RwUfwfGTUojUVZ3OR/vUC8RzIVKeYFCQ7O6kehOlD6qCAeyMIGK0YEnqrUuBkAL
         IKjRi/bVUGX44qm1tdHDI6oP9BZUkGpOK3jKGwmhs+ugN7pupc76LWGf0dN8t2CtlhI0
         7zHLv6Ja0Sw7fKiayXZCJyzcPhOKj3QvPKleL5qgOfPnF3tIUMbYh4RFWTKH2RVETv+b
         qq7Gfw/l1oYcqCBZk2qESmXFSjME4KvOH/4ZSQqRjMhmZmExx12jQav8Ni/4ttKEGMjY
         WrIApf/fZwU6lEhYIJqPjjiJsxEHdkGqTakQbdkm3Zvj0lFGHu/nWCPJhfyLWPklyEy6
         YagA==
X-Gm-Message-State: AOJu0YxLG+vf6ckDapnxeIYGGCIg2pwDGQ9bO4aAfyeMEae0enqKfrYp
	oFnMN75fMT5rDqH/sxnU9o7ZNcPRdP1PJR20bHAGq6yheGbq12NSF0N0kvrx
X-Gm-Gg: ASbGncvhNoCrBSqNv3uYQu9+ZBwsB2HcReh2X0ngvzYXuh5ppLTMLsGZMycjAvpltRt
	H3p/EfrKT9AOl5k8J4KpdWGFV1Kjj5M9Ak7zsFSng37VkvcUeftMZczxQVSIPBID9JVHEBrE25f
	YyKMLAiCNb84MUkyrCyRibr5aVT1mbCzS9kDVEb4mw6qzyZjDxQf1fsjJhRT9VwCB3gNbffOhnw
	jUMm+OSMby+fwPUg1sw/AYJqHIYcCd1NcVETPTkjlS6nNj2P/T54S0AvkpDbdu/BKf6gfP0De9z
	KldGC94T3PgQqQOU7NF/tQtrI5wYv/q47iQ36iAmpnWoedqno4sOHjkbgLa1IfX7G5+o
X-Google-Smtp-Source: AGHT+IFu887HBimRbqkcpJ8Lz4ZQhBlKH83i3RNEaDtglVfaPyUmJ3FhW9q+jh2+FSS5S7Mb4Uh0Xg==
X-Received: by 2002:a5d:59ae:0:b0:38f:30a3:5208 with SMTP id ffacd0b85a97d-390d4f8490cmr6544022f8f.39.1740650755805;
        Thu, 27 Feb 2025 02:05:55 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7371701esm17605315e9.17.2025.02.27.02.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:05:55 -0800 (PST)
Message-ID: <a124d30c-2eec-4fcb-bbe5-dcb2dc7d59a3@grimberg.me>
Date: Thu, 27 Feb 2025 12:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix potential memory corruption in
 nvme_tcp_recv_pdu()
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, mlombard@bsdbackstore.eu
References: <20250226134218.800559-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250226134218.800559-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_020557_702920_3E9D200E 
X-CRM114-Status: UNSURE (   4.79  )
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


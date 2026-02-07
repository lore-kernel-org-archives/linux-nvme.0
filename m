Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B119EE0AE7
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vFwQ9YsvhqA8j8UM40FiYVjXjg
	3D4XRzAXMz0V9tYFCI94ufjs4lvJfrl5nEp7VAps7SfU5WPM1mSdaQ3I1MJDe6X+4JP3wlvhYdPw8
	LqQU4b0u2gv5GdZ3pBHXtNgXDqRRHRgGenWzZEAclBEaFFeEpFI18od27szaTFtebjvi/4xXDF4eK
	l0bw3z4GrEc+k4DGFf9R4Kje+H/A085P00isbeS2d3i1r9QacUJGZgPI1hJwniRcin0y5hlFIkTzm
	Z80tbf+mrTxeWiOA1ieOjWx5MesOzicJRs1UbD42QTJ16EkvhOd3nMlxGOYI65IN4sJ1sULScxwGz
	3FJoTTpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj2N-0000000CWIe-1mgP;
	Sat, 07 Feb 2026 14:11:51 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj2K-0000000CWI1-3zEW
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 14:11:50 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so23656575e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 06:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770473507; x=1771078307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bga4R3Z3uzxVx6H/YGUvQ33Cd8KjTNP5g+8R7bSc2mfaSO8i2f3IwnM94yBrRgR/Py
         2I9ylyHIf0rwDB53Psl1k/O1+NO+qeB60XU7Z0nI95oiLfH10TF4uc5hwsK+V08tEfkk
         /eusgnaclYtilTFZoy5nRbFArfGL+iIq25Lzl/VEB2U8dYi8gqty1Q7peA8Sodf3bBBw
         +P984nUc4lkNGX3WSZefJ44gpEDiILZnBKVLw3f9TpTDkRhNxnmKataQJV1/9M9tNjMj
         yP4+8AGd5QV8Q8gR388F4vyNxaFQmP00nn+YtygWKPAiZYvnMqIg/Vi4ihawfqkBsyRa
         2D/w==
X-Forwarded-Encrypted: i=1; AJvYcCUTXpYGHhfIvdlFuCCmDzu7GflumUvvlsabSmM/5ZyhFkrRC2nQfdKd4loi6/iAvI6SuK/K3psr52rc@lists.infradead.org
X-Gm-Message-State: AOJu0YxAhhohBtCp5f2qfp2I7KzlYRhfC4jLr95lpTpgocegpHiZW3DF
	DqP6FU1M2AZ4s4zOfv5Ma2AtVCv59R1CzGF48+rrNyTLxZS9/DqX9WLS
X-Gm-Gg: AZuq6aJoDCLsjZkzTRmQH5qUA7W3RUMwPSHERPp9LAgyAXRy5Ewxophfjf0GECire7W
	qZVP2kBROa7Y04LjDiR5SO8jgTtmRT8HcsKz4k9MAU86iXMkNosloBtTTIyOkmykasq4QkH5DJe
	O0JNrrfwV3SKoiq+bHN3EO5cMK3KM4SPq5HS2/44Kb9EHlkyqiQgZEg5ZmzDdWpTfm6EMC6TvLs
	1szd9LrFRvsxVZuXICRpBowyCH5V9HdHIq/VUyvLcHNt5CWLIr5cSMtnjX1uCqbCnUve/zV97fl
	5zxRsP06Up6zzLBgUEXLZRIMUNmsmpjuf5hKm775aVHKajEB6CmsUxcOp06/HseY1Kmn95VrWce
	BnAaYQW346po/FID057eAPNmb7Y3W497QSpuGPgCAoUFbObwUYtsSFmoO7lUTs4zrOX3rDvEyfC
	04Pr9dB2ap+FoOs7O4TKDPwXPzIioEe4SqXPOYX8BvoLb3a+WHSpxWSA==
X-Received: by 2002:a05:600c:4745:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-48320227106mr89099595e9.33.1770473506862;
        Sat, 07 Feb 2026 06:11:46 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436309ed238sm8262484f8f.19.2026.02.07.06.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 06:11:46 -0800 (PST)
Message-ID: <63b56f2e-dc21-4909-908f-a329b1fe1b83@grimberg.me>
Date: Sat, 7 Feb 2026 16:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] nvmet: Implement CCR logpage
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-5-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260130223531.2478849-5-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_061149_255839_D453C40A 
X-CRM114-Status: UNSURE (   4.90  )
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


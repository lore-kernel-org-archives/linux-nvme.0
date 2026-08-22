Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D40C5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WXhxUZlgpbpVrSHAjq5Me3JOP+
	AEwLTq260LOsEpwIM0SV8vXW4srADoUPWB35l9MdCSIzr9m83VO2ZIdX8+csm2IooW7SRn8Mtn4Uz
	+TH3mAkU0bdlOyW/mwyKH+7cC3TrenqRyGLC2WwDc8rj6gGUVWxrIpdi3RodysGZWiS5PO1V11Ylb
	k5J5TK6jxKVdrblPYloVzObAMIfGHL6RED7VbCI/CtOEqiI7fQnxPuM48uHUiHfjP9C0wOE/kHZ3j
	h3JMA2xMyH6mHEj1yKv6viBqnIu7mCCuuPvVE0mtenOSFl4qcuhMaj7QTQABx/WpZw9zS+WK36oaw
	8FPazQww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtGX-0000000EoON-0e2X;
	Sat, 22 Aug 2026 21:28:37 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtGU-0000000EoNh-3wv9
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:28:35 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20e70a0962so331217266b.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434113; x=1788038913;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WOy1GFNDfoEsXEZw7u7WVVnESJ7LSP6hQqyKLKB5t7xeNMc8co/g3cFfH+p0Q11GQV
         /cpO3Ko1NerugMw4367R9FMUr60L7e9fzthHaQsHqfGHe0A3TgbbxBqcwu8mxmaru9NP
         n4in/rsgMHklnO5L4k9d4XUCiWQ0DmC+CByem/YXqnrRGAXsjZynA5h6DTEKsCbrhNP7
         mHM+iRXqUbxmuZvnMf6VwjFNlV+/gNbQKJFYdf4CJ9hxWR7HRILtL/rlEqy9Gw14irTh
         oWYhi55qLI98PP7MEzdOjqiv1/eEI3JVrKx/DlMwJ0EbyCL7wmmI4CdnRh2tByGMtQ0g
         57cg==
X-Gm-Message-State: AFuF++ntqnmZOfLoBnGOolAs6CXEuyQRTnw3I/4NKeYW3n1iUmo/rIsF
	SXsIBoLecAndnaRtS8j9fa1qQVtvZYDvVk0NjSY2yzsbwMM9wq0yMd/8
X-Gm-Gg: AR+sD11kz1iFwicIJWwtlYKRt3yoG2xLQQD9+6UHPCrKJSl1Ubv/5XjpZbNyk5Z8Ntt
	Aw4Nl/teUA50tKLvIuDPseTkjG9KfKzKb4l4w62RqZxJXMuSf5MoWQkFOaS5iuFvGk1DksUwAoB
	6O+vQN8pfrekapprYFClThu207kr1WFzQ4VbdKw/TnVPh/TxWy0UL01ELPxav67URxFU5s1dZqs
	M/IOhpn0i6Lkf1yBRXLwoJMewsr7HqL05W0PvVIp6/azxUTl+g7JJnBsYWqgBbPpY+bkjCTNvTg
	jO6A0IOtUKwd+qDvxac6nmN+ehaZoIxnN/s2FwqaSj3Lc73+SoMrMo3oWJtRJzTASQmRYWCsajR
	MiFcOLpJR0lLjERVFfV9j0qaggG31WpFz1QZu/yWuI+FZumWlYTuCG4Scz6BAG//gKIamLrwQQr
	LfstbSxU8b5fsc+699vD0nQUbfg0Gh17TM0/OPGeMGZ0cJgY/rBv5VAXWuRO8ZIBihp4tMafw+I
	5jQXlKnToOUor1SvM83oBk=
X-Received: by 2002:a17:906:9fd2:b0:c08:417e:3696 with SMTP id a640c23a62f3a-c246a710358mr1721283966b.20.1787434113091;
        Sat, 22 Aug 2026 14:28:33 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm475782966b.39.2026.08.22.14.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:28:32 -0700 (PDT)
Message-ID: <1c7da2bd-a735-493f-95c2-cfc4aa738066@grimberg.me>
Date: Sun, 23 Aug 2026 00:28:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: print namespace IDs as unsigned 32bit value
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260821230310.3937527-1-mkhalfella@purestorage.com>
 <20260821230310.3937527-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260821230310.3937527-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_142834_984804_4AD74319 
X-CRM114-Status: UNSURE (   5.51  )
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


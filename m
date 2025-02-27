Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC73C021BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QQGieTk6R0dx/mroW1vjOnlJ+V
	vULRnhA44T2HCCV6u26TRroMJtgDbF6k6CNMUKyF5S1UFoSvMPwBD5g5n81KFOR79O6qZl+q2NlOy
	Q1jV/miB/ktgLhbttklY0HjTQGFPTMIuZ3f17h8wk0u8LPoEO5vRUrKjMmwtakbEbVY1yfrck/0dP
	BfE9V12fOE2PYbJMK2mWae4O6trtkbBwGRrLgUmb9wuqTxZm72aGz+d7HF30CufhBBebr47wiZnRB
	OhjSvOStVacaUJbLEuTZptMBg0hvmu9YBCT2AHKd0rNIZPmr5PwWrRBlY566uCVIyjM8e3bfRy0Ls
	LNyDu1EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnccn-00000007Hgs-0Tlx;
	Thu, 27 Feb 2025 12:04:21 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnc4X-00000007BWz-0JOc
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 11:28:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f5fc33602so564399f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 03:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655735; x=1741260535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WzyJfArUiZABeUFlzeaEY1SyQLQ8MTGeO8tED9AiSI2jfIkU+DqhnXDuHEyLEpAQo7
         F0n0py1rtmno4PBniHQp73omM89Tmx6pDeRTqyJeh+86bs45P7xrYBAYkuVBSfypbcI3
         BPowBcO6MTwTjjCUQ3jqmC0gZDQV4LKzbW8RUQ3OveoUyOyKzjggkPDUZgWTkyqDrjFk
         pZeAyQdAM8GIbby6Yt+wQzeq3qeaAAcsiW5bJmzDjxN9hxLcD+sd+EBrf8oOZs+Hzb5e
         WbbG/Vm1l5rTUswoB6B2CYFuSUM7m/4vtaD10eqSzz3BNFwrlIoKiEsEc1HqWROvPEUf
         7ncg==
X-Gm-Message-State: AOJu0YxDXjzUn9Ls451ZXAFOswJcbpkeicYBvuG1FMDx0vPCi6E015Tv
	WCSXNfWHDKj68TtSFpUa3DAZLJlLokszDuTu7fdNh/rZaBiGvOfVe3w72ubB
X-Gm-Gg: ASbGnct5t7iP0I8/XM07SnbEFagzOkm4gI65lBQwaJzmgEzgUcxxn7LvoUlvKpqEGIq
	58vXGpMlSVO5sQ/oLboOK/ZlQJjE09usqTbsSFW3aZ8EJyy/q2cuo5GYwjcw5Ra1qbRgfT70W2/
	4HFqR6p067tNyNGujrcj9XvImFT+XataEOYlMQ4NOgCV1ABmCn6/8B3MIy//6LR7c2qLOCPN5BF
	UwmYFXyNK/H6bsPI5ydM0owoj2dUaXo/9g0jyt26xYQ0lgKa19IOsQ/YnNlKcAU1Baa55zMEkLs
	yPwV1lOVvsd078+ZpeQhuDea0fpEW+QJeypNyqnlXiOBNeXv0pJ45XfaMfrBJg==
X-Google-Smtp-Source: AGHT+IHLsKsQ6zAE6n+74cjml+lUkWmHN2goDTX8HwZ0ASaZHnKZCWlRsuO0iiWh9F0/DJExCSA4dw==
X-Received: by 2002:a5d:47ac:0:b0:38f:232e:dd5e with SMTP id ffacd0b85a97d-390e18c9426mr2730334f8f.22.1740655735350;
        Thu, 27 Feb 2025 03:28:55 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844adfsm1730813f8f.62.2025.02.27.03.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:28:54 -0800 (PST)
Message-ID: <1107b39a-7f22-40a3-81b5-476839afd230@grimberg.me>
Date: Thu, 27 Feb 2025 13:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Fix a C2HTermReq error message
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, mlombard@bsdbackstore.eu
References: <20250224144058.693927-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250224144058.693927-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_032857_110029_8DE8BB7D 
X-CRM114-Status: UNSURE (   5.04  )
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


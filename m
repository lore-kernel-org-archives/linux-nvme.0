Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CDAEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bAsddR+jVmFAzvgtlxuMFEE2KhkgoPbVN+pSO+lelZw=; b=2I7nFcBDDqfp9fEsSmnMD7Z8S7
	RnBjctTosgLR/R3XkAZvqhDdmzNyFhGFNbjZ+XTQ0j/99cmK0SxlCmjj3S9HE4BdGFdRqKC8i9d+s
	+KKtE9O3m0NZjg+CMaijMgf6rV4dBcUKcdtSzhrOfLX/rTK7OYrfYjyClZQi4wXXInvyS+ZWFTPhw
	MmLKOhbmkrW7MmBvXNyA1N7fXFB0EpdW0pUm9hFbJfBAnjtmA4efnQUnZjKWRTqH7gVNUsNaM9+74
	5syHZfqsFOUSifVAi2c/6oDa1DaTG3NRblSYGNUn9bd9sRBF/p1wxLOPPoosdQ0IRE+2onMdoD1zp
	K8esnFPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBhq-00FCRp-14;
	Sun, 13 Aug 2023 14:04:34 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBhn-00FCRH-1Y
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:04:32 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-317604e2bdfso871665f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935469; x=1692540269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAsddR+jVmFAzvgtlxuMFEE2KhkgoPbVN+pSO+lelZw=;
        b=Z0HxAIAl4gliEEgBjLeYbwpPgCxoLI6ymkbjPjCaTWRiH/7RsDUa6BfaLgGyHSscrV
         9no77SCTAitNFnSwuL+k8q57mCv5XEOU2xqd3QrC2m2w9QqG0/bTK2Uv6pbIuj+FBZLE
         sut3iHcOGlc8dDvknlW8LRUZ5Sz2c4tqyVXXm3FuMAqp1N+yfeUNp6jwIv6oCzino8LE
         zZIz1Hwi1vPRDG0LKBwCYMgOfLvGRb4PiPbz8PQMVeCfU5RXY+E2ymp/je860BkRPu6A
         xH3xBagyVDDgnADyvPNL6zw2spkKvRozijXl0Tt13vwc7V6qfpRjqNZqxfXYPBrqoxF4
         pP9g==
X-Gm-Message-State: AOJu0YzAG+exOYnzjlHqoSNpRxz1/97w/K+EHktT6Ae8K8L3FviDH/iS
	Rcu7GFHjAHknBTzrpon/t6c=
X-Google-Smtp-Source: AGHT+IG36UZ5ZHqk3SFV7IS9EN2sM1NW/EdVfaO9OtPGbpUmfFPXojtu7jtQg0IH4XJYi0n8eVhpAw==
X-Received: by 2002:adf:f68b:0:b0:319:6ce2:e5a2 with SMTP id v11-20020adff68b000000b003196ce2e5a2mr2828874wrp.4.1691935468082;
        Sun, 13 Aug 2023 07:04:28 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id ks19-20020a170906f85300b0098733a40bb7sm4623246ejb.155.2023.08.13.07.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:04:27 -0700 (PDT)
Message-ID: <36886d94-b6b9-4147-6795-03adc63c7b71@grimberg.me>
Date: Sun, 13 Aug 2023 17:04:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-18-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-18-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_070431_579100_04A890D0 
X-CRM114-Status: UNSURE (   8.10  )
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


> @@ -1705,6 +1772,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	}
>   	if (!status)
>   		queue->tls_pskid = peerid;
> +
>   	queue->state = NVMET_TCP_Q_CONNECTING;
>   	spin_unlock_bh(&queue->state_lock);
>   

Unneeded hunk here.


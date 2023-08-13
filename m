Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B03EB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/IOYqnYoR5gtf5lH6c6YptleVOmBT9CB02y3etRVezY=; b=Q0uGFxvVT6LR1VsLdIZdb6kAsy
	7x7F+efev+T1yzByTcknRYKqa2m+1aLa1VYLGpnWCqPuUslBaEM0fxrw60ps7WG4LxG8TdcBWl2nw
	KQgfQAhmWaUgGb4mXmd/DoCUDCFD+t+EafRChZWiaFJeBcAMx0iQAb7kupEWzLUr9iBITQYZP88AP
	F/fLMU8BwB167KMo0vdE3ZtTqFBQ2DP8fL4ojhnuRtfIeKopmXILkmXLhaI6c+LQjSm/6Lz7Q02Sn
	Vlu+7G7FZighcRxtOzthYqNI5t6kI5mwnibhYtJnJUa3YhFmhoIQxsTmVgNW19zf1TwNt/lzPPGFM
	r1MPYRFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBVz-00FBP7-1a;
	Sun, 13 Aug 2023 13:52:19 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBVw-00FBOc-2L
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 13:52:17 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99b4865ad55so81107866b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934735; x=1692539535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IOYqnYoR5gtf5lH6c6YptleVOmBT9CB02y3etRVezY=;
        b=i6qHeZCZb6pYgHRvrk6t1/8z4bnlB2mnT15RU3lA10XHTlhtN3o6wFOitCiPIQnq+a
         tVr3/SMJ+CDRw7hHztejg+nvtKvZ3vtzqtG7G9wTEsh+72fA3Tho2XC7EZFe7DhatpHF
         vEQXSlMfwh8UTHsybAh5sqC5BQBe/UZjwgoEXgJwYEu/cf0C6e1mblzA+C0aHKO16B90
         C2Tj/VWpROls5JqYIgRaIkaibT/JDhrsfUZZpUGQ8f2/Mz+1uQkwKo5nKwPo5XNC1Kyr
         xGkaUKKVkdSaRTQbwUxjdmDO/isgjc6h3dLilklGfk0LkItZzvx2KUeCWmSEdMay3pYx
         FVHQ==
X-Gm-Message-State: AOJu0Yxl+quYAjJkV9tRpEZnWcGICAWah5gH+58D9ZNBE7+cS5q4kH+J
	0cRbBkA40rJKZDaZAvs1Zz8=
X-Google-Smtp-Source: AGHT+IFKY3gmiZuUmM+fopOwnlK2jWbDppldax6PCcLwGf0E3PvMf8gzB4oPxT8TAx4Z5SstJ5+a/w==
X-Received: by 2002:a17:906:7394:b0:99b:d682:f306 with SMTP id f20-20020a170906739400b0099bd682f306mr5017687ejl.4.1691934734514;
        Sun, 13 Aug 2023 06:52:14 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906858200b00997e00e78e6sm4593122ejx.112.2023.08.13.06.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:52:13 -0700 (PDT)
Message-ID: <6746b78c-3593-468c-5401-8b1de79f0a8e@grimberg.me>
Date: Sun, 13 Aug 2023 16:52:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/17] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_065216_762178_6B056549 
X-CRM114-Status: UNSURE (   6.45  )
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

I *think* this looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


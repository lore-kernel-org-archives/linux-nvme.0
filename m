Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C41C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LMjfY9UYMjWL6dm7905skNAQCrE1/dBAyB7CzPbBVNE=; b=sRW+cMTpCei6YdaEYKv1pB4Ez+
	Mw73cHY9gk6yObqD/RtXSHiPHRMXMG9uYK/D63vk094H+ABt/Y8xUuxOxzQ+kXVtdB+w15xh3NOP+
	MCMV5RONiclcqA4EyxKQaqpIyMYOG6xbB7TOBCVEuKM6KhBodrNv3fQ8xeq0Grderdf2Pb6OeJ8Ex
	wI7ac6sCX37CukQhXYEBuQHdw3brK2tlEJuhUO5mEKwAZHizUOyztUgMhHVd16HRME7LspImr3MoQ
	Vf8ECBy2WQ8Gx4GPZGZtsO0FpkyYqAk6d1YZGX9UIFtQlvlm7Z8qwfluoiygQdhF+B5dwzLO5Aeh4
	/Kqj4TNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oneBH-008zu0-QG; Wed, 26 Oct 2022 11:02:43 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oneBF-008zsX-GP
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 11:02:42 +0000
Received: by mail-wr1-f49.google.com with SMTP id v1so25675970wrt.11
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 04:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMjfY9UYMjWL6dm7905skNAQCrE1/dBAyB7CzPbBVNE=;
        b=oPTnT/DNstBOJpo4BekvLTRpetCWpu+sbCpkSEmAbulrnlpTNRRvd7R0L8ME7u3kFF
         JKJhJY0tDlVscLjpBsXAngB94hdosdZbcIItiyJGgnO5guq6dcAY1BL//OydigCbrW9U
         thnCcaQrOg0QKd1m8bluppORgPz4PYIWh9gBN5xfbjc+VnMAaPim1lTnwMn9gX2yd1Gx
         PIgTd5mORbMq3Ni/+dcapMTZOzuDJPCAhdPBhGPbNAyQIcqe89tgpJfhw7Mjt8SwqdiV
         OFDHPVIXjo1FmETJPa1TM4gDgNrliniF7af0K1m988rloGCfvfcGDmo/XvtoH2EFPJQN
         EAGQ==
X-Gm-Message-State: ACrzQf0g+Hs+RvZyKcyRA9pD2ARxzZ7FkOfKWzXwfrRL5qtES2YDLucB
	MrHev00ybf0uDvJzBm0aVIY=
X-Google-Smtp-Source: AMsMyM7kn+Deq53dx5kuzGh+Jm5M8zS0Nq0FyeyXkh3sz5FDwwFKHLGGVSZjt64MCyyH1k0jyN1F2w==
X-Received: by 2002:a5d:5c13:0:b0:236:5575:a3fd with SMTP id cc19-20020a5d5c13000000b002365575a3fdmr18119108wrb.475.1666782158532;
        Wed, 26 Oct 2022 04:02:38 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003cdf141f363sm1657727wme.11.2022.10.26.04.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 04:02:37 -0700 (PDT)
Message-ID: <4a721959-c3c3-4377-d1e3-7fa7d6c3e814@grimberg.me>
Date: Wed, 26 Oct 2022 14:02:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 04/23] Revert "nvme-tcp: remove the unused queue_size
 member in nvme_tcp_queue"
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, smalin@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 aurelien.aptel@gmail.com, malin1024@gmail.com
References: <20221025135958.6242-1-aaptel@nvidia.com>
 <20221025135958.6242-5-aaptel@nvidia.com> <20221025161442.GD26372@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025161442.GD26372@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_040241_568677_5F96D546 
X-CRM114-Status: GOOD (  10.70  )
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


>> This reverts commit fb8745d040ef5b9080003325e56b91fefe1022bb.
>>
>> The newly added NVMeTCP offload requires the field
>> nvme_tcp_queue->queue_size in the patch
>> "nvme-tcp: Add DDP offload control path" in nvme_tcp_offload_socket().
>> The queue size is part of struct ulp_ddp_config
>> parameters.
> 
> Please never do reverts if you just bring something back for an entirely
> differenet reason.

Agreed.

> And I think we need a really good justification of
> why you have a code path that can get the queue struct and not the
> controller, which really should not happen.

What is wrong with just using either ctrl->sqsize/NVME_AQ_DEPTH based
on the qid?


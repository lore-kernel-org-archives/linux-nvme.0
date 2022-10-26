Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E892CC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=w4F+nyA7BRf0zU4IzBOcgyaniz
	iDsfFbRjSbK1YK/p/Nvj1FpzbhG84icy/KooA8C5BYgFGquuAgw4OOGcPdZrDpZ8NT2uYpM4CYktB
	kfgG88zlmuWmILSSHOnrVv35+4KaR9YiVIRgWcrOnuQOQixosW29pJAtWEeThOuSq7mO28PsNvVJI
	ZQjGNZ/bOCi7lcKXADRu/ng24M3IkkWcTk3nRyqzwxG8EUNgmPyBCHAG8UJmNFxPs6XYqlsYSFeJU
	N2TUgAHuSLZQutfvjje1rb7dihkFkdd7usPnDYc+YTrBnmeYi9FNaRBPTSWD559L7gwyKVHeOwWsg
	dGUOw8Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onflP-009Ej4-2u; Wed, 26 Oct 2022 12:44:07 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfhR-009CbS-Sw
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:40:03 +0000
Received: by mail-wm1-f51.google.com with SMTP id r6-20020a1c4406000000b003cf4d389c41so424415wma.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gxEGPstH0vDVMS2lwATxr/WPUVKdWZaf7eKgcC5/31IO1ydnTy4e6W09SJFTMkU7iT
         2lRnJk6IU0y6KJqu/ON6q4puEI5BBTEzqiSuaILdE26MVbsRVSmPH3yqz/D78l41dcDI
         iZi4zgYzr6kD33hPbCp7wYLk5N7aaD6plJTmjLBUcNy2R2KqmErtdWv3PxVQEygFN2Q0
         xkxaqokP/XkzEvh7EngrvQuYbC6uU7aocY873Yxn6kc8uXiFgAb2N5dQzN5x79Aqm2a7
         G628G7bRUspS/twEXWIpx+KJxi1nkBh0E07tCzdeWT35Wm53QCW+1WF6uP+gvsDs3jbo
         dUSQ==
X-Gm-Message-State: ACrzQf35xiAGf/eu0kf2oGJQQNcyXwesvmYgX2icBpLVAfDPkx+BH7q9
	MJgPk/NVwMULg0YEH1MZEqkB4RcLkfo=
X-Google-Smtp-Source: AMsMyM7rqOmWZX3SBMgIJK4VT+DcXle31VeUtHi0/7xyK+NzupYdd2xmp82KQS3XFa0kS1Bh/glsEA==
X-Received: by 2002:a7b:c5d6:0:b0:3c6:f970:e755 with SMTP id n22-20020a7bc5d6000000b003c6f970e755mr2307678wmk.132.1666787999091;
        Wed, 26 Oct 2022 05:39:59 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000050200b0023662245d3csm5250657wrf.95.2022.10.26.05.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:39:58 -0700 (PDT)
Message-ID: <8945ffa7-607c-e791-5ec0-3648628bc595@grimberg.me>
Date: Wed, 26 Oct 2022 15:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/17] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_054001_976953_63B172AB 
X-CRM114-Status: UNSURE (   7.11  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73300C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 07:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNoAYdGW52uAeLKeNmV0+1VSAmdx3xhtCtNvBXqRnwc=; b=UYZsBGOFsZbstoXog+c5uj7VZB
	h5L19uub7SgqrcjLkiPHbswy1elaJ1vOlIIu7feFLvUNXKVerxKaS/VeqLGbdAq9MHdquy3Gb492n
	N8W0UdpieNTNCTSfmKJTwvQCFQlOawTxlswXP2JV8BPqfvVPUNEnXm5se9cwJa0uOaDW3rDkNzMLt
	U7/r2MHZVY7MCSiSt0ULyPMe3BAwNjjvmr0OyWnuo2pACVR39uYGXhtEVB1a4ltg3IaiGnQYmLcgQ
	ItXYb0Bx1DFMpRtHknU29X/Ux/Q/sZiVtKqUVPL9mkamo5ZonQ6kN7hOTCj2dBTkekj/w9aDA9h/W
	kwP2k7kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pet16-00F1Tr-0X;
	Wed, 22 Mar 2023 07:36:16 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pet14-00F1T0-1j
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 07:36:15 +0000
Received: by mail-wr1-f54.google.com with SMTP id v25so12519642wra.12
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 00:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNoAYdGW52uAeLKeNmV0+1VSAmdx3xhtCtNvBXqRnwc=;
        b=cLSJudcTl1e9vZqka51qeY8dWCBhT+2vjYKrcvPJVn+EAs0zYsck+c2k1In8y5jWun
         EAhptdGSyzDbpsqRKuxWFvf+veRWXw9f3KMKAbXNoPlpa1JFT46zBY4mhtyP98t+00se
         I5H1nYRWEXVREdHsYn3EbKxjC6MK5MD+w162JCQxMXF3KuP8Rb3BvHSLazfLwaBchnDx
         7WJaJeUJoIqWU1Mwkw1ePRC4fRIpr1Px6J2npiWsW+3qxIzNrZpa940ppwWoXd8mMfeY
         NroMiwlx7N4OuUHo/RqHCwOlXtr6gS5zNQX1HKzpWOTUpM4kR/auaF1Y7XsQRj8BGGTe
         KE+Q==
X-Gm-Message-State: AO0yUKUVND3zc/mRUWQhEkKaIq4ZTwGZ1zlS5V4m1iaQ2tE7on2ZbozS
	PUDLIQcRGTxVjbVIrNuVSoRgZMdZmdo=
X-Google-Smtp-Source: AK7set9gxw/ptRZnz8Ssjjucs49QkDJwhPo1qRc3OQJBSaGukpZM9Ntc6xaM0SN8a5Cjrqsbtyj6rw==
X-Received: by 2002:a5d:50c4:0:b0:2c7:940c:26f8 with SMTP id f4-20020a5d50c4000000b002c7940c26f8mr3241888wrt.5.1679470572718;
        Wed, 22 Mar 2023 00:36:12 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm13275917wrn.9.2023.03.22.00.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:36:12 -0700 (PDT)
Message-ID: <423e7e1b-81f0-a4de-491d-4be189004bc7@grimberg.me>
Date: Wed, 22 Mar 2023 09:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>, Daniel Wagner <dwagner@suse.de>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_003614_570634_DB33FDB2 
X-CRM114-Status: UNSURE (   6.24  )
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

Nice.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


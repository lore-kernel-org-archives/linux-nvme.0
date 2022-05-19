Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=; b=dvgBL/r5c3w8VV+lQDJp0HsjIl
	ZxWYi7icOMff6Msn8sksIiqjbWrNpBeYKydG7aQqJJLkVuTTE8c7yGTJQTGPknQcHMnyuUdOm4IUs
	q76IunUXQWXHj7TrrAnnDxJzpJoDyLP3oxhPrA/fGLA08PhzbvitZGosd22QTIwNREZAZKOJG/da9
	CqAwVS/EH7t//CWZRNwHyk1d1Re5P/q/AgN39W/cmsLhp4gSJ64vDWGm1+Oqvlkjowy0sppk79x4B
	53RAAFIEzyuqJke5LUlLULp3j7xO3XXTuZzzUENupUSXC1KR5CjbBm+ZMDHyd20TsTxdzvinTqOKU
	FvKoXdXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrf2v-006cAH-5D; Thu, 19 May 2022 12:14:25 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrf2t-006c88-A3
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 12:14:24 +0000
Received: by mail-pl1-x62e.google.com with SMTP id n8so4636584plh.1
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
 b=p27yU6tdtyX4ZiycgPNJ1iNvzRs1b87/Voz0GLihHtppsn0VQ3J005iotBD+d8vcfc
 pSl70SwV2zgj2wW1XGGR3wzVPV7Ted5GdEV4zVKBunzNd7u8sjyc1eF/FWWXPgUxIwIf
 rp0p9c8opyZr+BSNShaf8iK1fu1Cbe4GNVcGr4uk4VJx3YUoRhpv0RT1/T/lPz5S7v4J
 A75Bhgl5CyQT7JAgoVP2i1Z78/9hWaX9YUb5WeKxD0xv9+85PAj0cNWCP3s0G31qjmJ6
 8diBYNnWVIkLmLoJXFzKa8Ez8S2M3Cog4RKVqWXlcK5ghGu7VAX+O5HJqzjgeyXisdvo
 GKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=J/AZdo3YK6FsmMYvPOANnKaQrNFnw7qbb6vl5sarRlE=;
 b=g/lY/xUjxhqfc+6vT5wJeo6QOsSv+a3704RuUqm9FimAjQomEntZwN++5F8x0OlXap
 nXAYafR1JCpMOB8kwHgSuDa2dgVUbmA+5LXAiy9d/iSguF+8Y7aSWratUuQVJ6//KaO3
 0/KEKkK8PvmlDCImUe285A0OPNnlcaUqdtcL/D2x7YiiZcTQIgjpYQn0v5rFCoj6wW+P
 aZPBhvaTsCUbLMjW3u/rfzPpPFo/1VIcdRBSnxCx7Xm4+Nxup1DfDuzzjTbglABbEEWJ
 K/sp9FancEtWABNxQ8l56UXt6f3w0brbc0ASno/qukA7Y27EYslx0pHwXB1iWrUtZ2YY
 hhYg==
X-Gm-Message-State: AOAM530m96GhHNqboM9ckI0x57kttHsgSVIo6IxE/G3Hofuv6H/RDT4I
 TPq9VQ5tsxdtwu4ojCHzUeOzfA==
X-Google-Smtp-Source: ABdhPJw2DRKb0mxn4KqbWP/jQzIrlt0CfwCkmk5n6p40P9UnKG1Hxulsj0NJK/Dq6iFqITKjk7qNMQ==
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id
 m2-20020a17090ade0200b001df3f94811cmr5442544pjv.112.1652962460260; 
 Thu, 19 May 2022 05:14:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a62a50a000000b00518285976cdsm3671518pfm.9.2022.05.19.05.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 05:14:19 -0700 (PDT)
Message-ID: <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
Date: Thu, 19 May 2022 06:14:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
 sachinp@linux.vnet.com, mputtash@linux.vnet.com,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_051423_378977_3FFC294F 
X-CRM114-Status: UNSURE (   9.49  )
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

On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
> Greetings,
> 
> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> 
> Console Logs :
> 
> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
> make -j 17 -s && make modules && make modules_install && make install
> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> make: *** [Makefile:1914: modules] Error 2
> make: *** Waiting for unfinished jobs....

Christoph, can you fix this up?

-- 
Jens Axboe



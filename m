Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D801BC55ABD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:24:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698BA206A1
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wOioAKgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698BA206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9bZSiy9cbj5meR2qgwK1hFRIasfRS+VBl2zjr4qEzdE=; b=wOioAKggbpyEsisKR0BWrPeHz
	ZrBMBhDhlsXEg4k6/PvZCwZUS79NzjdwCEpWY6Bn4YqMLoHQKlszyDRLxCqWLdqTATTCzYDfnioU1
	e43C60IAtvSTalWb28zoOAqu2EeS+vnBV/pVAYx/mOphC4QhQNBiUMJP4z5onHkLmmos+y/24bzrG
	K+oqaf7zRBiqW4cZlWQTgsVoBwbwK0A7QUOZE5e8N2Kqn1aF62pVIoemvq/Fm9sM3K+CaUJc8I2F3
	rNBnFJ3Ssle/6OWK8S7fJ83oI1t4h6z2gOP7Jl/IZALPn+ZO2x5QGjeHgyLQ7oiMsMEhXQ82hmnYk
	VA66OPe2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcGW5-0005dw-FJ; Mon, 09 Nov 2020 23:24:05 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcGW1-0005bx-Q0
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 23:24:02 +0000
Received: by mail-wm1-f65.google.com with SMTP id c16so1194837wmd.2
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4fYW7atqTCFeV0ZwbZO6DpnGkO9+ntK7D4Qq/lKRBTg=;
 b=lZwtIK1Y59rLm800qef8z1Hr27pVMjxksoPNV9soZEsTK8e+qLCSHpALThY9VgSJn5
 g+iBiNmN+eQb04lC8EPnp/wam/Dvi757447hC5h7sQOUfjaqFuEWz6NmCEjVJILxlGKN
 27D2WR29tmJZzegkM0LKZOEfQnvaJD187yq+00/ZOxAig46fpnS4Y62XEshBagrCXFKs
 DSJ9A7a1OWVnUVnoVComxtxjB5FXwcg2/ZVdi8hVq1LF6C6VDZw6epsBk4Z78TioWNOu
 A09zADobbNpTvSttBlw0+EY7wyoxPq49Dcvikx9grNKa/Ni06YwSju46Ujotfilhl1+5
 B9WQ==
X-Gm-Message-State: AOAM530i1XKVSXAqqLs0kR99U/jKg9Jc9Vej56mrycMvpNps8OwXzKZP
 SSrm+dXH1i1j13deJwaPA1o=
X-Google-Smtp-Source: ABdhPJxKUNNNYEHSscPU3HUyYSJ6LMGmPpaINmiRwm48+WreFKTG2CAqaCODa8p9/VQ92nXG9L2dWA==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr1605094wma.68.1604964239722; 
 Mon, 09 Nov 2020 15:23:59 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f26a:270b:f54c:37eb?
 ([2601:647:4802:9070:f26a:270b:f54c:37eb])
 by smtp.gmail.com with ESMTPSA id u195sm971656wmu.18.2020.11.09.15.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 15:23:59 -0800 (PST)
Subject: Re: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
To: Shai Malin <smalin@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-6-borisp@mellanox.com>
 <c6bb16cc-fdda-3c4e-41f6-9155911aa2c8@grimberg.me>
 <PH0PR18MB3845430DDF572E0DD4832D06CCED0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB3845CCB614E7D0EC51F91258CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a41ff414-4286-e5e9-5b80-85d87533361e@grimberg.me>
Date: Mon, 9 Nov 2020 15:23:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB3845CCB614E7D0EC51F91258CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_182401_914321_4DEF9CD5 
X-CRM114-Status: GOOD (  14.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
>>> 8f4f29f18b8c..06711ac095f2 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -62,6 +62,7 @@ enum nvme_tcp_queue_flags {
>>>    	NVME_TCP_Q_ALLOCATED	= 0,
>>>    	NVME_TCP_Q_LIVE		= 1,
>>>    	NVME_TCP_Q_POLLING	= 2,
>>> +	NVME_TCP_Q_OFFLOADS     = 3,
> 
> Sagi - following our discussion and your suggestions regarding the NVMeTCP Offload ULP module that we are working on at Marvell in which a TCP_OFFLOAD transport type would be added,

We still need to see how this pans out.. it's hard to predict if this is
the best approach before seeing the code. I'd suggest to share some code
so others can share their input.

> we are concerned that perhaps the generic term "offload" for both the transport type (for the Marvell work) and for the DDP and CRC offload queue (for the Mellanox work) may be misleading and confusing to developers and to users. Perhaps the naming should be "direct data placement", e.g. NVME_TCP_Q_DDP or NVME_TCP_Q_DIRECT?

We can call this NVME_TCP_Q_DDP, no issues with that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

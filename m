Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+2L2LRmeJoeCC/zotCm3ukWlF6727VI6B6PLMUImCg=; b=LYAIcA75/gTVpsAx5HZlzM4oNR
	pVLbZ5q12t34YIfD5nT4kw7JRtbCY0wwVUs/6AgawT/DVWks9ef+iP//fClIaroxTIAuSFgkXEJFs
	47iKjcNxzIX+wo/5mfTA14ps1VTSX7UfGqrWMy/3A6UvcEgNm/sA0DPodY+rWb9RCdDqXNGUOQofj
	2Gb0QyW3vyNS2Xf5XBFIKiZqkMpA5+bwimbV9WXPP7r+TVe4AsxgBOlKO6Z/bM/RMUX2j9s6Kwq5W
	2MeGL3kyPryoWY4CDgOxfifPlWr758vK/C5dqqkxbW5ooxIPbDU3RRg7np04S0qXp98FnCvHQlCgZ
	AiiQQhpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8GJ-00GIrr-Ue; Mon, 22 Nov 2021 12:17:32 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp819-00GDf1-71
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 12:01:52 +0000
Received: by mail-wr1-f41.google.com with SMTP id c4so32184180wrd.9
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 04:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D+2L2LRmeJoeCC/zotCm3ukWlF6727VI6B6PLMUImCg=;
 b=X3jMznJzfTIHdbZeEIy1RISpZB+vSumgGELGDF2330zPrV3EfqkbRi4ZEbUv+suwFP
 MZTDexYylUKns7l79AzQ9RDIw0OKOy0Dwd92esIEYn0R05qDmMuw87uKgCOjGjjjCQu5
 tyZtrE/EJ8YrU9Qw/gmr/GXXODoBvMp+bh98MjMXyGlY4Q0xNpEx93DqqbVccSJv2g4T
 PmHKF+faTsCwR58Gv0bjurIV72F0Ff6JdVjLKoonLInd4oUhgykLhOBDP7PHw8e565jR
 2AmmWwUnqbVyVqgUZcZmIzFEYSLn8E0+yfMifAmKTKbyO9D70ZBA4/43Oa//JW9Z8ZR2
 GFFQ==
X-Gm-Message-State: AOAM530oiEySkqqpbs2eUmxrF2w8yKCGW73ps9D5wqaiRC4OuFDmvPgw
 RGM/WWETWOE0u7fYkh0Cgy4=
X-Google-Smtp-Source: ABdhPJxUrmU5SPBTBR8HPe3Fztcuw6Gn8OBKRbJqfke5wK+C4sYYjXsTjkT13RPaQ4nVlWNHxtMItA==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr37112801wrv.120.1637582509148; 
 Mon, 22 Nov 2021 04:01:49 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h204sm9424495wmh.33.2021.11.22.04.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 04:01:48 -0800 (PST)
Subject: Re: [PATCHv6 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.org>,
 linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <14b025bc-746f-ea73-a325-7805c4b46c28@grimberg.me>
 <8e0909ad-f431-2600-7b68-d86d014fc9ec@suse.de>
 <8ba377cc-5c33-7cba-456e-bfc890f1ad88@grimberg.me>
 <ff0acc79-40d7-8247-6f80-e1c6f635df3f@suse.de>
 <153a78a9-8978-afc1-d321-35719feb5b7f@grimberg.me>
 <55524670-23b0-a7d9-4398-043477faa37a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74405bb6-909b-c71c-ebe6-678990ae4691@grimberg.me>
Date: Mon, 22 Nov 2021 14:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <55524670-23b0-a7d9-4398-043477faa37a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_040151_300726_933B37C4 
X-CRM114-Status: GOOD (  11.87  )
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


> +	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
> +	if (ret) {
> +		/* Controller authentication failed */
> +		goto fail2;
> +	}
> +
> 
> v5 had 'if (ret < 0) [' here.

Right, thanks.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8960CEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBM3kLO+OmxSA5ObktuYd2lmMDcK+c/9PBGCKy5Y4PE=; b=szpl6vLG+vipxMuarL/zCPS5TF
	huLjh2LUY20KjRUeYlOpMdT+59rRksafA+0vKUspGvUHnL0ZyVrqwr0ts/cZpGKlNGvh5SpQHKDeR
	DKMpoKPmMqCuq85qruTau9lvEAB8CmpKMbAlMswxZhDZSemIMYFmfRhbkhgNvmuGqQUKvK7dGNHRD
	yK7zbZEh0msiGWnAed5iBn5aSP3T49u8wDipNwresTApevG7lPoSYnZlUzzfw0GQjiKi4mdLqMZhZ
	jzxb99jXFZh4Ne7ZispOBs810dfUjOfxNEi88+vCFBL8R24BbliBDDU4BYUXVlFXLSVI9rwHHk1+B
	1N8woyKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBfa-00FCDc-2I;
	Sun, 13 Aug 2023 14:02:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBfY-00FCDB-0F
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:02:13 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-317604e2bdfso871099f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935330; x=1692540130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBM3kLO+OmxSA5ObktuYd2lmMDcK+c/9PBGCKy5Y4PE=;
        b=kq9iso7CdvMY/+o4RJl5LFNS3M1pN4njT7FlPWGCbxzo20f+VPMTlWCBBzMnKOCG2b
         D4fo1U/WVRusCvxRieDnEB6EA5KhEqsFvnYzrBEYIHoWpxYrr9VVKKdQd9QulkjFhkJ+
         qKKjAGHA9KGI4gB5t5c97PElLY5V5TGqRmYTaYSATd1xWZhqFKqCmgmqx3oowiXHY8v8
         EIpw3LDYcOkw92dg0Q1cdfvRcTVwUAH/Oh6sQOB0GN37RYQ1VAfERuJ46nAU7mQ3RFM8
         q2RoPZ/hss6Bks5+ehR1QO6+wPUe4YuqVcMVtU4wo5QYOXAHoo6nFZDCELM9flFy7ebR
         7VhA==
X-Gm-Message-State: AOJu0YyhfeBAQNxvaz9I7oZs2c06jnKUssEjpDEpei8zFwV6y/TOMSEi
	b5kHTBBmaJr2SPXAiqFP7rc=
X-Google-Smtp-Source: AGHT+IGIgOVI+FguTWh9hn/ikaP+DRPRd8rmGrcS6bqxy7tsftxpoHVO6ZFqMHU4hy0A+xOBEKC4BA==
X-Received: by 2002:a5d:5041:0:b0:319:7624:4c88 with SMTP id h1-20020a5d5041000000b0031976244c88mr633217wrt.0.1691935330051;
        Sun, 13 Aug 2023 07:02:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709067c5200b0099316c56db9sm4570136ejp.127.2023.08.13.07.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:02:09 -0700 (PDT)
Message-ID: <8bdecca4-4f05-1cd9-ef82-8384fe5b16c5@grimberg.me>
Date: Sun, 13 Aug 2023 17:02:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-16-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-16-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_070212_120064_06F28E34 
X-CRM114-Status: UNSURE (   6.31  )
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

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE106C52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2mWSh3xw8NquFLuGT581tnpK/1OdnahsfBkAptjHnY=; b=QtC7AfJhWA1vD56cQUfvYChzhO
	7JfIxSyy43ptWpNh0w/2RF9ampCrBwOqoriI00K14t5xCFUd0OrkOYZa8nHA2VyqW58QP0AZMCjNH
	KwCX84dp6vYZPKffDZFPXppaAAm9p3dxtSZhKOUfyZO50qOHFAUDRmb2o9OUTAJj051p4dkgHUPZn
	37ioPYBbwt1bXJnL3dAm8XyIVhWI9VD8ixXJmrRv+Fa3+B9jnT7rt1BsZ6h3Rb/9c8AUNW/BV+mtX
	6OwiSL+NTUig03QttbOf2+V3Ina3U9pZiYyQXS9D41nPmnM+GIFMhubFi8tED9RENPB0+xJnl+YHj
	ZMvunpoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxTX-00000004msJ-1Ael;
	Tue, 13 Aug 2024 19:46:35 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxTU-00000004mrT-0K9I
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 19:46:33 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280772333eso7361745e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Aug 2024 12:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578390; x=1724183190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2mWSh3xw8NquFLuGT581tnpK/1OdnahsfBkAptjHnY=;
        b=LJ5IPcIqxv9ZpUGikS+lnHAuksTn39Y4L976i0L8O8Lbvw2R2/CZt5He2G/GvkrGwY
         A8JSCtPS70vDVkFGiprHE2mTPhP657oTqarU1M1gydpvvRYVXwK67d4t9jr5nL7nFRcY
         JoNPBbTZLIqHWBSg3Qb1hyKEykHB8POWMBzoK80kh0Rm66PWFOT9HfFikrbb19iequhB
         LX8xoycwPiQ4hKwqB1YUaKA9C/Qom50XB5u259K3FslzUTY+Mip99irdxjk6naW0ADje
         3PtT/htrZ2R/lPJvIDHMrLSo6cKqR4og2tT0ohaPdLfY+n41Ji60BUrUjquKvg7kMR/S
         R+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXmFFm2q+vVpZJUO3+gfzSF1O7W7/2q5DgUPtt9h1VI7PFPvaJppES/ERO3XzQHgLCy2rJAtjNa4qi@lists.infradead.org
X-Gm-Message-State: AOJu0YwOgyzIksG8ZVo+QEw21nNIW2VXit13RBRzLDHiaQPJa5tdKglO
	q3q77V2YPR8vQJBlV7mx552kfxnlZgUmXBcBlCco3228+nqZR96b
X-Google-Smtp-Source: AGHT+IGMn2E8XTg7F1a9BWt5dMf6T2kzO8zwpgY2IYrtmNKS459vhAMvbpibBmeItuerYbHZWxU3KA==
X-Received: by 2002:a5d:5f88:0:b0:371:730c:b0 with SMTP id ffacd0b85a97d-3717782fcf2mr264534f8f.5.1723578390151;
        Tue, 13 Aug 2024 12:46:30 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea82sm11221929f8f.72.2024.08.13.12.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:46:29 -0700 (PDT)
Message-ID: <97bc146c-4f11-48f0-a077-b22f29c5efda@grimberg.me>
Date: Tue, 13 Aug 2024 22:46:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-fabrics: reset admin connection for secure
 concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20240813111512.135634-1-hare@kernel.org>
 <20240813111512.135634-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240813111512.135634-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_124632_148095_CF798FB9 
X-CRM114-Status: UNSURE (   6.03  )
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

I'm assuming you mean "nvme-tcp: reset admin connection for secure 
concatenation" ?

Other than that, as already noted:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


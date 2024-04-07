Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D95ACD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kqpWl+ympILrF8gLobz/TYCmWS
	NN+Huxwk7+lDExLQeByVcjZhu/BVxG2LUE4RHb8ewbXtVMDuhCULUoUVOmBOFVAMd0mRc72kG13g6
	zsN3xLBvKWU+pjsLx2ExGnD/3bqMjhBTORVfiFlkSx7LKI1gOscONpTBEB0xdJHtxDgpgfaJhHajz
	Q1h4CFdaPS4w1H/sS7GR+oZ4+cXpqVPSpOvhgIKzGTQN7f11dAFJwCXOMcCFUKVkZjXw8fsKukgCd
	oEU+4bMOwfyw9uQAlyDjdqwZsSKcpuo0oGxrnWFa8MNxAoxtYkgZYQ0y760dKWwvlexEWNkSo8ImO
	jbsP6JeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaSS-0000000DafG-2qwE;
	Sun, 07 Apr 2024 21:53:48 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaSP-0000000Dae8-2Tda
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:53:47 +0000
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-434a7621b64so481711cf.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526823; x=1713131623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=J9wIRIX7HX98Y2FdzwF22oXrnHaNcXwGQjVwXrZ4vOTvc7DkYRGYG3Ptc9Aj7N0GzG
         w0bJVBRLqd2LiRh8rGh/eY3Z2rDEINCc2B136GIbYwzZrbrFP9barVIIW/zkwI5gcr9t
         ENRNmyU4rXVdGeXIYpMHHFzFHJQm2eMCEMNKobSRfMcRSxw7JhfmKDfDMic72U2iIWbn
         sg1KploYaciEhdfqcL5x0wGSth+4fdZXxTI9dXhQH+Apla2fhLtN/95/28fOslWVe9xg
         jzirnIsUOBp5QvTqoNBv88yibTa04LePQ06p9Oaii/g6+9TN5vJjCmBSseP6LOmHSqGG
         v6mg==
X-Forwarded-Encrypted: i=1; AJvYcCWrN2IFucscD9pW/p8tT1KH/abjEvVgbQRPYLFyUX6dk5d47PuzuRmxONsNU/QbGEr82kHXSTgeHxEyxqG7snr+ny4tfS4H6TyZpoiUtwQ=
X-Gm-Message-State: AOJu0Yw/WZZYC0gpEWKEceNxKRlFhNH1nXupADSi55mKUhLTYqBwxPnB
	MDel3ooB16VTS/bS9jGnR8CPKu+7YFLUqqqiKUdZ8COTF/DmSt0S4hKZKPnH
X-Google-Smtp-Source: AGHT+IE02F2F39IyH4IRRYzEWUGt4GWOwVJTopUeHSdF4iHdmmyLdEjzHG9bHLbYc6o1IxYPPyznuw==
X-Received: by 2002:ad4:4f8e:0:b0:69b:ce6:271b with SMTP id em14-20020ad44f8e000000b0069b0ce6271bmr4460521qvb.2.1712526823151;
        Sun, 07 Apr 2024 14:53:43 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id cy10-20020a05621418ca00b00698e65cdfefsm2511910qvb.87.2024.04.07.14.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:53:42 -0700 (PDT)
Message-ID: <dce0eac9-5081-471f-9294-4cb6abcd39f7@grimberg.me>
Date: Mon, 8 Apr 2024 00:53:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] nvme-target: do not check authentication status for
 I/O commands twice
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-17-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-17-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_145345_637600_A4320CC2 
X-CRM114-Status: UNSURE (   4.97  )
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


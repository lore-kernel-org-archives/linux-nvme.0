Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0308DC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Gm6vgFiSHbeCK3Rlp1FfsCPW2r
	LHy/W26QR4E6aEXpQcjNde5QTEZnA41uhYd/9WKdo+wLKMeXiryllPJezwFUU0wWnnyR1DXe2lIq5
	XgjqlNDIHpLyue+TwZpWozC42G2Lxe1Jsx99Vc9VGA3SLoKz2jBhXFL5BGvJ95D1TyjSLO0oeDmeY
	O4F2BfTXIRsMsvt49yUvvhY2stixKnGpQS4c+hmmVRCBJHlbdznqS1kuLpvGnC+HqcMsJvy0xvCKq
	5t4f/mLgAHts4cvQGSaansm06vmNv+RaItFGkPrn2zPHyVsCdk0Wj2Pm/6ljIN1LBsHvajWAE12cQ
	yreCP7Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9VW-00000003icK-05Nx;
	Thu, 07 Mar 2024 08:53:42 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9VS-00000003ibq-23bD
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:53:39 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e4ff2e95fso108665f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801616; x=1710406416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KR4u26iU8tqrJHWW53Bz8zkqjBleL0tqz0B9aYnWYJp92Q5pJ0hKj1MwnfTO8B4IWv
         Mq64k8CUs6e73sHW0glSMGjbuT5pbajZsR8GrI/Zs29l+vgnMMLwYB7XqgdWSReVxUyy
         t7t+XZI/B54CP70LTOKqdewWq7QIop6euVsoGzj3ymapZOpx5dipt+EPb7pz+53/+LRX
         8jTJquMuzq7Qwlx4BTjGN1cv6BovWloYbY5qbdr+bLQUQsYVWI3NMbQH+6UT1rOFcU7Z
         D11iCaJe7xO/dIcjUjsn5Rnpk7iSSolxgQK6hZdBWamj4Qf5y7QhwDy/wbzC7qIi/KiD
         4yww==
X-Forwarded-Encrypted: i=1; AJvYcCXwJZhFTwySUn91MZ7F+s4/p7U8LKZSQfJjlx+C4HZpfAdvUDJzbIto1fkMwd3Xrbw2uV1ruAF78dOzLELHJtGHYr905cldRDx+PdP38KQ=
X-Gm-Message-State: AOJu0Yx/x58OKvclIAyVOoF0FWx8oMrP6wTkqEjNzIZyqZ/Rr3fqrGOc
	1Goc2z6LLpmyR1VjEWewmtdDaDKCifo/XK4j721SvT64ABfUjeIlwQ0biteg
X-Google-Smtp-Source: AGHT+IEJg5tH49GX+YFcGyRLqxftiDlrnPuCl0ZC5zJaSXVyN6Mb/tOgkq2Zw27KNnH5Fe6pzmUrzQ==
X-Received: by 2002:adf:dd87:0:b0:33e:4503:3ba4 with SMTP id x7-20020adfdd87000000b0033e45033ba4mr3329880wrl.7.1709801616156;
        Thu, 07 Mar 2024 00:53:36 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id h12-20020adf9ccc000000b0033e03a6b1ecsm19613536wre.18.2024.03.07.00.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:53:35 -0800 (PST)
Message-ID: <4e11e781-195a-4d52-8804-04bc79d3b4f1@grimberg.me>
Date: Thu, 7 Mar 2024 10:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvmet: lock config semaphore when accessing
 DH-HMAC-CHAP key
Content-Language: en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-3-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240301112823.132570-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_005338_554242_36195604 
X-CRM114-Status: UNSURE (   5.30  )
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


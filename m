Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DEEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpU3iAvlI7vFNNtFjXtBf2TLbwrk4hSlTTyYCdlscgc=; b=gdNxTghCjc7znVV56ZhyqhQxXt
	pA4qdOFr7cudpneNxqremVRzea1+TJdJ9/el7dl7TJjnF2SEMSMiOylDe5g6PtLQkhBo65BGjUBaz
	y1fchbjVKzSLsRwqii7Lz+WOs189r6VaxH1aYLoDD/l40n6P5avB4Hzlj1APqfVufmywzjLumUkFn
	rLyIg/jQCxdns8bSZjkR7ZLY7mNCN/WccQKbmNYMdgJPQsmQ6JCdMCnhHMh0EfvwZZESjJnqESVoO
	HDoObbce3OAXyy+D2krqrS7bGvqS5DHfs3Mt10NKwwkIHujkwkQ4N+HOSAkn7SmC3RrExCCMKY9Rl
	Kb7OGAHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaZ3-00398A-OQ; Wed, 13 Jul 2022 11:29:57 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaYq-0038wR-RH
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 11:29:46 +0000
Received: by mail-wm1-f47.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1038494wma.2
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UpU3iAvlI7vFNNtFjXtBf2TLbwrk4hSlTTyYCdlscgc=;
        b=rilec9v62EEZIiYGfZR1gYm8aEXnTwRUVYVj4CphJ/MyB53bBTcbGiQAcwCN/RZIcL
         1aRE5c0FrqJFvLIWquRXFeo7NZIP89Gk1MRBnrTosv+dQ6S5G/2dizXVHsfFFENymwD7
         fkIDByAh26U6dZKobJu9P2dPZ7uQFg8sXOzFVwfYMePThO+k31yQ0aTaP9fNp8Q2/25n
         Nw3ftyyx+EWfAzlpND4vQk7DkOjyOpqlDsp8zrVw7GMT3uyIXQgp0qzPVsZCeAdcM8XM
         5cfYNP79PjVdmLIPrnvtrEoZjyZ5HcsUIrLLr8QzGVIhaVtuhaIIgTqRmfdK6K2yrnHV
         EjQA==
X-Gm-Message-State: AJIora8Ci7OwbTUgs7bAc5VX+DhgjX+UoXTCwYR/BNTuwmp7Gkmx6Se6
	TiOp4dIbCIzQmDRG3s1/i/A=
X-Google-Smtp-Source: AGRyM1tAV3cbh98V7zivcQQEJSRhTtBKASVvqnCwfoRbs+PoIdpF8qowitkgzUE7t3U/ctmsRvFMEA==
X-Received: by 2002:a05:600c:4fcc:b0:3a1:987c:82c9 with SMTP id o12-20020a05600c4fcc00b003a1987c82c9mr9495996wmq.73.1657711780854;
        Wed, 13 Jul 2022 04:29:40 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b003a03e63e428sm2367497wmb.36.2022.07.13.04.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 04:29:40 -0700 (PDT)
Message-ID: <d5b7a279-0271-f53c-b886-b9ddaff906b3@grimberg.me>
Date: Wed, 13 Jul 2022 14:29:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
 joshi.k@samsung.com, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
 k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-4-hch@lst.de>
 <a09f1d0d-09de-6dd6-3810-d6fd5e11f63d@grimberg.me>
 <20220713101655.GA27936@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713101655.GA27936@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_042944_938415_3DF097C2 
X-CRM114-Status: GOOD (  12.33  )
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


>> Maybe nvme_ns_info can have a id reference such that
>> nvme_update_ns_info_block can reuse it?
> 
> I thought about it and, and it does seem doable.  But it just seems
> like an awful lack of abstraction, all for avoiding a single command
> on some setups.  True, those are the absolute majority right now, but
> with more and more information going to go into the comman set
> independent identify page it will become less and less so going
> forward.

I don't think its that bad, and it saves fetching the same data
twice. But I don't really care either way...


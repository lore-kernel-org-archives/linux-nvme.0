Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C9C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=U18ln3eQWsh31659aPcEn1BnHq
	qGAAqu65iHFMOCKAfqOfLxseEoLuMb28az8g6M+peg8pruqMDks2HdJ9euPJqysiF9FAyiH4RfzPu
	Zv3P7digIH1+ouVUtcuydRFChESxOXKO4Dctp96MCddNmpZ4l/IpYrmz2v5exj1zk7VzBIK2GnlXP
	h4lh2WUxx2/uih5DicMT3PxrFBYLqedaOWxlbiq/kuOT3hsmwK8kUsDXeZl0a9TVG3GRBqFwOMRPP
	H20/w5WtVjrZLqvFNnCS3mCCi5i0AVCuyrD/Nfqm8/QUajv3pYE0LRi6ngkMoYNy0mYKTnX3hfDv2
	XQOaa0Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OX4-00AAeR-1h; Sun, 25 Dec 2022 10:47:06 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Nu3-009pLw-IY
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:06:54 +0000
Received: by mail-wr1-f52.google.com with SMTP id co23so8119253wrb.4
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eTGKruDnivTNqOO/N0yTD14IoQFVN4OseE+PP9wBAWIaBE6K96qeeoQ249u7VQs+XU
         GATPLQE/eRR1d5SWYkiUY66rSGhR4x41MYAukKWqOXd41UiDiEPlYTSEaXvXZlWoEqrP
         xRJhe0fxarOJINMiync9TJI6mQYyAtmuVBUZ08hFRVO1ppSkJEL/sBV7l5aJJ6Vpp6ZZ
         LALULdUtdc6kM/w1KMDvnsJsnyGGDw8KrJ3hatwqywww91d1F3Rds1YAtTeJjh9e7czV
         CE/WCC2v/YP0TUD/qVEopTLR3IuEK4wjYCfKBZXjaJm6yqz3ITUZgZF5b1fJ3nh49jQr
         EEkg==
X-Gm-Message-State: AFqh2kol5QlJZtWGha2C5ua7PZPuirwclMEhuL5epRzGj2Xy20/RmkXH
	/iTaTyodBMqcgDrQvXq4441ryvz18Ps=
X-Google-Smtp-Source: AMrXdXtQVgrvpbHh7QKuOka1WMcP3qJqseicNaEQ5eNTIFQe/rrnLX1ovVWVSU/YwGdB2rGoyuTY6g==
X-Received: by 2002:a5d:49ce:0:b0:26b:c52e:f7be with SMTP id t14-20020a5d49ce000000b0026bc52ef7bemr9701574wrs.66.1671962803963;
        Sun, 25 Dec 2022 02:06:43 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d4dcd000000b0023659925b2asm7399658wru.51.2022.12.25.02.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:06:43 -0800 (PST)
Message-ID: <9f37ddbb-e144-366d-a999-8a42ee7cf963@grimberg.me>
Date: Sun, 25 Dec 2022 12:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/6] nvmet: set the LBCC bit for commands that modify data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_020647_632171_78CD143B 
X-CRM114-Status: UNSURE (   6.07  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6EC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 10:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vwve5dP+jIkDxCzsb/nLYrd1Xi
	Zqxm12kSDEMpTVC1mzDlr763WYE4QVp7U6VEjomTS0UmvIB3lIwhktKuna5qldQNPL65huVeodnUQ
	0pdnm6w4MDKIbqH9mNSNlk7leYgFTBYXUYZCBlTBLtbuQBubSDduH/fLtehuZEIbW3X2uE5gs2bfY
	DMXeq+1He20b6cu37BPNc+D5RQwoshbax6zy9RUanY2oKE5LuAtHmRMMLA9M3wPjsHQUqiMdVRNyA
	JeGP2U81VKamBi1XIPm+KDdQ6O0F7X91020948PbqCBsCLaH82R8JZQAcx3JDGtC8KzhYXFZWmPZf
	6pXb7JCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ondyA-008xjX-9v; Wed, 26 Oct 2022 10:49:10 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ondy7-008xjE-PD
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 10:49:08 +0000
Received: by mail-wm1-f50.google.com with SMTP id y10so9937008wma.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=55l9P3GZDbpsnCGm5mGhugMMT9yYnueXLHjMC3vOlz6zmNF8nebnSr9qDdjUxkCM6J
         /p4E2pmE5Rpp++tTF+C/H87E1gXmBkOce1y84+c6q/CQleCP1fE1hUXBi0O+2mxrdELb
         0FoiCrchorpUi5FHcBcS/DxZ5u+UV2fzX2Io++SlNKq1cSRmkiONsTyNefkJojk2K/HB
         apcv1AyCg6myfngmsz03s2YfwtEWW9uESJF/NoKnWxfXj42jq5SkKgLOcS06tOmVCCOE
         pG00V9kobGFpSaFXy9BFT/V959RKHpvDfFXDFBGxj0126fgNnZ+OzK6JbWizFoHvssmA
         pYdw==
X-Gm-Message-State: ACrzQf1PBBE05MbttxUnwJjP0oZ49uxeoEDKw/bSa4iWiPXAwtqYqB2u
	0LHClJooTyie1VHWtN3FygQ=
X-Google-Smtp-Source: AMsMyM4sebGbNtqD8R2eQtKX5uwHwRScp3A8wrgHnWupEMfhDG8eOarzi1DmwEvHmWquLjycH7zMzw==
X-Received: by 2002:a1c:f30d:0:b0:3c3:7c80:67f4 with SMTP id q13-20020a1cf30d000000b003c37c8067f4mr1963667wmq.86.1666781344994;
        Wed, 26 Oct 2022 03:49:04 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c338100b003a3170a7af9sm1526927wmp.4.2022.10.26.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 03:49:04 -0700 (PDT)
Message-ID: <dae55084-2168-b469-8e86-4ba7d5e12774@grimberg.me>
Date: Wed, 26 Oct 2022 13:49:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] nvmet: fix memory leak in configfs
Content-Language: en-US
To: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux@yadro.com,
 Konstantin Shelekhin <k.shelekhin@yadro.com>,
 Dmitriy Bogdanov <d.bogdanov@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
 <20221026083135.77125-2-a.miloserdov@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221026083135.77125-2-a.miloserdov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_034907_864882_A26D8BBD 
X-CRM114-Status: UNSURE (   6.85  )
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


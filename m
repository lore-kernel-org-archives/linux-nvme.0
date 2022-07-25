Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E716CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ivmUCHnJcC9fqptBsD+rztCpPC
	GOcn14H/uLY6R9h+jTxnJaLvfgk1naJBa6FNaY/hyETZnoFQs40UPe7bx4GAlNyLwkU/yoXL20HDL
	o20IMWEDvqCeby6bdQqookL7is/IKatt/yEVJu6Aps87X+lIQcH5pF45232qhp8Bwc8PlW3qi9Dz3
	+UOBTEXUkdNU94Ti92tnnworkcayUuwy4I2QQl/VJJsEqNxl9JdN7V1rV6Iby4INFbCMxWm7klBAT
	jC49eVkXJwkxpnBtzx48RCTo5Rg0h3zrLozU8KYUIfFOfHsNfy/T/9V/Sw4uapoA6aFFO8wUWMnAF
	D16QTa9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwdf-00977c-MM; Mon, 25 Jul 2022 11:52:43 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFwdc-00972e-Uv
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 11:52:42 +0000
Received: by mail-wr1-f54.google.com with SMTP id u5so15606076wrm.4
        for <linux-nvme@lists.infradead.org>; Mon, 25 Jul 2022 04:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Yf5e/AMrhfsq/KJgptKtIxRC5OxfsABfd371UtHxO9KGZNRRg29fyBvEqdyfAdGarm
         AW3n7bUjMb2rRo5xODXPRyebF0i77zoUJOL71Uivqm3LLnk1491aIYReA1K+inlByWGJ
         DAR2dX5egNAhDq/m91swbA2t3NAlFHC15Am9CE93HdKAeDwX3PsJeIVFbbIuM6nEYSyu
         h9Ruj1FJCtaOiWPQpBZ4Qsx/qSAPingTz9pS8KqpxNQRS5xPNu9ww6n5DdF4RdH5H2ZA
         2zmjJUtlCsEpw1S7ZY25h9JFiXyembFmN5SFHL0e3n5A6EAWw7HFAMHct7T5NFkCduXm
         VkaQ==
X-Gm-Message-State: AJIora+MlUUTEmcHn423+sN6WlGWZCZ7ZNu2oudJhjKJGuMzv7+gyQ5L
	AMCCt6OiqnkzQLYwd2JDmcY=
X-Google-Smtp-Source: AGRyM1tzfhSqZTl1bvObrjbmCPN8J1MbTcdmD96H2T1toTOGrJGLz/51YHNXw/wqoHpexDsD21bLrA==
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr7752394wrr.538.1658749955913;
        Mon, 25 Jul 2022 04:52:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003a32251c3f9sm20943303wms.5.2022.07.25.04.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 04:52:35 -0700 (PDT)
Message-ID: <a1eebf43-cde1-496a-bdd1-eca452a54d4c@grimberg.me>
Date: Mon, 25 Jul 2022 14:52:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "Ewan D . Milne" <emilne@redhat.com>
References: <20220721003358.543509-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220721003358.543509-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_045241_015866_75A7FBBF 
X-CRM114-Status: UNSURE (   6.87  )
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


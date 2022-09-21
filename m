Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEADECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xpiO6LAgkdRaMvD00di/cVhQQA
	t7o5V+XAtEL/dL41z/BBXRGRsg2y0tKkzo9X3M4WLfPj+Dje9+6SErQ1eNq9PdEHwFnoDd/lBhimK
	fKP/tlEzcocKFzp+Dr8/SRmC1IRyddZ3s6MK03DMJV+WEWXqgL1RD1FOgLPcZQSL3g6+AEmVuE0Mg
	wJqJ91K5YcJ2Bg0KBd0j4WSaeKDn6eW9r6jjABRLkmGlQlWdtjQ3hEsSND9XLZK81qI/IZ65/bIon
	13+daojyHbQO/ZSX30NcWoRYYoE/KkUISuTxu9kuqGYwcCcK9Z0LNqp0gVCWxhHVRPjg6R2PybFAx
	OqzeooqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaulV-009nkk-Gx; Wed, 21 Sep 2022 08:07:29 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaulO-009nh6-7W
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:07:23 +0000
Received: by mail-wm1-f53.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so8537044wma.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=R5UotDvMRpWT1wy+jOzIiA8DNFosN/IRzX2fPujxrW0Cw0qzhDaa6xCmVlJSR/qTap
         dKyLBy/nyZdz0zMzMFHbAUN/TLdHBFYeNNbtNho6XcM2CCJfrQhbxJb00Bn0kVCCqxt+
         wPnDT68N/C3fyvbXnt80XhYRTVLmWOS4k8rqbcKpCPQ5LT/tDs1QvrmSYi2jnd/QpNq+
         CLQw4VVQnL2BfS9qISrNS8kah+9FRlWgKJg6lJHMScuHHyKcZ1DPeCVBNo89FoUNDHUM
         qHRdW74bCwvssbLabYToZ+lzmqFYB3UlA9XjTqiUY/2VkZxWMXkWmT5xdEY+yDe0fJuV
         /HOA==
X-Gm-Message-State: ACrzQf2pPg8oP44Q6TFXBKsxderkCv+tkyx2sV28v/qRDIsX7JnjDwe8
	eoUbmT2w3Jkp/vNE/Uf3L55RzxfAEks=
X-Google-Smtp-Source: AMsMyM6Q+/6gT8ESbWI+1Ayb1KuM46MZrtSYgjQpilUehq6cfWb+CaCzxt1LsEXNPhJoKbvieDQDqg==
X-Received: by 2002:a1c:4c02:0:b0:3b4:9249:3539 with SMTP id z2-20020a1c4c02000000b003b492493539mr4938897wmf.128.1663747639318;
        Wed, 21 Sep 2022 01:07:19 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h3-20020adffd43000000b0022a2f4fa042sm1829797wrs.103.2022.09.21.01.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:07:18 -0700 (PDT)
Message-ID: <0f5220a0-4ff8-c7cb-3d5d-ebfa40d841fd@grimberg.me>
Date: Wed, 21 Sep 2022 11:07:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND] nvmet-tcp: add bound check on Transfer Tag
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20220920183649.5177-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920183649.5177-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_010722_316080_3A495183 
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


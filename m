Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2458BC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Z3Xeuf3yb2FHd70QuaLrRWKRSE
	h0hUEzPd1Z9mQa7J5rY3hii797XIKX8XePsHza4aays/IFdiGZhhGhtjxUefYYV+VGsSRVCIn397F
	pE8LrlH6DU+HzTNCn271k+wHN+BYfrsfwbuwmCLS3Yt/yzLR6w+leXSbcimGNp4LAKiPnJtyoz1kM
	MmVmSTicpYE5xpg+sJJZulmJKanXQRbyn2PK+Xi/JZWvdOoF73eaCArO68bOw0UOfqz9gOODYGZiT
	wcnviqOe0PC0FctH+cqWXN3JJ7IqD3rCTm8a9vM73cAs4/1cZpkZmw3lijVYzVjMJLoTJ0QMWMoxU
	EUOEZVyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Ww8-0092Aq-KZ; Tue, 06 Dec 2022 12:20:36 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Ww1-00926z-Vk
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:20:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id h11so23138691wrw.13
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=zn1YCvjypuF6nZmeQdXkKVIqBovKG8caV+zjhPe3ZN5fBZNqY96NGHQN910RvqlPSr
         j2PIopHevpDg56XBKauytX2PzShNW7i5GHqQR3N3+lN+xE7t0PA1k2bVBTu6NtJCu53F
         t6tgAkFCctj+v6exQMcoXIyxi5GCyhTJJzrjvzASeWBWB5pAleXlsJZKqe+qaOrSvxvP
         HZfKhASW1582a25/uxQM0uhLcS6AE1CeTgWuyw/6+ICoHqr1/lKsUEspVmI2+NId5UcM
         Wx7N8s8Pht+4lXmREUU56PyBe2m1t240VVuyUrtwbS5AZB4v6KWfXxiYkueeU+rFl4ao
         Dgxg==
X-Gm-Message-State: ANoB5pnelsuCtR7YKiNPKiKtJln/GJIzVjkEUQTI5cly8BcCzEerOn/v
	4WvuWM7Tq0nJUUXVlMVb4SQ=
X-Google-Smtp-Source: AA0mqf4DeYYo5jtHzv+j3gyj2Dk/Mm3VU3jhVIWae99nnFsFgr83kGM4uI56v150OWkGp7+0Va052Q==
X-Received: by 2002:a05:6000:137a:b0:242:5b1f:3dd0 with SMTP id q26-20020a056000137a00b002425b1f3dd0mr7079667wrz.633.1670329228695;
        Tue, 06 Dec 2022 04:20:28 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003b47ff307e1sm23303488wmq.31.2022.12.06.04.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:20:28 -0800 (PST)
Message-ID: <c263f818-844a-d417-69b9-4be6ae6d031a@grimberg.me>
Date: Tue, 6 Dec 2022 14:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/9] nvme-pci: cleanup nvme_suspend_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_042030_031104_0F4A17CA 
X-CRM114-Status: UNSURE (   7.00  )
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


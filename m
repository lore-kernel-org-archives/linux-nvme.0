Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DFAC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lYlMCgpMTKquSjJsZN7668NRqM
	JP1rQQgAfgL1KV6O11k7+YtXtYCmxQ5NvXJOXLu2WRQlP/pvWv3hUtc234TMAwAnc/qjY8hc/dd4I
	fZE+4X2NLAPI6eM7FTVrM9W59JuNtELjLmx8LPsvrnyenO6n4FSqfeDA2LnncNJ60khdue9A5Zv1u
	mbZ4WC+Y0RKglZnXFpOk7sQAIaXcCxZvap5ERHKjlbDW1UjETekyCdDSHkIE0t02868rIv0svFOqr
	JsoEbHpTG3wPxbaMO8OHnrVyTITFEeH6Jfr/DmwQsp08tM77mg8T8JBXjCPuJw7PwzXFB9BUBUQHH
	iu9DLJWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8KS-00GK2q-RR; Mon, 22 Nov 2021 12:21:48 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp85W-00GFDz-R7
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 12:06:24 +0000
Received: by mail-wm1-f53.google.com with SMTP id 133so15134204wme.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 04:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=GmYDhRm3iNhf0Ft/zQBXgg9Dw2qpttW6RV0sDE7YI+k/yaDjBGWtGEalsphpEld5pO
 zd8LlbgjJOQXnooHY57rYGEZ4QiMTJibvtAwLShJ5/hNW5toiY5pHY5eP8xtVQDY2r5b
 +dGrsQQc7ihrpCiuhWC44WpP5/ZrlKkQDX/VNQppSgKYjwkxokugcHvxxDpSGpk7a433
 wgmFYSG2JnXHWeSnuyxKK8UA+oiM06hWCVRp/KhQi7h7t1myXDQbHScuDQ1ZhPpF9KG1
 PcvaKN0YOEsIhWTdUY/fPcCOzKs9oGwMuT3zkH/2zRLU4vDRe67CLgCOa8X8rm+Bxduz
 N5/g==
X-Gm-Message-State: AOAM531IoRdSpP4jqu6FWzMV47FwfmeJN5kyW/Q0GOho/FMgRVXJ50oT
 WSpG+jtnxZW3uZ1jVYoBXF4=
X-Google-Smtp-Source: ABdhPJxL4LIU1rFckMrmqPa9CPngiVCGd1uI5OOln874UTL90pfeQ1pCpyY7Db9shRBpxMU9Qmwl6w==
X-Received: by 2002:a05:600c:ce:: with SMTP id
 u14mr23940394wmm.83.1637582780881; 
 Mon, 22 Nov 2021 04:06:20 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d1sm8458510wrz.92.2021.11.22.04.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 04:06:20 -0800 (PST)
Subject: Re: [PATCH 04/12] lib/base64: RFC4648-compliant base64 encoding
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.org>,
 linux-crypto@vger.kernel.org, Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <baf279df-257c-dc78-2205-ee68df8f7bcc@grimberg.me>
Date: Mon, 22 Nov 2021 14:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122074727.25988-5-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_040622_897982_2EF52BF7 
X-CRM114-Status: UNSURE (   9.28  )
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


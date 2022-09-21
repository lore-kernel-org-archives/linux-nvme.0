Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C50FC6FA8E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lKItASf7hT9cxQJ9e+eFk6N20T
	a9PCdztZLqfvFY/QfiJ8B+iiKX3Gvk91YiodyJU4jkVKfe3ijePFZHRJ0olW5TzRd+RgNxj8eugHh
	8iixZA2qK3/9PNTG/7nkysqmUmIX3OW0/kBtSj7bnukqQyDGGFXaCIvGO6vbkqTMaXM0tLxC07QYj
	DZzOjkWtLm6zjpeYayLiUsIh8HikF8VzZX4qJi92EWcAlEbsuL9pod6twSvPOyqdLBfKPYI3nZ4MG
	2kH6vyswsuQW+H7Tzd3G5hykelkfPO2yjMG408cEzS+65tO3ipSdj9iow6etxaYcuM8FzAhZx8dmX
	r6h7X3Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxGl-00Ax3I-VU; Wed, 21 Sep 2022 10:47:56 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw74-00ARPs-Fk
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:33:54 +0000
Received: by mail-wr1-f47.google.com with SMTP id t7so8813921wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VpKGpZbFFW71W3Vy619zTQYJVWxi4/EPKPCFdXPOBt1oeUncNy9C+NjkL7Bw1XB5r2
         jLszpXhvPNyS5FJA3gfSx3g2VcDXw+BmunEI5W+bKojI4IaBV2+zqI+hGbLhdEq6G2L9
         zy2KV1fr0dyTqASN0wHN+VouQ4gpN68agvirxJHX4qVNMY/5QqdlitPC0LkbQjPHusV4
         YJFwotZG1tWNSX4//cIOfePyU/oAzJfxaXhov/9vqCXsYMR5PLcEbXiewQlpcLB13gDN
         UQ+OzTHJyyYhKKrtpANoHghjcN+GWZmK0YJsoIArozI/czAW80/YoIiCAjvNIwYjQlKb
         MslA==
X-Gm-Message-State: ACrzQf2qHrLyEx/1Ht/JEFO3FHefy9MpUebZM/JXVnKn214F85JiuBI8
	W6jhUAmxP5hAXurQLOepLGg=
X-Google-Smtp-Source: AMsMyM57TmsFJDgo1ShpILGnbsxhusejNtVnqx1Xivb2Yd87eM1ecDkUdFZevMZ2oF1Sv+U7tuoHjw==
X-Received: by 2002:a05:6000:1681:b0:22a:fc6b:f83c with SMTP id y1-20020a056000168100b0022afc6bf83cmr9132981wrd.507.1663752827557;
        Wed, 21 Sep 2022 02:33:47 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d6b42000000b002286670bafasm2042014wrw.48.2022.09.21.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:33:47 -0700 (PDT)
Message-ID: <972466b5-28ec-6b40-f0d0-fbf4b2ffdd6d@grimberg.me>
Date: Wed, 21 Sep 2022 12:33:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/13] nvme-loop: initialize sqsize later
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023350_562391_5245E5AB 
X-CRM114-Status: UNSURE (   7.19  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B9BC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MbNE/HdfL8z/j/2vM7B+Zw79B6
	NJPhT96demFBVm/j5fz3En8aWrOn/Vdc4HNeIM/lq5v2YECumLhwtg0cRUCO63KGVaa/sG2rFFCqe
	EWYRhccu8rjkmXsZybemCjlFsIhONCho67EMyrSTsxxHTUYWoPKnJallmr7gUyVtA1oKAEy5Ii23s
	CCFJuKhJHOh/MxnLBAfagE08Aam7uHwM2sRZVUG916JDchXo/Gzhy/iE/g0sgTnCwr90mMVvC9qqi
	+h4hBw7JbvE+cVRVdxYKjUqQNcrtlNoBBDgtiXF113Is9Esyc6OvwRUVWhccaiUb2aXqecaBZXMOs
	jqg2+H3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA47I-003Ezf-0X;
	Mon, 04 Dec 2023 08:15:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA47E-003Eyx-2S
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:15:46 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3332e285ebcso760479f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677740; x=1702282540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iuPUvh5JfzUFki9CQQvs5t9EpUNOzU8CC5GsVErpD2HrV2cYF834htDEaw6yxIo5ad
         lwDQOoKZaaj49pc7Y1xGXVGRQgfgAG3f4eU4gYrdzFeQckIOFF+gsi+NZPWpFtGHfvv4
         Dk2wcc3Hs0TBEsaS3xPyiszAh8JOprd9GVCfGfYga6F8Xz9F9ICiC80hA2J2vlWcBiqG
         cVJA6fedQP1b00mhEDE/g8r1oam+9j8REwpGE5ZV9tczUjCk0ngwt26H6ZMn/VhcEEO2
         gZUff//H0nFt5IeVMmQ2+M/pl2ibYx7g4n+0or5pYEloe7GCuKy/yP8mdzyqlj07294E
         RLmQ==
X-Gm-Message-State: AOJu0Yw48iydUUtMorjYP6jZeqISZa9y7cIm6m3ssMwkSpwIevdgiG9H
	2qTWWj/mHh5+Ik6nuRym6NI=
X-Google-Smtp-Source: AGHT+IHij3ijkLKy0LAZcWt30FyU97OEdKVCjD4dU7zcW6fwfly/8RWO49RjngtCjri6sMZDTWpBSQ==
X-Received: by 2002:a5d:5f4e:0:b0:333:4d89:b172 with SMTP id cm14-20020a5d5f4e000000b003334d89b172mr610781wrb.2.1701677740265;
        Mon, 04 Dec 2023 00:15:40 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d6d8e000000b0033343b1ec1asm3362494wrs.26.2023.12.04.00.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:15:39 -0800 (PST)
Message-ID: <d6e33e3b-2b91-489b-b2aa-29ea97101748@grimberg.me>
Date: Mon, 4 Dec 2023 10:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Content-Language: en-US
To: Bitao Hu <yaoma@linux.alibaba.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kanie@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_001544_820703_D074BF9D 
X-CRM114-Status: UNSURE (   4.72  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2A7C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=aRgC5xoNbmDT38ByhnTOKamQQC
	GPwKwg7Hf8IdMOsRCgi0qaXvTRBnRxN6hIv+Ccjt0MHT1W+Req9KQAa1CjX4ZRdCD14N5E7fQdJGY
	MiGQkLIRGhntarUl5bY0hzQZc1e7xvqJ7uRZnObvI0IHj2OwJSus21jcHUcOGy1Y2E35X3DKiOmrj
	ikyigyB3ir6YgIy8BCNL1Brx1RrjsFfGDRk2ocjlB0XOAUo8Xfnp6sLayFoQFHn6GbQ8xUlKNDHf1
	AtCrek0YojUEzsKxh4xLSZsL/iEipO2ARasC/woNlD4GjojLh55WhM3WATM/jhaVp6j//kHS2k4cs
	NaYFkkfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQpI-00EJ0k-St; Wed, 28 Sep 2022 06:45:48 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQpG-00EIxn-Kd
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:45:47 +0000
Received: by mail-wm1-f43.google.com with SMTP id t4so7884424wmj.5
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=n727jyfUYJJWthE11zL9KHzeIbWIY6rwaMTJEykCJBwwfmKIyvW6sMEWyfmi/YK9AD
         YrR5HQovEwux130QJlMczUpHvjf+NvMyuNZ4Djl9BV/yEsc0eOlLisiwMbtFbBZTSPEM
         16ECOAEJoqwpEqFed3U0m3/H3yamtttiJQ1IlYabdrzsWTD3IwzcXshn1VNH7A42Rkoy
         mNyIfwG8iEemsoRdnFaqVlu6VQ9qFV3mYKwUlKAQkXhN1cmljg20iOsEtrbkfkxelCwi
         HuOpJHlI9gfcRlv5USOWmCdYG74hDo7Jre5zfSYygvPbVTl2mqVReNr6TBz3Mc9gZ+di
         cONg==
X-Gm-Message-State: ACrzQf3itYAZuNgmUG3WlUpqiLw9VJ0Ve17AnfWDMlxRORgrnyv2Srvk
	RGt3LHlZTqQWjz1ljAN3arJnLstNSAs=
X-Google-Smtp-Source: AMsMyM7F0LnNQu7SrhXgWFtwL4mKMqo+1C62vPSnBQLYj0KZK0xHjZpAKFji97ufGqXflIVM63jFFw==
X-Received: by 2002:a7b:c4cc:0:b0:3b4:757b:492f with SMTP id g12-20020a7bc4cc000000b003b4757b492fmr5599493wmk.74.1664347544095;
        Tue, 27 Sep 2022 23:45:44 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm824532wmf.30.2022.09.27.23.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:45:42 -0700 (PDT)
Message-ID: <00159fd8-51cc-c021-d339-2b08c4b92baf@grimberg.me>
Date: Wed, 28 Sep 2022 09:45:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvmet: don't look at the request_queue in
 nvmet_bdev_set_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220927120915.280166-1-hch@lst.de>
 <20220927120915.280166-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927120915.280166-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_234546_689141_213A7875 
X-CRM114-Status: UNSURE (   7.16  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BAC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfYC1I7WIg8Bmww1dWWk5X2t/tvBwcN0CmoaonN2t0s=; b=hBhIvq+iTAuSjWi7dKVr4khLE+
	owMLOGUUHKDRMo7FJ7KU/k3p10e4QsEngzciPsH/mRJ7FRhwqPw1heDoHxgC6SLe2tNUnAvogIsBZ
	h5zEzQTBg6gtt5v/9nxyua+TJC1Vw2KrLIYJguTSWyVPu3HiWVawpnUu0vG5GLO5cceTNQM0JNU4i
	NGWBpiRFZDfR6Rtz0RUfHY99emoOQLxYBMKNz4fMcmIxUE6V+MNxSwIrlkhaWK0K6+VQYbWK538aD
	eP81eN6HG5uNzsEHFlnauXUr/X75uRHWFAq0C/9G+/4DE79lD/uBncFjGow2bAjGOoYbUsetF2qoM
	9tUjN5kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IbL-00Ec30-Rr; Wed, 30 Nov 2022 08:37:55 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IbG-00EbyV-U6
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:37:52 +0000
Received: by mail-wr1-f42.google.com with SMTP id d1so25901227wrs.12
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfYC1I7WIg8Bmww1dWWk5X2t/tvBwcN0CmoaonN2t0s=;
        b=j5CKmaL+lHOYAdvr2uVgEXgoNwLb/G4KmyAicHFLBd115l0D0HC7WazrjDqwPsTvOF
         lk1gRmFhQY9fWzqDb9tNaQ7znTRUfaiDcMW9wiQDMWAEaVhWffOKCNKXwW4McO7tVWKD
         FoTW+Osfv6KjarjgED7LcKyJ73Lv3uNb6/i0M9xA4hzGqkzlNsSexlfflqoADa8OCXbf
         dy3o4U0Fda0dngkmZqsTLeXjK7Qe22sKdzFL6vAqgdMZCb/LwTfMwBIJGuQ7zt4/yuxj
         ypiq68ypH47ulVxoAcfj6WVkmfLy5Ykpx9GY0ikStPXse+eDW4KKY7buIb8Qy58csaLp
         208Q==
X-Gm-Message-State: ANoB5plk2tNorEg/JSNHnsJhXN7evDavuB6Ep0CdVKJmTgtPvrOSrfGl
	6TafyunTJXbW12NE0PItEE9LNKzyjqs=
X-Google-Smtp-Source: AA0mqf5bP46S8n/xUv6IZDlLTqlSqiLZBptN1f0UjgJ0AwU4IqQ25ABdh5sVnvBjghXzr2qTUhytZw==
X-Received: by 2002:adf:de03:0:b0:236:c820:97e6 with SMTP id b3-20020adfde03000000b00236c82097e6mr36079328wrm.215.1669797467928;
        Wed, 30 Nov 2022 00:37:47 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b00241bd7a7165sm826411wrr.82.2022.11.30.00.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:37:47 -0800 (PST)
Message-ID: <ea20a977-e0c1-d9a5-907e-387d312e55bf@grimberg.me>
Date: Wed, 30 Nov 2022 10:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Zhang Qilong <zhangqilong3@huawei.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
References: <20221122044929.27600-1-zhangqilong3@huawei.com>
 <20221129084725.GB26082@lst.de> <20221129134042.GB13668@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129134042.GB13668@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_003751_036437_DD59C437 
X-CRM114-Status: GOOD (  10.83  )
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


>> Thanks,
>>
>> applied to nvme-6.1.
> 
> And I had to fix it to actually pass all the correct paramters to
> kmemdup, so it looks like this code wasn't even compile test.
> 
> Btw, how can nvme_ctrl_dhchap_secret_store work without any kind
> of locking?

This is fixed in 6.2 with some of my patches.


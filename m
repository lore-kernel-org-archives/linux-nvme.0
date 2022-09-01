Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A167ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfrvPUeDfSxsB+ZYct4Y42o1R68SAbwKiDdGA0lYRRs=; b=o/aUr4agyOICx0UcwmrO96Zo8O
	vqNNvAf67MymsRICumlqm5OZk4DMTTZmucXn4VN4sWSPxn291Bu1AsseaPUdIPfh9pFlo1C5gqfh3
	3S160jlOpMKM48mZ0iWue03eH948cvgzVyo+KZm/S/g14TVFt32E5OO3DjsmV98t+eRNQMw5/PCZx
	IL0URorZKDK7p/kKV3N6d8v4rQBc51CSzPezE9FKr+W8ewuotUKO91flBJA04WG120JeQseC2njlB
	giup3Wuhb2F23g14HGBX2AHCXnYruP//FucczoTWSKuVpMzgaNqS57rGsusQZId/5o0WEV6xI3dOY
	DitZ609A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTkvO-00CNiW-NO; Thu, 01 Sep 2022 14:12:06 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTkvJ-00CNeW-0D
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 14:12:02 +0000
Received: by mail-io1-xd29.google.com with SMTP id n202so14656996iod.6
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SfrvPUeDfSxsB+ZYct4Y42o1R68SAbwKiDdGA0lYRRs=;
        b=z2iEwOE80S0iG313rO+YNUbFY2tCEJHk3q0I/NYmABlyEEIw0uxCMd1J7K4kkpuxBy
         VlVT9TlzPcv3jpBqqDHf6Nvamb+BMWwbv7xTtMNjBiFhrGI+ugH7lXwBmT8hiQfHM7pm
         h9523/uw3V0aAKQ15xjN+kwoecOcTw8Z6eKAyLKlhuhv5cQKWaZE8XQsYN4svZ+vL9oM
         BYg5JZUiXGum2Bmh1OJXvDixzRfb+a+8PbZRVdciFC8lDJn0CEzv7GnaW+9wgGX/o+Yq
         +fBrwHWWnCJ/BH4uMz/dD7R+mVnWsJ7Ydgu1oP9rXBdjBUjZSmbKMqMhDoc0ascJZqFa
         4RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SfrvPUeDfSxsB+ZYct4Y42o1R68SAbwKiDdGA0lYRRs=;
        b=j0Eoh0i9E9H75LrXfF9/SDlxkw2yop7O69FiScTUtWl7kr+lYhj7pYWOMHNddF9/Qo
         ruC1VFzV6dCHw6oqWI5LiZTfAR8uHMaaC+8wHKV9D3c9Q3GqEuSjcLY2Lm+pqoNC1453
         Gtl3DY/EQdNGRXwRd6wlRQEyPX02Qx1PvmzUjoiKeOx8HAyl0WdcJ8GXcZeOwZg/Mev3
         z+I5hd2Bvr8D9K7GklBviiv3XzZq9OyYp13rD7iIhwKn1allKumAZNOcNMoHZtEov72x
         RzEk4TFSbuvQxMyCLFgbr2wxh57dqI3E32IhUdqAb5yRW0cyVSKBgMKHUGB+GDnf1TNK
         YEZg==
X-Gm-Message-State: ACgBeo3sUUcG3JrvJe9UE6tVlWQVV7KCKKVZlGu6V0ihHIS8Y2jjoBFW
	xXW7YsV6UJ8DjddcBLh38QbJ9Q==
X-Google-Smtp-Source: AA6agR4ABVcTUn7sukr/ebvuT1Cz3/kWBYqX1W4p7pAaTobOVZY+FrD/Gmw5BomPJooa/AUJlosY8g==
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id g21-20020a05660226d500b0068adb5d2923mr14861253ioo.175.1662041515212;
        Thu, 01 Sep 2022 07:11:55 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i37-20020a056638382500b00339ef592279sm8017661jav.127.2022.09.01.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:11:48 -0700 (PDT)
Message-ID: <acb80792-99e8-1e89-2972-3878154c1677@kernel.dk>
Date: Thu, 1 Sep 2022 08:11:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YxBfb38kb18Im/QB@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YxBfb38kb18Im/QB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_071201_056710_370D9E14 
X-CRM114-Status: UNSURE (   9.93  )
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

On 9/1/22 1:29 AM, Christoph Hellwig wrote:
> The following changes since commit 645b5ed871f408c9826a61276b97ea14048d439c:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-01

Pulled, thanks.

-- 
Jens Axboe




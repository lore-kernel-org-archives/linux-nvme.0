Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1981C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zFLoHLb1Dak8B2hEAlRd1msRP6Th/qVOfnIe/tfsAo=; b=ioA5T+2jzcxJsj72dp1508sfDs
	jzF4G7qd4L2gih3sWpvUShsuapbOlI0+/J+GudyZ4H/mON6lpcD4cS+rR9iYYso9nRd9fh7qxa89H
	TNp2lWkcHfX5iqK4wNnF39G7WtcPbfNgO1kpJNeDU0Ekmh4IOJ0/J5uqeHihTi5vMBjwS5JPSlych
	cZBAZvE9lvuvGjTvLgJiVdQ24+MzUs1ObWYd5yLOvtrK+TqjO33pnKU0EyCx8+D4+TpH/uDyGkcky
	v4JHTgCMF8C7xq348mof8V0Elc2GjfZga9w6aVpkbRfaChR7raEsndJQMbw1y9WosUmqvpnQVKlqa
	YJJGxRIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30HW-00Ayha-Vo; Wed, 07 Dec 2022 19:40:39 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30HS-00AyW8-8m
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 19:40:36 +0000
Received: by mail-il1-x12b.google.com with SMTP id a18so5782075ilk.9
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zFLoHLb1Dak8B2hEAlRd1msRP6Th/qVOfnIe/tfsAo=;
        b=0h5EajkaNDlkepqaplu4kd0DtQzDvNutIS/6I16Gs3Zqe2qFPpJg5r8fE5qef74UvW
         5r1DUd+RkRH/lRKg5IZ8bKETHSCStUT+OPQ15WNbQIhVGhjqEXe2awUqT/oAQfPAtYot
         ENTaSeq8aS9iwgoxyK7bNtIIc0rCLrxiLmXhgcQgzPG92rsSASg4ijiMDfLRZLNmRA6O
         ATQ3BhoIbANJ1T1Ac1xbh15uUVIQduvneERofvvUCvg4BBPUpqC9EmwBf1ZYQ0Thv06W
         3P773wJ5V5gFlkcqqepB5pJuC3qrYWiJh9VFITMecmwXPA64lPruxuQDBo7e/4HBHcSF
         1OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zFLoHLb1Dak8B2hEAlRd1msRP6Th/qVOfnIe/tfsAo=;
        b=erhByKK3eWsQpTKDkn6hv+1FAXQq2AQ9XRJf0/VsU2RziAQYZiq+/FbeegZVlNx3qA
         nxBdJI3OsGDJ4rWT1/AMRNbpD01UHMKE1ZS1jp/YhDLNtPNJMmvVo4yBP5xCdZLrFzyT
         5DqOIWphqsXWwajg0tVqGVkMDzFKP8lWtWg9nkPbylbBpu+LKpodgx4YiKBeiLX1hpMt
         ksm6G+0rRNoZNiETWYY6TAqb9QDmAyiFVGhLZvq+q5z4KK/zsdgIzIY55NGql//8AiUg
         a6S8ijWkBqZu3eKkutpmSfm7JOmMp+UWz2B7afJpPggV7hu+IdxghYcYTC1Yf0NieIII
         47ow==
X-Gm-Message-State: ANoB5pnQdIwLfrQGwp8GXlbnAcZG+7CWlxy8DcKpZ7gsVTGQyVBPhhFC
	cB9bGbG3oZBf1p+Vlw/nRqVd6g==
X-Google-Smtp-Source: AA0mqf6Jz5PYh1LkEVLw9teBsWBYb8QL6Bw523dDiFXvPgFWqFFhFCmOenpWa4gWj+hTE0+OnXDX9A==
X-Received: by 2002:a92:870e:0:b0:2fa:f47:d960 with SMTP id m14-20020a92870e000000b002fa0f47d960mr33450223ild.19.1670442031401;
        Wed, 07 Dec 2022 11:40:31 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d9-20020a026049000000b00375e136bf95sm7952621jaf.127.2022.12.07.11.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 11:40:30 -0800 (PST)
Message-ID: <3747bc85-967c-fd5a-66e5-7cad42d00bcd@kernel.dk>
Date: Wed, 7 Dec 2022 12:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] nvme updates for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y5DbMySCBMWI7CbE@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5DbMySCBMWI7CbE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_114034_551269_667C5F03 
X-CRM114-Status: UNSURE (   9.21  )
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

On 12/7/22 11:28 AM, Christoph Hellwig wrote:
> The following changes since commit eea3e8b74aa1648fc96b739458d067a6e498c302:
> 
>   blk-throttle: Use more suitable time_after check for update of slice_start (2022-12-05 13:45:31 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2022-12-07

I pulled:

git://git.infradead.org/nvme tags/nvme-6.2-2022-12-07

-- 
Jens Axboe




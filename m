Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263DAC64ED6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Mar 2023 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJFIlarrjVJwPJRCl6YvPmLvQz3xc4je2RmrHpaRSCA=; b=JAoQzvta9XXy+65x6Bn+f+rpnM
	bqlyOS9HoQwh6sMJFzXoaHlfDi09Uz4nZ7cv8Wqbc8DDx9iyFcto+3rnnXJkjKckcT/kJ/10UYDzg
	Qpr9swTXEoNMANpObboPHJ9MylX17QNdteQNTufJJKIjrQVjrbhHtV4XWqZ0deOxWW2JI1zcmOMdF
	WLaxwl1tCFwWtQOAa2BwT9rWeNq0rLR69R6cdG49rXBt4lsIzZiLBY2/XeBFxZk3Fms1GqDN98tMw
	XWh2ivkYeury8PcQX5gY9yXffCp7UqULfFIGjJtlLSoj9Ro7MLPIamoLgMBI3O5vFM4h7O5ycewDv
	Nkl/sECA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXNnC-00GUNB-MY; Wed, 01 Mar 2023 14:50:54 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXNn8-00GULz-R3
	for linux-nvme@lists.infradead.org; Wed, 01 Mar 2023 14:50:52 +0000
Received: by mail-il1-x134.google.com with SMTP id y14so6371359ilv.4
        for <linux-nvme@lists.infradead.org>; Wed, 01 Mar 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677682248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJFIlarrjVJwPJRCl6YvPmLvQz3xc4je2RmrHpaRSCA=;
        b=GHZw0khq3kSQ6YlQej6S98YxeK5PeU76sYzkcSpn6eMLiiCO9bBj1zpI37GiGZ5lan
         FMsJERkETKo8m+7P59NIyyD2ECRFULsr086vEApkQuFJoqLzu9fFzETwJswIwuWx8Gsu
         r3kSCMaFKv9qkCJIHJVzSpRZ/WaK3mCACQv+zM9TlpfoCttQIG2RUi4pgFYxuUmGNnCM
         +OawypJMQ7vFTaSYDf4eevAi9pxrrHHMHzEsxpi5gSTWGnNMDkbqZETGtP1pzVT55bPD
         Xb8POw2T5Vo5JufIYPy60k7se/QBcFUckCQETdA3M596jDQ45eNN6hZ0EMH/AozOeaXi
         gWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677682248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJFIlarrjVJwPJRCl6YvPmLvQz3xc4je2RmrHpaRSCA=;
        b=fvRgUFEfWkp1gnehRDEGU04icqG4DM45ymvwBnB4u+teEGAjt+YWpsdAePppYCFfi+
         Nm3Lq/J5uFPcN7gLuSy6Snv3KbR4PyYMk/1fmdgj4O2wskYWya/CZ4NqyMe0ZtzVJvFo
         RZ9hIG9wR1B9Pdvn0wrb7EZNvvrlSOShrqn+Wu9gsmNRa4gYHb7AE56PC2CpOJgJY4pH
         Kzpd1EB29AlOPI5hhWeTKekqTrawjb85wavPvP1/XmPWWqDQ/wtWl1oo2fgAXXHGdPoL
         Zz7YINfAzEIgZI8s4meDk1LQLuanod/Lh8O0D3tyLvvTplTwlF0SmB43gyO9Za8d0zrD
         m2Dw==
X-Gm-Message-State: AO0yUKV7JcL6cir8gkOTytOcdgA9SDBUBnW9Nyf/IzV+F6rW8A/+oPGa
	vibBp2N5BkPpz33EZxIv8mSMeEpHTAkp/rCe
X-Google-Smtp-Source: AK7set9EltZZrojlAUGifnFi1l+Q38lmH9doSBfrFMr+bO6GkySqbALWbVM7F64wsrr8qZxRjb4CQw==
X-Received: by 2002:a05:6e02:1a04:b0:317:33fe:7d59 with SMTP id s4-20020a056e021a0400b0031733fe7d59mr5131341ild.2.1677682247932;
        Wed, 01 Mar 2023 06:50:47 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u12-20020a92d1cc000000b00313f1b861b7sm3612802ilg.51.2023.03.01.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:50:47 -0800 (PST)
Message-ID: <65c8524f-e21c-04e4-c56f-8bb24eca9cb0@kernel.dk>
Date: Wed, 1 Mar 2023 07:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y/9Xn595ioya85dO@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y/9Xn595ioya85dO@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_065051_128728_0DCC8AAB 
X-CRM114-Status: GOOD (  14.73  )
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

On 3/1/23 6:48 AM, Christoph Hellwig wrote:
> The following changes since commit 310726c33ad76cebdee312dbfafc12c1b44bf977:
> 
>   block: be a bit more careful in checking for NULL bdev while polling (2023-02-24 13:19:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-01
> 
> for you to fetch changes up to 26a57cb35548ae67c14871cccbf50da3edb01ea4:
> 
>   nvme-fabrics: show well known discovery name (2023-02-28 06:14:44 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - don't access released socket during error recovery (Akinobu Mita)
>  - bring back auto-removal of deleted namespaces during sequential scan
>    (Christoph Hellwig)
>  - fix an error code in nvme_auth_process_dhchap_challenge
>    (Dan Carpenter)
>  - show well known discovery name (Daniel Wagner)
>  - add a missing endianess conversion in effects masking (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe




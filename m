Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332E4ECAAA3
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b/kOGC4F2xUm59JRxyr6870MdL+nGgrRYhM7/o4VT0c=; b=r6UCDhCbWVlPYY3j4W+rxw+dt3
	/RqfPz8A5b74cPpyP3ooMy+ibOAgOshIZ86CcdEA8C/J6SaMZJUMhBSwKxmEDb8CHohPEYEVf3YlN
	FlI7eCbAhhoa3es8XuXj1DmvMufzKNCKHXc9+poGFY1x6tGeunZCUmBprGmh51ILdtuYVEYBF17Y2
	1X1sWw5A7+tsM8Q9+ZW7e8P1B/ALcriFx+D0FyCZH6sM/nYyxGvO/ZJydKzDL6MolCePpRJN08ZQd
	BXaYva6O/uu4jqF5Sj2ttKMIqs6kxbkS4uyuEovvo/n6W5zFcuLLrQaxCR9R87ejBHzdc+bECAzsf
	cN+D8m9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKu8-003g8r-Ne; Thu, 25 Aug 2022 22:00:48 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKfw-003YCJ-I4
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 21:46:09 +0000
Received: by mail-pg1-f169.google.com with SMTP id c24so18993052pgg.11
        for <linux-nvme@lists.infradead.org>; Thu, 25 Aug 2022 14:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=b/kOGC4F2xUm59JRxyr6870MdL+nGgrRYhM7/o4VT0c=;
        b=x8arjvRhrl+3laOWQkWKzZQz3uQHeVSmTS2GAZPxB+GnEg2PZ1f9Z0EKeKsBaE4F0L
         1bQxDyHX37IfRdkTwhWMyMoVK+Ybxsj8b9ZHywNTEm39DwhnxFshKqHq/9JSniVjUt9r
         StV1+2MN1kSuWlBHgB+47VqA/Qg3gMZt3SNV91u+GnRKZTwvuqMJVQVH4FBZJs33rva4
         HNpNZ6wWo4NbX3zLxSWIZXUGnpxz7iZcqVj/gEXWG3EJvZMRi9yDkCA/Lk6LCu6LhRGN
         pRWpw9AlkTdYSOniTV1TwhQdE/KtEOtUdiQau3SS8bTrrexl6QsOPet2RMUkU9eJzBx7
         5sgw==
X-Gm-Message-State: ACgBeo3b0atKbouj2nVkIoaWUeXwB2PxfxUEa6jPMcEnyq83Yaekn7IU
	UMb5h44PidYIIqujDZ3AcqU=
X-Google-Smtp-Source: AA6agR75klAqItVGOT27TBqBxype2jtUq57AMSY37jZpLRunDrmU0pjJoNsnSIYBhfJ1+Z5ssbsM1g==
X-Received: by 2002:a05:6a00:1a91:b0:52f:29e7:c32c with SMTP id e17-20020a056a001a9100b0052f29e7c32cmr1064285pfv.10.1661463966264;
        Thu, 25 Aug 2022 14:46:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0016b90620910sm49487plh.71.2022.08.25.14.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:46:05 -0700 (PDT)
Message-ID: <ee3be9d8-b473-8e59-4d3c-84e0ef9dd6f8@acm.org>
Date: Thu, 25 Aug 2022 14:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
 jaegeuk@kernel.org, linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121907eucas1p295c375935b556729864dce39534c2579@eucas1p2.samsung.com>
 <20220823121859.163903-6-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-6-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_144608_632256_895ED09B 
X-CRM114-Status: GOOD (  11.07  )
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> As rounddown macro from math.h does not work for 32 bit architectures,
> round down operation is open coded.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D535C83F11
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e+8NbH3OkSUgunICilRSyAwwlEnHmG2jLuoYIeResH8=; b=Z9F1V9kQ3DYn1KcFbEolfC4WvR
	GzFIxpStvtUYk+Z4OYM0E3zSWtQXJzLDitTwJ/vDYRzQh1Jm+tJ5WiUK4Um0b6TNl9+uFFyi2Lxs4
	ZekLBujvy7ItkL2ccz+ZpcnEYnjRyJZJf/SPEuidzQDwtCgPDoUOlKC9P71FB3YmbZyodHbWGJ/oE
	Y6u8XTiu5aIOJsGd7euzlUu4qONAPOuS6Bq0+MOBkNi5i19Yn0DW+HfDsXH28GDY/i7Ib3mEwU0o0
	tyvG8QzkGG7ONvPrgV1sBHMGfarkg6jlTg376BFH5B2n5dMTR9xMp5YCo4VpSoXQn6gJYZjDMgNI9
	m2b5HUAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qadwX-009m7n-21;
	Mon, 28 Aug 2023 15:14:17 +0000
Received: from mail-oa1-f51.google.com ([209.85.160.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qadwU-009m79-2c
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 15:14:16 +0000
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1c4dda61eb0so2426698fac.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Aug 2023 08:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235652; x=1693840452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+8NbH3OkSUgunICilRSyAwwlEnHmG2jLuoYIeResH8=;
        b=DVAUUa50ZLkKCAJ1eTuMbgxTWvLbMhJW2C42t1TvEPtZ/9HOXy1uZeJCsmZH0hfFP2
         CDAXcRVl/dCvZKXpia55Zv6lpMyVFEe+KQTEUePWZ2hpcrgaTpI0ADoSfJEpaV6bKHzO
         p1hTWOA7wx/tCo6VrNSqmSSMh+MiWQZTvv8UYFH+33YgYGZSmrV2dLST87N5PteiiRwf
         JCHQEgC8jxpYAP8a56sixxMgoH9qWT4luDfwzDlkyIaiPzWoNa+12llTAGhuqZPPbKIo
         ld/1LPfjaqcYHoJKOxUC18dfH5DGIO8OFtegKrlG+A2aTJQpHDCjVYLgJgSYheK0vpzJ
         Fwag==
X-Gm-Message-State: AOJu0YysLX4vxazEVY8Gp7Uk7Ua8cPrweJpmHR4WeFoM+xRHUq3tSOyO
	w04qdw/jJRRegdPHV948rWI=
X-Google-Smtp-Source: AGHT+IHehlIs0QtxM1G3arB1CsJ+l1ULiJfDx1nonQ34Og0tJzw+InmyhN+hI3mSyQkLfTcVgUYTRg==
X-Received: by 2002:a05:6870:418d:b0:1ad:4c06:15c with SMTP id y13-20020a056870418d00b001ad4c06015cmr12264398oac.18.1693235652069;
        Mon, 28 Aug 2023 08:14:12 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b0068bff979c33sm6708230pfp.188.2023.08.28.08.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:14:11 -0700 (PDT)
Message-ID: <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
Date: Mon, 28 Aug 2023 08:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230822083812.24612-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_081414_848021_4B1E0903 
X-CRM114-Status: UNSURE (   8.88  )
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

On 8/22/23 01:38, Daniel Wagner wrote:
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--blkdev)
> +				blkdev_type="$2"
> +				shift 2
> +				;;
> +			--ctrlkey)
> +				ctrlkey="$2"
> +				shift 2
> +				;;
> +			--hostkey)
> +				hostkey="$2"
> +				shift 2
> +				;;
> +			*)
> +				shift
> +				;;
> +		esac
> +	done

So all arguments that are not recognized are ignored? That will
make debugging typo's harder than necessary. Shouldn't this function
complain if an unrecognized argument is encountered?

Thanks,

Bart.



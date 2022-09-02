Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F207C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXSB5TwQbhvqvewpZ+yLTD4zJlq0TXQvGw/arvh5s4I=; b=dft2t41kMKKuwacHB9ALlS7DOL
	NVXCgqEPsQVTmoG8wResjP2PXQtyibqosX6lZ8QLjWdKrYqYkcRyIynl2/FIQ3LjrCoB9j1uxhPjw
	5MtqlQJgeQ/Z4GA90jlaDe0GTvuXzZ+ECmXREQckuHZBGlk5HsDkPB///BFnSRxn8Lic8RQl+stJ2
	/QwijtiOSz2fRYNWWgFvfZeFMsd1dcK+11dFsDCV38d2KtTt88rihCUi2Go7K3AkLPO+NxWGKX7Kx
	CcYDmCBhogCfYE7Pkm5dwI/mMgPxeP0LdinCLngkpsG7NZGX1FF7Ie8BJE+OvLhMfJeVJQph8+NtD
	E8FdOGQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUFr0-00CrCw-2R; Fri, 02 Sep 2022 23:13:38 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUFqx-00Cr67-E3
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 23:13:36 +0000
Received: by mail-pl1-x635.google.com with SMTP id 9so30894plj.11
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CXSB5TwQbhvqvewpZ+yLTD4zJlq0TXQvGw/arvh5s4I=;
        b=ydYkR1iRxIzyhVhT6ccZmKXT8Qn8AKHxRsc+Ure00NiYxb45RSanHnq/6xmpSiqXLh
         WjKbAXViH3J8OqdcKTBpOAB4+81FRqfJNIdAXpQH1wxoJEXQNtbL9ZbZr/cC/tu9LIEi
         a4ep0wmMZBQv+w16n4R+mot2yZSZ0+koUZunuvHTOv53RJbiNrrUnmPjcoe8TIN9Zk2y
         YfdlLS4daLj7Lv1RX5dGb2evckuypxQRbZsD1uto9Q/wrSL69HUaPW46aP93RoV80KDA
         6KRIjpfqeL2fC4xTr1HnbhXHTwMDq3K3o+u9dUW3iu0lgltHGkGZC/xtpC2GeCD2ZuAN
         VasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CXSB5TwQbhvqvewpZ+yLTD4zJlq0TXQvGw/arvh5s4I=;
        b=wiIdwJ+xttV2o9mPQbgOHwEB9krXheE5picwn3qGk3w1aOhpMgyF2b6o/OgR7hDRvS
         anuAwz79pFfHHQ6DI8z8uvLGnZDhhIH5NMDiozI/tgsjhJHX4UnzJLyjOd4BuAbUfeov
         XvnTOyjUSbmz37aYEKuxb8bkw15sQ+NXNEi2w48IKvQq4QbfRZlmbT3eF8tpwbmYG8hZ
         v71rCM3Khk4Ur4+lcmj3rvuOGnnz9ZWNIIpUiJ8H59Ojc3xJW2OXIKJbP2xv4M8EFnVS
         mWTR4Hx4sWDhb/+aSqL57oNvJe3vQDTK2DF4aX3Jop5kNii2ZhhBBAgKWI4tjRrt3FsW
         6COw==
X-Gm-Message-State: ACgBeo2DxQipx5r2AVBF2mN9vKq4fNTGMcAlrLDUJsHuDFyrYmaVEIBA
	huW8cuK0CPsgEy9uJgl92yzm4A==
X-Google-Smtp-Source: AA6agR76BTTkq043ixjnj0rmLmscN3HwyukynuCP9i23k3WkPxF7v9Fg7NyV/p1llvEwU516/dBXpg==
X-Received: by 2002:a17:90a:ec05:b0:1fd:9368:2c8 with SMTP id l5-20020a17090aec0500b001fd936802c8mr7215591pjy.183.1662160413809;
        Fri, 02 Sep 2022 16:13:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001754cfb5e21sm2243630plh.96.2022.09.02.16.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:13:33 -0700 (PDT)
Message-ID: <71945cbe-fe10-2d53-5df7-9f7e6f88a905@kernel.dk>
Date: Fri, 2 Sep 2022 17:13:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 2/4] io_uring: introduce fixed buffer support
 for io_uring_cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220902151657.10766-1-joshi.k@samsung.com>
 <CGME20220902152709epcas5p1a1bd433cac6040c492e347edae484ca5@epcas5p1.samsung.com>
 <20220902151657.10766-3-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902151657.10766-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_161335_503102_DD25B736 
X-CRM114-Status: GOOD (  11.47  )
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

On 9/2/22 9:16 AM, Kanchan Joshi wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 48e5c70e0baf..c80ce6912d8d 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -56,6 +56,7 @@ struct io_uring_sqe {
>  		__u32		hardlink_flags;
>  		__u32		xattr_flags;
>  		__u32		msg_ring_flags;
> +		__u16		uring_cmd_flags;
>  	};

I don't think there's any point to making that a u16, let's just make it
a u32 since the rest of the flags are like that.

Rest looks good.

-- 
Jens Axboe


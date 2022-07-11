Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D19C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0tFRdeac06SJMsCOq/f2cgz2EY5sDCDg1mZk+43QRV0=; b=3GA803bruphXVYiH06tOrIzWAz
	5Eel8aJw3VkTlk262+isAhvj/a7IyyIIr8GWQ/UPe4t4Tzwx0SFwapGLqYcwwtwa5EXNNqlDv4SgX
	8A/70ug5OYvrhUL5e8EpRqN545j6PYVqNFDCPMuVsKBXv+XdBIQbiY44rg38mDPtLeUDTAI8X5JnI
	GpQMjms52RK6geCw01qK37NgR9g5MfWt/IjWDP19JLUzsc+YBOirBtFcA6pqHPQ5TsjqrhtKesG6D
	MtZzgxQ/ZDXUL/1pnXAPK+oiiqb8YvJwR5IUF7+T9GG2xNZkb0ldqPziQUlNxhuF/lzryRQNzqU+p
	ve0/AWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAx3b-003S7a-2Z; Mon, 11 Jul 2022 17:18:51 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAx3X-003S3x-TL
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 17:18:49 +0000
Received: by mail-io1-xd2d.google.com with SMTP id v185so5508417ioe.11
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0tFRdeac06SJMsCOq/f2cgz2EY5sDCDg1mZk+43QRV0=;
        b=ka65AOIn5LxDbde2si8bwDbYBSN5qbpoeB2GLKlYUZKseQ/isw0mnUoMaMQUQa7JWz
         eQ8LecRXq7XZ+7i8GGZOOW3pdQ31Jh2bO47iYCh85DaiZeXFik9p0R8CheRULUcbX49x
         L6alNSRp/Hg56lhOQQK7CACBpdtw+TKsSaBEvWiVe4SJv8y7jILgKd78IRjzsjEqbnAB
         BzOLdUib9++niIUMMWWMMdSkeq2OlvNYWcPo3Mdrf4aefcSiWhNA9K9UkKICcpPYVMLJ
         Nr8H+/bNrI2wLcvqVpm551r3J8B5TZMnfW94RMEXkWMP32wjl/ABNhyQ/lMCuq2hh5LR
         lMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0tFRdeac06SJMsCOq/f2cgz2EY5sDCDg1mZk+43QRV0=;
        b=x/sGQeDsq0A11Q8nbO0em7ni2G7oP0McC0Hj8pZx7/Yohs/lD165KW0nQTJkc+4IG6
         Wsow3KoP7cZI3364aj+7Z8xAkAvgpW/rYXJ0IoImCm01kA8BQ2TDNgE14znk8eRt+Y0y
         37DUH2mYy6T2+Q/Z1jfKEIf0IZHrksPSHlBsNY7XM6Jr2A3jDixfzgMwrtSmd16m9jIs
         mAWTC63wtIF5KBn3RJTP4snG4M5WpBZ8YDI375C34qWFJiheZVD+uCsJxjfbzSDyK/bj
         Y90pSlYSVLnTozNSwJCAdvlgIAM4R3sQRIY41Y+9x9WFsXeNYlXVi24N9Pqyf4IktEyp
         VTgA==
X-Gm-Message-State: AJIora9jom1mAd+9GkIXh54NfWQCkBqq3npZTuH8eKd+HhjyUV9ocW96
	5fxjeCvBbHyqF/I8FRH7O9z9wg==
X-Google-Smtp-Source: AGRyM1tZ/tuzzEuYjxyhBIk6pqAW/CgmVerMDOF3aoAdK7DDenHSvDRfSrbmPmIdIqisEtD/k7IrLg==
X-Received: by 2002:a05:6638:328d:b0:33d:5615:a95a with SMTP id f13-20020a056638328d00b0033d5615a95amr11039045jav.96.1657559924743;
        Mon, 11 Jul 2022 10:18:44 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q17-20020a920511000000b002dc2a5abf44sm2856494ile.62.2022.07.11.10.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:18:44 -0700 (PDT)
Message-ID: <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
Date: Mon, 11 Jul 2022 11:18:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220711110155.649153-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_101848_195011_D2144D0F 
X-CRM114-Status: GOOD (  10.09  )
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

On 7/11/22 5:01 AM, Kanchan Joshi wrote:
> Use the leftover space to carve 'next' field that enables linking of
> io_uring_cmd structs. Also introduce a list head and few helpers.
> 
> This is in preparation to support nvme-mulitpath, allowing multiple
> uring passthrough commands to be queued.

It's not clear to me why we need linking at that level?

-- 
Jens Axboe



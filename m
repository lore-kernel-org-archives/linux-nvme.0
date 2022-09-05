Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25905ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMGczNNDnvQjhMlzadltZhTx6kCLg0d3lQU+dzOdk00=; b=TDSW6iFMJlhiXElh1Kqu1uDfTR
	pTgCF2fdL/eIX3H9pYTKrxE+X5qgITcf4nqdStrfJq9Wq1V83w5ghQCrZQmQrtXv/laZ+NKVjPOyl
	Xl7P6NKkkB8F7vzSjV4wLwsz5klFex4sXarLNWD38Rh99TpkubbsidzS+cN0x9+FWTo4p3lbepczB
	VoFBLwn0SmYzc4WeJrc26PqE9qUeGyoygDADW4URyMYiIRQ7uDAYLXW41yEA645nypzOnFYGHcvTD
	BsXHz7LjskfIpqzaNdp+RWaCjbjACfiC8ZRFlhQQxm6Ev6LDpIZZLJ7dVc6UxRQraSIBTOOL2bORg
	wDxNjf+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVHUd-0090Xf-IE; Mon, 05 Sep 2022 19:10:47 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVGJM-007wPe-00
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 17:55:07 +0000
Received: by mail-pl1-x631.google.com with SMTP id iw17so2443993plb.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oMGczNNDnvQjhMlzadltZhTx6kCLg0d3lQU+dzOdk00=;
        b=4f9VNE3QHhF74oirW3Xm5YT6Z5IFvSEj5gD4lTkrK0JXgOO4NfEbFcAc72k53/HTaF
         fPwqjITi649PlkD/DLc4ugJ0PyZICzECgstdw6ebg6KFL5zsgIS/TSU2Mv+33EuqtxhC
         f/LPzzyOFrwxaDSyWh/5lT3HT1V79THSAK7q8wVBO1toQqAQX8YFvVlAtx4XwJzCz1fZ
         xhusl4SaN65Eh5REORD4JV7k4hPZV/TqBS9W5cX5I1UX9oPHDbgAs762CMF6CJl4qmVq
         4/nXPNvT/BJdYNteIDkb+1nQnPRoPeSUUDvgwubbbnhz4DrvZUJjITgH69FOFSUdmJ7y
         Hg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oMGczNNDnvQjhMlzadltZhTx6kCLg0d3lQU+dzOdk00=;
        b=iNmC2DvNAERcdRlYNX3XVRq+hwNvkU//Zcpk1a42msADrZre7xehdzmxBSn4jg60GO
         ymLCcn4KPyEDkFYQ2207iX2XWTfRyqfUE0M7aG2bAZang4jNqlplyEQu9Q3ONo7/pMgm
         DT+6snoMJBo3aa0g384RhsZlyK6FLB2tVZH+T4PM4CdZPkwaOBgn4sXt9Kwcsb1tsJ48
         mINf9TgNt3oy7wiaoz7V/kiP+0fR1ZcR5lmdVbgcbShkPbKo4ZFdbvu95VX4ITLKMI53
         92Jdk/yrqyzc6isIleF3TvQsNC3qCuUvC2sxN58Mshw1IUkJftvWeGqVVAzse17jQU6+
         BvEg==
X-Gm-Message-State: ACgBeo26vQDT0M7iUrt76HN76ypkHwDkKPjCU5kqXugkC+JBDklzW+tR
	ULYhoA3g35ss9bUWlXNoUhNLVQ==
X-Google-Smtp-Source: AA6agR4Zfo2wzIoy/4ELYjXlw/YqjBdzzZVMytXGu7EWjMtl/52eaJQiyCI2flPR9ixZ0xD3T5PV6Q==
X-Received: by 2002:a17:902:bb8c:b0:172:74c9:62bd with SMTP id m12-20020a170902bb8c00b0017274c962bdmr50297464pls.87.1662400500263;
        Mon, 05 Sep 2022 10:55:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o7-20020a656a47000000b004308422060csm6524186pgu.69.2022.09.05.10.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:54:59 -0700 (PDT)
Message-ID: <34abf867-93e7-c168-f5ec-289c72a020c5@kernel.dk>
Date: Mon, 5 Sep 2022 11:54:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 2/4] io_uring: introduce fixed buffer support
 for io_uring_cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135848epcas5p445275a3af56a26a036878fe8a8bcb55f@epcas5p4.samsung.com>
 <20220905134833.6387-3-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_105504_166086_6C2B3A94 
X-CRM114-Status: GOOD (  11.36  )
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

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> @@ -76,8 +77,21 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>  
> -	if (sqe->rw_flags || sqe->__pad1)
> +	if (sqe->__pad1)
>  		return -EINVAL;
> +
> +	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
> +	req->buf_index = READ_ONCE(sqe->buf_index);
> +	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
> +		struct io_ring_ctx *ctx = req->ctx;
> +		u16 index;
> +
> +		if (unlikely(req->buf_index >= ctx->nr_user_bufs))
> +			return -EFAULT;
> +		index = array_index_nospec(req->buf_index, ctx->nr_user_bufs);
> +		req->imu = ctx->user_bufs[index];
> +		io_req_set_rsrc_node(req, ctx, 0);
> +	}

Should that buf_index read and assignment be inside the
IORING_URING_CMD_FIXED section?

-- 
Jens Axboe


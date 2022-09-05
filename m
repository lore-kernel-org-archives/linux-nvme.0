Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB5ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeGc0vwJDgBIJyeNrQDrz976x5n1fo0aH2VcrMu6kPU=; b=CoteNLDw/uJgN7bGYQs9DkCtq+
	UZITOWMKLgNKHt60GdECucTF/TyORA8T5NDF9R2qzJRo0zsbXtMlQQgCEY+0OXQi/yTuIk1yvVRkB
	qudKdjYCnI3bnFOPqAAUenSfMCDqlMPjya0mg3XQOkf/aEdtoduscx9iUz6yfZzshex5x7z3ROH0u
	0Xl8JIk8AAWq3mSFHkWcfShzZNRK+0LtkFNH8o4TVSynD64L0+ACjbi++5oyKajYz5prUbf6uHHRw
	QCrO/1b6akNKvHWpb4cLhuaaRWdiTqfvZObp3AQj3hgi0qwmFhzDcdGsRt5i/CDv20MFJ0Vm93Nhk
	CMd0cVLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVHU6-008zyo-41; Mon, 05 Sep 2022 19:10:14 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVGI8-007v9C-Uz
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 17:53:50 +0000
Received: by mail-pj1-x102f.google.com with SMTP id fa2so8993988pjb.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zeGc0vwJDgBIJyeNrQDrz976x5n1fo0aH2VcrMu6kPU=;
        b=3TzLFPJsgQVoyzIEgelyj96PTJ9RA2qoPFKMvnvgNEGKK3Xg7EfO0JMiwAXt32iElf
         vfYSQMKS+7btTv0zYBL+JqK4B164T+u6A4q65qijRqZyjFwAkIJp873GODXmEqUbmCCl
         a4PU+gLa9IJVBoluV1WyE8I2Zq7+YUslviqLsKLMihwruNHwSorxpHp+7VzMqUYi3TBx
         YFyW7ALBsYtKGUQT/cNuSBySGtF5RFshRyz4JQlfcDDqnfeOdKj2rIW3G6/Iq+Iicinq
         dqOHLOCjuAfw7X/gYLQhSZJIUxQsokZNds8p706H8863+sWLzEVugxnU1gj8eVaU8mZ3
         4+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zeGc0vwJDgBIJyeNrQDrz976x5n1fo0aH2VcrMu6kPU=;
        b=6yVBYbldPeoivBHxb4FZdsDT6j8P/E2TcglBCcGQSi9rZtUqoNgwuts2zQSk2eZPbR
         NWHxYg8M/1GcPgoJ+oeAggv0FjI1HmC7ZY7xO57nmFrufQtH9c/Qv1h53Hdj8Wso4jsJ
         J8Ds94/WhCuMdAlbZLrtCeGL4xypf2Nfu/eziL+8Ns7eJtNuM+b1j3tN8ri2d9vKhafo
         HM2IBCRLnxqV2PxzUkNyYiTT9epByIYb8JNVw1GJWREesPcvDy0WWmXq4Xezgq3fqT0h
         aAGT00iw385LvugaviALsooBPi53la0XNm3OG9QBxneOoIgOY/+PtGNwDAl3DRKTifaz
         oKxw==
X-Gm-Message-State: ACgBeo3QF2Z6j8SRRI0d4A5ySyYMxcYSLkfWHMLkGzAdqPJ2oLh3Sxlk
	6NQxCYi/vxnSajXYHjyg/Hg5XJGDht/VAA==
X-Google-Smtp-Source: AA6agR7DiMNf6wfT4ZoG5rsHUmL/ehmUhw+ETrtpWSzJRoiOawk/VgiGVH9Vb1lT8IaVGei10sbUSg==
X-Received: by 2002:a17:902:e848:b0:176:c746:1f69 with SMTP id t8-20020a170902e84800b00176c7461f69mr1501581plg.125.1662400422716;
        Mon, 05 Sep 2022 10:53:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u67-20020a626046000000b00537e1b30793sm8331899pfb.11.2022.09.05.10.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:53:42 -0700 (PDT)
Message-ID: <5a0f98a5-8710-0719-91e6-e75af1818b1b@kernel.dk>
Date: Mon, 5 Sep 2022 11:53:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b@epcas5p4.samsung.com>
 <20220905134833.6387-2-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_105349_177740_E960E652 
X-CRM114-Status: UNSURE (   9.82  )
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

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> @@ -124,3 +125,13 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	return IOU_ISSUE_SKIP_COMPLETE;
>  }
> +
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
> +		int rw, struct iov_iter *iter, void *ioucmd)
> +{
> +	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
> +	struct io_mapped_ubuf *imu = req->imu;
> +
> +	return io_import_fixed(rw, iter, imu, ubuf, len);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);

Oh, and since we're probably respinning this one anyway, I'd do:

int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
			      struct iov_iter *iter, void *ioucmd)
{
	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);

	return io_import_fixed(rw, iter, req->imu, ubuf, len);
}
EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);

to both fix the indentation and get rid of the 'imu' variable that isn't
really necessary.

-- 
Jens Axboe


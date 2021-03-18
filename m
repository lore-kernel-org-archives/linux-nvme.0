Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6982C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 12:50:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433B564E28
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 12:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433B564E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mBPMa4jKmUbKUr9xt5hX9ajdZgaUMQCHjhbVfv8n+hk=; b=JC51HzN0Yyp38dRB68/Tz1moq
	9+ifKad/i/Rzr59a6i7xijUtlUkrU2FRmw75wauvIA+x09VPhSg+6firjFBTYszPQSIvTmx/EpYQ0
	YyUjuU3rhwpFphl9y4Agu6tOCGFYcXy0xURtsOisE1rLoXaR7Nuvyn4kWpOEOAGbevccDf1jxzplR
	p+wH+RJX6AFoEkO0fKoEK61bHbqCXPym6xffFLL/ybdG7NQ0AvJgPJf61yQbxa2MoDcL1RFVziwFp
	JP0VCb3UpJZTSkfmg4el04z6Hj5ljdfd3g0GSa5lUas7MTP+YOWrv7vdGRFnAG/6650fWRzKxlukn
	yo+m/72Rw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMs5k-005G7U-JA; Thu, 18 Mar 2021 12:49:32 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMs3N-005FaB-MI
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 12:49:10 +0000
Received: by mail-wr1-x431.google.com with SMTP id k8so5390581wrc.3
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/7hhXouXLzXJnQVgooQWsG4lzJE+kCYvy66qhcwIVc0=;
 b=iQ/px8vy+bSVHo9K315/Wv1T2UOq5ZuSDW6/62XqoMfFMT819TPq8ReU8DlSmev09f
 b/drhiFwBNPkjqqNnjFZe6tK0NXLkAR/pZdwkPayplkXv8ugi84lfZUR/41NbQOY+02C
 q3rqTT1sP21innGIpX7P2EBzIoul2Nf2ryGHMBUqpIzsNWzenOX6FucWI06psrKYCvtA
 euHRQ2lsXeZrg98X1pEEsHX2TfT4bUo4MuiCDfPrr/NIFMkTipulmDpcEFF7AVf0zSRJ
 gsgNA6rU8RYfwt1HQZbCOFLmdlE7OUbEuvV+40Db6APtl27UkZWZAafR/tcl6nR2nd4U
 pogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/7hhXouXLzXJnQVgooQWsG4lzJE+kCYvy66qhcwIVc0=;
 b=J/qsQluDAymKNbDPKvZeWNurhV36MslUp3w1FuPeyoDutkKUnRPV8zdP94JnRMKPe9
 cnaQSH2f/HuAdZnuwVYCXSX4kNU/sN0YxDJ8fOz2S8TxpdSH3MTYnDe17EzmILMSCwWn
 Tj5UuULjuiPGI0sjKXUUIPkP7W4bTkdgBqZrn8BMM5FfmnSsKfzNG/0KqudD0+gd5DlA
 6E1uENyo3uYj+HXGPS/2osaVNh0g2Vy3BmD7TwfSXcAGEPXFBo2HWSn3JCkegYZnmxMi
 ybdFAlGY1AgPJRNNA9pbT804tQE8bp+U3r1Kf8fd4lTtDE8mCMfVtJQWQaa2R9V+kKt/
 Sz+Q==
X-Gm-Message-State: AOAM531F0vmHOPnxjJPEaksCEhPVkcRmkyFPai+owiTM/XGf+9r1hIJB
 27aGVgbpAPOunWHscLWg7es=
X-Google-Smtp-Source: ABdhPJwBSC/VqhemD3bDjaOq855R5P/g+LLsw2Yki9qlIYVytFpeqhLYhqc0wlhqe4u3hVbjYYC4Ng==
X-Received: by 2002:adf:e809:: with SMTP id o9mr9783503wrm.110.1616071624504; 
 Thu, 18 Mar 2021 05:47:04 -0700 (PDT)
Received: from [192.168.8.170] ([185.69.144.156])
 by smtp.gmail.com with ESMTPSA id g11sm2789419wrw.89.2021.03.18.05.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 05:47:03 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-7-axboe@kernel.dk> <20210318054506.GE28063@lst.de>
From: Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 6/8] block: add example ioctl
Message-ID: <dc15ec75-46c3-8e24-d061-5992f7dedcd1@gmail.com>
Date: Thu, 18 Mar 2021 12:43:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210318054506.GE28063@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_124906_295436_9C8EA97E 
X-CRM114-Status: GOOD (  16.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18/03/2021 05:45, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:10:25PM -0600, Jens Axboe wrote:
>> +static int blkdev_uring_ioctl(struct block_device *bdev,
>> +			      struct io_uring_cmd *cmd)
>> +{
>> +	struct block_uring_cmd *bcmd = (struct block_uring_cmd *) &cmd->pdu;
>> +
>> +	switch (bcmd->ioctl_cmd) {
>> +	case BLKBSZGET:
>> +		return block_size(bdev);
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +}
>> +
>>  static int blkdev_uring_cmd(struct io_uring_cmd *cmd,
>>  			    enum io_uring_cmd_flags flags)
>>  {
>>  	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
>>  
>> +	switch (cmd->op) {
>> +	case BLOCK_URING_OP_IOCTL:
>> +		return blkdev_uring_ioctl(bdev, cmd);
> 
> I don't think the two level dispatch here makes any sense.  Then again

At least it's in my plans to rework it a bit to resolve callbacks in
advance and get rid of double dispatching (for some cases). Like

struct io_cmd {
	void (*cb)(...);
	...
};

struct file_operations {
	struct io_cmd *get_cmd(...);
};

// registration
ctx->cmds[i] = file->get_cmd(...);

And first we do registration, and then use it

> I don't think this code makes sense either except as an example..

-- 
Pavel Begunkov

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

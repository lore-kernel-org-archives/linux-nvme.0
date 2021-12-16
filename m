Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E81C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRFQR8Yf1vYbRc7EqH9E5i9XTaBo5dlhI5KykDhEunY=; b=om/L9g4j5QMmfDI33boyrJA7b/
	120o2Kbi6b2Y6CvE0v01fMogMODSL0WC1Wa0oUHUVLbzMpRBzma4/WFn1d2kZcFimZgGh3GQyBrjw
	WNsH+70NlNvWckLsHrATk5kI71FcZTqHetUnDd49w3XP01e4ik42PgVDnK7h6ViPSrmEq3Kq+u3hQ
	ZY+6ciJqLfWXEHGXoLxSL0xgCORZaqRYq9unQ++OLbiOSTaeehbDD6l6yDEbrWAq7dNvV/ep/XqF5
	HtKGu/cWL79HB1+AYgufMk4m2C6D+G5/r2MrJ28sQBckJod1MLUKMKCdV5tL0c8tN8t2HDP/wOJL9
	EY9W479g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxszG-006P2Q-8c; Thu, 16 Dec 2021 15:48:06 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxszC-006P1Z-U7
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 15:48:04 +0000
Received: by mail-io1-xd2b.google.com with SMTP id x10so35730259ioj.9
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NRFQR8Yf1vYbRc7EqH9E5i9XTaBo5dlhI5KykDhEunY=;
 b=jbGPcR8DsNLJmTTf6Jn9+BAvg4fll+eALhhOgFsGp/QxKiyf2eXeO/QZehs90taEM5
 3LtUg4rDb794xYffxF2sADQi7iP+XEXA1KB3sonsG0AHRXtK2neRkUFAPylYDlYVYqU5
 or8HEX0QhTXCjKXZgwdfg1t97UiAHTeGGtfIQHInHTzRBpmwh3SfhXau2MrLoplwy24r
 W8r16JxcPaTWD95IJF9JIUZSnEd3+Eme0MfTGZyOX/qUogC7yPIKavUJmqWVExMS3HBY
 CxNpYVcHQsZrcJJItYMK2+tx3ivpnbOecMDV82BSlSTgaMG8ydKudoBBFSB8X4vGeS3j
 weGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NRFQR8Yf1vYbRc7EqH9E5i9XTaBo5dlhI5KykDhEunY=;
 b=IGeaOT1FiZpWiWDZXvp7HlzaDwU2eSgVLd5uSo99tPszk34xq0aq39WHrK3NoMZWtH
 4H9f1SlxAjzZWVLKWkZyZurDRrs4F8UmVCoNZTPBz+z24m+xZxWVHklGT3Gq3Wbx+H09
 PqTrS9t0zhegQJqtIfrgTON9bbCdeFOQAUR0DHkUVLPTBsaPpEqsO2/CXE87a7MoTKr4
 BnvPLabJKWG04WkZcwbjuXWrT7cHFhL5batb5IybT1iigw2RBaOlru+LFizlee+g7j/L
 kzU0kUtWLSqvjsvLDeEjxPOv58CiLV0O6Py9AmydQQHeJYYg86hXnT8cmhBNgPu0JW7i
 ug2g==
X-Gm-Message-State: AOAM530ybGV+P4Ced5VZbQUhObaBcLZW4E3so4eQUYWv37nRYOvS4gcZ
 p/WVBTECrvbNDH+Ju/MQPzEF3g==
X-Google-Smtp-Source: ABdhPJwOvcVk5qmGsJ1rKQqPyPcBkxxJ2k5pa75zQElP9O9KZv4qyx8PvMI6zG+010jN7cnOKI0L4w==
X-Received: by 2002:a02:85a9:: with SMTP id d38mr9988551jai.71.1639669682314; 
 Thu, 16 Dec 2021 07:48:02 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id j7sm3552824iow.26.2021.12.16.07.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 07:48:02 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk> <YbsB/W/1Uwok4i0u@infradead.org>
 <2adafc43-3860-d9f0-9cb5-ca3bf9a27109@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06ab52e6-47b7-6010-524c-45bb73fbfabc@kernel.dk>
Date: Thu, 16 Dec 2021 08:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2adafc43-3860-d9f0-9cb5-ca3bf9a27109@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_074803_010380_455D7D69 
X-CRM114-Status: GOOD (  22.09  )
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

On 12/16/21 6:06 AM, Max Gurtovoy wrote:
> 
> On 12/16/2021 11:08 AM, Christoph Hellwig wrote:
>> On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
>>> +	spin_lock(&nvmeq->sq_lock);
>>> +	while (!rq_list_empty(*rqlist)) {
>>> +		struct request *req = rq_list_pop(rqlist);
>>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>> +
>>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>>> +			nvmeq->sq_tail = 0;
>> So this doesn't even use the new helper added in patch 2?  I think this
>> should call nvme_sq_copy_cmd().
> 
> I also noticed that.
> 
> So need to decide if to open code it or use the helper function.
> 
> Inline helper sounds reasonable if you have 3 places that will use it.

Yes agree, that's been my stance too :-)

>> The rest looks identical to the incremental patch I posted, so I guess
>> the performance degration measured on the first try was a measurement
>> error?
> 
> giving 1 dbr for a batch of N commands sounds good idea. Also for RDMA host.
> 
> But how do you moderate it ? what is the batch_sz <--> time_to_wait 
> algorithm ?

The batching is naturally limited at BLK_MAX_REQUEST_COUNT, which is 32
in total. I do agree that if we ever made it much larger, then we might
want to cap it differently. But 32 seems like a pretty reasonable number
to get enough gain from the batching done in various areas, while still
not making it so large that we have a potential latency issue. That
batch count is already used consistently for other items too (like tag
allocation), so it's not specific to just this one case.

-- 
Jens Axboe



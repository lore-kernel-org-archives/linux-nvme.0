Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCE0C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQw2Zj5KUIsDa/ieOYZbm2/6v2+/XhgWeavOqCOY00I=; b=IxE3YblyAJBGKNWEsLDe+oPL6Q
	oCwCSYTXM9bKTt3C3Ug13Nzmc3r+N8lqKNMp5yhMXgBTlk4ECcNOTkz7JguZ3aVjugIvPXZzpsX87
	5ED/xwtdOUgQWQssHyoGfKrDSYhBtlkoVrWCKn9RfZ0tzdzfex2AarGGndQ7x8Maprtxt4T46CSOy
	kcFVXxkNcFKjOKiCu/SdJ6sYHikcb6eJTR2Lvo0FyzzeN/XPszfrHvOMo3UNrMPf0o9cbU96zYzr2
	7viNIMAiC4laMPDE1o55UpGsaCSIA9HWlJZdOEjZfvQh10+8Mb7aKh86P8dw5wJHDW4OinglSC7xE
	PgnF7nmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9C04-0000000Fkf7-0zVg;
	Mon, 20 May 2024 23:01:00 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9C00-0000000FkeP-3mqH
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 23:00:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VjtMn72SPzlgT1M;
	Mon, 20 May 2024 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716246043; x=1718838044; bh=aQw2Zj5KUIsDa/ieOYZbm2/6
	v2+/XhgWeavOqCOY00I=; b=PehElcPuR16ne23nVJjyCLEC5pZTGgL7HlZ2Kxua
	n2cwa+5UETakW7BozQAxpiAOpJNiQFoblE0sO8W9zGZntLgVq+L4+ssB7w8ydWF0
	e4GcyRfpv0dqMzQcYSOQJtonTQj/RgJPpG6TZPrLRHqk6q0ODeVa4IIGzLpomuVb
	KYkARosoHEDcCYuqQIoi56SXg+zG1cb0ynEhlwnZ9hatPelhQSc1RG4KuAFfhInH
	fvDLZKA3tDDmosxmSsRsejPyax7kXYcOdl2G4tVfdrUPo+0VihiYOqfd7nfyaxnR
	y4eTSKEkR1JoNPCQfutPSg+Wnle/Lby43uuuoMcMS5w46g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hxkO5ubB-DWu; Mon, 20 May 2024 23:00:43 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtMT2NMKzlgT1K;
	Mon, 20 May 2024 23:00:36 +0000 (UTC)
Message-ID: <086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>
Date: Mon, 20 May 2024 16:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_160056_997033_75286507 
X-CRM114-Status: GOOD (  16.23  )
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

On 5/20/24 03:20, Nitesh Shetty wrote:
> Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.

bios with different operation types must not be merged.

> +static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
> +							    struct bio *bio)
> +{
> +	if (req->__data_len != bio->bi_iter.bi_size)
> +		return BIO_MERGE_FAILED;
> +
> +	req->biotail->bi_next = bio;
> +	req->biotail = bio;
> +	req->nr_phys_segments++;
> +	req->__data_len += bio->bi_iter.bi_size;
> +
> +	return BIO_MERGE_OK;
> +}

This function appends a bio to a request. Hence, the name of this function is
wrong.

> @@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>   		break;
>   	case ELEVATOR_DISCARD_MERGE:
>   		return bio_attempt_discard_merge(q, rq, bio);
> +	case ELEVATOR_COPY_OFFLOAD_MERGE:
> +		return bio_attempt_copy_offload_merge(rq, bio);
>   	default:
>   		return BIO_MERGE_NONE;
>   	}

Is any code added in this patch series that causes an I/O scheduler to return
ELEVATOR_COPY_OFFLOAD_MERGE?

> +static inline bool blk_copy_offload_mergable(struct request *req,
> +					     struct bio *bio)
> +{
> +	return (req_op(req) == REQ_OP_COPY_DST &&
> +		bio_op(bio) == REQ_OP_COPY_SRC);
> +}

bios with different operation types must not be merged. Please rename this function.

> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
> +}

The above function is not used in this patch. Please introduce new functions in the
patch in which these are used for the first time.

Thanks,

Bart.



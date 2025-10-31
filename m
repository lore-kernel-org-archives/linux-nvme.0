Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566D2CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZmrQaMmDI5wcpJi1s03VwcCdyCNYupSnLPNCN3FbIsk=; b=voS9ZiVDXJrTWg9sxRxJINXX+R
	XlnJzr+I6VeOHP5QU4NeEzRc1jllWn9HgWV0bPURV1GgWaaecDcrrNq0dHbAo6veq8YzNqtOveDgh
	VSp0Dgx1QqmPZFw9IeRPUfEgWtgR71rYj4grpAyEJZZjA5w8bvdrZW8lnmO+JfBnU5qO2hhwO/+pE
	0UGYkvIc6QlwOh99Z2bgtAwCBDda7Uk3i3y6Rzlh1jBnnwo53Qw7Eos4yfMHjXNl5YJ4GToVjmLq8
	Agef4lXDeD/Aj5SVyq4n1v/EcvZtmZAtozI14bJ9gYx+OtEgo6zzpdpekg3U8rz7aU1UfmcvG5rO0
	F7UpYaGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtRW-00000006at4-0KnT;
	Fri, 31 Oct 2025 18:01:42 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtRU-00000006ase-0wr9
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 18:01:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyphM1QDqzm0jvf;
	Fri, 31 Oct 2025 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761933696; x=1764525697; bh=ZmrQaMmDI5wcpJi1s03VwcCd
	yCNYupSnLPNCN3FbIsk=; b=ZpkeXcrDhmruIHjt5YlLICRvVsSzhvWioovxYNsN
	MWURrST80Y+7j2o80I6hpScVrP5jfkp4j6Dafb7SUYnSikS0bOVYE3bugmaSnoAj
	Xbkhjf9GVDMTCZI1TVAdaCX5zPAwMCRRDHHTpbl5YfZfLW3lYL7LueM3+6p88jOf
	2WkEqaQaagZdba8uI8ptEKmyIuImsFLD7I0GKMUmsqm8dkSVKUQPVmJ9klFMOFBo
	dx2qiYqEn99ky8+CFL3a7b2g2OfEZM6l28PdEYkxy4vHIIHQ8Fc4yKoekLmvpOjA
	qQBKOOkRkaiiEid3Wr2AlxCPdrvYY2c6ob6qJcl0q4C7EQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nP_AMHoCVvSg; Fri, 31 Oct 2025 18:01:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cypgz4d4qzm0pKK;
	Fri, 31 Oct 2025 18:01:18 +0000 (UTC)
Message-ID: <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Date: Fri, 31 Oct 2025 11:01:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-4-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_110140_339023_64F2E953 
X-CRM114-Status: GOOD (  10.17  )
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

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> +void blk_zone_mgmt_bio_endio(struct bio *bio)
> +{
> +	/* If the BIO failed, we have nothing to do. */
> +	if (bio->bi_status != BLK_STS_OK)
> +		return;
> +
> +	switch (bio_op(bio)) {
> +	case REQ_OP_ZONE_RESET:
> +		blk_zone_reset_bio_endio(bio);
> +		return;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		blk_zone_reset_all_bio_endio(bio);
> +		return;
> +	case REQ_OP_ZONE_FINISH:
> +		blk_zone_finish_bio_endio(bio);
> +		return;
> +	default:
> +		return;
> +	}
>   }

"default: return;" is superfluous and can be left out.

> +	/*
> +	 * Zone mamnagement BIOs may impact zone write plugs (e.g. a zone reset

mamnagement -> management

Otherwise this patch looks good to me.

Thanks,

Bart.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C156CCCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdPb1N/XvciTu3RYqzV2sI8GGuB9BnyZJXd9jeyzPVI=; b=pyqQIXKXBkyG/c1TVAth/xHs25
	FZ8qu2gX2ojTR7sO9UtSTDxXJSVDUIqdXsyjEN6AGTYsiiRY6d/enScub9aPIUWry7SzzbJ2xytW4
	qbsqoqJiUVNiMdgDhhV0Bmzr4seySfyCRd3rBoWC24XjcskClKNvIpsbrBgUBP25+8ryLH2tZ2gvn
	QzycvOkEfMXoMGB4C+hnImI+7WCdcBPr+ClqWDNfndzEQr+Gf7/8XJDlBDyN39RFMGzWFEFCeUkQz
	4VpVmrWeBstJ41WT9qBaPFftNPLzqFutSl4obNIE/62U5W4JeZlP8ZGMD3CnAu8WQ8KU2NhPAyyuN
	+bGt1bDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEw8r-00000006nZC-0nOO;
	Fri, 31 Oct 2025 20:54:37 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEw8n-00000006nYo-1NU7
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 20:54:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cytWr0jGvzlpkk1;
	Fri, 31 Oct 2025 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761944069; x=1764536070; bh=tdPb1N/XvciTu3RYqzV2sI8G
	GuB9BnyZJXd9jeyzPVI=; b=3hvDimZ4pmAE3kPI9/Qi3OGemeLEeui3ruzROjBn
	E9j0eA8tDDjAZwnY4kN1Q/hbHL+dLF2ZPDd7JH90wIsr8QR5RWjMgFbakqMUQsxL
	YkqMQFVpaFcwIctAh5cmMhyCXTcFjjx9Pv7OZq8TqTQu0iV1lo+OKZD9UFU9lmD4
	CdYhyqYdrHHyVlwsdu+yl48KvBLlv+busO5s2lP3HodQ5Pa/t0FDQEdLK/ngJnf9
	vER4MxP74/j0GFH3Ec3OO2uulmXNtCt4++wY0oJ6U9U32k55BP8w04gmOrYs7f4f
	u7ETNfkeFj1iPjc3ho+MAghTB9qxJVWf0Ir932vxJnEnIw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2Pf8FqZxqiMt; Fri, 31 Oct 2025 20:54:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cytWZ5Cn9zlnfZD;
	Fri, 31 Oct 2025 20:54:17 +0000 (UTC)
Message-ID: <c2734f13-aad7-43a0-a164-b8504ffc1cb4@acm.org>
Date: Fri, 31 Oct 2025 13:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] block: introduce disk_report_zone()
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
 <20251031061307.185513-5-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_135433_847270_FAD00B33 
X-CRM114-Status: GOOD (  10.20  )
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
> -struct disk_report_zones_cb_args {
> -	struct gendisk	*disk;
> -	report_zones_cb	user_cb;
> -	void		*user_data;
> +/*
> + * Zone report arguments for block device drivers report_zones operation.
> + * @cb: report_zones_cb callback for each reported zone.
> + * @data: Private data passed to report_zones_cb.
> + */
> +struct blk_report_zones_args {
> +	report_zones_cb cb;
> +	void		*data;
>   };

The suffix "_args" seems confusing to me because this data structure
includes a callback pointer. Please consider changing "_args" into "_cb"
to make it clear that the data structure includes a callback pointer.
Another data structure that follows this convention is struct
blk_plug_cb:

   struct blk_plug_cb;
   typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
   struct blk_plug_cb {
	struct list_head list;
	blk_plug_cb_fn callback;
	void *data;
   };

Since struct blk_report_zones_args is passed as an argument to
disk_report_zone(), how about renaming this data structure into
struct disk_report_zone_cb?'

Otherwise this patch looks good to me.

Thanks,

Bart.


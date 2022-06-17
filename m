Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CEAC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3T4D+yOaq9lo8BU1AjLyhVwMBWPQQL/H4Z2pOmaK6c=; b=Vn5OktVgUbp8p1abeOdj6fup1t
	jtjESUp9NHkQtXZ/7HO9uCNoCqXMTjrdg8rUiNR0hynP4eX+7tABa1ju00rsMNSrlaF3+/cDRcdC4
	UMr/ynJsP3KMpEZm7vpTiBfspY5kur377mys67k3eQsm9qOHfcgtNImqMeUnGp9FSw8rH4hLsDT5o
	2XImThKbcB60BhRu/MA0F9yMULJR4BKCBzwpZfTbsZv6rtdGE/e4WHGx+VQybg5aDj1oAQCTbz/1W
	Lif6jOCH+pe80QtFJ1JjVny+FLg1ssq9zpmEx+Fsc/t8LKZ81BL18ZjfVSKAN7rcaCqAbZOajlf/I
	FpLSL8hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Eqn-008Eqw-9W; Fri, 17 Jun 2022 16:29:37 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Eqk-008Epr-I8
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 16:29:35 +0000
Received: by mail-pg1-f176.google.com with SMTP id g186so4481040pgc.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3T4D+yOaq9lo8BU1AjLyhVwMBWPQQL/H4Z2pOmaK6c=;
        b=i2trSh0jAFwjPkjzvw7KZ4Io1jc5r7pI7CDvOKo2NwmnW846ApJovlBAUI72jXBKXb
         iUeBaH8pO633tjSkqgs+CVq3wQRYti3oPNrrcAWWp5//WCxAM/o2B2c1ieq8pIvvrjIl
         j52uXtQcLt6+Xk9a8ZIPAHlguLexbOteVUTcZ2TthHgwMzEoO3NSHT3th5BDndYQn1H1
         NV27sO9LVsF9x3NapIGJNUTpkZ2wOY/9koQ7sDjQFxYPxqN9EuRAzMqXj+M6WYXyITSi
         xZiniAOwDzfW1G8TejgwDimcLTPHylbsm460sHo6xZGxppcQshuznxnPPeXYrzHb0Fu/
         lpBw==
X-Gm-Message-State: AJIora/J7nRkr/G65FY0pac5ME2PbbCLDBHnEbV0Ksu++j94z/6k8ZKG
	uCVruJWBuLdEqpsYW4JBbyVR/0Oiji0=
X-Google-Smtp-Source: AGRyM1stNp1gT9uJQRkH23ZVZcEfOLXxdhPmA8X/nMhdFsuF8GV3jpeyCFDLLrooGlCGjlATeQWtWg==
X-Received: by 2002:a05:6a02:201:b0:3fc:6071:a272 with SMTP id bh1-20020a056a02020100b003fc6071a272mr9888178pgb.518.1655483372280;
        Fri, 17 Jun 2022 09:29:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a168200b001e31c510f10sm5637387pja.54.2022.06.17.09.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:29:31 -0700 (PDT)
Message-ID: <6d84b3cb-a362-05ae-c7c3-62d3eddf9f02@acm.org>
Date: Fri, 17 Jun 2022 09:29:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/5] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-4-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_092934_648406_8372E9E2 
X-CRM114-Status: UNSURE (   9.57  )
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

On 6/17/22 03:55, John Garry wrote:
> With new API blk_mq_is_reserved_rq() we can tell if a request is from
> the reserved pool, so stop passing 'reserved' arg. There is actually
> only a single user of that arg for all the callback implementations, which
> can use blk_mq_is_reserved_rq() instead.
> 
> This will also allow us to stop passing the same 'reserved' around the
> blk-mq iter functions next.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


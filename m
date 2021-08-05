Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB3C43216
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 16:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F8260243
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02F8260243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CnRQ48aQjdnVSXfaRZDK6cV20bgXBPXfgL7wBAjnmA=; b=ApSfXH/15aufgPcQ8Vh7DnAdSB
	zZ3BNen5FvBb+0Br47f0lEg5hoAxSZFKyrP/+h+kIaNqQPi1iF2FqxRfofsL0gQGCYfKH1cr/pZZu
	8WJz9nJp8KTKyWx6mM3erDCAN+MLrWaXXqwukuVDUNUYiDOsoy/G/TjriU0EO9n/38DvioakHdxTg
	Y398+PwOXESHtWKtGvzP1lv/XS2WoqJw8oTISTwK3udkZK7nHefFha4mVd0NfyRFW1UQiXpd6+4aY
	BnhEWcDhF+i5YNjcvevDqef5Ubyk8kIJHzXhu9GVjtFEw0bVjqGR8SJ8I5oeBfQaiGZmdYUB3estV
	fplbg0xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBgH7-00AFWx-9E; Thu, 05 Aug 2021 16:31:17 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBgH3-00AFVT-R3; Thu, 05 Aug 2021 16:31:15 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 dw2-20020a17090b0942b0290177cb475142so16135295pjb.2; 
 Thu, 05 Aug 2021 09:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hHUTsKDnxap0EiJI1vbHiNIpoH+R0H2TboThtqpCWSc=;
 b=JbnEeQKjxRZ2ntv3DMX8zj6OY0LJnDb8jH7d+X5cxQRaYXOa9jSipVXrxBpPTvL7rd
 b6QfukEAmXl07/AoeNF72vK0iabbscBLzJ2LDvE0G3K/w16Y/awwOGDl9cfbFkP12S8Z
 VUxF8zZ3A+t+S5HMRTLbvcY459k1qBVW1h0K3AMl+gL5bmG98Ed7HKYY5Q8YHLEgMDja
 jzhtlYSpYiI6GFyRdiv6Qing+ATsNOsWOKk6zG1i83fTNxfY0I934kvre3v1wnWuZ8wd
 uCbwon0Tb9U+HYZWxk5tzmZd+6HEmwD6Q747dug6Tp04A0LCv6s+OTgTBH7lJrBghbNg
 9Puw==
X-Gm-Message-State: AOAM533fQIRNNnKGLHaDYQ4uWwLDURnRLu2U4VrW4FCWTRPnr5+kanKy
 Qw+RPuZeLAksmzlYSmdQD/I=
X-Google-Smtp-Source: ABdhPJyCuisk5RzZy6da7AsZoR/DaZLZHn4oZn9ITXuwK2Rjv1pBKXahTV8aXSruiOZbF6hVQSA8vQ==
X-Received: by 2002:a17:90a:9f91:: with SMTP id
 o17mr15924247pjp.29.1628181071870; 
 Thu, 05 Aug 2021 09:31:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:1:93c2:eaf5:530d:627d])
 by smtp.gmail.com with ESMTPSA id r4sm6334361pjo.46.2021.08.05.09.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 09:31:10 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 10/15] sd: use bvec_virt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>, 
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, 
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org,
 Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-11-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b487c0f-71be-19d6-249c-9cd1ba228548@acm.org>
Date: Thu, 5 Aug 2021 09:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-11-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_093113_930504_94D3D064 
X-CRM114-Status: GOOD (  21.34  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/4/21 2:56 AM, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b8d55af763f9..5b5b8266e142 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -886,7 +886,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>   	cmd->cmnd[0] = UNMAP;
>   	cmd->cmnd[8] = 24;
>   
> -	buf = page_address(rq->special_vec.bv_page);
> +	buf = bvec_virt(&rq->special_vec);
>   	put_unaligned_be16(6 + 16, &buf[0]);
>   	put_unaligned_be16(16, &buf[2]);
>   	put_unaligned_be64(lba, &buf[8]);

The patch description is not correct. The above patch involves a 
functional change while the patch description suggests that no 
functionality has been changed.

Although the above patch looks fine to me, why has page_address() been 
changed into bvec_virt() in the sd driver? My understanding is that the 
sd driver always sets bv_offset to zero.

Thanks,

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

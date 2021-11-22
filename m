Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE33C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4zT3ReMn99MOdO3ezzDw+pZFjCzqehx4f/GcytHtJ8=; b=mCd2YO32x6BgObibioO/m3zYut
	hE7Bj04OaCfSFwBFRY5jWvYStiQQn2PA7g3ycygjGoWhY9VALmxK+NysbmYvvHC6agQJkQR5jrQ6p
	sWpXxn5GCz9da5emA6Mjmaa4uKXRCZy13U+1B9tE7equWx9+YAAtQ89qwawfsJ9oUWEbsEfL7DvBA
	Guqep13XlKGn8fmlUZteVLW/kKajQDsbuiJvODA3i1YrYsd2X6YLxgdakw4PKw9v4T3RiM1U0j8az
	/X5yov9dHvnOsDbheQmT8BKGwFNMd3OTrM8/e91ZCCvGPMzQNR2PSEvVazWqVNNTVmOu5F3gWJjOg
	a6+T89Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Bt-00FBDv-8u; Mon, 22 Nov 2021 07:56:41 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp447-00F8Ox-Co
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:48:40 +0000
Received: by mail-wr1-f53.google.com with SMTP id t30so30873384wra.10
 for <linux-nvme@lists.infradead.org>; Sun, 21 Nov 2021 23:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C4zT3ReMn99MOdO3ezzDw+pZFjCzqehx4f/GcytHtJ8=;
 b=f65KAfnLs3RcNWkoumtD0S1XfcFxqYrZfiGrOkSlu6na5omvV8tWvpo92bSZRALk9H
 OtqqHL5KsUL7VRh6/IeWYzIGEoyrpXJx/MkocNKjOyFYuHyPFKtoqEVC5upmHSR/sHoF
 eJJ0fMElniC0NChkPwHPsCCDdujo6dLSqK6GDd5BT0+TOGSg+r+hbS2dgBJXlbYjHc3S
 P2jIqZXjgvg3vZDta+fRXAB7Rcm4xYCffAHHnvDT0bDiqYKjm0ubzFS6KBxBpTyDSNhf
 6gBIysKA/o1+v8Tz38jXMY6cJNp2x2yvFMr9nXWRwsXWpcqZOyW82XDyMfnCK/O2nQ1Y
 RWqw==
X-Gm-Message-State: AOAM532GRFkCUPXpHY4/dNgasp9OqOsnurz4SLYaYoRoMCKAhbj6U6NM
 RyIW3MahXSq5ZN9DG8RRgv8e4hOlnIQ=
X-Google-Smtp-Source: ABdhPJwMLV1WjMkc93GmHdHQiSqhJHqhjTncRIF462XpmhlliKKGh6d/HzRUcY0RtzZOGfeCmuqNhA==
X-Received: by 2002:a5d:62c5:: with SMTP id o5mr35867758wrv.408.1637567316940; 
 Sun, 21 Nov 2021 23:48:36 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id e7sm10032241wrg.31.2021.11.21.23.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 23:48:36 -0800 (PST)
Subject: Re: [PATCH 1/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-2-ming.lei@redhat.com>
 <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org> <YZdb2/XoJVJOa1r+@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a219fff8-8f2d-adb1-eb8c-3e5712cea5bd@grimberg.me>
Date: Mon, 22 Nov 2021 09:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZdb2/XoJVJOa1r+@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_234839_481464_922D1F14 
X-CRM114-Status: GOOD (  15.09  )
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


>>> +	bool			alloc_srcu;
>>
>> I found the following statement multiple times in this patch:
>>
>> WARN_ON_ONCE(q->alloc_srcu != !!(q->tag_set->flags & BLK_MQ_F_BLOCKING));
>>
>> Does this mean that the new q->alloc_srcu member variable can be left out
>> and that it can be replaced with the following test?
>>
>> q->tag_set->flags & BLK_MQ_F_BLOCKING
> 
> q->tag_set can't be used anymore after blk_cleanup_queue() returns,
> and we need the flag for freeing request_queue instance.

Why not just look at the queue->srcu pointer? it is allocated only
for BLK_MQ_F_BLOCKING no?


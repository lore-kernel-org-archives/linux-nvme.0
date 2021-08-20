Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61906C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 10:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209416056C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 10:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 209416056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ecGjVCcyt+QLYKaQl9R+jEN4WdrBeteCCY/MWYppl28=; b=P0uiIJ1UmvXlH+
	98n9OPELq0gVb5bZfD2nQgROhuiKmdx6CF/tjlRKtv+3E7VkqJB0bn6SJjjcsu5d+/u8po5n++Mo9
	/pIkhjzc1jyPcl4/k6yAdoKT5DUvUM6E9rtqCvunC+JlVT7sV2NUqnXtsubf+IMphmBWYF4paFrzH
	xTg/cNceYt8caMudOJdvG37F9E02rjdN0lyTleV/7qXYGRAO5lJhI+1g/ICu6QIFp4FG2hOpYaagT
	X+ZTpINOnXGKii6C4ZhEcAIk8pSmR1+Bfkf4FsFDQZT9XmJ43cWC7sGQffOvfN9yK7nmZhlauAWOl
	ly1z529bkkB1K4ORalxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH1w9-00AiH4-L2; Fri, 20 Aug 2021 10:39:45 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH1w7-00AiG4-4C
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 10:39:44 +0000
Received: by mail-wm1-x32e.google.com with SMTP id f10so5655139wml.2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2l4f87jQ5BCVnW/LtVQs/ujfdv1Edqo9vK1XTZNmj64=;
 b=ZKKKORCLDq/VeWLjAhd2HF4b6J9R+CkAnEfTsRsXC2JpHBz3EFmWxVCXTcZRliZzQR
 6csaOtqJCaGtnor4OR+v0r3M9n4Hqwku+6mczvhp/kb7Xq81d62hdrqDppClM0C9fJW7
 jedZswfJPGrcD+k+k/useJ/R6zKptTamgma6736L4OuPpV3mmKK461sGuAteKDuHTs1F
 oBTxGt12BAtPC208K4MrtaKBOwhQ/Eo3OiQIKcjO5+99rzhSGMfoi7ElNn/+p39I/l+u
 uqNc8v1njX0kTwoFUmaRK2oZYXUT4RlZ44L3WYVQ+XTo0puEMXes5atR/VHN8zs0yxtt
 jzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2l4f87jQ5BCVnW/LtVQs/ujfdv1Edqo9vK1XTZNmj64=;
 b=MQVxmhDzDrQEeWrJKDa6HOpozdaExSGlRF66oT28cyHEwtxI1Si8K1ekxbkSVuq5HX
 VOqbu5ZpJz/+eIcYxYsfAeZOzZtaqizw6kSkPh1amgTcpS3aSQToT10xGLzideAQL0R4
 C/1dI+gZ3BJtZT0fm9E3k2OuVv14C+o2n5veDTBJ46qGIxo5sRKCvYzbQA2MxnrTlctQ
 5WZlFOnSf9O1zN640O1odY7GYOZSN1T+GYaUntkoGTz0CnhbFCL53wjIQKUu4VLjAUSj
 ZqJqdvEH87B7g1gORTiKnqk/ejf7OYdmlX1OwJvBVHrC0txhbb+/vWu2PaqK/pKNCPlk
 VIeA==
X-Gm-Message-State: AOAM531Eef4IulR9+JqzYZDMCzncneGZ3nsiyop+ylkRWQWpO2YAFtAR
 VoUaHgSmFO8MLhf7TKXQVcqqj0NpzL+A1YBVAnQ=
X-Google-Smtp-Source: ABdhPJwvvbvC7oT0EDMBScqPKbmq4ABDQwLkxNDJHv+ZwVgPws6KmaaRL0F7/tnmz8XSY+QaosFzbLsSI9/h7hXg+gc=
X-Received: by 2002:a05:600c:1c08:: with SMTP id
 j8mr3147766wms.138.1629455980524; 
 Fri, 20 Aug 2021 03:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
In-Reply-To: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 20 Aug 2021 16:09:14 +0530
Message-ID: <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: Bart Van Assche <bvanassche@acm.org>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Damien Le Moal <damien.lemoal@wdc.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, kch@kernel.org, mpatocka@redhat.com, 
 djwong@kernel.org, agk@redhat.com, Selva Jove <selvajove@gmail.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, nitheshshetty@gmail.com, 
 KANCHAN JOSHI <joshi.k@samsung.com>, Javier Gonzalez <javier.gonz@samsung.com>,
 Mike Snitzer <snitzer@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_033943_212476_78738E0F 
X-CRM114-Status: GOOD (  19.41  )
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

Bart, Mikulas

On Tue, Aug 17, 2021 at 10:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/17/21 3:14 AM, SelvaKumar S wrote:
> > Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> > bio with control information as payload and submit to the device.
> > Larger copy operation may be divided if necessary by looking at device
> > limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> > submitted to zoned device.
> > Native copy offload is not supported for stacked devices.
>
> Using a single operation for copy-offloading instead of separate
> operations for reading and writing is fundamentally incompatible with
> the device mapper. I think we need a copy-offloading implementation that
> is compatible with the device mapper.
>

While each read/write command is for a single contiguous range of
device, with simple-copy we get to operate on multiple discontiguous
ranges, with a single command.
That seemed like a good opportunity to reduce control-plane traffic
(compared to read/write operations) as well.

With a separate read-and-write bio approach, each source-range will
spawn at least one read, one write and eventually one SCC command. And
it only gets worse as there could be many such discontiguous ranges (for
GC use-case at least) coming from user-space in a single payload.
Overall sequence will be
- Receive a payload from user-space
- Disassemble into many read-write pair bios at block-layer
- Assemble those (somehow) in NVMe to reduce simple-copy commands
- Send commands to device

We thought payload could be a good way to reduce the
disassembly/assembly work and traffic between block-layer to nvme.
How do you see this tradeoff?  What seems necessary for device-mapper
usecase, appears to be a cost when device-mapper isn't used.
Especially for SCC (since copy is within single ns), device-mappers
may not be too compelling anyway.

Must device-mapper support be a requirement for the initial support atop SCC?
Or do you think it will still be a progress if we finalize the
user-space interface to cover all that is foreseeable.And for
device-mapper compatible transport between block-layer and NVMe - we
do it in the later stage when NVMe too comes up with better copy
capabilities?


-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8AC6103D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C8AC6103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjuW8ayyRJBzQTK93+AyGywXl+F8llW4cpKd+jN9SVI=; b=dYr3a6nCea/umLBGtJ14K/6/jI
	NzpMeL39ayeC1v8tSVEzneIMIb1aNEgw435Vtko5Ix6bN6tL74CFimdr89uQY1FCHrJ2FAh6j9bLm
	z0mmjKHJl5DBdLl3isgt+pJHAAFq+D0A1nGgur5CEJB/vTocgQZFFGGpsp3QauLCusIWiu6LfNNaC
	i5AKrP3rgPQpdu7HE9aWFwc2LG8xK3C4gJhFhLFWxWhVn6eZUekjJPP3U2PsSkXabEw7LkKvIGxBi
	Dt1ZWm4bpykhaHKifyaWBnqVjZ1IYlwLeIYKFWLUzu2/GVY1Px6CjB3cLLhUpQC88O8+prqvG34Vg
	Owdge3rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJDy-00DGyR-31; Tue, 12 Oct 2021 14:57:50 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJDv-00DGxt-Vx
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 14:57:49 +0000
Received: by mail-wr1-f54.google.com with SMTP id t2so67844278wrb.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 07:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtXwb5BYNS5KGkt6MvcktBG7LF1gDr4C50twzOZ5210=;
 b=Z3BRejL2qX2qzsM8Re0HRT8tmTLNzyrGqnXxLGncWhDUa/2CffAoAUrA5V+fh1t3C6
 5kM6IGsy6pX2sFv1xbQvNwf8JBHXCJVmhWTqKwyljCr/fy3DDn73AAW/Md7qBc4WJn8K
 cLchaPC/Q62A7IihO/QwevpeWFg0MVv4T2+GM8t2ap0ethYIL24pxdjrYaCgqt12jQ3/
 YeA1VslB3nC5Kner9HirF+Sxh+bBrj4RW4PXsiciuBh7U/YPdkR/75ZSbxS830YHPVVp
 ztX2t4L3OyF9BMuB0Pp6aiKOk0fG5xUxY8hjosEMaBLBKIpRGyOC06IfqntfkecUNKse
 emTA==
X-Gm-Message-State: AOAM533EXKxWyBskavqO94oiceDp7Z9QrSpbXZLonTWHcxvqBRwkd+rR
 VVYpKFw/D/3cPfPLuCxNxPqqLjYWzTo=
X-Google-Smtp-Source: ABdhPJxz+cYCges9NE0K4zRRi+5Im04qxitQs7NFCycHffQ+nJC3FVxsi+esTCwTWq5519XTQc7Pqw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id
 r16mr3654310wmq.97.1634050665189; 
 Tue, 12 Oct 2021 07:57:45 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id w2sm5646211wrt.31.2021.10.12.07.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 07:57:44 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
Date: Tue, 12 Oct 2021 17:57:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_075748_067687_33DBB86F 
X-CRM114-Status: GOOD (  21.85  )
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


>> Hi all,
>>
>> This series clean up the block polling code a bit and changes the interface
>> to poll for a specific bio instead of a request_queue and cookie pair.
>>
>> Polling for the bio itself leads to a few advantages:
>>
>>    - the cookie construction can made entirely private in blk-mq.c
>>    - the caller does not need to remember the request_queue and cookie
>>      separately and thus sidesteps their lifetime issues
>>    - keeping the device and the cookie inside the bio allows to trivially
>>      support polling BIOs remapping by stacking drivers
>>    - a lot of code to propagate the cookie back up the submission path can
>>      removed entirely
>>
>> The one major caveat is that this requires RCU freeing polled BIOs to make
>> sure the bio that contains the polling information is still alive when
>> io_uring tries to poll it through the iocb. For synchronous polling all the
>> callers have a bio reference anyway, so this is not an issue.
> 
> I ran this through the usual peak testing, and it doesn't seem to regress
> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
> core:
> 
> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
> Added file /dev/nvme1n1 (submitter 0)
> Added file /dev/nvme2n1 (submitter 1)
> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=256
> submitter=0, tid=1199
> submitter=1, tid=1200
> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)

Jens, is that with nvme_core.multipath=Y ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

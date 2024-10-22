Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F8BD2C54B
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doI9dnYU9khV/lZLroP8Aji2iy4gTFD49z/1DNwsnjU=; b=w6ZMISfCja6IAsdpA/bBhQI5Qz
	OdFH4TzNdtZCv45loTVMbWswUnAyYNdJYHzOM9DXHzEookOrUMZhCVFoChdNGPGTdpnWycDvI4Ivq
	UTJPZbumIqWnAyQKIuXn0WgblW6+ZOOzw8xcDdVuYQq6Qrp7SXBU0YHiSZ2JSIvKVLDlHewNntmFD
	rs5hhjKf/AwgHbR2xYvSDVpSJtC7VklUTOCQejF1B/z+3R+g4slx3KGrvUdCY+8byJwBvCl6N/3TL
	1JcERs4WE7pwAP2YNx1Sm/tLyLmxnti+w5gvShK28wwbYZlFf8jZiKAEIu/Qkw9KW2R5ZZjqg33IA
	S17UuGwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ErI-0000000AwQr-0rXX;
	Tue, 22 Oct 2024 13:23:36 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ErF-0000000AwPN-1fWj
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 13:23:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316cce103dso41313055e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 06:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603411; x=1730208211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doI9dnYU9khV/lZLroP8Aji2iy4gTFD49z/1DNwsnjU=;
        b=r4sni7Dg95OA+iDTQGYXQsK9V8qpJalYn4x5262el1VILkZ12BXNyH6xk79Vz9s3gR
         AuCIEtwpXvy1hCDVUX/aZoozTazXrnqco1sKY7O1MOed8LkZdzPL2FSC5fCQtSovSF+U
         ef4xWaS7la7q/hA/VUfOE+roWp+5MIkMi1CbwTjknfpIjylbDI3xo6/EfEr393U0/IRM
         XCaF/8nfc7KswxPc51a4htkXlzG1irTKFkzMeJsZd6kvnHzHpYRXfJge279fyHkWRMnQ
         hndKv/svchYh/BKRd2T/ecnhXioKxfrsKMCd1cDrcSKHTdVdHqb2mH9BBWASK/UEoXva
         aIYA==
X-Forwarded-Encrypted: i=1; AJvYcCU+z6yO0JB+sTg4/+nrtL2SCl6RW4MHmQxi6wrNxUMH6gp/1RqxY/HiGB1QhA4i67sYyBP2IMAaoubP@lists.infradead.org
X-Gm-Message-State: AOJu0Ywfr52FVBH4gkTpxlur852ydEjHf6VU0WJ+jgttLOmhmaBc8g7C
	Fo7crNZ5HrmlV4aecnq5366lRMkynfehqldXp3bg2ijZh9OXmcLC
X-Google-Smtp-Source: AGHT+IFtfcGtHriiS8qJidjpGvb1I0KhqA5oCBvkMBNtAdG2Qej7SWHcMOpQCTXGIcwwPTdSMBhvJQ==
X-Received: by 2002:a05:600c:5118:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-4316163bcbdmr184358845e9.16.1729603411208;
        Tue, 22 Oct 2024 06:23:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4856fsm6625100f8f.33.2024.10.22.06.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:23:30 -0700 (PDT)
Message-ID: <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
Date: Tue, 22 Oct 2024 16:23:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
 <Zxb8KaoUVstRCxiP@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zxb8KaoUVstRCxiP@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_062333_468759_32F4D45B 
X-CRM114-Status: GOOD (  15.46  )
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

>
>>> It is just lucky for connection request because IO isn't started
>>> yet at that time, and the allocation always succeeds in the 1st try of
>>> __blk_mq_get_tag().
>> It's not lucky, we reserve a per-queue tag for exactly this flow (connect)
>> so we
>> always have one available. And when the connect is running, the driver
>> should
>> guarantee nothing else is running.
> What if there is multiple concurrent allocation(reserve) requests?

There can't be none.

>   You still
> may run into allocation from other hw queue. In reality, nvme may don't
> use in that way, but as one API, it is still not good, or at least the
> behavior should be documented.

I agree. NVMe may have a unique need here, but it needs a tag from a
specific hctx while the context requesting it does not map according to
the hctx cpumap. It cannot use any other tag from any other hctx.

The reason is that the connect for a queue must be done from a tag that
belongs to the queue because nvme relies on it when it does resolution 
back to
the request to the completion.


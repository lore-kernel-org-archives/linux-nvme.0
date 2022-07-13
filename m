Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16482C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T18yAEcOYCg0I5dMCxK9RpYvXfa2NL1kjk3NiDP/j/A=; b=EolDdP/2NjRP8IeC1JvFz/NrSB
	vN5WNiJigOYC24lzUptD6jIxxDW/t6pbzvvsJ+6pqV8JecyWomq5wauvxQcu0pYrXxj9858Bi/uqv
	VhDdRDHE/HJZd7yheFKXFjgQTjj4CNxS1qghNDs2T/rW+/R2hcqhMV592cNFPuZwd59Eo8WQpmDno
	lD0Wedpgcz8U3Sn8PM5i/V6l81R8ZzZdvi1GvfkHKq+TDtA66syE9dROVgn+Mm1wtWEd8OFZodaLt
	kYMKko9pVchZCnieV3RqayPvMXn8ukwkMzMl2Q0lsG1YNWS1ex88Ss9jnCHU9DBSYD5xBSRDkDYkZ
	gcuzNT+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBa7S-002tNl-UX; Wed, 13 Jul 2022 11:01:26 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBa74-002tAR-6g
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 11:01:08 +0000
Received: by mail-wr1-f45.google.com with SMTP id r10so8809456wrv.4
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 04:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T18yAEcOYCg0I5dMCxK9RpYvXfa2NL1kjk3NiDP/j/A=;
        b=w/+OhW29xExiKd5yf92GxUIgcF9vWPjQ5GpyQ7jiZS4ANiP+a+J05baUugjn5SIbkM
         zuT/dOhsApe18QdX+wrcP2Lemmn7Q/rHiUIa8E1UHC8M56RF7qI/284JP34DxHOIbZim
         xxbIUMupX6VmZ+s0xSNIyTUMRcQ3DUl2FDP2n/0kWJE6xLn8ZZtQjJHRNHEEM+XAGgSf
         Nf2KtXy29byRe/yYTsbyvgMT6vl12OCyQUdDHMbO7spbheiqHLJl5iGduWz4GYDbXRi5
         R9XyAjlZgpMrctM95dk4yf0+5ex1InhR3/HKk9BEaizIFebxA3IyoxTY6QI/YILEvF0Y
         r+LA==
X-Gm-Message-State: AJIora+YvWU9SgheNzvlfg2IrBIfqzdgw3pJBRueKSbOS61+SL+9n981
	dE8Gu7N3pX2Bj4KBbqRo0cM=
X-Google-Smtp-Source: AGRyM1uLDJ5KrZQfhVzYZeqC7ptNaRIFw7vlxuL1wa/br2L1mpf8BiyQW/709le2PXqlVH1hmUZstQ==
X-Received: by 2002:a5d:4602:0:b0:21d:6784:cdcb with SMTP id t2-20020a5d4602000000b0021d6784cdcbmr2632040wrq.470.1657710059145;
        Wed, 13 Jul 2022 04:00:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d6681000000b0021d6924b777sm10417359wru.115.2022.07.13.04.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 04:00:58 -0700 (PDT)
Message-ID: <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
Date: Wed, 13 Jul 2022 14:00:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
 <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
 <20220713101235.GA27815@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713101235.GA27815@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_040104_856110_1F540459 
X-CRM114-Status: GOOD (  18.30  )
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


>> Maybe the solution is to just not expose a /dev/ng for the mpath device
>> node, but only for bottom namespaces. Then it would be completely
>> equivalent to scsi-generic devices.
>>
>> It just creates an unexpected mix of semantics of best-effort
>> multipathing with just path selection, but no requeue/failover...
> 
> Which is exactly the same semanics as SG_IO on the dm-mpath nodes.

I view uring passthru somewhat as a different thing than sending SG_IO
ioctls to dm-mpath. But it can be argued otherwise.

BTW, the only consumer of it that I'm aware of commented that he
expects dm-mpath to retry SG_IO when dm-mpath retry for SG_IO submission
was attempted (https://www.spinics.net/lists/dm-devel/msg46924.html).

 From Paolo:
"The problem is that userspace does not have a way to direct the command 
to a different path in the resubmission. It may not even have permission 
to issue DM_TABLE_STATUS, or to access the /dev nodes for the underlying 
paths, so without Martin's patches SG_IO on dm-mpath is basically 
unreliable by design."

I didn't manage to track down any followup after that email though...

>> If the user needs to do the retry, discover and understand namespace
>> paths, ANA states, controller states, etc. Why does the user need a
>> mpath chardev at all?
> 
> The user needs to do that for all kinds of other resons anyway,
> as we don't do any retries for passthrough at all.

I still think that there is a problem with the existing semantics for
passthru requests over mpath device nodes.

Again, I think it will actually be cleaner not to expose passthru
devices for mpath at all if we are not going to support retry/failover.


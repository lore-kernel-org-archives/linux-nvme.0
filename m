Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55919C4707B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Li3Y7982rSqF0PYYpzguyahagJqPSE8wbuDH2ZsTdfg=; b=WghjMypLNleLOHWtQN7+gnhDX6
	D7Nx6z2OzZIxzKPW90wRz7eO0AjworvNzCwQbgDO4zDctLEllg+4kEH3l2uTr3vP63LVWQKPBdfD/
	TeYz8vhHwht7t9AekSqes75wyGGDJvpJyj+jAQjTgC4FEn7zLPoQ0kHthA0WZKvTBAp82UTWXxleH
	J5XczhjsdMlACQ7p+d7ph/k5BxHk3ydFjQ3uo9Oi7irN38Xqwn21RhUiCP3F5a9DMP/bdBxOVXYoq
	ECcO8srL7e72Y9Y3gOyyrnz7ZukiVn1nFeZxrDoF/o7SDMMJsMpnQbvqHBZVc8nDtfxEeHHa5Jd/o
	4/lIkGkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKGq-009fUB-1U;
	Tue, 09 Jan 2024 22:08:28 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKGn-009fTn-1C
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 22:08:26 +0000
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3f29fea66so17518985ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jan 2024 14:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838104; x=1705442904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li3Y7982rSqF0PYYpzguyahagJqPSE8wbuDH2ZsTdfg=;
        b=l7mNzvl9sCz0sHhGgEwI65D6MhEcHhouIJISRrM/2JONHIpXWnXjitgEiuMtpRlyAm
         FccSBu1oA89UnNrJl2k/KFz9K3hj1by9uLI07ZgUu/VfOw4esMvnS6EfKNQ+/lBU5h2m
         hlvUUFeUtSfce5sCAOuSuGpYG5D18mnxaRzmZr0gGm21/8QadH9M+lO4EWY3HMpt9Dza
         IFSvdLKBht49CSIvKjXfc3gJgPP1c81xn4KjooXT80BbHtvXqlJbKDTopt2OfHGpW2LF
         78vNkiXbdC0mPpR8Q4U/G5NiE2IIwWL4+kCqPnW+1mvzmsqrWl4DcJujIeCtecdzUg1U
         dEzA==
X-Gm-Message-State: AOJu0Yyhb2zF1tPNnE/vKPsIWdYepYHQ0xNkNtAXcdQPZjUBudfns3PR
	iAxQcDgjGgmOHuA2Z0umEDk=
X-Google-Smtp-Source: AGHT+IGcWxDZ2y2EsYJ8J084FeDEXeUlv8iQBOshvurkaqeU/GhU1KcrlCwGZBF1z9PZMM2dV7sWXw==
X-Received: by 2002:a17:902:fe18:b0:1d4:67f1:5daf with SMTP id g24-20020a170902fe1800b001d467f15dafmr33390plj.132.1704838104030;
        Tue, 09 Jan 2024 14:08:24 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001d45f92c436sm2286620pll.5.2024.01.09.14.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 14:08:23 -0800 (PST)
Message-ID: <ee9eb364-7aed-4a73-8e42-f66f084b0118@acm.org>
Date: Tue, 9 Jan 2024 14:08:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, "josef@toxicpanda.com"
 <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org >> linux-fsdevel"
 <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Daniel Wagner <dwagner@suse.de>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
 <0e33127d-6a43-46a1-9276-0c2f1965e345@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0e33127d-6a43-46a1-9276-0c2f1965e345@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_140825_431177_C1E03FFB 
X-CRM114-Status: GOOD (  15.11  )
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

On 1/9/24 14:01, Chaitanya Kulkarni wrote:
> On 1/9/2024 1:31 PM, Bart Van Assche wrote:
>> On 1/8/24 22:30, Chaitanya Kulkarni wrote:
>>> 5. Potentially adding VM support in the blktests.
>>
>> What is "VM support"? I'm running blktests in a VM all the time since
>> this test suite was introduced.
>>
>> Bart.
> 
> An ability to start, stop, suspend, issue commands to vm, recent
> patchset async shutdown on linux-nvme list is one of the example why we
> may need this feature, see [1].
> 
> -ck
> 
> [1]
> 
> https://lists.infradead.org/pipermail/linux-nvme/2024-Januar/044135.html
If I try to open that link, the following appears: "Not Found - The requested
URL was not found on this server." Anyway, I think I know which patch series
you are referring to. There may be better ways to trigger shutdown calls than
by stopping a VM.

Thanks,

Bart.


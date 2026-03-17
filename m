Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA5FB5E8B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJmZWcweGo/5CL7dk1HuKW3M8jV+oED2e+YlbfIAvtA=; b=Q9S7Ahl9PN+ZzgM2H1H6llqzVf
	k0DArnMcSYNMPt7JkR7jASZRlXyKhKYHtBRjX2Xhs61VXZmbHIt6qj1Bqn+mRFCFhixm8I2ZbDw2t
	9YSmfG7NJe4dkDZDs1h6HLDYxMOC+szf/bPsMqwg5SoxjM086ZeSmmsiC8oxSn8Htb7wUq1chDzht
	UVr/flKfAmjLJKlje5vbgq3562ChXkgjf3Old93B4mDb8D51JPwKgxb43XDxcewXGZC7pvneQZz2E
	XSH3ezn4l6He0DB1q3ppG/t18Nouvs4efwyGGde2ERwxGYNY5XoWSDOuPXv/8b015f2kfaX7KIqBC
	8mxa2jkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Ioq-00000005A4l-050Q;
	Tue, 17 Mar 2026 01:02:00 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Iom-00000005A4M-2mHD
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 01:01:58 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7d748ca8708so3070563a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773709315; x=1774314115; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJmZWcweGo/5CL7dk1HuKW3M8jV+oED2e+YlbfIAvtA=;
        b=ktbZdKaLRaluUczZAUle3lPrnSyNEFy9edjL+tTg0CqlQp4dfkpQB4NOXe5Nik8JuX
         BvJOAwfMxVs9j73ZaUWpxyqoIVuHeEwNeOTvK+5K5YztpubBOJoMDPG9rYp4HXVh0u6C
         6C9sU36Qy+2+k6wNv+oHscOtyRj0Lkr0loJ+S4hlBqDlx5qfi4N4SepvL5p6sSJ5i+Oa
         ygDicjJDxXKf1QaIe2oE4pGi4yZyuHADtzzGZ52qunt9sRPiWy8feRfBcoMbuEskGvg0
         Dao2YWqJIWBN2XQr9M8yarDZT5eKZA+W2KAvFS2Z663+BsWkFC7y2537hxSTuO7w+B+X
         MmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709315; x=1774314115;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJmZWcweGo/5CL7dk1HuKW3M8jV+oED2e+YlbfIAvtA=;
        b=KYIFsRZO4YRWYYT3YQEOEob+hXzPGhRWTQfuukYwDEAoxt8lJ66fv2z0HIvCwJTSTt
         b64+0u3F0b/765N3U3UciIbf0PyN8cQtnpIy5aJPgn6pgJjnQphM6MVvjbBmEwlf82LP
         6hbIH4Gqa7nIQaQXiTBCtoAhPDnFGuMuUDQNyQxo3Wy6wnXeyNaCeaOlENWSLoy/J6JG
         X16rhC5aoeRt9IHaY3pu+5iRlN6zHs9q3BYpuPFTWPr1JqBnIjthx4Nvz1dUWZRvS1Fx
         txeJHlLL1ctqpP1PsOjD/IGwkrp9bV7tdqHN+EZ/wcgtYUzJ25vACCd0wNZZDt3jp7l1
         RCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoLQD2KOsEj35dlhOy2QBaVv8+zJIlOBzU4yNwxfS3AyPG064MKOtP+FwQ86EncBhyDIfbUOn5GOf0@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7J6nrvp6g0kpCk50qCbzy2Rilwj6IZVqZGiMWVZ2fNvD5dk7H
	wMVswgRCHBXhWQnqV13Zus37Fohu6mqEchXMpZX4mSTFuttKhlQJ8Vj1+JR4AtwmFro=
X-Gm-Gg: ATEYQzyUk1R98aHBRGEKlmdgU1xiKQspEdTHcmTf1W2Ygq6FPqtmIUyFd5CRBHMF/Gm
	6Fb4DC/BzNiHbmB//PYCsFTuxte4MjfQPSyvxN2CnvKOtr8xe74OxIuoRWgrBezh85fi+jiUAAy
	AMtCB7paI+krKBzqO8ZVnVXWBPu1mYMBsmCw1FrRdLxm939rpdUO4KOfS+ATXdGIEswtTzdghIl
	DO2l3y8kRYnm891iiAqG2vEqwt1BGQkJOvKx54yuvZ+fKtDMuSVpMvt3Occ5gUWvW8OCzCJNimO
	XPeLZVAGNANpqm3rWitsB39W9xfORnfHQy591Oj4wv4p0GhhjgHz8LW53FZRR8An//Pps1zqZWl
	pmeUwPXfTMCCylw59Qqe7NGo8oxUraQXziD4D7eBqHN6eyfnPkyy8T2iC6v94+XeUh0OWDovIH1
	Vb11DGydaElJCYaWMq1V0mMBL1fbK/3qXU1hWIsUPZyQV4wXbbK11s6ZEFRAUIyiSOIMT/KcYEh
	6NVYm9CtOYE8MjoMznu
X-Received: by 2002:a05:6830:3e07:b0:7d5:96a3:f7a5 with SMTP id 46e09a7af769-7d782519025mr10383836a34.18.1773709315458;
        Mon, 16 Mar 2026 18:01:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d77c961e79sm10284487a34.7.2026.03.16.18.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 18:01:54 -0700 (PDT)
Message-ID: <307e4126-91ed-4ca8-9eb0-3f24f1490aa8@kernel.dk>
Date: Mon, 16 Mar 2026 19:01:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Ming Lei <ming.lei@redhat.com>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <177369928494.700746.8101380068186003544.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <177369928494.700746.8101380068186003544.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_180156_717995_F8708334 
X-CRM114-Status: GOOD (  11.93  )
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

On 3/16/26 4:14 PM, Jens Axboe wrote:
> 
> On Mon, 02 Mar 2026 10:29:09 -0700, Caleb Sander Mateos wrote:
>> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
>> requests issued to it to support iopoll. This prevents, for example,
>> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
>> zero-copy buffer registrations are performed using a uring_cmd. There's
>> no technical reason why these non-iopoll uring_cmds can't be supported.
>> They will either complete synchronously or via an external mechanism
>> that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
>> io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] io_uring: add REQ_F_IOPOLL
>       commit: 9165dc4fa969b64c2d4396ee4e1546a719978dd1
> [2/5] io_uring: remove iopoll_queue from struct io_issue_def
>       commit: 7995be40deb3ab8b5df7bdf0621f33aa546aefa7
> [3/5] io_uring: count CQEs in io_iopoll_check()
>       commit: 3a5e96d47f7ea37fb6adf37882eec1521f8ca75e
> [4/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
>       commit: 23475637b0c47e5028817c9fd4dabe8f7409ca6c
> [5/5] nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check
>       commit: f144dbac4b177cfd026e417ab98da518ff3372cb

Caleb, want to send the liburing tests and documentation updates too?

-- 
Jens Axboe



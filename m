Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F22C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLN6o2U2Q5UcOfg7HYEXDQeP/B1QpgdGyUG+UWgI3BM=; b=BcwYb36b4VPF1P
	NRB5KCjQyM/pagjc2s4xL/WqY9/r1XJ7sOhLam2w7pydiJEkKQWjnK7xONgRVKE3R4/UdrWetfJ94
	vzXihHrVpjSz29h4JI/iYuh8gPOImepXFQMZukcZ97TeZVwDbZSHiFG/xpkkwYTf66f4gJMBXLTjm
	t//cpJP3DVlHe3sZwL3I++Tmp1qYVNT6/ddDhCGZsKpnG41ECrygXEk7dcpw1jtjFTldFzTOe2EZp
	fLcadIHwAHQwXL3xj1ryEQKUT1kF/YA8+BYpGsSiBNG6Po75sEcXC3p2QSpF5CpIVzARM0wMV++D1
	WfqTN8J3iTJrq1+WgO4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7QCp-005QYJ-94; Tue, 20 Dec 2022 00:10:03 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7Pkn-00587e-G7
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 23:41:06 +0000
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14768727pjp.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 15:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xLN6o2U2Q5UcOfg7HYEXDQeP/B1QpgdGyUG+UWgI3BM=;
        b=GFerkYVpijRL609EOQ3VeMKR3i63twSSNNxxopBAg6pwoETq2Tkkvs6HH/UQ2OqzAZ
         /hFgEEGLlLfE4+pjnmt6pENlZKyOQOVL39HOTdWERipWJR0ahHWu2Ad2P2CKn+AoIvCm
         rDZGJGQ+/3xaynI59/LjaNTYvLIyhVT+KqSV2baSeboLVC2/MCkAZuTgH3AgZF/p26ON
         aM1Wh9KREyODsJDLQXGgA2dtquZ7KherpTzxdVLP+UAaqXtB5SwEor8ZNiEuIhuo8bmk
         /P4Y+6NHyhE8YbGr8iNhXMdEYLAB2ZYqYeEFLFJfpyUBG1xUyEgC6nYpIxfyqEZrxUwD
         iGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLN6o2U2Q5UcOfg7HYEXDQeP/B1QpgdGyUG+UWgI3BM=;
        b=c9Jew/fcNRnBGQ4Uc8c4y3PP2hd0qfN2KdlMnTqX5D7Uqzj6YIWpbs/6O1qmB8bJyD
         HdBUYw/kw/Q2gI9CjpZl5RRNT20eJCnnzAiClxU5Y2sWDL3rQacQa7OsjZ4SFDMHThCW
         oHjhmlZuz5OaFxCljJQ0VDa0eRbGMZRVYRZTScgs7faDcAV44pfbf6Y8Z8rLJvuCMRRr
         EB0e5Z2Q1rIuJU0V7rrqv0AfIhzhXdxFMnMkDsyg1H3B4U5sQ/2vtF8YdLushTvFNPeb
         sJfqiMGT/fmgDm3V6tUFXhC65/daIme+cP8MAyRd1fDIcgibg5mLm/gl1HcwAgyGUSrV
         Pm2A==
X-Gm-Message-State: ANoB5pkIoL9Te4AiYKJTlfwnslZzHef3CLoYn/fQLwU3QAqqkPmJ3h+4
	ZcCiAIZuhFAEN/9IUbpxUhQ=
X-Google-Smtp-Source: AA0mqf69PXTpqgO+/MFgfFSeI9d+nsqmEnMuHUFvfzNAZ/qLItUrbKgjBRpBAk/GIG0sMYqvIc8ZHg==
X-Received: by 2002:a05:6a20:4494:b0:ad:87b4:948e with SMTP id co20-20020a056a20449400b000ad87b4948emr36983395pzb.12.1671493262321;
        Mon, 19 Dec 2022 15:41:02 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id d15-20020aa797af000000b00574345ee12csm7190449pfq.23.2022.12.19.15.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 15:41:01 -0800 (PST)
Message-ID: <f2b6305b-ffd5-51cf-74bd-de39d50c67dc@gmail.com>
Date: Tue, 20 Dec 2022 08:40:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
 <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_154105_604021_759DC206 
X-CRM114-Status: GOOD (  11.88  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

My apologies on that last, it was a typo. I should have said /dev/nvme0n1p2.

There are two ext4 partitions on the nvme drive.
One is /dev/nvme0n1p2, which is a 64 MB partition.
The other is /dev/nvme0n1p3, which is the remainder of that 500GB drive.

The 50 GB transfer was to partition 3 (/dev/nvme0n1p3)

The consecutive fsck runs in the previous message were to the 64 MB 
partition 2 (/dev/nvme0n1p2).

I am presently updating the util-linux and e2fsprogs packages to see if 
that makes any difference.  The versions I was using were rather old.

On 12/19/22 11:45 PM, Keith Busch wrote:
> On Sun, Dec 18, 2022 at 09:08:19PM +0900, J. Hart wrote:
>> Here are some consecutive fsck runs done on /dev/nvme0n1p3:
>>
>> -bash-3.2# fsck -f -C /dev/nvme0n1p2
> 
> I'm having some trouble following some of this. You mentioned nvme0n1p3
> corruption, but then show nvme0n1p2 instead. Could you possibly relay
> your recreation steps starting from a freshly formatted nvme drive?
> Partition setup, device mappers, filesystems, mount options, etc.?



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19CEC77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3OHLR70ERErcVWVOIXcQUQzyAztkWXEGKP3uB9D4eFw=; b=lxacB1NcPsWzBIvTDCFWalA5cU
	cjCuYUU7orFjMIhqbl7yyRS/fEMFyWDrbeTokYnzYTOPTCgo54jTzPmOF1MHQYfXE/j+85Ad0NzIU
	BTLtQoy1CpAM3lDHNsKgOcEvEZrmTDDeHUM81qMt7qNjwGzX/y9oNJ6dydF4huQKS45bY2i5971c5
	gAnPZX1bq09XW41On42KSul38wIs6EmX+8lP70crzO5/HP/7g+rCsivQBsz9S7E0dt2jOehJ/Lz/8
	aSt5u5dSk87f2ilN3D0Ls0Q9h0kezvROsC4HKxEWyhRKo2M1wnVfAk6AdK+UaVvWmyo87fmRPpoKV
	lydkr4Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzMra-00As7D-1V;
	Wed, 17 May 2023 19:31:06 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzMrX-00As63-0J
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 19:31:04 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-760dff4b701so7552139f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684351862; x=1686943862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OHLR70ERErcVWVOIXcQUQzyAztkWXEGKP3uB9D4eFw=;
        b=0QRWMWCG0ozeMGf/GOHaYaYARviZj/cR3DDQVK+yx0cxaiVOauI+uj/hBJh6OtP+W0
         Dx4eh+mq0r/gVuMINr3TU/4rPVjT5qT7njOKjdEVYTPOzhh0+x82N9D3vshpbrtafkfE
         Xu4aXL9+C6MwsavD35QKtGH0TcfuuTMKgS7HYR7sGJJVWUl3K6188LDp6rsDYjzSZz3W
         Kj/ogAToFXcAskZrtMyPGgKcrdw81VFU6auNyqJMFtjl0soO4jUP6HpfcqI140NpYcVm
         xYMnv/RUQ8tvBM1kThkcg9SHQyi+L4M4vb2M9ya2+PfScUiuWZKt39R2iT8IpB9CK/Sd
         UYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351862; x=1686943862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OHLR70ERErcVWVOIXcQUQzyAztkWXEGKP3uB9D4eFw=;
        b=ZcG8vm2cM8EeN0mU8ZmQ0tQCLpzgQbETjwV/YdaaLzb4d3n1l26bQSpabHjMPwyL80
         TsaCp63XipL9FuBAu+UQIpqihk6XEBqmnX/hMVXuJh4GxQbsQVeyyja8N18kovl+cC0J
         pPuWzE7aQP/lL7EmuwsI/E7L96E6MMpPTkbNjCoSSWBf9WsTrZk+LtOvel9ynKTpQouB
         hTCOmt9LPaeaEL8V0SiZhpWsrFYvcCLGI1VZXGiiCNNxN3X04clB0ALedd3Draa4R6Ei
         n+V0VKMWdf7ttT5X6peFKCZF1sT4qlyWQ2oZdJNzxVeU+pOwmhl86wVdjsHQ0qX0HkJN
         5FHg==
X-Gm-Message-State: AC+VfDzas8mynI3jBgX0oA0rPdBPIX1fNAXuxJlUDGgQbim6M+mym9hx
	W9UwK0/rnDVsJ9NoWKG144Eopg==
X-Google-Smtp-Source: ACHHUZ78FLRicfxazm65ydU45P11Uw42OT1d6h8VwqAthGiaYjb/pWt8nd4BCq6WD7gnoyRJ6NNHVg==
X-Received: by 2002:a6b:144f:0:b0:770:4bd:34b9 with SMTP id 76-20020a6b144f000000b0077004bd34b9mr1887014iou.2.1684351861763;
        Wed, 17 May 2023 12:31:01 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a027b03000000b0041672c963b3sm7422559jac.50.2023.05.17.12.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:31:01 -0700 (PDT)
Message-ID: <84e1ce69-d6d5-5509-4665-2d153e294fc8@kernel.dk>
Date: Wed, 17 May 2023 13:31:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
 joshi.k@samsung.com
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
 <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_123103_134802_AEF5DC8E 
X-CRM114-Status: GOOD (  14.08  )
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

On 5/17/23 6:32 AM, Pavel Begunkov wrote:
> On 5/17/23 08:23, Christoph Hellwig wrote:
>> On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
>>> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
>>> commands completion. It further delays the execution of task_work for
>>> DEFER_TASKRUN until there are enough of task_work items queued to meet
>>> the waiting criteria, which reduces the number of wake ups we issue.
>>
>> Why wouldn't you just do that unconditionally for
>> io_uring_cmd_complete_in_task?
> 
> 1) ublk does secondary batching and so may produce multiple cqes,
> that's not supported. I believe Ming sent patches removing it,
> but I'd rather not deal with conflicts for now.

Ming, what's the status of those patches? Looks like we'll end up
with a dependency regardless of the ordering of these. Since these
patches are here now, sanest approach seems to move forward with
this series and defer the conflict resolving to the ublk side.

-- 
Jens Axboe




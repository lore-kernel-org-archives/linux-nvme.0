Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C560C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wleVqZQjFGRt46QIYxqPep0CD/JCBA/ddZDSj+HddI=; b=cX1TQXEB4+fpAsIzqLwlqW5WW8
	hHR8tL1oIgU8QOQSV1K4TRFyYQv5/yz++2Cs58N+bZzYmK/0poqxXb9bkgo/fL/Y6UfxZjUI9FwNJ
	u2o5+q6r5c8w1Oa/Pj9YTFzMvUYMxlGtUyPQAq/tRI1ynT9OR2+AJ8XGCmz5D68lFRugyJII5F12G
	vJEBALVmMr+XA3YI74oouGC0AYc2vlxWr4zMMtUO8v5ZkUAroKK/RAVaQFzGBsn2qPyijG3q3jwVz
	U5AmzUp7/EIS35ipCmiuXRl69Y04oOKKWRpLFwjSXXkvregB0wkFSWZgtjDg43AC6pJilcyit4CfU
	xQg3szIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmg5m-00HJHo-RZ; Thu, 05 May 2022 18:20:46 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmg5j-00HJH4-Cc
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 18:20:45 +0000
Received: by mail-pg1-x535.google.com with SMTP id x12so4235039pgj.7
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=1wleVqZQjFGRt46QIYxqPep0CD/JCBA/ddZDSj+HddI=;
 b=HN5+C6RfB8Rji1MsNRalF9wxLyomoBX3GImk2iWU2RcgKCVSd+HLDPDA6U3CVNqobx
 LQ4O6fTv9ixniphwKYtBn0GRdyzBYp7m+5Kl9OzdTvx55HdY7lo0V+NIw+uX8S9Z1t+k
 Si6GLcRxA4QvtyYS2hjRH6jyo6VQtFsB9dTqPLxttvmzv42BxaDGzgmgmlivenXvS8s7
 8/1GVeFa+r0sghvXGFPSE3y8nqacKaDL4ABWM5R+++hVFMWzgDLNywyCIK79BW2O3C6y
 ycz+fO+sbS+wbArMe1BAnLwIQVVV1G8InKWU9jyJC9wGkCU3znBaw0xxCfWsVHqQXfuX
 8VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1wleVqZQjFGRt46QIYxqPep0CD/JCBA/ddZDSj+HddI=;
 b=OiFH4vdJKhVFQ3kUYwMu+B77J0vgHymGAW1ki+RjFymnFSXPHWxCFeeEzTu2Wbr7/d
 lHV/jdJsIretjzQyDSp3//agk+O9YqD3meIWjn0/sRj8c0s7S49XNdi+ieqwyhAqlY+I
 EVbnesERDQ/+0TzdZDGYVd/Sei4CPtA/RL5JfnVHzb1WePu0tAMAlwwUj5iDzCSxVTun
 po6Sz+4J/tYKMQ/X+n1dsyWfa5pexn5A6dtI3rrSVGyEwH/5nTOWsvk9lRr8pn5ez/MM
 iuAghVpV6t9Zmtya/n5eLnCuoB2lWbRxHQea0zaCc597+BMifvgmlEguKQYy84xjgb/9
 bxcQ==
X-Gm-Message-State: AOAM530VQisnllPDBWxD0z6eHvC2EvZa4E0bOJD5MF5hK0WzfPtUjHoz
 pocWtxBmHkAoblxARTTCwdw+GQ==
X-Google-Smtp-Source: ABdhPJzv4gHa7MpsIdjCMkM5gCRgVPL0TG5ZiLod7uVPMmwscXff8JCY/HmX8uEPJPGxDurpbscjYg==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr27012945pfu.59.1651774840056; 
 Thu, 05 May 2022 11:20:40 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a17090aa61800b001cd4989fec6sm5675834pjq.18.2022.05.05.11.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 11:20:39 -0700 (PDT)
Message-ID: <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
Date: Thu, 5 May 2022 12:20:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220505060616.803816-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_112043_476311_0AAE935D 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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

On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> This iteration is against io_uring-big-sqe brach (linux-block).
> On top of a739b2354 ("io_uring: enable CQE32").
> 
> fio testing branch:
> https://github.com/joshkan/fio/tree/big-cqe-pt.v4

I folded in the suggested changes, the branch is here:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough

I'll try and run the fio test branch, but please take a look and see what
you think.

-- 
Jens Axboe



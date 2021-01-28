Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA7C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6A764D99
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6A764D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P2eu4W1nJXe7P9MxcIPrn5baEdx95X3cvwmZ3Uym1AQ=; b=xg+Di0JJxQn3VLR5DmsJCAaVJ
	fD4ZaNAoJyZ0foBLqkhRSiCFN/awBaNK8KxDrcf8PjlwEOqOz5wiAx6enWcopr+pL59W184nByaWw
	E5QR9IomRIxF785wNjn4P/mZKBXmT6kr6NZWtqjbSwVD4zrm+H08zVyw4vsACM8NTVKnKJ9FmgjL6
	CZKW5eucw59/oA495xQ4gVQ+RUtLEC6E1a3viZiM1R07jyJR4nIcLLG3wR/61sgIOnLo3rbS6rIH3
	/fM3G4ikCyxD3+tp/q7bn8gMI13Cry0m7i3ZsGM23pTCGSK/mC1TDtYLzZrw/ik2FaN9SbRGAdc/Y
	QWIxJBdgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l58ci-0000fR-IG; Thu, 28 Jan 2021 14:50:16 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l58cg-0000f1-K7
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 14:50:15 +0000
Received: by mail-pl1-x631.google.com with SMTP id u15so3463708plf.1
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s8pODfBWHaQpNWcashPUSkcAafUoNUPWcP3DPIUKTjU=;
 b=WEdHchlcmcEhixyRtWmu1QEJe+qYqKJL5RByzSBG3oCvEcrj966ntlz2wQh8YQlE/r
 OPgpkENuAH8x8AUBMgSQDX/nUcFGdSmSRxuHnr/Fut5VkWMdyewnfGM0jFfOeg6CHeJp
 6y+cOI+pft++Xn0+4Zu3CyfIwZcY2y6hLtN5nTUVRuSosulO+q7Nevz/g+sqoYlf14ly
 Eb3yAU75c9GRaxLFT/ZFvPjFXoY0eN0Gt1Hdqvns0skv7NSAw0S5RC0htinWznPqes5e
 LG1E5C8lU8zsJ41wG9XMGobmauGanoucrPZpD3posk3tE8qsBOAkzYaMu6dct29G9tKx
 RLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s8pODfBWHaQpNWcashPUSkcAafUoNUPWcP3DPIUKTjU=;
 b=SX1P9nZnGa28u4rJ+IhUGIIXWTCkKoGFrz1PRdiyLhnVEz+7vLAY2NX2rJA9WW8bRr
 2RRX/1y51glyoZUc05CFE+ErzmZRiQNT3DrACpI3q6o8JR4l097WjJoEdgl8P79giFdD
 1n2QvCt67vXgvlbNJylqDcWbuhh4H3rxeyrK+HVJalj3AKqWixXyRTRqViiCq8Mja4r/
 O995vmZo+6PkDndfcGAwy2IDAYKzQzzpo4FS6UOj4NGug2glKkrPitAYKWx9vvhIM228
 zvCaJxNUA6ZoY0Fgi1dOZMP2CSdE9oc08o2Q7CpHxlUH7GH6BrA2Y8SzniAUW593miZI
 i2rw==
X-Gm-Message-State: AOAM532sL8YgMU6kafGRQk18I0itWKdZWZttiSLqTHYDVqAQUB6r49nc
 uHeUh+mmzoUwperOY9IFFdD9mw==
X-Google-Smtp-Source: ABdhPJzeNAvsJAgMGTnjBX0wSqo6KmbHl5OLS498tPt64M7TFXQ9deOeINAgiEEvunnFN89hD5rqJA==
X-Received: by 2002:a17:90a:c7cc:: with SMTP id
 gf12mr11700787pjb.36.1611845411062; 
 Thu, 28 Jan 2021 06:50:11 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 i6sm6115206pgc.58.2021.01.28.06.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 06:50:10 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Kanchan Joshi <joshiiitr@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6d847f4a-65a5-bc62-1d36-52e222e3d142@kernel.dk>
Date: Thu, 28 Jan 2021 07:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_095014_692434_DCCCCA05 
X-CRM114-Status: GOOD (  11.40  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Selvakumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/28/21 5:04 AM, Kanchan Joshi wrote:
> And for some ioctls, driver may still need to use task-work to update
> the user-space pointers (embedded in uring/ioctl cmd) during
> completion.

For this use case, we should ensure that just io_uring handles this
part. It's already got everything setup for it, and I'd rather avoid
having drivers touch any of those parts. Could be done by having an
io_uring helper ala:

io_uring_cmd_complete_in_task(cmd, handler);

which takes care of the nitty gritty details.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

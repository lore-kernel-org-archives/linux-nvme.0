Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F17C77B6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uMcgY8IieE8gzKMG5aAaijf4mzx7w11YJMnCEozMk0=; b=WhaQHBy82gKROCSv8A7nwHeimP
	HSN25/JS73L+SZylUlJqwjr4kNz9vSmZcRwj/XEk1FJ/evTMLDN3I9NkN6Dzi8LOG8D5N2u+gCVxk
	N+lRQBu5NNXLKKiCAkLmQU0DR+xvtL41tE4RpQ1SEVg6Djt+/eQWP+WdHBYP1XZCge6pJcMxAkFOJ
	W/siaMALpu8+fiJWOHvGfm6Al7+8VUIN4wXT99LEhUxcl1YiEAoBZL6ALwNLVuQkkPa2x2IVT4ju6
	s+2qHL4sZUOGZa+bi/IZv/TrwzpG4D8ut/pNW9aCr19CcYiaYagc9VwMBh+keK/LGNO0uBs/kg/NW
	IaWdB13g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnIYv-009WiC-1l;
	Fri, 14 Apr 2023 12:29:57 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnIYr-009Wgt-2n
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 12:29:55 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517ca8972c5so139940a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Apr 2023 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681475391; x=1684067391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uMcgY8IieE8gzKMG5aAaijf4mzx7w11YJMnCEozMk0=;
        b=rTws7UXnVHXf5IQb75IfwnnhNyvcXbUas/gAE01YFc0VaQKYXxMsLDE/uSz7wXWFOD
         b3HKl13+q3zXVUcqPWnYiJVj7a7oJ7LVdTH/qCZ/c2RSOmJfkYNn/mz9k5tUeNLMcZxt
         48r3r+s0ZSPJ/ezc5uZ18nm26ERXoiDmhQaU1mYhO2ZWHK2Ib+fppO4AgUwIp0nLbqH+
         svF2ff2JlEG4/AUj9BXLC39e0Jm/W7kv4PVIZDiIlJxGrQp9ZGo1CbTVQn5Wbx+5pax/
         I/7MGN02AaFf9sv7sLXwIrkui/6Ts9Br2NK5SRWIKLmeRvGNKrj6ex8CTQgTF8v4Obhu
         oGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475391; x=1684067391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uMcgY8IieE8gzKMG5aAaijf4mzx7w11YJMnCEozMk0=;
        b=iqTcfM07doYtyxg/5oyQtdttYEdk8BtbkOt188+/DVMQ4PTm5TR5uPaVz5IQFNEeVN
         Y55Pkkbyp5cta4TOChkEFxEjAxuJrc17P/HfbQfd/czpXtU8qSHSjIGdN2d0dgJ7fQZ4
         iYwd6D9TVrCtVE0XlO2Z/cYJgCQ0IujhjGhc+t6bKgD3+Y1Vwasd9IyI+sLHkifXyLc+
         i7oVZyU/au0XyOtZAy40tGTuaXqDufu98g1LfwpmQeiEddGO4vlYbwcBUG2+k8PS5quP
         6SZWRXY88VE0lc9TQ3qRDfaxQra/lf+OF7UYm2n7wjc5ZIraQfKWk67MZR4Adj6C77ZY
         f5+Q==
X-Gm-Message-State: AAQBX9d/VxTMNGmibqcFvc6NQlC0jJ30rIcACO7kNewmGRfWMOOUBASc
	fjHgD28gWK6vvNkunEHfHjcBAA==
X-Google-Smtp-Source: AKy350Z72TYK6r1hISc329zOFsu2NE/qye7h4d1EJ/ieZ1R8Wg/uw74xsKZlKNds5jn3I7xgwOkn0Q==
X-Received: by 2002:a05:6a00:1f0d:b0:5e2:3086:f977 with SMTP id be13-20020a056a001f0d00b005e23086f977mr2459653pfb.2.1681475391191;
        Fri, 14 Apr 2023 05:29:51 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b0063b63303bf8sm1390561pfd.22.2023.04.14.05.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:29:50 -0700 (PDT)
Message-ID: <46930d77-7c4d-25d6-7211-183de9deb74c@kernel.dk>
Date: Fri, 14 Apr 2023 06:29:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
To: Christoph Hellwig <hch@infradead.org>
Cc: ith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZDjhyQfNnHzyvKAm@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDjhyQfNnHzyvKAm@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_052954_170242_7079AB49 
X-CRM114-Status: UNSURE (   9.88  )
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

On 4/13/23 11:16 PM, Christoph Hellwig wrote:
> The following changes since commit 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:
> 
>   block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-6.3

You forgot to create a signed tag. It's trivial enough so I'll just pull
it, just a heads up.

-- 
Jens Axboe




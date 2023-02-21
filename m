Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0F2C61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=; b=sAiGwr/YwjtiFNvIyDV3dT27BW
	vhW2w9pzmM8r4zynOqa/8jLG0ShCr6Wm1fsSC7jtxsHu9RBPHfea9PvLFAHMHhVBbaLEYW9SbJpUZ
	XiIAEhrhDAJBam9mvogaiuPhWBc3HsX8d+P5NplO5ETleF79giOq3GoLNg9IA3Bv0B9blgdPcg32T
	UfNCz0KYQpV9bV8qunB1wI6kzwgvq5mcqf92sO2Dch3oUlgWeGZ0lmbpHy6R6nSZw1RjsIUwazA4o
	YHnmzh3bDRrYBSqenFidgP8JBatZk3WkCnumZZ8ID/2v5HkBRZxh2lVUanJ6FhcowqUtjr4gKCmSj
	8mcotmPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUYpu-009d0u-NK; Tue, 21 Feb 2023 20:02:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUYpt-009czu-8m
	for linux-nvme@bombadil.infradead.org; Tue, 21 Feb 2023 20:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=; b=es73LxBK4bOHCNeGEAMbUG8eHw
	/lWv80RcNfNIPqSpH7MLWm1N4wcyxOF6MrdGrozxokDl9GONWlbnWrRZWsZSH+AoCiHbMxoDjbBnY
	Axqgp6WpdKPZ5k+7I01rCIf/aO5hYW0TKHDhX/wGD9VT1VDtB1wWIj4BR8cgiH+AMBtKt2Ku8jWhj
	30OZMEJk0GjirWtIxXT3y6jFPF2RmneJ6wsvaaMTVTbEijIhBctWOct1Kxbrwf087dMwbBB0T3IJr
	I3/DB2P9kAYhBRIoFB6nGak227Z2TT+rWAsEL82YKzXJMhU4K9XsUoB/V1CYpCYzZ/768EcFKUz4V
	e60xBCYA==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pUY13-00CGUC-07
	for linux-nvme@lists.infradead.org;
	Tue, 21 Feb 2023 19:09:33 +0000
Received: by mail-pl1-x62b.google.com with SMTP id s5so6098169plg.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Feb 2023 11:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=;
        b=bdhJMgh91hdqT4luYd5ioY/yBXBRYAcZQsrKyzfveBzI6gQiYch96TORD+AxB6uQk5
         oyAYXLrRF89zBrePntkph1MFBau8LlCFmliyyexlK0j+3mbX1GbnvNgBjezJVVByiuK6
         MBiBBJ+EcGIQp5x7oabLl73LgLF+Cmlz8VfVPinHfxB11/IW9v7uriJCTkaG/CJizM6w
         aDR2n57qZhkpUfLGBKS4SRojyDwEm0mrj+xKqE7p0TryLWAkHhYiKsM+en/HnklvLWF+
         LXwxDNEtUbd1NpX/LR+4xebS+8N9Y4qW8vqOXqDFgwu6S98CGAngdWBGfGOBhpX9kHu5
         FLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7toiITCf4zEDwukcWIEguEJe64NlPZx5g99K0VzyLdE=;
        b=AgdIpIPwyxgTSUXArCHzBuOVQ7wWd4DkneZgYY6hu+5wha8COrB0cwkh7YoDP9SEgh
         LSg3C7xpeBHikiowP1qp9qBvVdQ8o/6g504JMfT9kctyPmABl1l+SqWZ0Fjk3T2J0e0n
         DFE5AqEcp+0X6h5/HXXibOKDNQIPZHAwWLJpoOrD0+VKpp26JOTi6JF3VnG7+xoto2p7
         hMhv9ddBOzLg/hgPNsrWVgnXRvQh5jnJl095ZpU15iLt2IB/6jgbIuvYauZk516I+HDN
         BrUnMhAqo7Mmd1qKhst+YO/XHN9FFYMx1Ptkpj1B3M4TYmCxQeAojKdT46NO1rci+05I
         Jlwg==
X-Gm-Message-State: AO0yUKUEAFYh4UfTDuTmI7t/ubjbfodgWm2CDF5hafy7j3WZJvbeshzj
	fOB58hin8Y+z4FWXnfbVZrLDGztkoS8GUJCjUHYQ3QLF
X-Google-Smtp-Source: AK7set8YEZqM92nnqZUTzt9FzDBxitixBpPf8665l200lnehWpcnu9yFX9pL1BBOzg3ERV6oA+03SYtDiAWrbbJF4no=
X-Received: by 2002:a17:90b:3b92:b0:233:e796:7583 with SMTP id
 pc18-20020a17090b3b9200b00233e7967583mr1597504pjb.1.1677006565041; Tue, 21
 Feb 2023 11:09:25 -0800 (PST)
MIME-Version: 1.0
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
In-Reply-To: <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 21 Feb 2023 11:09:13 -0800
Message-ID: <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_190929_245132_2C3E1FCE 
X-CRM114-Status: GOOD (  24.26  )
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

On Tue, Feb 21, 2023 at 10:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/1/27 00:40, Matthew Wilcox wrote:
> > I'd like to do another session on how the struct page dismemberment
> > is going and what remains to be done.  Given how widely struct page is
> > used, I think there will be interest from more than just MM, so I'd
> > suggest a plenary session.
> >
> > If I were hosting this session today, topics would include:
> >
> > Splitting out users:
> >
> >   - slab (done!)
> >   - netmem (in progress)
> >   - hugetlb (in akpm)
> >   - tail pages (in akpm)
> >   - page tables
> >   - ZONE_DEVICE
> >
> > Users that really should have their own types:
> >
> >   - zsmalloc
> >   - bootmem
> >   - percpu
> >   - buddy
> >   - vmalloc
> >
> > Converting filesystems to folios:
> >
> >   - XFS (done)
> >   - AFS (done)
> >   - NFS (in progress)
> >   - ext4 (in progress)
> >   - f2fs (in progress)
> >   - ... others?
> >
> > Unresolved challenges:
> >
> >   - mapcount
> >   - AnonExclusive
> >   - Splitting anon & file folios apart
> >   - Removing PG_error & PG_private
>
> I'm interested in this topic too, also I'd like to get some idea of the
> future of the page dismemberment timeline so that I can have time to keep
> the pace with it since some embedded use cases like Android are
> memory-sensitive all the time.
>
> Minor, it seems some apis still use ->lru field to chain bulk pages,
> perhaps it needs some changes as well:
> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com

The dm-crypt patches don't use list anymore. The bulk allocator still
supports the list version, but so far there is no user, so it may be
gone soon.

>
> Thanks,
> Gao Xiang
>
> >
> > This will probably all change before May.
> >
> > I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
> > their work to convert various functions from pages to folios.
>


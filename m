Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FA4C83003
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2UuwNiIULVdlTjH/QXIKxAjBwjiTn6gs7reREGjC+uY=; b=2Beny90BT2xYRZ4LDXJfBLhEUQ
	46NwarA/VkrXw6t6SAVRl08XZzxSSiaUuLGeIMO0KBGsYxz0mAwDjgB3ZNEV8JIHP1wxgBTG1UpL8
	tzuPMj9VUmiq0RVHGzGSjTUd/4+nIr7QvGuBsG1FLStSvbQ+ImyGvQNaOsA2JR0OfpsEBHj87Fgxb
	HcKuz6XZXj0gcUAPmoyruT8LCwa4gFvohg/fX+BTcvqvs8q0HzVio5kHRzKcJJfRgXoIsamNvuLsT
	mJ05BvIf6VvK9/XoOUeGge7vRRM3Qjg+5mycWZ4wU0nCepvFLg190Ot06YPKOYu2ageKJrH+DesF+
	31kf3D+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZRg-000eE2-AQ; Thu, 02 Mar 2023 03:17:28 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXZRc-000e7j-Mn
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 03:17:26 +0000
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so1360100pjp.2
        for <linux-nvme@lists.infradead.org>; Wed, 01 Mar 2023 19:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UuwNiIULVdlTjH/QXIKxAjBwjiTn6gs7reREGjC+uY=;
        b=gYWIOdvWKDLkaxODmaIE7dIr1QixXJmeMC7rNoGekgeKf9iS4u1Q7Xx4YfhGTrkbZw
         NOVMfgd1VA0FAaH2xEZDAZVJpZJVlYu2KRh7wSP0KUSQJnnznFPdFFMHdMBl2ulskuuh
         02+csEGd5VyrKuqSvMKsEHdM08xNw74SOYGclj2edU/lyumUyrPCImen7zuK9phRU/aL
         sMObElyT6YQRgQGCLQcQ9jyCiQBwxlp4yX2GTsGamaCUjHFEzDuk4FPMEZuUBsa8ORKQ
         Xl1Czo++gA1lrGq8td2Xgu0tfNs9IsKQI09xGNL1qiKeGID0pnSCZvvpXnkWccCxY2Nj
         8b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UuwNiIULVdlTjH/QXIKxAjBwjiTn6gs7reREGjC+uY=;
        b=GyVRdhlToOnJ8NQ1LMLP4DAjf0FeKMHOY6tcya2ufBU3UmALF4D7OZIi5rOMfd4Tpl
         ah6WX2CsRtfXf049fouMDF3Jsz5YTdnjb5utbpVOMAy461J0JtdlFjf5vTXpygRUc2JB
         RbYdXVCL4/7MPTYk91S/PnSAFJUCLs6kXY94dnZ6EZP/hO/rOdWoYvvVE3K/yRyiIGZu
         4Wn6QBtegqebUxfj/pCoKCJGIa3pcG3xXJv+gXYxrnkEo4ne1x3sXcunJw81zMYmz0Sj
         i8VyjxmRbDF/I8LlDges0D1Ijv0v8g7IMT36R9Dx6xbXfsNCBviUAybFEPplQW1TBtLC
         /ObQ==
X-Gm-Message-State: AO0yUKXweNQPiP0nN1agZaOGue500kQBnNX1fCBuK+L6OHKzBjOVQE1q
	4jF3zBNqnoC7WY9YU7R3kiumCA==
X-Google-Smtp-Source: AK7set9D7ipY/0SmxAsTtsROL+QxBusuFZ0I9xJ1TBi2lMvOgTicOaOQ94eDPBK/WLMENx8ZozpeGg==
X-Received: by 2002:a17:903:42c6:b0:19a:6cd2:a658 with SMTP id jy6-20020a17090342c600b0019a6cd2a658mr16658plb.7.1677727034772;
        Wed, 01 Mar 2023 19:17:14 -0800 (PST)
Received: from [2620:15c:29:203:5530:853:8d92:ba58] ([2620:15c:29:203:5530:853:8d92:ba58])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b005810a54fdefsm8584795pfe.114.2023.03.01.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:17:13 -0800 (PST)
Date: Wed, 1 Mar 2023 19:17:13 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Matthew Wilcox <willy@infradead.org>, Pasha Tatashin <tatashin@google.com>
cc: Gao Xiang <hsiangkao@linux.alibaba.com>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <Y/UiY/08MuA/tBku@casper.infradead.org>
Message-ID: <a94384e5-cad2-fbdb-9187-7b626557e93a@google.com>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com> <Y/UiY/08MuA/tBku@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_191724_785633_C7112967 
X-CRM114-Status: GOOD (  23.12  )
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

On Tue, 21 Feb 2023, Matthew Wilcox wrote:

> On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
> > On 2023/1/27 00:40, Matthew Wilcox wrote:
> > > I'd like to do another session on how the struct page dismemberment
> > > is going and what remains to be done.  Given how widely struct page is
> > > used, I think there will be interest from more than just MM, so I'd
> > > suggest a plenary session.
> > 
> > I'm interested in this topic too, also I'd like to get some idea of the
> > future of the page dismemberment timeline so that I can have time to keep
> > the pace with it since some embedded use cases like Android are
> > memory-sensitive all the time.
> 
> As you all know, I'm absolutely amazing at project management & planning
> and can tell you to the day when a feature will be ready ;-)
> 
> My goal for 2023 is to get to a point where we (a) have struct page
> reduced to:
> 
> struct page {
> 	unsigned long flags;
> 	struct list_head lru;
> 	struct address_space *mapping;
> 	pgoff_t index;
> 	unsigned long private;
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long memcg_data;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };
> 
> and (b) can build an allnoconfig kernel with:
> 
> struct page {
> 	unsigned long flags;
> 	unsigned long padding[5];
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long padding2;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };
> 

This is exciting to see and I'd definitely like to participate in the 
discussion.  Reducing struct page overhead is an important investment area 
for large hyperscalers from an efficiency standpoint, we strand a massive 
amount of memory due to struct page today.  I'd be particularly interested 
in a division-of-work discussion so that we can help to bridge any gaps 
that exist in realizing Matthew's vision, both short term and long term.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B395ECCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2026 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8jd2Ibhvngu1lVvyqeiKgt0aWWT1GOPQoZ/zlGkZL8=; b=KT9k+z+Plk7f0XTDkXB8JF/KSw
	H3cbm4/e0g4/qM1Vuemz+grbTq3yASkxvWGZyW8C8DwFOb4YmzMKZx3LHRZHD1qk/d2p8KTIKeLfN
	bdAcv9o+SGvLu1te4XVz3R/BGrjQwJUmnGUjQM+RGydogkNwxgYprqEU7jLYfKU2Cc56ti6+LkzTE
	7dcVTKiPA16zJttOko02Lc1vj46QltDIq+HkDdIHWxA2wrZ2+E7i8ybJJFHPEUzzuYmon0eR0mjDC
	enLSAFhqt2UaNLv0avYNx6ZcNOdOS5egFGzZ4z3FH2koZUfpedCOeu9Sv0lYod83wSiS6tPkw1LIq
	kVv/Bf0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIowF-00000007Gtv-14Vv;
	Fri, 01 May 2026 14:33:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIowA-00000007GtK-0GD5
	for linux-nvme@bombadil.infradead.org;
	Fri, 01 May 2026 14:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j8jd2Ibhvngu1lVvyqeiKgt0aWWT1GOPQoZ/zlGkZL8=; b=JlLp3nC5QFGk3BtYNoCroq6B0j
	W8vgg5A36MBeE73KXsh7wwLma6wYSWPSTTkHLwVBwvjVZjFOW3sgYis6Gct1JQfK163Hh61tV4qMp
	KMEh+6l5BPnjaI49jE5mhay65vaEoA+TXFSkRoeQUI4e1T2jB/Za29AARfRwBtumwLtBW1Ab37L19
	+bxEysJ3BHvjlBsh9nAxPA1FnJHLJ1h1GRnAXVUn5g+AxhgXfUXC6qFGQx5bOQA1LnB8y2nO/ajar
	uwjkKWnejgmtab5TkN7pECXk6Zp8p1VfQeopvoT7wj/ei6uY7GislSmeaNeUw/arZYxbGSTSTxmdD
	KVP2yyow==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIow6-00000008v1n-2Dtr;
	Fri, 01 May 2026 14:33:47 +0000
Date: Fri, 1 May 2026 15:33:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <afS5yn5QreBFQWLi@casper.infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
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

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.
> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>   just reading /proc/buddyinfo?
> 
> And, of course, I would like to present (and discuss) the results
> of the testruns done on 4k, 8k, and 16k blocksizes.

I think that Rik's recent work is going to affect discussion of this
topic (summary: with a "small amount" of work, reliable allocation of
1GB folios is possible):

https://lore.kernel.org/linux-mm/20260430202233.111010-1-riel@surriel.com/

but another aspect to it is the recent performance problem reported by
Amazon (summary: compaction takes too long):

https://lore.kernel.org/linux-mm/20260428150240.3009-1-dipiets@amazon.it/

Anyway, I'm putting you on notice that I may hijack this session to talk
about how GFP flags suck.  I may even have a proposal for a replacement,
depending how inspired I am over the next few days.

I still think this discussion is useful because we wouldn't want an
attacker to be able to make Linux unreliable.  So it's useful to think
about how userspace can make memory unreclaimable and if large folios
make the problem worse in any meaningful way.


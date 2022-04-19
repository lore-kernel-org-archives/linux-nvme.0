Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADDBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3uTLPiJrypIFbJrBbJWzyUq8lrOCNCTROK2VPYKwjoA=; b=eQWeDDV0O6b0HLIUC/4yJYbU4V
	bv0LxuQvdLF4fUm/J0L6qdWkAMke//TBIF0tyksefu48CbD+06d/ut86VZPCduwXsoCgwG2rSYYUF
	bDhNtTdwi5nU9bKvkMrZTPS7nnLCva96STL1utIh2qCq8pnDN2E7EoYDEG0yVhKgrZ+G+IeJGGZAL
	rwx8b0j/AwBd5Z8/GUpFodwZCy7z9XXCH9lXNw8+eo2vQTk6m0zG+geqRg2xFxhhiqeg3E8qsAQ9r
	gqXhLS+5WylNTMOss4lCMPVJeyNpstS+SqA0Q0BfeYN9+ya9YSfU6ykmAHIzbkit6j2GkxwbxkGZY
	23mO4BYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngpxG-004jj2-8y; Tue, 19 Apr 2022 15:39:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngpes-004bU5-TL
 for linux-nvme@bombadil.infradead.org; Tue, 19 Apr 2022 15:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=3uTLPiJrypIFbJrBbJWzyUq8lrOCNCTROK2VPYKwjoA=; b=CqToA9mnHuh9R675pN4UgpoBZg
 gfu2d3mM2Owwa+3GmAofOGXIkBfmV/sB9AXgipt84d4jtCDfNjNc/8T8xR3fiWIShDCd7CK0Ivf6B
 SevxsUBQjZV0HfnnYjW8xaNKIu6jMGOMDdZD0K2ZiGMUDUvbYmNkYn6Zd7S/5ZLs/MH6CpU3qE/31
 Jag8nwx17tjwDTXsxb5aBbZIfhJzWnYXKEItolLqGqNB/m6cKSLsCjjUzmF1oz+/Hpo28sifNg4wa
 xgDt0VPEu/+w+PC5KVfDcP3sCIjVymIn8khwth399ruFBjMc86W3INsvi8dunb11Q+a9560yXNE/G
 cUsLfxfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ngpeq-003DM3-Ew; Tue, 19 Apr 2022 15:20:48 +0000
Date: Tue, 19 Apr 2022 16:20:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF 2022: Running BOF
Message-ID: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

As in the past few years, let's hold a running BOF.

I propose meeting in the lobby of the Margaritaville hotel at 6:15 for
a 6:30 departure for an hour-long run on Monday, Tuesday and Wednesday
mornings.  I'm assuming breakfast will be 8-9am and sessions start at 9am.
Pace will be determined by whoever shows up.

We're only a mile from the North Lykken north Trailhead.
Other trails are a little more distant.  I've been reading
http://www.hiking-in-ps.com/the-north-lykken-trail/ (note this map is
for the south trailhead of the North Lykken trail).  I haven't been
to this area in 30 years and I have no idea what the trails are like,
so if somebody has local information, that would be great.

I note that the room rate includes complimentary bicycle rentals.  If
we want to, we could cycle to various other local trails.



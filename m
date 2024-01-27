Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AD4C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhHNxgF3fX8abmBvoOAyuYkGMYHZsCw8fbKtovSaG/I=; b=AoOzxW75B0/x9OnPn/O6DMAkXR
	rYlZMTw5XHolqgpy0x4UFqrdrVxcw/+W+7eLq3Il3XwcjAyC/D4q6xow/sGy1IAkzcFSm8bR++6PG
	CU5ha3D4FONE0C2EKLGAA6MQOnUpYGYkZKuJhn8i29Mrd8sijA+H6oO56ZSkX9V9h5ms2a6AGn1fs
	SAsuUhtegCl59lmwlV1u779jZ06vfU/FaQYcV1rkYrRLd3gQ0M7J3MpU7PAoEun3o8l8HNMz7Fc+x
	7c/ii0XryXoeZBI8OaKKcUQWqFTi6QdG0YCkdYna3/zTEMUkjTazGJRwIv2nMGGdKx71kEyhWWpub
	OWFVrtvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlNf-00000007jqm-1i41;
	Sat, 27 Jan 2024 16:18:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlNd-00000007jq5-2JjM
	for linux-nvme@bombadil.infradead.org;
	Sat, 27 Jan 2024 16:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KhHNxgF3fX8abmBvoOAyuYkGMYHZsCw8fbKtovSaG/I=; b=gdFaxO8t6tnCSKV8WTnvzfHz2e
	vL3goFmREafb6BeoodiQOqw7C6OocFzhyq/eIYwdJAhsYIdpoCUXYDONbVTFM9Wc/aGWtxQ6yl021
	APdqJgfTxUUXMDYm7Re0cYNuq4tL18oadwnRPa7Hum6f6R2lvDwbqc9TVET+KbAHR+C5N+KuDNf6S
	EeVNaMcEFmgUYrmxhgcrjFDhDXK+jLn9UsH4bE+3ON6iblEXxOR8UGQMyj8M0emHEm5KI5oT38/y8
	WMH9ok4+pBbJkgSTOd4sC+FOfd8sq1abWCj78o1W14txC4lKOh33kzs4Mo/W/uhNb7OKnJxMm8ndZ
	cpI2T1MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlNa-0000000HLiT-3PXm;
	Sat, 27 Jan 2024 16:18:02 +0000
Date: Sat, 27 Jan 2024 16:18:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbUsuquUXXq4D6fw@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>
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

On Sat, Jan 27, 2024 at 12:10:32PM +0200, Amir Goldstein wrote:
> Matthew,
> 
> And everyone else who suggests LSF/MM/BPF topic.
> 
> Please do not forget to also fill out the Google form:
> 
>           https://forms.gle/TGCgBDH1x5pXiWFo7
> 
> So we have your attendance request with suggested topics in our spreadsheet.

I'm pretty sure I already filled that out months ago within a day of the
initial announcement, and I thought I included SOTP as one of the topics.
But honestly, I'm not sure which topics I filled in there.  Is there a
way for me to know what I wrote in and edit my initial response?


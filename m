Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12229C4707B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 22:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTaJ7F4UvxTDYLwb0WtqTx+At6efRtBZFNZppNwGZ4o=; b=Hm13aXSF6W/hs0qByqAoTz6yLM
	fykzUQrtalQP1EC78GrmecKIZgRYR/dDreqhWn2f82tdZooE1Wy1jkGRH8Hc2+ImMkFDqS9ByJGTX
	Sjr27zoyqslN94vKoffHOYyuWVaLlaISAxfEc3oknOdDZQhKiON1HcMfWPIbwnH43Mfn5XXu4mRWa
	9qFUAkCKFh6j1eXUenck8o+OzkAMXqAICqDW7NnUhaJapwHtQPOHQl4aORjkvgFT1KHrBavM1XTHi
	iZN41KsE3RJi1h3c16DiOR4n3OMwIpSmJhfY9ShOgJ6huYanEKjj8j7/Cy9xSIeh9qcr0B3LNGCil
	WXEwigmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKVV-009i5P-0w;
	Tue, 09 Jan 2024 22:23:37 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKVR-009i4R-31
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 22:23:35 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1536610a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jan 2024 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704839013; x=1705443813; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTaJ7F4UvxTDYLwb0WtqTx+At6efRtBZFNZppNwGZ4o=;
        b=jwJECUbbKJ/RKLWmsKNzS1pwY+RXGQsFyK/j5s2ziWYm4Bwr1eGhEX2R3GfnbgU2KD
         4OhfNOIELew5sXdRGpZ8iUsxJLifmTnKf/XEK6/unGiT0JPf4CNq2EbRB8/JQrfGf9hL
         6usVnYUw4m9H+yOG9oi7kySWTBKnXnVwvr6zdurUkD6TultSSfK1GmSPVoBSa7OWqtfh
         IIeXer8fcOfygxFL17j1+j9fznUKZaaGOGROoQSBpm23YK9R5MFp6c888iQaPoTQtohz
         3bKqKt0e0jK+wgRKtvvgI4igVYN+W1qpCo3AYHb8dvBjNP+PhXJn6O821XrL1zg275Db
         +9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839013; x=1705443813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTaJ7F4UvxTDYLwb0WtqTx+At6efRtBZFNZppNwGZ4o=;
        b=Q03oqmgnZOByyWHXWJfBnCf0gQ02Q4lRAc1gvf3JJ2SZ6KOhT2Cq52sE6XEEH7YDC+
         K4pq6WCwq/grskvrXNgKv8I1t504C1/qIpz34LuHUpk22UNbcMyJna6VRHAwy6/cr6jo
         fQpYgbcXmLY2tbY2vea4H6TfVZ4hAKVSInfC1gLTln6XFf4bofhAEJ/GwBltJ0nH7HgV
         2EWr3ZjsI0uNIc5ix7y/KXrFK/VDMPgvkmNcutri4BnoQBwTnhRrUTnqJj+FmZKTXFqz
         tytS65O+0dfE0Aw8k1jiYgLojNxP6/pM4x7HYsyaWHCKRCSRDyHpHwSBjbFoUNna3DxE
         omEA==
X-Gm-Message-State: AOJu0Yz2XEPJ7ouaNLUJkshCbCAhDFnXetsFEA02nh/tdeHhAwFQ95MK
	tcimV+hqTtSmg3u1bJyy0d/sqhVdzZ2hTA==
X-Google-Smtp-Source: AGHT+IHwxs6hfy7c10y/Z2WOv2jOl6yN4BZqONuQsBTiNNd0jqVThjnDnXUFG2w0+QL/HodxmXR+Zw==
X-Received: by 2002:a05:6a21:339d:b0:199:c372:d775 with SMTP id yy29-20020a056a21339d00b00199c372d775mr10071pzb.91.1704839012809;
        Tue, 09 Jan 2024 14:23:32 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id ns14-20020a17090b250e00b0028c2de909e4sm2574940pjb.50.2024.01.09.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:23:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNKVN-008FeO-0H;
	Wed, 10 Jan 2024 09:23:29 +1100
Date: Wed, 10 Jan 2024 09:23:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZ3HYUR85iIEJiGX@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
 <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
 <20240108173928.GB28693@twin.jikos.cz>
 <b5bc1e72-72ea-4b67-86a1-3d41deb5bc72@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bc1e72-72ea-4b67-86a1-3d41deb5bc72@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_142333_975307_51FD611A 
X-CRM114-Status: GOOD (  20.52  )
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

On Tue, Jan 09, 2024 at 07:43:54AM +0000, Johannes Thumshirn wrote:
> On 08.01.24 18:40, David Sterba wrote:
> >> 199 - btrfs
> > 
> > All the easy conversions to scoped nofs allocaionts have been done, the
> > rest requires to add saving the nofs state at the transactions tart, as
> > said in above. I have a wip series for that, updated every few releases
> > but it's intrusive and not finished for a testing run. The number of
> > patches is over 100, doing each conversion separately, the other generic
> > changes are straightforward.
> > 
> > It's possible to do it incrementally, there's one moster patch (300
> > edited lines) to add a stub parameter to transaction start,
> > https://lore.kernel.org/linux-btrfs/20211018173803.18353-1-dsterba@suse.com/ .
> > There are some counter points in the discussion if it has to be done
> > like that but IIRC it's not possible, I have examples why not.
> > 
> 
> At a first glance, storing the nofs scope in the transaction handle like 
> Filipe proposed sounds like a good idea to me.

That's exactly what XFS has done for the last couple of decades. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


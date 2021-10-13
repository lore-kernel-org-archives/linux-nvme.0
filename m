Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D326052B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24D326052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvE9A+LL2XADoLsMv/QT6HGglilUC7cXAXtJNsfa8lA=; b=WEWEFV57+xVSYrbAZuNkrD+ZBN
	oYISbG8pdNcBw3cio7DtdJDRoM0erVCbpQYYZVTVj+D7nuM8WHd05rSAq6SGIfkbtKgAnPbrkQcdf
	dllh/pPsJhDuOcHsFRwwKHGRck/igDNb7Z7bTZ5ozN6bwHZWip++hiDP5VCCN/tRXGSPimj27ewv3
	h32S1AmuWYrTrXGxOpz3BsKeay7x6OHknDx5KAnKmXIfaRZ2nC2FzcnKjmOzqv56EMem0+agDMzks
	bG98+OvRZnLXtOLsFGWotRzu6/5gZVGUqAABKZJIMeNBK/Ajt6FBu76bO5hZK/FNgvDiaYUfnsLSD
	aVWC0raw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mahQa-0005JJ-TP; Wed, 13 Oct 2021 16:48:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mahLZ-0004Pp-O6
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 16:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634143395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DvE9A+LL2XADoLsMv/QT6HGglilUC7cXAXtJNsfa8lA=;
 b=IIypTiFYhWCZbUSA7VEpUQlZe+SKXR1aCyCxIeoqcvY99VskuswRyMMy2b0K556uJIiCjv
 Ox6qgb6HttmrXI9seTaJDYkZUlW9UeyOf+kL7QD/bz8MJ74DIoTbmWfaHbeNmatD8nYYnh
 K+JHChfxdua7U/XCkmmnTUNapGNrs3s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-UAE3l7C1PWOJserrXFjP4Q-1; Wed, 13 Oct 2021 12:43:14 -0400
X-MC-Unique: UAE3l7C1PWOJserrXFjP4Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 103-20020aed2170000000b002a79b815862so1954037qtc.11
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DvE9A+LL2XADoLsMv/QT6HGglilUC7cXAXtJNsfa8lA=;
 b=eLfi4xOQcM8mI85+Psfic9Si1ctueGAgmgMtMr4A67l0s3eKPn2nNsvYvxfkVr4AEu
 6uLyJNR/Ex4fpjVFEjsX6JHBXRZYrYN+no2/CBt48Dj6UsHt+A4dxx0ceHMSaAYGSWuy
 JDSVCBfqd/rv36tZTx6f9r/+Sboe7Y7mbYK0uQxBbfpVzYe/GeQIMr3ZokRgG39zbKHr
 UmcfST8T9B+lpspRdW7ZBJhd8Fj4GUqs63rrvOOIQZg1FcsRJcrxim2xBqar6peO7r7N
 eShbhodms+q2gQm6I1AEFr/AoGTFL93QCPBIGneNml3bGIGwa5OYqaSIdAn5hKZ88Qzq
 m1Cw==
X-Gm-Message-State: AOAM5325cB/R5MoiSzpVouXuEyyB097pHZdiwVbB3PpIzULXcm2JegCv
 DPt/zAqQaD6NhtYriN6MD31HHfh4HCfJMbU2uFS3xzbnzPXULq2UiBm60fEhFSEyYMsJA3+IrMU
 JieJVBIiniOhccwx9N98YJIgd+g==
X-Received: by 2002:ac8:7d02:: with SMTP id g2mr450210qtb.66.1634143393832;
 Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4uQGBl82DdkygPL4oygkwPDtljuRYBV8+ESqW4tKnOahM7pZ+SYljUTQ3BKpa4FdVi33PjA==
X-Received: by 2002:ac8:7d02:: with SMTP id g2mr450159qtb.66.1634143393507;
 Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
Received: from localhost ([45.130.83.141])
 by smtp.gmail.com with ESMTPSA id q14sm77870qtl.73.2021.10.13.09.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
Date: Wed, 13 Oct 2021 12:43:12 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 03/29] dm: use bdev_nr_sectors instead of open coding it
Message-ID: <YWcMoCZxfpUzKZQ+@redhat.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-4-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211013051042.1065752-4-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_094317_898994_CE513649 
X-CRM114-Status: GOOD (  10.96  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 09:48:27 -0700
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

On Wed, Oct 13 2021 at  1:10P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>



Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45D561181
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 16:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A45D561181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ph+oZ8UT4h1HTx6qQ3UwPOnmmXuejFlF+FpHdhVkhfw=; b=Yjy+XdxYnJ3jODL0Hjw5lzhxaD
	Z2HwnDv1DR3ghb4GmxQUNu4T4dF5T2OevOBwvdic81ijHJg5co8KLO5GTgsSYFDVRKpHCNa7fihY0
	9M5LzY7LRrnLlJmsRSUus4igxjNdUtKTl6ln4Y3O+bCzbKt7Y79A77LGkdYgDjWNcMgaVWsmXS18y
	bVA1gse4f5rHCZubtTR3Su627LOoRYECxxAHkHqT/ldr/JLxWp9bIlu14tqnAjZLETo7+utfqqh29
	86feIAtsbCw06wVILAjkJq+yPuY9Kpt6iAfo0ThGZII+5617tHNfeY9euu765RP+w3YQm3ieE1oYy
	fmsH7W6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbPhm-007zX7-Ht; Fri, 15 Oct 2021 16:05:10 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbPSj-007xMU-5v
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 15:49:38 +0000
Received: by mail-pj1-x1032.google.com with SMTP id gn3so1944305pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ph+oZ8UT4h1HTx6qQ3UwPOnmmXuejFlF+FpHdhVkhfw=;
 b=iSbFTO7hl5wsHi/v9726DpD3kjwHBmUweM5nSVDlyWBslMc3wVKEMvQCq5pVO/6MpZ
 QpL/26LdJe7GrULqRDxfawSnvbruhiXNd7VKIbgGj0HAHUSD4T22YVTuGUCVLgeYQ9DD
 YRPQKjchN3EU8Gz5xfRwkBHxJQvIPm4lQcdPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ph+oZ8UT4h1HTx6qQ3UwPOnmmXuejFlF+FpHdhVkhfw=;
 b=V5+oqpkZIVC0q5vn7AKDK8joLSMJzQbvnTVrZNQ7JHBmb7Ebui/XPe1JSqrDvC2Zm7
 k5rjk7EZgTYtGkuSLQXUveArwMaBJZJczH21Ttc/ylgwItRLqd3eSR3ShM8iFqEimXqG
 d8omspejpgrPr66uqV3QQyHIIBGWAnkT6yUdQdTBg48w8BMRbxtsY3H9wrdIpy683URC
 QKJ5ESJo4rkTv/hGaLffHK45pyDhzVd13+0GpAUYLATwAFhXcbrKwyQJglvUe7jb/Bfp
 YghhbktUOGX0muz9KjtaPJfYi5poG7+i4/wTaGDDSPTQGcYoeQwkfgAKsakUUklvvSfc
 u6Uw==
X-Gm-Message-State: AOAM532ZSabLT55IAPBUUUs2QpJH4F/iYjJm5eh24xnrzI1KJnAGDaPw
 HwiTIa6fAxlpnGSfvtjvqUImeA==
X-Google-Smtp-Source: ABdhPJz6i9tGVLgkq0eULPGyuk5x/dLn8xi+sif8q9XJ9Fat4Z2U3sGqOIlP99kszRnqXPDgBVaPnw==
X-Received: by 2002:a17:903:234d:b0:13f:3180:626a with SMTP id
 c13-20020a170903234d00b0013f3180626amr11815749plh.49.1634312976314; 
 Fri, 15 Oct 2021 08:49:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id v22sm5451930pff.93.2021.10.15.08.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 08:49:35 -0700 (PDT)
Date: Fri, 15 Oct 2021 08:49:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, 
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
 "linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>, 
 "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
 "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 02/30] block: add a bdev_nr_bytes helper
Message-ID: <202110150848.375151B3@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-3-hch@lst.de>
 <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_084937_254176_03C8317E 
X-CRM114-Status: GOOD (  14.00  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 09:05:09 -0700
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

On Fri, Oct 15, 2021 at 02:37:41PM +0000, Anton Altaparmakov wrote:
> Hi Christoph,
> 
> > On 15 Oct 2021, at 14:26, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > Add a helpe to query the size of a block device in bytes.  This
> > will be used to remove open coded access to ->bd_inode.
> 
> Matthew already pointed out the return type for bdev_nr_bytes() but also your commit message has a typo: "Add a helpe" -> "Add a helper".

Right. With these fixed, I'm a fan. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook


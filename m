Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:27:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD45C60EB4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 09:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD45C60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=17qBBdl1yRvsEvKIV8Sk6+ytZnSUmLIwifc/qXSvaNo=; b=FoRSMB16nqsxmR
	sIWbGAn1DSD7VWfQ4wX1XFGjciZsP9D/HWJi+6euVQn4YtTb6FmfEAp2aM/gTfZZ0CcV7WRdFcrfE
	rvwAQdfr4HN3JuFq1CrwyF4dEnFFExAUuplebhCAPGVHG21F9Vf534tZpaQusi0gYtKH9eF1dMJHK
	R0nf+zrneJX8MzdG8vug+4W9qB1kvimgWSDkdXQ9L3tKTIp8npJZVVyDq4WumCnspindJot8a2Ht1
	42cYVGWtjVzFPoMXgyYySd4SYbxKEpELeWogDyQaiXxOvghueWoL3RQSJM8Fg04z22K52i+CsN0r2
	jRLr6N422F0DQXJFYX+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maaXs-00FlN6-Uk; Wed, 13 Oct 2021 09:27:33 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maXq7-00FAHT-7x
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 06:34:12 +0000
Received: by mail-pl1-x62c.google.com with SMTP id x4so1123214pln.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6VbHD8PBwfaj43ljVUZZGyMj52YEmx4jfqAsGhf6+JQ=;
 b=AvobKbPMrQUDEUEp6fPFubcGItxc/wnKkqnDSAjF2JOJIzD6GaHgOkeTfLVH2dVkY7
 athTU5gaBp9pQ5+vN8pGXUoM6NXB9m94GmbcWoYtzrCupD5haSLJb51jgUAYN2bie92y
 Cw/fWMm7nAHe57gHGr8VcvjTAn4+/uHsWTDDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6VbHD8PBwfaj43ljVUZZGyMj52YEmx4jfqAsGhf6+JQ=;
 b=pcZVUcK3Uw+SeotNw1hgWa87BwVlfvSZy5/ugKpGc7MX6bghDm9dahwDC6rs0PHDEZ
 HJUycAQdoeMPGnxS83w7Y3uXdDn6Tw9Ud3HZDULb+mL+AQdzPSXdFcpcqwOmsUz4gw/Z
 zcA79RZcfjMMnnwqwk/yJ5vKnkA8XNJYc1xmBaOLKWnV+Ym/GXXCXt2zL4tY93etqzi0
 1udOwHArC5tnz9n+m1GHapNGyKmlZvuwMXqMpbhtztir4eWpwvJVzaN+ywrDLSDPsdr2
 SJ4pD3jvlQu0JJ1t7XjVUSX0AU2ePU/aTos4kUHQxMkntn1WzpOIJjgKqIJ8bM1IlerZ
 1jBw==
X-Gm-Message-State: AOAM530/nT6tDa2yV0PEQoqAK7XMXc3g5AUsLAvxLY9bxVsV4rXFT6nD
 FamxZIRAwOcin+DgQxBqhwcSdw==
X-Google-Smtp-Source: ABdhPJyCtmPDTqSGxs9iwHCnitZ1F86E6zXvgsm3yviJEZQtBzg0xs5Q4LZVn9iTvPOonDA6xdZ1cg==
X-Received: by 2002:a17:902:f683:b0:13f:2fbe:498f with SMTP id
 l3-20020a170902f68300b0013f2fbe498fmr18917273plg.17.1634106850602; 
 Tue, 12 Oct 2021 23:34:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id t3sm13004045pfb.100.2021.10.12.23.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:34:10 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:34:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
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
Subject: Re: [PATCH 29/29] udf: use sb_bdev_nr_blocks
Message-ID: <202110122334.7A3E933D@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-30-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-30-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_233411_332849_5E65373F 
X-CRM114-Status: GOOD (  11.61  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 01:15:58 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 13, 2021 at 07:10:42AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36733C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7900610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7900610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNMuazvAc4LKzA11EtG8eLgr12NNdEoTIw6YmGY7ihs=; b=XEjHwEQd7rzcc8iWoBF5u81f4W
	umOSSHvZPUFouauzxPEgSBW8B+X7NV9yomlsJ7kUsuIPxDJK/59rfnix4LDOAPBuInvcyWoKU6qxQ
	9WKFlHc6roz5jH6+l49QoPJL5HF/TSiMwo6atjvUBKIs3yDtCBCSyouYtsjdHABv5BxaxtMTqQwAm
	v7XMBLJVz4ElYboZBWAs3S83wKjfQGpO9ElkvdhwEVLETxl5BFqkXSPNRPG4o3jGNlGl47DoDYz3s
	AKpvqBbk6jxO0/bsJu5FuAXH7hho4Of4REn9wUDLj8srrIDiI7nDoTqfj7YmuFSv6+olMKPF6GV0Q
	r/X77Zgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1masXx-001Wl6-Es; Thu, 14 Oct 2021 04:40:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1malaI-000hZW-M3; Wed, 13 Oct 2021 21:14:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3ABB611C0;
 Wed, 13 Oct 2021 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634159685;
 bh=SlbEmP0SftpYg5Qzgl+3uhbNwtKN42MS1eJbqRVvz8o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hiKscGct16rhTAVFUvB8ulUGFNYX0XJpF+2YqPKF0No0/OTxa8B+FbCYvPeznM3IT
 o7+9DVjPYoKAxa50QdWsJ1gL4J+4wBU1jNZrm6P/FvNKQ8G7E2qrXO9VM2GBzVJvw8
 S/gFZjYpmMou1VruRE19i94wuylZi24lJbQ6yAN6OeRqXntYIE5B0JYh+T/uz9ctke
 L86OtKTf7XCkJxLOyXfeIFv5kZLrR3s6zlWx8Mcxq8cYKDBsASwSQxb8GUZPcnzqgT
 VFHmPHbz4NrsEHQ/qmk1iEmYL+m9W0ImnKdxKKKAOXKE+hMXaoTAVCJomjq0s1kTjo
 7pgsY+NMeWiSg==
Received: by mail-lf1-f43.google.com with SMTP id u21so14407216lff.8;
 Wed, 13 Oct 2021 14:14:45 -0700 (PDT)
X-Gm-Message-State: AOAM530W/Jez/bAIzI3zGA6jBs018fCSfQm2iAiPDrDCzUJ96c25MyRf
 yN5mg/V99bxesMDADrqhMTSQzhNJfyvs1wGCC4o=
X-Google-Smtp-Source: ABdhPJy4PwudaFsA5k7zIKbmlSW7M8/j3iWHJKEthDYdjnMO754KPa3JLlK+wmXJkye7TEJ2vXHzCCixulymuZnDiqk=
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr1736234ljc.527.1634159683768; 
 Wed, 13 Oct 2021 14:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-5-hch@lst.de>
 <202110122311.B43459E21@keescook>
In-Reply-To: <202110122311.B43459E21@keescook>
From: Song Liu <song@kernel.org>
Date: Wed, 13 Oct 2021 14:14:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6MFRmKfpUxLL3=TRAgNTuTMFySc=_-NA7YOWDAvYAxyQ@mail.gmail.com>
Message-ID: <CAPhsuW6MFRmKfpUxLL3=TRAgNTuTMFySc=_-NA7YOWDAvYAxyQ@mail.gmail.com>
Subject: Re: [PATCH 04/29] md: use bdev_nr_sectors instead of open coding it
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Coly Li <colyli@suse.de>, 
 Mike Snitzer <snitzer@redhat.com>, David Sterba <dsterba@suse.com>, 
 Josef Bacik <josef@toxicpanda.com>, "Theodore Ts'o" <tytso@mit.edu>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, 
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, 
 linux-raid <linux-raid@vger.kernel.org>, linux-mtd@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, 
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_141446_787777_110579A8 
X-CRM114-Status: GOOD (  13.26  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 21:40:48 -0700
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

On Tue, Oct 12, 2021 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 13, 2021 at 07:10:17AM +0200, Christoph Hellwig wrote:
> > Use the proper helper to read the block device size.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> I think it might make sense, as you suggest earlier, to add a "bytes"
> helper. This is the first user in the series needing:
>
>         bdev_nr_sectors(...bdev) << SECTOR_SHIFT
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Song Liu <song@kernel.org>


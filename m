Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C9C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:34:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EDA61181
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40EDA61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffV9EXIvpsxi/zzat9M/mXqT6D2BowDOkY1JbwoxMOs=; b=McyOjWY6amXFQR1EG7q3m9Kp6e
	Av8OQeX75tdvz5NpJUkQhTI2SIQYisKJk2Nyx32UvNeUzRzUxRoOuprWHOI8LfhZUz5hL3Jf1U0C7
	Ioe2QFp6uN1DMEV7se8xbm553AkAfePgwMsTO/ZqehTxU4JcXEXZFJdt7VO+erLGNR0tgT/NkEOqI
	VqVTEkc2oMv/VKMJUKTcIQ2CzSL8zuvQoWaxGHJncQmGPxvh87bNhuHLaHE9/tTs054foPOoSiiT+
	8woxiMyEY2K3mETzHFcc9IotsHymR5kR6KGESCpkr9GtrsbWODr2OCh29+BwIZp6nMqJG4aw3PCiR
	cozTSZJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbOHx-007db8-Ij; Fri, 15 Oct 2021 14:34:25 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNfb-007OTK-MZ
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 13:54:49 +0000
Received: by mail-lf1-x131.google.com with SMTP id p16so42278670lfa.2
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ffV9EXIvpsxi/zzat9M/mXqT6D2BowDOkY1JbwoxMOs=;
 b=dywwSbIGuXR+dXQSROUIhljg5+mHDSiHww9Tc5QE/0KVc6D96c2ocK9S4czPbKsPtz
 ySNRWdT9ve7V2FStFVRj6GJtI3GsO5QLdZltms855+mPxWEcF0y64BVbP3jeqDvlTRSC
 Q0SLO0cmgDLKr6f+MZ/VrWRqoygoePpVOM+o8yB+jCv00rDqDRMVdNenYkm3jQj9uL4k
 E4/MHhOextdkY9W69AUB008H67vZy/HWT7fbCa67+7KfpngwPIaSC4I9QxVoGvAnEL8B
 uHW/dfm/FieH/pIjg0HJFLHL4EoFbkdCY9X4ZyWcCPHq1gpKkT+6jn/WXPUZSeEosezu
 YVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ffV9EXIvpsxi/zzat9M/mXqT6D2BowDOkY1JbwoxMOs=;
 b=66hLCVCFRwevRD1LRkAcfaau117ae5KYy+3z0OZWnmvjpyg27IldJqdVmVVjue7f6e
 JEyvxTvWX35xgjF+LVIYNmLbFtx/VFrdAd/fuFG2iGvORCffWf4U9KazJyLshWlNcLLa
 T3x3JX5doFVDPPedDx2GykALGbzy9r5uJozitZWgGhEW2sNlebmfLANNYWw0fqXQHX/R
 oTBUPjulhUNlw0sxBdZDHzSTOVdEPGOijmUiMWrfYutaQNWvyNAiAkB6VswKwCalGT3r
 CDI/4ZWA0lic74OvbMqkJ89zoKdWAR1jgQbFPZwTFwUKk3RDpO0+bGxabHuJMbmj+APh
 +OYw==
X-Gm-Message-State: AOAM530DidN1Xck2B5om3yuvesQJqnrd+1swTEusRJVUz2UGIgnCiYFj
 B5gUYc3KKrYmEc0AA+PKpKWe3IZCJosGvFbLBnk=
X-Google-Smtp-Source: ABdhPJzz49VguPSiC+Fo0EQ3C2KxuaRWGiHMMcfCON0rRU6wG0keaxKFCd23chpDIT1aQ64ecAbOb/mh29DzHZBz3N0=
X-Received: by 2002:a2e:a170:: with SMTP id u16mr12947954ljl.108.1634306084449; 
 Fri, 15 Oct 2021 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-20-hch@lst.de>
In-Reply-To: <20211015132643.1621913-20-hch@lst.de>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 15 Oct 2021 22:54:32 +0900
Message-ID: <CAKFNMokH0ZU-zxMe3Wm87hZwVgXPv3nRYBx2gXU98GekaeDFRw@mail.gmail.com>
Subject: Re: [PATCH 19/30] nilfs2: use bdev_nr_bytes instead of open coding it
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, 
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, 
 "Theodore Ts'o" <tytso@mit.edu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Dave Kleikamp <shaggy@kernel.org>, Anton Altaparmakov <anton@tuxera.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Kees Cook <keescook@chromium.org>, Phillip Lougher <phillip@squashfs.org.uk>, 
 Jan Kara <jack@suse.com>, linux-block@vger.kernel.org, 
 device-mapper development <dm-devel@redhat.com>, drbd-dev@lists.linbit.com, 
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, 
 linux-nilfs <linux-nilfs@vger.kernel.org>, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_065447_816004_4BB68D04 
X-CRM114-Status: GOOD (  10.68  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 07:32:38 -0700
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

On Fri, Oct 15, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the proper helper to read the block device size.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi


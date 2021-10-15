Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B83C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB8A60F25
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 17:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEB8A60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eOYGY8U37n2MZu0N4BHYKivX4HrXVHyr5D+KqaWhQU=; b=DhNDkNB3VsloadhSHW7z7VdbyS
	8duIIiRKNUxlMXMJpvy4GSYbbwREaTLZa6cS07aPZ2suNJ5pGg7WJhmKxW2PbHY6trhLq0KfF3W5r
	ueTCY/SJzdebQv/p8Kk6Cw4bmPfj8zc4CdsMmDmogvZW+M0GGQktVRA4YiWUdKMCxi8LW52OWtmLG
	utFu087uA9ZBRYOiKku9fvqMKy1b6n0NYreHHj9/VcNd5sPgDpbzbYKo558DWUJgCgWuFWQms4qtA
	YVx2eQjueZM77CnCLZ1BDw3J/O9f3k8dRZaZfnrQDGRvIqmAzDc44SBlYdeDcU8erxwfvCWLUoUq/
	lcrifK6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbQcA-008DhD-Pp; Fri, 15 Oct 2021 17:03:26 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbQWG-008Beu-ES
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 16:57:22 +0000
Received: by mail-pf1-x42a.google.com with SMTP id 187so8845300pfc.10
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/eOYGY8U37n2MZu0N4BHYKivX4HrXVHyr5D+KqaWhQU=;
 b=DmViUCP42ryk0/zjuuQaBiRmRe/mzSHK6WDkRvPw/tFoCT41pzGsk6sbtBTGe4K1S5
 OLN5lTFSJc9JHAwBNbm8/vlAKnFBSpj8DIDLl39Onh8N7+06YtLNNZRfLZuy7Z8xH+qc
 GC7tjeAZF2U3l2PkPMfgIzPMHYdB7TC28kw18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/eOYGY8U37n2MZu0N4BHYKivX4HrXVHyr5D+KqaWhQU=;
 b=Is7lCz5eqaMuTyydy+xNs367sShTr9PRLcTY/eR9+3NDIcUYp/qmpmfo0akE9i+UfJ
 +ohY9TMh4Rw2w4dyP9qEa1kGb1inrEzP++XPwddl8NbK1MTlJVUXSzizfMDS96w1WknX
 D8d6pt5tDWyvlkKdh6EaOmR9Ene/x+iJnq4jq38hK9Luj1IupBRfRsnoo5uBlYtdyek2
 iSQALr3bo0ovmLVtVxESisU8QJ29NM3a0CyuFjfOVusF/jx1MakoW9wRDV/MscVs1gtb
 h3c6cnAXoA1FFeDrN0KoJ0zDUx7gyN/J+k/EKzxkuBq8wZ1TpF76espLtSVAn0p6+a7R
 XALA==
X-Gm-Message-State: AOAM533ceffQ4PJDUgPEp60pRLt7pKtiOaozb8VFApYDQd6Zm2AHNUJG
 Onyj899cgxc8Lqs2DP+xBnZaVw==
X-Google-Smtp-Source: ABdhPJyzpBRnickMzNbIwiNU4SlM0+KvU9N1DSuPdJJGXTy9zuESs+0VnjHyi75qB2n8UZERvww2Xg==
X-Received: by 2002:a63:b950:: with SMTP id v16mr5917773pgo.361.1634317039225; 
 Fri, 15 Oct 2021 09:57:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id a20sm11450710pjh.46.2021.10.15.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 09:57:18 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:57:18 -0700
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
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 24/30] block: use bdev_nr_bytes instead of open coding it
 in blkdev_fallocate
Message-ID: <202110150957.C90F687@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-25-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_095720_524608_7AC485BF 
X-CRM114-Status: GOOD (  11.85  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 10:01:29 -0700
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

On Fri, Oct 15, 2021 at 03:26:37PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


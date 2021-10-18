Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30488C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:19:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70F6103B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA70F6103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVetvWb4+B/byEt0HFTw7Li/1VctyD/QgsPHbsid4H8=; b=W+zwYi67gJTN+nMHOC94uxquSD
	P/zqRnzg594rGRYxBcJKU6ivQ/Y5MAltm3wy2YfPYEEMbQtuQiRNklPf4T8SxmVw9hhdl/FY96LwI
	VG8SfLRaXMYfXl3xBO8KCdTyk4UH0vKDpA0uU79sWxklCFSjyNnYxcPyzuLRo33hpUwNv7il2/i+X
	QaRCbgJiHvDIAqZmpHSnBN8/m2hIDQ6cK4HWfl9U9dpGlVeYDzLYTobJkjbohGeNDMjdsTswlEsP+
	tHOhjvxKfX45QtnTNHEGRByM3PseBcvXNC9al8C3z3G8r4YUzgYxFu271xcXASVFeRZmZfsWzlbbc
	xK1Xtf6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcWI4-00Gbv8-AP; Mon, 18 Oct 2021 17:19:12 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcWFC-00GbTc-QG
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 17:16:16 +0000
Received: by mail-io1-xd2d.google.com with SMTP id d125so17165822iof.5
 for <linux-nvme@lists.infradead.org>; Mon, 18 Oct 2021 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TVetvWb4+B/byEt0HFTw7Li/1VctyD/QgsPHbsid4H8=;
 b=rkRLnHg1S4u8HX11jOSUsmgOu279172YT/qIHLznH/jwI1IdjUhSA0m6I5uyrdNBJQ
 GZpTrNqHq3BbgsfYzCH0RiwOG+GG3HdSbaxtt1+taUjeE/o2nf0qjkZ23LPZL14mgyVx
 r5QceDW/MeG8za7F5qhNzSKPR2x7wRt1a8B5T995CSTZ1u9OS6Ch+FzWEBtUbHpcq9AQ
 KUlG6PBJnMhvawvbI3ONNOa5vJZRKzg+iSpti1pyNyehN+8MHnCAxM/sIrViilbzyvRG
 Q5nXCXvu4cEFPGfCltmsbNSsOl86kwWVB1XaqYHb9cyqB+54s92TMxyv7jKS0YWyf0KL
 kSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TVetvWb4+B/byEt0HFTw7Li/1VctyD/QgsPHbsid4H8=;
 b=x0MUlbEXlt6rgYMcesYvkJXSbkaeJqiA7L2B3BQFOqn8apMfFFu7sm5Orn4SYItjrG
 eHj3+2FjAKpiPoST7xxPGAbE11HmqDkIFIR9Lcpi++k3AGTgIei4euRulAS2L8bf4T3p
 do04l9NfcJ84HC8sK2f7fDw5aAkY+Wre6isFuIPu2LYwFTYwxXbx+k9XR1Z998jWETh9
 3R83AIjzangtxNAXIqq/fhlw+xcMFPsqd1dbFrLGujZuPz6VD1RwJKL1H0YshSvvbgjz
 04R3/vLy77/S9ypu5g2caSTL7cHM+eaq3He/9rfmI1bZQMmSHaOLxG2fi/tJ5wjQL46P
 nLxw==
X-Gm-Message-State: AOAM53134C+fwlScuVxJes/cj3Sx7ByCbPF5r7l6Bv9jCBNulwjyNJGN
 7H6sLOp+ZfXiFMnTyTMTaCJteg==
X-Google-Smtp-Source: ABdhPJz+RKspHd19wACUssDbTNQ6NJRkN4g7OdL6jX2ni5qwlHyFbIbt1tgTl8EVs5WghyoBxus9iA==
X-Received: by 2002:a02:ac8a:: with SMTP id x10mr745552jan.43.1634577370548;
 Mon, 18 Oct 2021 10:16:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id u12sm7081225ioc.33.2021.10.18.10.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 10:16:09 -0700 (PDT)
Subject: Re: don't use ->bd_inode to access the block device size v3
To: Christoph Hellwig <hch@lst.de>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
References: <20211018101130.1838532-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
Date: Mon, 18 Oct 2021 11:16:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_101614_884844_BA3C9538 
X-CRM114-Status: GOOD (  17.12  )
X-Mailman-Approved-At: Mon, 18 Oct 2021 10:19:10 -0700
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

On 10/18/21 4:11 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> various drivers currently poke directy at the block device inode, which
> is a bit of a mess.  This series cleans up the places that read the
> block device size to use the proper helpers.  I have separate patches
> for many of the other bd_inode uses, but this series is already big
> enough as-is,

This looks good to me. Followup question, as it's related - I've got a
hacky patch that caches the inode size in the bdev:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=c754951eb7193258c35a574bd1ccccb7c4946ee4

so we don't have to dip into the inode itself for the fast path. While
it's obviously not something being proposed for inclusion right now, is
there a world in which we can make something like that work?

-- 
Jens Axboe



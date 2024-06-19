Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596E8C2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVFpcyqMw7891fhn8oME2l6O88u8sGFZorCmmUmii2A=; b=URhxAFuAOjenqcNp4j/iR5DBZ5
	q1eBS/WlCdl7siFVzMr8lMeSymix9F0YmPE1qQeNzHvspCgfm6xxcAx9BnLpH34Z0uhSurRQRK5IA
	IYhDhXbYdAPjOUyEpluKDC01ruE7EwIAwrkNZofYVrfLv3IJJisoCvG8P26qvXhNo8EbcljT7QQ0V
	de2I+5GbUPPE+7FSf1NTiGh0+hk53Pf0vb8jNbPQ9CaE/VHe1mvx+yxiRrGaubPHrdDfSj8+H5hXv
	1tRrtq9cEYbaAQafQNHS+b2FMPgyFx6UNRNC42Qx3Drb6rQCUg2IePFNEk+KUUSiplSDeb0VwS42c
	omiIrLWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwEl-00000001VcK-3LY5;
	Wed, 19 Jun 2024 14:24:35 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJw9A-00000001TpG-2jFT
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 14:18:51 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-6f86dcadb14so170631a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718806723; x=1719411523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVFpcyqMw7891fhn8oME2l6O88u8sGFZorCmmUmii2A=;
        b=Zgq4/VSWnk8SF68xDCSWmSNNulB8ShhfelECBoOGv8EvHc6J5TWgw21qGT6PXTvy13
         ymOjY1hCoET/MRw5AscTpEGlJYxnA+WWIbXKkhjCBJW5fX1ZJferbF4Xv+Z+G15iw9wP
         CAIyDmuA6H7ynZsVP3wGiTbc5ZDUdIx09D0knhqoNdPJ7h7fmkkOFBMahKbeJLxRiD3u
         eaSKLnVxalhJZgarrurqqdcUo2wH2J8ESvEnc3W/NkC7hY9drqnArpa1R3TKd5MNJU1q
         JS3evlmTtp7p5W+W2CtLlGzqR1kVoYmFjWenbAuzUwjM3+PlFLGlzbHEguUak5QSj9S9
         0Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806723; x=1719411523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVFpcyqMw7891fhn8oME2l6O88u8sGFZorCmmUmii2A=;
        b=m6wEhMZCdTclxOfSB4fhrKM9J0tyHD2NRgEt8Ze5BhX1ds+QN0O8Qc4oVvbtrHAh08
         T2O/2c2lbi2C3xQ11NbET3Bz6e7/YqQwQWSBEMPh6W1Ivwu/empMwjT62D63omjJhkrb
         25TMSvtWEYQjF1RiMJRbJ6iqNUFHwTfCgdSYME/8/2gc0gU8ZDjTqQiX/VQBhiY6N0U2
         pwxm4B0alRGaVhv/5R/+YkhJnsgHapwnncyb2g6YcPlQlXmO2+f4NfSo3v29XcAeDELo
         EYBB2i3RmU+dRnIQW4+SusjWINmOJJya0hrkmiOD5Lv1GvlLOhVFCZv2kdEqmzmm04D7
         ay3w==
X-Forwarded-Encrypted: i=1; AJvYcCW/72ox3i6Iyoe4kPLdfZ8nz/1eNTJ9+QOOIB8BXFSy1paYueiqs5euRTuIS9ngTbBNEPQsGFhOS3QEcMx+ei7NiZJPjkFQj0Glj9BEsF8=
X-Gm-Message-State: AOJu0Yze90WW4GOhlTPZiBXLDROVfjSUwccyKFICy+hRcRPaTKwKdxba
	Z4HP5UFwXCWy7fz28uKbwK0bnLxIHVCeaY7wgW08/ua6WNpu5a/WxOg/I/zuank=
X-Google-Smtp-Source: AGHT+IEWR0naxsjqG6PjL5n5tEp1Ci8rJdxP3J1CbAApgRxLYFkmM+R0aL8qHW5Lv8+tjuuvrYAkhg==
X-Received: by 2002:a05:6a20:3ca0:b0:1b6:fadd:8862 with SMTP id adf61e73a8af0-1bcbb8ce3e2mr2590711637.6.1718806723107;
        Wed, 19 Jun 2024 07:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2e8sm10689218b3a.107.2024.06.19.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:18:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Richard Weinberger <richard@nod.at>, 
 Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, 
 drbd-dev@lists.linbit.com, nbd@other.debian.org, 
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20240617060532.127975-1-hch@lst.de>
References: <20240617060532.127975-1-hch@lst.de>
Subject: Re: move features flags into queue_limits v2
Message-Id: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Date: Wed, 19 Jun 2024 08:18:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_071848_746277_06B85551 
X-CRM114-Status: GOOD (  14.57  )
X-Mailman-Approved-At: Wed, 19 Jun 2024 07:24:28 -0700
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


On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
> this is the third and last major series to convert settings to
> queue_limits for this merge window.  After a bunch of prep patches to
> get various drivers in shape, it moves all the queue_flags that specify
> driver controlled features into the queue limits so that they can be
> set atomically and are separated from the blk-mq internal flags.
> 
> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
> changes as the Cc list is already huge.
> 
> [...]

Applied, thanks!

[01/26] xen-blkfront: don't disable cache flushes when they fail
        commit: dd9300e9eaeeb212f77ffeb72d1d8756107f1f1f
[02/26] sd: remove sd_is_zoned
        commit: be60e7700e6df1e16a2f60f45bece08e6140a46d
[03/26] sd: move zone limits setup out of sd_read_block_characteristics
        commit: 308ad58af49d6c4c3b7a36b98972cc9db4d7b36a
[04/26] loop: stop using loop_reconfigure_limits in __loop_clr_fd
        commit: c9055b44abe60da69aa4ee4fdcb78ee7fe733335
[05/26] loop: always update discard settings in loop_reconfigure_limits
        commit: ae0d40ff49642651f969883ef9fc79d69c1632d7
[06/26] loop: regularize upgrading the block size for direct I/O
        commit: a17ece76bcfe7b86327b19cae1652d7c62068a30
[07/26] loop: also use the default block size from an underlying block device
        commit: 4ce37fe0938b02b7b947029c40b72d76a22a3882
[08/26] loop: fold loop_update_rotational into loop_reconfigure_limits
        commit: 97dd4a43d69b74a114be466d6887e257971adfe9
[09/26] virtio_blk: remove virtblk_update_cache_mode
        commit: bbe5c84122b35c37f2706872fe34da66f0854b56
[10/26] nbd: move setting the cache control flags to __nbd_set_size
        commit: 6b377787a306253111404325aee98005b361e59a
[11/26] block: freeze the queue in queue_attr_store
        commit: af2814149883e2c1851866ea2afcd8eadc040f79
[12/26] block: remove blk_flush_policy
        commit: 70905f8706b62113ae32c8df721384ff6ffb6c6a
[13/26] block: move cache control settings out of queue->flags
        commit: 1122c0c1cc71f740fa4d5f14f239194e06a1d5e7
[14/26] block: move the nonrot flag to queue_limits
        commit: bd4a633b6f7c3c6b6ebc1a07317643270e751a94
[15/26] block: move the add_random flag to queue_limits
        commit: 39a9f1c334f9f27b3b3e6d0005c10ed667268346
[16/26] block: move the io_stat flag setting to queue_limits
        commit: cdb2497918cc2929691408bac87b58433b45b6d3
[17/26] block: move the stable_writes flag to queue_limits
        commit: 1a02f3a73f8c670eddeb44bf52a75ae7f67cfc11
[18/26] block: move the synchronous flag to queue_limits
        commit: aadd5c59c910427c0464c217d5ed588ff14e2502
[19/26] block: move the nowait flag to queue_limits
        commit: f76af42f8bf13d2620084f305f01691de9238fc7
[20/26] block: move the dax flag to queue_limits
        commit: f467fee48da4500786e145489787b37adae317c3
[21/26] block: move the poll flag to queue_limits
        commit: 8023e144f9d6e35f8786937e2f0c2fea0aba6dbc
[22/26] block: move the zoned flag into the features field
        commit: b1fc937a55f5735b98d9dceae5bb6ba262501f56
[23/26] block: move the zone_resetall flag to queue_limits
        commit: a52758a39768f441e468a41da6c15a59d6d6011a
[24/26] block: move the pci_p2pdma flag to queue_limits
        commit: 9c1e42e3c876c66796eda23e79836a4d92613a61
[25/26] block: move the skip_tagset_quiesce flag to queue_limits
        commit: 8c8f5c85b20d0a7dc0ab9b2a17318130d69ceb5a
[26/26] block: move the bounce flag into the features field
        commit: 339d3948c07b4aa2940aeb874294a7d6782cec16

Best regards,
-- 
Jens Axboe





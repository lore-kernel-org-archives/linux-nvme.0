Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525A0C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=; b=bYUbQvCQEk/nMMl2dGLa8aBXZW
	FlwR57jySu8UqU2QQbAojydfjaCASfHX8omhQYV2XzIlpcbPSA8rmRkdXlBlsGzT8Xft4G4BUBS+J
	0Crp9gxqP/Biu14lmhun7HJE2dtYYaeFYHcgC18IS31cBk+NllElnr/WvDmBWcEklUeeGofYhyITd
	rOfkPKt5+rcDgcFRcmOkQ5xASwFRDYINAzfrQunUHB1jiO/zJyRF1gDjKySAagQc2Tuhv81gNdlAL
	HkiRm9IyXH7huHY8Auvk5+dFtZKlImBbDgrYHzfzrWyGzq5w8H3DTn5H9PTM/3xxz4T+A5LjHGUHT
	q56NpAog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjIvp-00000009qAc-02BS;
	Mon, 13 Jul 2026 15:50:57 +0000
Received: from mail-ot1-f44.google.com ([209.85.210.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjIvk-00000009q9e-3oBB
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 15:50:55 +0000
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e938d8538eso641068a34.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2026 08:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783957851; cv=none;
        d=google.com; s=arc-20260327;
        b=dSbAX8qJtk3OT88395WeLbN3mRwngMx4tb7C68qvQG4GflwphbXKi7ME4pJPTB40PJ
         Ow7qB/DdZsFqk8F0zxgWAISUJekbVfMddu3f2Y+WP7JPm8CNP0f/jdXzAdre8IsZY2eM
         VrZ6bl3VNRqk+lYlQBVGeeDMTe5E2RG7yP5Ir7WpklmiK4roKfZ/xuc5GIa9rb0yz/uE
         YOGdag3B464XoThFgpdRM+4g+Kf65qTxMLVvd/R5USWM9YvE6Klumdyrp7g/JYluXlkc
         IMKYj4U8iSmqQJGGcGON3O4ODp9/XFJP4AbWfes1nk1cCoN8Y+kJq5w90LdGLVZjnVH2
         FB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        fh=RcPv634HljaZ367Fg/sAE8kdgDF6zGhpgNk5vfvW2v8=;
        b=rO5TbuNM54dA/cWT26ij0GT6W784bWTHXdzWnQ+WjvmIAUjVwKa+F1wN+NtLgf6fln
         bZ7mCNtCqnRdzuU6mFIk0jDcCLLNkbq6xHV3LOiWi2LTAKKTdvklod+FABr/lcIvke4L
         rHIdvu4w/9M0Y8wnuh4lLrkb1WoczRAQaxN+kouVwdzcUlylbq5RdIN/MVZ8+nKaNTY2
         Obwfi1aRiulYFBZbXQrcX1v1ttYAsKsa6QfgX16kFklFYtZHEta4T0M2OWdls8VkV+k6
         369oamDWgJ6S0JU0L0lYwBNEZ1ROmQO3lDexfoQmPSGan44aGtaqZNyoT9wbyLYx+Uze
         8qbw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783957851; x=1784562651; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=JwMBEnOu+2+scH0u3SRVqxgpiq/nZfu1zBuLW2scj5WA7dnxTZPfhhRydTBYLbQnfx
         q5dOZC6pBALZ9sp9TkOpiBfz1P61HlIv1azo7/DyJzOp1eZTpqDf6DaJ5T30zZPzFOKG
         6umzO79m0shZv9lXmRvCsLctaII5pJU28IdEd2AF194vqcMDJzokXKY0fzp718KoUVlS
         /NUgVXYaghq1o4CnVjtAPoESszKjj5fi0tD51UIdM5GfB6zxz6ZoDZ4nU8ep3AEDKbea
         VZO1P7NZSSUax2pKrecIOayquF75skxd1Nfz0O3SCsV6NszA2jTpMC954q7TFgE4eXoU
         v/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957851; x=1784562651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=fMwGvIdviiIvxc1c8LLS7et8oVDM7eo5r++ovSPc1YNmGnT0QwOJBCoMGtKq8ZvdY3
         fYKtzahIacCoRy4t5d8oWnJgGOre3p+3MxxnO39WrR7F+rnZ+Ya7G2b1nG5tVb9/3x9f
         imEekiT4MMA7hl//qmhjOc0e/w+dO5KvQrhci9FWHe/CMyTTwMc1+MjiZ0cMiCkv+e1Q
         T63qv9zpk5cl459PhCApvoDqSOBGlYy2QrKCYdOqJtuahFPAwCGdZaqE8GvLOA1yqD3f
         Lxn+djkH2mx/8GTxpTAiIQOBALVOdDxJsfz5/ExkwUJkqptgt5kRTP5/IleQ3t/SaXBs
         e3xA==
X-Forwarded-Encrypted: i=1; AFNElJ/I+D4Hnzg1ftINjqsysO/eILwUi7RAt6xvVi8uFRCL3CW5JyC+Axm8ezXgQv8OFh3bK2J1zYRfIaz0@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2zmUQ2QJ3R9Zr+sui0QKZY08EMlDBvRoMN0rEgyXy8OJ13Pek
	JrF6sn0vQbiaUqYd22E8jfyw30UwjWNq9WPHhJM2nHnyVv5D9iWsxZcWcA9z7gozxbU8ea8kbgs
	m5mEKM/x19/48JNMigCgR0ZkcfIyPvqxGLct7HiEBRA==
X-Gm-Gg: AfdE7ckh68Qkzui9cJs/Dlla0/INRfBmKLs4t13sWHBEfT4NM0M9p1AF3YFigR0Wth2
	nc8WJzhnCHvcr3JxTG04NCgWUYCPd4hv/l+8kCNIJy4jR68EcQtsoZWriNSZterfa5qklmsNoKN
	tsnfZ02lEc4XgoCaC2cT5HYkDgllbwic4+48t5WG3UZWzMc4dmbrhSOsKk+q74aPC3K+Hi5g4An
	9Ijd17X5JfWnnPX4RNwODxkxi5AbmZbhyDdPedNid8XHurtYRYE0D4Ee1mYE3fNwGP6qKT4og==
X-Received: by 2002:a05:6830:650f:b0:7e9:e702:a9d1 with SMTP id
 46e09a7af769-7ec097b58famr3955386a34.4.1783957851185; Mon, 13 Jul 2026
 08:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260627054220.2174166-1-csander@purestorage.com> <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 13 Jul 2026 08:50:39 -0700
X-Gm-Features: AUfX_mwkxpGgZJY4pVFOcqA7Ferj1yZzrVgo2oA_tVNxLSUmFMmyocci83-Ncfw
Message-ID: <CADUfDZoGyu-EWxT5tN41K24oFwu8p4mmxFRsHcDpLBoAY6Y0Yw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_085053_135194_C310A649 
X-CRM114-Status: GOOD (  15.87  )
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

On Sun, Jul 12, 2026 at 4:09=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Caleb,
>
> > The block integrity layer currently sets the integrity seed (initial
> > reference tag) in units of 512-byte sectors.
>
> ... because that is the fundamental addressing unit in the block layer.
>
> > However, Type 1 and Type 2 ref tags are actually in units of integrity
> > intervals.
>
> They are not in units of anything until they reach their final
> protection envelope.
>
> > On devices with integrity interval size > 512 bytes, ref tags are
> > seeded incorrectly.
>
> The bip seed is whatever the caller decides it should be. The integrity
> interval size is irrelevant. As is the destination LBA.
>
> > But REQ_OP_ZONE_APPEND operations don't have their ref tags remapped,
> > so the ref tags using units of sectors will be stored to the device.
>
> Then there's a problem with how we handle REQ_OP_ZONE_APPEND. For NVMe,
> the PIREMAP flag should address this issue by remapping the written ref
> tags based on their ultimate destination LBA.

Yes, it looks like PIREMAP should allow this to work. But Christoph
reported that ref tags weren't working correctly with
REQ_OP_ZONE_APPEND:
https://lore.kernel.org/linux-block/20260624080014.1998650-3-hch@lst.de/T/#=
u

Christoph, were you testing with an NVMe ZNS device?

Thanks,
Caleb


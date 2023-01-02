Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140B0C3DA7A
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jan 2023 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=So3BflQIJavAgxu+EsjEqR5WiJ+WBjX6FZYxdvbwvjA=; b=4NUdrGT68YJmTNO0KnipzUGDiZ
	yGpX6trhrEA5PFezxxqh4VlbiFpEIAyIdXi0bV0xiNs7qH1u3n/UCP0lmXpm9NwHQGSqREoXcDSeh
	6vk4QC5pJpWXlUYetyRpUGJpWmaeHsNDmvIvRNF/7AyyUK0/L+fJUUmE25chBAgik35nI/CcFeIiW
	pWoaSfkHIy0Xb0zV5xoTyffaYE+Wc9qzRsr7w5URflqnOqmBuh/Qm2G1u09GD4w0ofDC/3/xYsRRG
	NZCNjZGfyvDKX1M3NGzV1i+sKaar3hxY42P2+xDTKo93btFPN98/fFXhLMNOwcKRkTBJZiY2JAyKD
	EWYryCHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCTiD-00Ehrs-SK; Mon, 02 Jan 2023 22:55:22 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCTfo-00EhFo-79
	for linux-nvme@lists.infradead.org; Mon, 02 Jan 2023 22:52:54 +0000
Received: by mail-lj1-x231.google.com with SMTP id v23so20070503ljj.9
        for <linux-nvme@lists.infradead.org>; Mon, 02 Jan 2023 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=So3BflQIJavAgxu+EsjEqR5WiJ+WBjX6FZYxdvbwvjA=;
        b=UUDdb/lCvnju4IHmNlGRrBHE+a8LvimrBz2zxLrePYH4IU3z5GBFILqtKuZgT/EssK
         aRMWGD8HDUJXq8mU7rD/xwR6+mffgHWC36xkhBa1uaEJ9P26uTgiddJo0Rsk0shCRDfz
         BeOSqgtcQmFSs2G0okE2SvKgkb5mnLwEM7RW9se15a6y4VZPzumrXS3j77B+K/7ZN617
         sBNjt2CQsdLJDBBQKlNG25t1YKzrNlos6iqt20vUfWz/5XiTMxyMYAkqMXrF3EA4YS/S
         WC5y4fyu+efSgVVZP9gktOgTzM7taN7mNKzfCgWZeodJGaUTJ0lJYIXSAvtIl4ive50J
         Xl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So3BflQIJavAgxu+EsjEqR5WiJ+WBjX6FZYxdvbwvjA=;
        b=v43fySJugwz4Mo4WMtjCXupzGH3QpvH88+Z0Cl8I0j5Ls0p3YRYAgkV2Xh6J2WKQT3
         5xyxYA4FcptY49Cg1gZA6rqFw5qA3l9cq5SxRDgrZVHnvng9HWZfj1du5HE9ay5xJyAu
         hbrnS1qOU8yC7zZ18nB4TPDCa21ColfjIXTYUaeWq8AtpOl2v149vtZr0IUUfAmF427S
         oa5lLnUfwInhFWE/YP7g4s5w6K7j7W7B+GDcYWg2tQXOHC92sF2Sp/jf6xuU38Yin9/0
         OyWh1QUqrL5B9JFcMh9LtT5uQXgLZ8UOuQNeNH6d5aCO3pVFUCnsIVLF7H0NBj9mthPg
         Wvow==
X-Gm-Message-State: AFqh2kokBDQolhHUiBr1q8IKkUFrZT2FlOS/o5MQX9WmpbYoc35ImF8M
	zhw4UpIr6kesMHQmlZVCdoasMjgLfKCIkC2FJJIt+Vvxq+KzbL/n
X-Google-Smtp-Source: AMrXdXsfOz7B3+FcF4ijmBlYtHh57sl7i7Juu//6Rt87xV/wp5proP+cCueMuq3MQQM/idp9TrgALgD02LLBbqZ6EJ8=
X-Received: by 2002:a2e:bf05:0:b0:27f:74fb:9f24 with SMTP id
 c5-20020a2ebf05000000b0027f74fb9f24mr2758273ljr.30.1672699960791; Mon, 02 Jan
 2023 14:52:40 -0800 (PST)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Mon, 2 Jan 2023 16:52:28 -0600
Message-ID: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
Subject: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230102_145252_318144_2BF3BCBD 
X-CRM114-Status: GOOD (  13.56  )
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

I've been using nvme-cli 1.9 (default on ubuntu 18.04 LTS) for several
months formatting nvme drives repeatedly without issue before running
device-level benchmarks with fio. I always format passing in the block
device, e.g., /dev/nvme0n1, and haven't had any issues.

I recently started playing with creating file systems on the drives to
do file-based benchmarking. After doing this, I've noticed that
intermittently the format on a drive that has had partitions,
filesystem, and files created will fail with code ECOMM on the
re-reading of the partition table. However, I've struggled to make the
failure happen reliably. This is the error I'm talking about:

https://github.com/linux-nvme/nvme-cli/blob/c3db2bfda5346f68344a9e6d795319a7bf35d19e/nvme.c#L5212

The current nvme code has multiple guards on running the problematic
BLKRRPART, and one of them, "cfg.lbaf != prev_lbaf", is enough that
current nvme-cli would not run the BLKRRPART for my nvme formats.

But I'm hoping to understand if these guards are actually fixing the
issue I'm hitting in 1.9, or would just mask my issue... that is,
upgrading to current nvme-cli would make the error go away, but it
seems possible that changes to how I format cause BLKRRPART to run
would bring it back). Are the added protections for the block device
format case to avoid issues like the one I am hitting? Or is it
unusual that I'm seeing such an error?

In case it helps, the system does not have the drive or namespace
mounted in any way, and the format is being issued immediately after
the system is resuming from a suspend. Happy to provide any more
details that might help.

Thanks,
Nick


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2036E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydW0TG4z7XBo7HBBH7ij90+wnNI4JxxB1fs88STRyos=; b=Xlmhd5zJJhrS2yFGF6QCljEGp1
	5/x3ffLfW66xWIPAPy5Sn9IVk+0L61AtUWotyrVV2MLqQksRYuU2zGh2N9w1ppD0Tg5/roW9gA+Ur
	TlNePoWrMY2LFJSZlpW6r9Dn1TI7DyJhoD1KBRl74M/YSA1ECkMxGC9/Cntgou6kvPcEk0MbFQMY3
	Rzf8CBAH/54TxzzaAMbIo2xvZjtFiL7gGpMg9JO6JHuZKLWeWRXBB+I6kw/7kuvq3uzCQ3EAJdhMd
	t8efpFvog0QQ6hblRYScnxfKGjoD54E4NW+Dt0O9EOgKCJ14nEW7t/wA0eUD+PSw0hdaY+pW8wOhJ
	2jo4UDyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCcg-0000000Fj8r-2el6;
	Sat, 04 Jan 2025 22:27:58 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCcd-0000000Fj7V-1639
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 22:27:56 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2156e078563so162738725ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 04 Jan 2025 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736029674; x=1736634474; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydW0TG4z7XBo7HBBH7ij90+wnNI4JxxB1fs88STRyos=;
        b=2D/sdKSGRTOCggMBpr7twqjJfZK4az6EUA72qWiXtkBxxy3tjazob1mQTGTeo2WMgq
         t0kbZJ1t08um4Ep4Qql0uoIFTsBNG3qgt1qQGko8Nid1ilK60FHFZ7CYqGsiPiTQXaH4
         ydadIfktzaIbDxnAjxvIl+HGGoSUHutHLxmrm6DUknaOoQ3uHNuwBMUZAbP9DBETaDI9
         FPzSQoBy3QKLXRtvAsH5N02TZFKpHs9kR+6wggcapczFepol2Duopd0UJLarpr+hUmcK
         X5CiTUQhebe3/zxrFoNQyYg4r51Yuiq5UnfpdfoMcoixA+VsLVMwHTLCi2iZTwc7wJDz
         glgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736029674; x=1736634474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydW0TG4z7XBo7HBBH7ij90+wnNI4JxxB1fs88STRyos=;
        b=cHT1mdE8NUdAm4ArbEg5Th4orDbtr07Fj2dYocPWGjjwTaPfZ8RP83dklnxoaQDwfu
         DkBh9407+haFeo7T935sF8Dh2CB5TFDuAlAdje0LIUW6Iz1jD960kWXhYVjpdOmx5vnV
         X9RqxikPIhEB5NQ26ugYsY48KkXM0voGYYWkSAVhV1l/PjQEe6IPEjjpaMghf3Oj/53U
         a/dQpgKke0o55wgw7U+g9CtgQBO6pkEUanl/oV9mZHsaIFN23bxFFjiQpG5AOb13seFy
         HuKelNniOOmi1HoHycLZ7e4iW/RUWPjoh/w+Zmy68CxjiR2p+4g0UQ8rM/Y02jtYFq1C
         Xl/A==
X-Forwarded-Encrypted: i=1; AJvYcCUK254gm3uyqLvFwTxXpVZedRmEZK3/BzhwYpA2IelUHvF3XkdfhmKvUWryr5XntcFewkJB0ZZ7PB17@lists.infradead.org
X-Gm-Message-State: AOJu0Yya0w9r/wF1PQrHVt0Xr7tcHTY/+0bbHfm5qJXb9rPWcnhf5U6d
	GFOuJOBJ11b98RM/gQoCaux5djDQwAIHSshGEzSkxEJp+ZG5iAJOiRDDoNDXEtlAtoZNwlNTj3K
	4
X-Gm-Gg: ASbGnctSR1jAlAgODfG//QiTLYIuSCThl4+Z9IUg1mTtGN0Gi8PhM5Bk7ekyvxmL+Nv
	KvcpQx+2G2llaDHqL4y+8CfsaIVPaKnzFuyHzM3i+/UYENU7nAvkcFyYCRsl6n6zZPVoSZvs9Ir
	0tFreBFXe+FBAng7xV9hV/UfHH03z5g6/O5fLgraAP5N3Sog92VaqP5Gdes5AIXIR67iRW62e2A
	TReQOjr5McjCqf+3lnFg1sKZzxe50b+Ax3uExsEuZgVK4zT
X-Google-Smtp-Source: AGHT+IF+L+86xLxNKDCy3NJpJ1Whra//RstFOL/I1FY0ppQLvIlzdnb8Hv8hv/Dxi+bSvhcBNsb4Ww==
X-Received: by 2002:a05:6a20:6f06:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e5e080c77fmr83798682637.29.1736029674019;
        Sat, 04 Jan 2025 14:27:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81641esm28451472b3a.3.2025.01.04.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 14:27:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
In-Reply-To: <20250103073417.459715-1-hch@lst.de>
References: <20250103073417.459715-1-hch@lst.de>
Subject: Re: simplify passthrough bio handling
Message-Id: <173602967287.135972.1134077263108813311.b4-ty@kernel.dk>
Date: Sat, 04 Jan 2025 15:27:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_142755_306564_F5617052 
X-CRM114-Status: GOOD (  12.12  )
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


On Fri, 03 Jan 2025 08:33:56 +0100, Christoph Hellwig wrote:
> this series removes the special casing when adding pages to passthrough
> bios in favor of simply checking that they match the queue limits once
> before submissions.  This mirrors where the zone append users have been
> moving and a recent doing the same for a single optimizes passthrough
> user.
> 
> Diffstat:
>  block/bio.c                        |  107 +-----------------------------
>  block/blk-map.c                    |  128 ++++++++++---------------------------
>  block/blk-mq.c                     |    4 -
>  block/blk.h                        |    8 --
>  drivers/nvme/target/passthru.c     |   18 +++--
>  drivers/nvme/target/zns.c          |    3
>  drivers/target/target_core_pscsi.c |    6 -
>  include/linux/bio.h                |    2
>  include/linux/blk-mq.h             |    8 --
>  9 files changed, 57 insertions(+), 227 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: remove bio_add_pc_page
      commit: 6aeb4f836480617be472de767c4cb09c1060a067
[2/2] block: remove blk_rq_bio_prep
      commit: 02ee5d69e3baf2796ba75b928fcbc9cf7884c5e9

Best regards,
-- 
Jens Axboe





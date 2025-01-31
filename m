Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271D6C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+9HC8EV1wWIoNgKbafn8wjlhkFnTml5y5fJi9ZNauA=; b=XmsaBsgl12owEwenLxm+g+K+FI
	xkuMhEHPFUODpDpj0RYbxs2ib7Tgfv4G1UMCwTnjq/zMMaoN6tHTeTJxsu4Jtrs0ArCZM2i7kBLir
	102+vsho7XcaLgeJh25dsIUtUaXCFI8isdo/DmkS+yLKnH+Xnn/BXW9leC4YS91ntlJz9SI4pu3LK
	EwoicAEfr2HrQVCfIotXsANhyUypeTDAtDtZ0BRJjSvAEw5ZP/+coBF680v5OaaqDTovbGNK8+GRH
	6SL97TnUk7uMpuCHlYMXcQyGSt0CBepfYCraxUXaW9surR9g6eI7OpTI4572ufE9yI8FCWfzrYZkf
	UwKc3Izw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdsiL-0000000Ap8D-30Rw;
	Fri, 31 Jan 2025 15:13:49 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdsiI-0000000Ap7T-1WGO
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 15:13:47 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-844e7409f8aso54151239f.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738336425; x=1738941225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+9HC8EV1wWIoNgKbafn8wjlhkFnTml5y5fJi9ZNauA=;
        b=Ez+Ze5Q82GVzFprun6L4PDRXR5oQxpi48SLbR4L2EfwK+hfiuaikrLD+/fRsw2tB3h
         B9r1B1qNu1cxBKltmrE0CdZahwmOo0ov5BKoRadbkd5FkwTI8TwkRynEaKFp3BrSP1F4
         mydKUaUO+6yLw66pf/hzi3vhn1dq142nCbe+kqNvSjFteGFfj1mqVtjVKjVOY82YTtxW
         9+qGBMlbeKJkjQ6PfQWn0/gmWcYDRxH+G0ny/mriwJp0Vksp1jByYZGKrlsdsz6F9N3T
         1RFB9G2/rGqsrazBvOhl5QZ9jCkT+8Fq2l7+U/OYQmed1XMiud0zHVjAcfFUpLeIMeZn
         3LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738336425; x=1738941225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+9HC8EV1wWIoNgKbafn8wjlhkFnTml5y5fJi9ZNauA=;
        b=DIAJOZBokmXx6PIOgZ3jLiK2sDNzY/K/RIy/Ech7fTJX+uo1x+0ivMFbdexlShhD1Y
         SY0nIiAXuOu51UI0+M23zHQk1OaxnQPOgJmuG19laSUHrRVH6bNeQ3cbt0X71zLxFVaW
         hw3MMa2ExNsdPeO6NolCXdhXQWbfZeZXeH1aQKcDC7XPjaGFP8KHh9WzfU3fDyVru4tA
         MpAxn15n5liniMJESf+hvh0jWdon5ta7f0kHZ0gJkEYrHPsRn2GqBBOcm0yrEVZ+0eZE
         BMoHaDlcDAw1crbcbLZ8Sja3UTHKfdgKsZPuKO/vVdqmd/Y4nLeRppW5aaFPpPvBTtvP
         myUA==
X-Forwarded-Encrypted: i=1; AJvYcCWDj1ELgCqZ05t4v2CIO9RXqlnCE8O/HDqDD7X6JgeSit46x358nHYvnK5dBlC477M/5dLeLaHdjcKW@lists.infradead.org
X-Gm-Message-State: AOJu0YxJs/1UtAnrIo9KE99B7ECwjkbXgOk7r5IoG4eFIkg99iWwTZ8r
	YxIyPJQb0VqrbPxtUl322Ew7NEcacPaA0UxOwpH25gNILQqnG/Zpx8YB+kacFc+GnWyiiPfuAos
	b
X-Gm-Gg: ASbGncsJlkpGBd13fbuTdKto2oLCEJIiFf0wAtnpfjXZXo2yRREpjj/OhUkQ4T5HnkU
	SJNp6RuLcvlHxnC7CjKkkrMjvWrEEI+1C5WtVER8u7L7lCqG6oHTDyzSdSp62qQH8bnbEvs6QdH
	SpR0cEg+IhoDQ1mXOcfe9HjoE0XNocB535txHKNj7hdiOXiZ87JbTn9CkQQHJubub/TdzVd6bfY
	m435E+ofKe6dkjUxt4xASJK78CRFGxG0GLU8o72Yo0q0W7Iq5QFzIusEKiT3JNHEBzAbF30QF7T
	m7g5Yw==
X-Google-Smtp-Source: AGHT+IHdBYkV/Lcjpt9Dx2u2hBI2V53NbB2KTd/PWwFq4iCV5vqkwpfG1ZQm3S6I8vweH0IHJRW4Uw==
X-Received: by 2002:a05:6602:6406:b0:843:ea9a:acc4 with SMTP id ca18e2360f4ac-85427e24fa1mr1154985639f.8.1738336424835;
        Fri, 31 Jan 2025 07:13:44 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c920dsm856099173.125.2025.01.31.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 07:13:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 nbd@other.debian.org, ceph-devel@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-mtd@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250131120352.1315351-2-hch@lst.de>
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
Message-Id: <173833642386.354079.3672902422068183900.b4-ty@kernel.dk>
Date: Fri, 31 Jan 2025 08:13:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_071346_390937_8835F377 
X-CRM114-Status: GOOD (  11.81  )
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


On Fri, 31 Jan 2025 13:03:47 +0100, Christoph Hellwig wrote:
> When block drivers or the core block code perform allocations with a
> frozen queue, this could try to recurse into the block device to
> reclaim memory and deadlock.  Thus all allocations done by a process
> that froze a queue need to be done without __GFP_IO and __GFP_FS.
> Instead of tying to track all of them down, force a noio scope as
> part of freezing the queue.
> 
> [...]

Applied, thanks!

[1/1] block: force noio scope in blk_mq_freeze_queue
      commit: 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c

Best regards,
-- 
Jens Axboe





Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8AE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/gcAKNkCa46sAJjco4x4Dt7XCwnmRxnbzpikJ5Iyr8=; b=bz7DCJysz5oKnnihgxA7Z5JrSl
	5+xv8AXfVVI96LoA54qQZnDvuXWCH8pOTQ6uZtbC8m9jINKxMaOJhjZ3u1EqWJNe4nfoKMcNbjayd
	lpMVlbtSCHdSvXzNJyLVtrrkJXqGizmbiJhC65jEzgbbAqrAXJILNxZeExpmyHP0KhoNjpTZ0bE0M
	9aFPAkRIjEQKWudSJQzsgHbi2tmF3TTGr6nSYrv03b9z7nX0+oYk8zO5sj74SBey7jKum2SW1iJ2I
	jUophGP8k7k7tX3cmtmkgcwoTKxlV7ixsbf15heW4gTovWKXw7VT3XrHbQ3wIdSJI5KMSyywDcoFE
	Q4zIHCSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWG3Z-0000000Fdl8-0hJV;
	Fri, 10 Jan 2025 14:32:13 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWG3V-0000000Fdjd-3cUN
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 14:32:11 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-844eb33827eso64778339f.2
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736519528; x=1737124328; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/gcAKNkCa46sAJjco4x4Dt7XCwnmRxnbzpikJ5Iyr8=;
        b=JzCe+FqrrqoJuE/akLJ7NwJNpHx2ixWAWR3B9KcFPTVLhYnj9do7fGzWTRb3M9nDMW
         4fI2qho2hboOvuqOFJjbfmXWMBw0OS4jYKPv0EPnb2dluDsD3Hzbii6UURM5Z5tG5xOO
         SMYnbVesuVclq5j9RbqcMeoyQ2nRhksq+dYWVeZ5186OeqYBonV/US5OR1qhab2D9n8z
         aGoCDmALE6mhSQQshGqMcAA3KEQ/Cc1VDhQRHG7xfcBFGPIGZv4Kt9qHMaEsK5/cPGhu
         +xqxGyb3ZmkGrNc4ulFR1aWw8YVHhGNBFd4srJqg1LbikA5bxrWrLZrESAhyxputbs7l
         FvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519528; x=1737124328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/gcAKNkCa46sAJjco4x4Dt7XCwnmRxnbzpikJ5Iyr8=;
        b=NWJsQ1ZKzeULk6deeBUvmh0uwGoCAcRz+/7KPl3SfOmJ9+xb+BMjewN7LmOriDn6rQ
         EEdxjvme8BMPFY3fBGrIVy0H62wYDb+Pr/XoJ1cEj+yhC62IB0L+NzaulrqASXwn3Y0f
         7kFc0s8pR9E0J3uohoDS6kVcHpVddSXVb8RVNF5GsszImDIFfWFW8L3shNC15o+2rkkt
         jyPhYjYGjZ+NbRENTL1rKZ9ruO3ZgRufu44Jx8O2JNu1NiiYBD8n/kR10uTZ55TiNMS4
         dbw82C792A2EFKl5odVgfcDxczk/tHB1up3mDOV9KruYvARAQjbqM/rmgzy6hDKDy9On
         4p+g==
X-Forwarded-Encrypted: i=1; AJvYcCWvVIk11bRd3/5dEK2/l2n9xQmmk54uQ6+aDHXNZ6hsMvlMRWeKCLI1QhVc4+LL3cILJUDRnio4RPM0@lists.infradead.org
X-Gm-Message-State: AOJu0YyGZ1K2TuWGVOmIM+9szZ812AkJuyoIBXXDAyYOswKQu4ybE4uZ
	36wuN2viPCiJkJkbkLEbuF05htL67WGLXUuPYDlXyQxDyAILtd3LdmBcBgxH1BY=
X-Gm-Gg: ASbGncuCGZAwXhX1VJ/HSgW2vQxVAW7xfQfUkQ1gucFMzuWcGbLCl1cKIZmIUBa7EAJ
	DFX7racpG50KSM1mxB6LhhXkWlxYoWrVZ0x5XfLfTklIvhIJQVX52ngsxlEP70Ne0/qEDycglCi
	LBLv94Rto4V6fkaNNoQWGY7AzsWF4s0VZ0nS4TJqzI7mVD1o6Dh8t9tJwDx6RMmqvg04q9FIb1H
	P16qxHSZRPlprrb8Ucnm7YauPZswIpcZ0m0WYZiaO89Jqs=
X-Google-Smtp-Source: AGHT+IHH04d6dGti7fVXw+0NaZh/+tDlC2458jxoW49T1h/PFC0T6YfGUhNP11btFhq4QTA6+HtDyA==
X-Received: by 2002:a05:6602:3585:b0:84a:51e2:9f93 with SMTP id ca18e2360f4ac-84ce00c49f8mr971265339f.9.1736519528352;
        Fri, 10 Jan 2025 06:32:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fc84dasm91086539f.46.2025.01.10.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:32:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, nbd@other.debian.org, 
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
In-Reply-To: <20250110054726.1499538-1-hch@lst.de>
References: <20250110054726.1499538-1-hch@lst.de>
Subject: Re: fix queue freeze and limit locking order v4
Message-Id: <173651952702.758529.3309066666363818120.b4-ty@kernel.dk>
Date: Fri, 10 Jan 2025 07:32:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_063209_903489_2C675ABA 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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


On Fri, 10 Jan 2025 06:47:08 +0100, Christoph Hellwig wrote:
> this is my version of Damien's "Fix queue freeze and limit locking order".
> A lot looks very similar, but it was done independently based on the
> previous discussion.
> 
> Changes since v3:
>  - more comment fixups
> 
> [...]

Applied, thanks!

[01/11] block: fix docs for freezing of queue limits updates
        commit: 9c96821b44f893fb63f021a28625d3b32c68e8b3
[02/11] block: add a queue_limits_commit_update_frozen helper
        commit: aa427d7b73b196f657d6d2cf0e94eff6b883fdef
[03/11] block: check BLK_FEAT_POLL under q_usage_count
        commit: 958148a6ac061a9a80a184ea678a5fa872d0c56f
[04/11] block: don't update BLK_FEAT_POLL in __blk_mq_update_nr_hw_queues
        commit: d432c817c21a48c3baaa0d28e4d3e74b6aa238a0
[05/11] block: add a store_limit operations for sysfs entries
        commit: a16230649ce27f8ac7dd8a5b079d9657aa96de16
[06/11] block: fix queue freeze vs limits lock order in sysfs store methods
        commit: c99f66e4084a62a2cc401c4704a84328aeddc9ec
[07/11] nvme: fix queue freeze vs limits lock order
        commit: 473106dd3aa964a62314d858f6602c95e40e6270
[08/11] nbd: fix queue freeze vs limits lock order
        commit: f3dec61d7544a90685f1dd9a87fd4afc751996d0
[09/11] usb-storage: fix queue freeze vs limits lock order
        commit: 1233751f7df722435bb93e928d64334db260b90d
[10/11] loop: refactor queue limits updates
        commit: b38c8be255e89ffcdeb817407222d2de0b573a41
[11/11] loop: fix queue freeze vs limits lock order
        commit: b03732a9c0db91522914185739505d92d3b0d816

Best regards,
-- 
Jens Axboe





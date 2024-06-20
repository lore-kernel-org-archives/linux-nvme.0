Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA13C3DA40
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q32PR8VJwyaaGnJCPVdwaybh8Bp1RWGH3YQnrF9Y1fw=; b=ueCpnr9ulnPtGyxCg6ffdXCfUC
	Bailro94k96JSU7LSBLpGAA4Onf26lR8JLkIPQMxcAaLoU/CsfXh8teVm90jFyzmy1gYuTORvFVnC
	XGPwM0Nq8p92FFrOso1sfrDZwsWhVSKZ+GzrGDl9x8Mn1hQgtIAd8FzaZ/CkYV3CmyHJYHNMWvuwy
	nTURCgy8imBHk/MCCzmyfL+1psqr0JCXvlf0B9CdeSsxM0J7Ul8lw0JxLCOFO8YlIQc19JkyhFN23
	n4FLvVK/WrkQAR9BhDozijgSKIRm574CdccHFBpuJqKVq4fMnTAofreOkV7KIgCkAuK7xgJYvnSFm
	EOdPjrVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXrj-00000007zB9-38UE;
	Fri, 21 Jun 2024 06:35:19 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKPFQ-00000006kqU-0oSi
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 21:23:14 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1f9a617f88cso1251425ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Jun 2024 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718918591; x=1719523391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q32PR8VJwyaaGnJCPVdwaybh8Bp1RWGH3YQnrF9Y1fw=;
        b=LF4QpfHnAncjx/nDcokTp7UsFCY/uffocL0WWH+z6afvaHqnwUWG+n4DxWCJwVMs26
         n+1kGwgBYjRWrtcfO/AKbB9yjuMZPwYft/ob0u1sJSnLfYal3wjURxChPR7TCaKe4/oG
         NXAgNidH0kEaX53g1T93mpau0dvgLkMM+oAqsrny12cVzxWuQ/i2jHlJNkVQrlZJhY5i
         P1eVBhyFvr4Xm70wdr8Fm5fMnLY3BTPVGcedP25UHWAbw2fREX9nRYvmW930oOfO29Xf
         PpkuLLEs2OxITnGz0JfPWZiB8f36Izb0Vdd2dFMP1oRY26/hie9C/3b9OkaAJmQVNY+h
         NWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918591; x=1719523391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q32PR8VJwyaaGnJCPVdwaybh8Bp1RWGH3YQnrF9Y1fw=;
        b=j+y3o9hLbv2xzYvEp2um6c0lJLwIuc51k3eFE6kjgZrLglbkjPpqj0a9+p0WJn7T5O
         gO0+mkQl37KLgia4UoUN7P8fAjW0c5h8k3INIKtuX8XIlFHRvXVoT/jnsDH2KFc1zbef
         xuHJR2YruyrNGbfwuaYGEKq9pxo/5sEP3K66CKb4s/5IMyN+cQ45Xld6AnbXb8qsqk+J
         dS/yJbWwfpIrYX28wE9KNMtyVlV8WfQHzzU/WBx201tqL5oMXGKaNRgiTNaNyax28XgK
         04paNms40AWxe5DFeVdT7ggV6UfMyBWwR7y0i922dPlrrnRx7/QG7AwV2TD1t0k6EtO1
         GQQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6o651XWs+rCpJBjLfZOezhkVGgRwXvCjWneg3PIShlSXAlBKkILtu63VzM4JqDuMPXrkHoksU5zpIjxu1/jjuAKX2GhoU0AqjITaMgAE=
X-Gm-Message-State: AOJu0YxFKPLufUgl8zrnaGLUjVgs7tklVK7iw728wj+CFpah+/abszIA
	dxCHMjeEkh+twQCmJAi72THhnIFkCAS93/Eb+bffAmMif+gmrJc9OQ66oFLzbNU=
X-Google-Smtp-Source: AGHT+IFpAE8rRXH210v7uuhhLHSJBtr+lAuPBX0TSREwLr72nwKk3bIU+qQDyxKzIteobELD9VqsaA==
X-Received: by 2002:a17:903:1cc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f9aad9d286mr68451195ad.4.1718918591063;
        Thu, 20 Jun 2024 14:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:7562:ac7c:9f3c:87fb:fc6a:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5089sm668135ad.193.2024.06.20.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:23:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, 
 martin.petersen@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
 dchinner@redhat.com, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, 
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, 
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, 
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com, 
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev, 
 hare@suse.de
In-Reply-To: <20240620125359.2684798-1-john.g.garry@oracle.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
Subject: Re: [Patch v9 00/10] block atomic writes
Message-Id: <171891858790.154563.14863944476258774433.b4-ty@kernel.dk>
Date: Thu, 20 Jun 2024 15:23:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_142312_382878_376F6992 
X-CRM114-Status: UNSURE (   8.57  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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


On Thu, 20 Jun 2024 12:53:49 +0000, John Garry wrote:
> This series introduces a proposal to implementing atomic writes in the
> kernel for torn-write protection.
> 
> This series takes the approach of adding a new "atomic" flag to each of
> pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
> When set, these indicate that we want the write issued "atomically".
> 
> [...]

Applied, thanks!

[01/10] block: Pass blk_queue_get_max_sectors() a request pointer
        commit: 8d1dfd51c84e202df05a999ce82cb27554f7d152
[02/10] block: Generalize chunk_sectors support as boundary support
        commit: f70167a7a6e7e8a6911f3a216dc044cbfe7c1983
[03/10] fs: Initial atomic write support
        commit: c34fc6f26ab86d03a2d47446f42b6cd492dfdc56
[04/10] fs: Add initial atomic write support info to statx
        commit: 0f9ca80fa4f9670ba09721e4e36b8baf086a500c
[05/10] block: Add core atomic write support
        commit: 9da3d1e912f3953196e66991d75208cde3e845e1
[06/10] block: Add atomic write support for statx
        commit: 9abcfbd235f59fb5b6379e5bc0231dad831ebace
[07/10] block: Add fops atomic write support
        commit: caf336f81b3a3ca744e335972e86ec7244512d4a
[08/10] scsi: sd: Atomic write support
        commit: bf4ae8f2e6407a779c0368eb0f3e047a8333be17
[09/10] scsi: scsi_debug: Atomic write support
        commit: 84f3a3c01d70efba736bc42155cf32722067b327
[10/10] nvme: Atomic write support
        commit: 5f9bbea02f06110ec5cf95a3327019b3194b2d80

Best regards,
-- 
Jens Axboe





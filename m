Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E8C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pb8qWmhccm9eam1IG6/mzCzwkOR/9EGblOaiwee7lpg=; b=rUpZpQnEwqXXOigllPoqo06eZ5
	SKUZofHblKCh9fw4t0pzfhEm+zeoHzogDy2hbt+GF0w95gtiVyCFYegu/J58n6GXtfXMNe1jzUQwh
	V7Lbpq1wubH1jUJ84MmOd3JjXNB7vILfPBS1TkgV+OjH2+7ReEnCmX5qNBICtuI3BRCHETMfuG0Zx
	d4Vxeu6bZ11IfyLNGhDaFakZDAXu0GTv3i4QZGl7WGocWK4EynYEAmNRgPXBOyccNAXRPTUxm4gcE
	gFsErDA84up0w5Yqdij1k96MKauDSr3L7EBify9hL394RehtG+70SJHMdhhvcepWcw4BSM8XRtMVO
	RfOqkQnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhCg-00GUPq-0H;
	Fri, 05 Jan 2024 10:13:26 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhCd-00GUMZ-2F
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 10:13:25 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2cd1aeb1b02so16806971fa.2
        for <linux-nvme@lists.infradead.org>; Fri, 05 Jan 2024 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704449597; x=1705054397; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb8qWmhccm9eam1IG6/mzCzwkOR/9EGblOaiwee7lpg=;
        b=xWXwiaxt5AZSNzFmi51zJL7KllAw7F0nYlgUPWLNGS4Eg+JaAfn0yG4InVsc+ssGQ0
         GLOC8qd/ISYJ+Rc0YBvnepsGbvSQMkA/SuTkDbmrNv0fsWfzyuVgkWrLIgOiElOWa6K/
         abSPnHkkbkdSKV8XTo5XxT3aS3P7VnqmbMrZ0ttT0ovhJplpG+J/0YBIjyJutXMTntft
         ZsyA3OmLqbN8kI2CQer2Yyxc0fG/DgO59O2wdfKzJbabaN5QxMjekjLNfOUPd02r6o/T
         tGhClvS15+IsG14vZZGlmAASVpzwuDh02vbR9cZ/fSetjxVhc0espurpFVsTmTyIR2Ht
         DkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449597; x=1705054397;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb8qWmhccm9eam1IG6/mzCzwkOR/9EGblOaiwee7lpg=;
        b=s7CABGILOWmkhjwo5JOJVI3siveJeCUUeKpxpTrUqMXNOEAbKjFzSHXzk0S7trtVqZ
         y4jU65G3dISgFhm1LdyoHCgihgV+51WSDm01p3O0Z8CbJLfHsBSLpSY4XQDA81/dJHoA
         JEex01Hwhjbhdj8m9++zOb6xgsCW86MdUkdnsGe2+AAzN7JX1tf0693FLcdcwgeONvGO
         KVgwtUjK9ha+im5lz+BgyiG7iEwKWZBNSjyX92hwMhNGm7DsEreB7GLIbckI5R+/BmUb
         WiWYW/D2jj6L4cbQYoGsxANbogQmi+mRif2iaCvPl18WEj0geU2aGsMyQm1vJKlnIjOH
         XadA==
X-Gm-Message-State: AOJu0Yzg9WvTknjfsh5Fb4hzLZOnWO4uaulbs1HTs6GZatmNEe3VJAh+
	9WtCQYzCbEmtQuKm3a3GabmGHF/L37aaVA==
X-Google-Smtp-Source: AGHT+IERFwtvcyoPP3L+QB9SFl8+7lNrV2k0KLfbM/7+3R7xK9hX+EDB4G+sBp41ebG01fKH0Phabg==
X-Received: by 2002:a2e:be93:0:b0:2cd:1d5d:322e with SMTP id a19-20020a2ebe93000000b002cd1d5d322emr1306524ljr.10.1704449597179;
        Fri, 05 Jan 2024 02:13:17 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:3983:bdeb:5f19:e2e9])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e82d7000000b002ccb9f5ffcasm262090ljh.93.2024.01.05.02.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:13:16 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
Date: Fri, 5 Jan 2024 13:13:11 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_021323_735805_0A5B471A 
X-CRM114-Status: GOOD (  27.22  )
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



> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> This is primarily a _FILESYSTEM_ track topic.  All the work has =
already
> been done on the MM side; the FS people need to do their part.  It =
could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
>=20
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
>=20
> The old way to solve this problem is to specify GFP_NOFS when =
allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of =
deadlock.
>=20
> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.
>=20
> This results in better code within your filesystem as you don't need =
to
> pass around gfp flags as much, and can lead to better performance from
> the memory allocators as GFP_NOFS will not be used unnecessarily.
>=20
> The memalloc_nofs APIs were introduced in May 2017, but we still have
> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> really sad).  This session is for filesystem developers to talk about
> what they need to do to fix up their own filesystem, or share stories
> about how they made their filesystem better by adopting the new APIs.
>=20

Many file systems are still heavily using GFP_NOFS for kmalloc and
kmem_cache_alloc family methods even if  memalloc_nofs_save() and
memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS
is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), =
blkdev_issue_zeroout(),
blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.

Would it be safe to switch on =
memalloc_nofs_save()/memalloc_nofs_restore() for
all possible cases? Any potential issues or downsides?

Thanks,
Slava.



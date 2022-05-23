Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B18C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EA3FIBNNDoj02Qd5UyhoYbcYuhDKnQDkuCoIXsHPGWY=; b=oV3XXx5CqbXW7PZ/BSOrjM2JqT
	ZgmyEsRBwLSCi1SnvteRY865lmIVLDXOQh6iHRfuE9gYHvny7GQJTMpq4Llq8jffBWninEE7JU/Yp
	hvKQJ6HjPmD8/5eY3UfUuioBzYk4GD6l/9PdMccYB/SYpQeUftxAcAWx2mIzX3FBblLoxHv2bQ7s+
	ClJfGTsu0658IETKivICyaQ1tb0tMnbgVMyFMBvtmuGh7D5LAmBWBxf5OtWL1dqR3W7qO43GvqvsS
	D8SOWcUqwpvQmI9hU2BC3UUYq8/QvJ/g67VBE7YUhKZUSPJNRE6EXHKq0ovad50DYxzY8TEaNvnNm
	1NW5is/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntETS-005mxk-8w; Mon, 23 May 2022 20:16:18 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntETP-005mxC-P3
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 20:16:17 +0000
Received: by mail-ej1-x62f.google.com with SMTP id q21so10961886ejm.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EA3FIBNNDoj02Qd5UyhoYbcYuhDKnQDkuCoIXsHPGWY=;
 b=Nfn7ww9o3d0ammGcjT3qgI9xxfAGwUBtkBtWkmxyujjnhZ5owJd6qJrN9TUYSY4B0G
 C8sS56B0FTy0zY8TGSBy7mCZaTgAYNDgfE2spXBFYauQ0VIko+BXGY6hGxZXyllmvji6
 JZ9lWCVYiTDJz49RoARM4qI73Jd0TIJVA2Yow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EA3FIBNNDoj02Qd5UyhoYbcYuhDKnQDkuCoIXsHPGWY=;
 b=OZVUrcKNQS/8p588EvVsNXPJ63YZ9356cKrvaWIWHHzn+32jGAZUTsYcEUL5f/CESG
 59poQJ3r6HvDTLfZ4WiQiAOBeGARl9T1wbOEWar/8XZ92EGaKJ1EYLPiUkuvXBSR419q
 3a/6M92RSDZnvnTUvLHzKQfCj8NLK5D3B8LSb+0ghffqjvOxnr9/WCKdE4tyUiADp3RT
 T4h3+booljyea0Op3mgK7d3pMpchMONQK1BCKdhd88NW03LdtNKe4tHDsSm/Vi9tJ3iz
 wTyKU5VYKy7wCfzdQU3QuRrD4DfSoPzVzVIxRrZdXdZdk74bxhKgNg5+0Hds2WKwnSda
 goWg==
X-Gm-Message-State: AOAM530IZtk2Bx5E6lpP9hCXQNT2VMnf8YmSS7gNxZXw8KuD4K80RzaU
 R4nH+MPFUgOJsBhPjydz7SZhGRb4Ml6fghJJLtg=
X-Google-Smtp-Source: ABdhPJxffN0894Qs1wGwUQiwai0Jfq6bszT3m3RQ/ZFF2mIj5eliJedfarBSMPBWZ2mUyAn0VPcsvQ==
X-Received: by 2002:a17:907:72d5:b0:6fe:c343:1ace with SMTP id
 du21-20020a17090772d500b006fec3431acemr9950980ejc.563.1653336972972; 
 Mon, 23 May 2022 13:16:12 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44]) by smtp.gmail.com with ESMTPSA id
 10-20020a170906024a00b006f3ef214e5asm6564812ejl.192.2022.05.23.13.16.12
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 May 2022 13:16:12 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id p10so4277033wrg.12
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 13:16:12 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr14025325wrs.274.1653336971796; Mon, 23
 May 2022 13:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
In-Reply-To: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 May 2022 13:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
Message-ID: <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring passthrough support
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring <io-uring@vger.kernel.org>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_131615_863646_C4C4E3B2 
X-CRM114-Status: GOOD (  12.73  )
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

On Sun, May 22, 2022 at 2:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> This will cause a merge conflict as well, with the provided buffer
> change from the core branch, and adding CQE32 support for NOP in this
> branch.

Ugh, that really hits home how ugly this CQE32 support was.

Dammit, it shouldn't have been done this way. That io_nop() code is
disgusting, and how it wants that separate "with extra info" case is
just nasty.

I've pulled this, but with some swearing. That whole "extra1" and
"extra2" is ugly as hell, and just the naming shows that it has no
sane semantics, much less documentation.

And the way it's randomly hidden in 'struct io_nop' *and* then a union
with that hash_node is just disgusting beyond words. Why do you need
both fields when you just copy one to the other at cmd start and then
back at cmd end?

I must be missing something, but that it is incredibly ugly is clear.

                 Linus


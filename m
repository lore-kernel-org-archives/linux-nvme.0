Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4343CCF9F0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=; b=sW4JJ+ZpqZqHEuQO7wj0Iw9cyx
	WHoSM/eDw+WEil08qF4Xp6weCc1e69s5cKBIocMlfrA8l/FchXCpyul4kz7wybUgL9uDXGkFyuSQX
	4lUCZDKixEgqbucViOYkbZcw0sz7WAPf4C7Jj7E/DWdd3u8z+ew6ENCKnHW8JeNrrbTFg/gCoDoey
	7/PtIn0ExE4k1aOuKWkGamYwv5h6BszkPKK3dbNRxWKP96OSpclpmzzELpTmEITj6d0JpWnfYQrAU
	IVUuC9x/3sTiCbD7M5+XnVLLIBB6Gg9v4k9nbwj7clvLLTwCjFp+ALsjqNa4XtSyegB1/UVVNBy+X
	JNn3zXvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9AZ-0000000239y-39dL;
	Wed, 29 Oct 2025 16:37:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9AY-0000000239k-3rA1
	for linux-nvme@bombadil.infradead.org;
	Wed, 29 Oct 2025 16:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=; b=Vh2l+fGzG49VZl5oWqSFHbeZ/C
	tChBLR2/0wtLMID++twd9zKtNMlvddHuyyT+hDDSr4TajdjzmUZPag2fB97KrUhtZX7YqQ6M5Mbau
	uyt15vMXxJhApUbKTrGG440KHzWnEjps5Y69AkfNlHIs8+UllS0dK9X7WVyjZw99kXZrpZNyQx6r/
	UnMjn+CXAGvG1CR5qJyBjemdJZr9Y0lkXTDhkK910v2foxC0fQYzyG+EnbcU/ZQTpACB9+s/n9E2U
	ctBNMFezpKWW+E263RopUW7TPg27Pqq4g1Av/YsBNG1F62iG6auZ5ZDKFLno7EWt5b4ARiYl3NRb0
	gRzHgqBg==;
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE8Im-00000007KMx-2QK9
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 15:41:34 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-784807fa38dso1289127b3.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755821; x=1762360621; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=;
        b=BK79AEaaqWwSy3UwoKwF8f/o3YYb1HPkNpSjCrpvaLP335GNxWCp5vKUviuaJ1K21x
         fY5XO9J88V3JAjEirVbDhaTvFvZ1+vCAPZ2ywQGWC+d7Evq5UyZPLwFgBkKNGOqaHsu5
         Qh+bdOKzP8EdGNEF85GfgEQOjV30I+qnz3LqlpkH1qdw8xg+Ys2D2kRvvgGSxvL2c62M
         ZXJ/eYBrrEc45Jf7wSoX+XxTxMh0qbA9qRLlIRDY3DiHAZhkdMOEjnMn0LhI9y9Pk/HR
         Um9tDx81XOmFVCSIoGTuN7cfuAoUw8Wl0qFylRaTjjv5DjOyxd3jquW1wV2nstWSNAX3
         q91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755821; x=1762360621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGMlqEZjKYp5S+5IieVYbFA6n2E0dxbgiRC2sMcci1I=;
        b=AWZiuEOGako9DNHEoGqXXNBxgjrMMCU4tV06sL0zu4dytNIQZJHkombM3fEyD2g7T5
         11OnGDc9Pe2sP4HX8bJvqwIzREoULO0t1pw9BAx7iM/BnA5VNJWO9tyJs8fB3L1rW3JX
         /1VLbjI3Ehqlt/YHtdDmQkv5uXriXwrq/w3DAQaJkBtxTcjbCk0SW3jodpyTZqXVvCni
         SbfNpHgf0bUsFQ1ysJyTSvbAYqXAq5k0kFJ/y+3j7tU7Frqiy13qSmSAp8ONfnb7RGQr
         PZEK4XK/NIUC0IrVcZdd4Qk4JOTzuKfpF15Gk8WghbjSPZdfoqGQ17dXkzZRHaGEIJd7
         KrtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhUYFgYMNCQVwxgPRqwHgjfHC+t2vzYGT05jSmGedNhPxyoDxBSerNROHL6IZDI+CaaCQ4Pq6yYfKq@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+ATZCWNn0BQ7T8hZAEfjhpqe4zV0JKDdsfzPrcuZAZv7Ju7gI
	T5wW3zzalRgresx73ZVnwtoUapykyxbORH/Sw0gOhdDfLJK3typTO9+z2YMz8YlqQDuCiUT8Cjc
	wYQlvR0tzCl9wmJPZLty0ilmw68MgV8A=
X-Gm-Gg: ASbGncviYpSpMnI84jU6O4p9jNSuJ5TmyovXdNcCZ83w1aCeFIUeh9Bdcb0p1Z1QB86
	UrgUVHhaCBb/thgCJO286xUdTh5psUMlqxRNMdPfhD/2YD4/D4IU48JDmZhk5h9a/3dZ3/yTEDz
	3na+d7el+d3XE7f5DSDS59moVDATwGQq9y1uHocb3rc7zOrk4aqcvN3w72lzL8sfPTVJ7nhLL07
	2W+TODBUiAXh5pJH+feWIg0RMPw7E17OIfrXmXaa+AWAteVmL62KM+skcLqRg==
X-Google-Smtp-Source: AGHT+IEEhdrnhAIGKxvabw/x0BOPfVjo214oM41Opns7baxmqAdYDdZWpcyM0kWOnxNmncxTiuZVHnVa6tugnIs2HJg=
X-Received: by 2002:a05:690c:9a8f:b0:783:afee:fc46 with SMTP id
 00721157ae682-78628f8eff5mr31278617b3.37.1761755821463; Wed, 29 Oct 2025
 09:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
 <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
In-Reply-To: <dc6288f0-989c-4314-9217-8f1a12eb206c@flourine.local>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 29 Oct 2025 09:36:32 -0700
X-Gm-Features: AWmQ_bkYqCwqgTXJV-73FmW6iGOzC9mLFMAx4nn5hm9_kYOzj8oWovAhwrKAM3Y
Message-ID: <CABPRKS-xgumM-E8hKO-3SoOg9xP-ar=mB=jgZFwsG2T2VqE99g@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_154132_726080_65C7FDB1 
X-CRM114-Status: UNSURE (   8.12  )
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

Hi Daniel,

> Should I add your change to my patch (obviously mentioning it)
Sure, this sounds fine to me.

Thanks,
Justin


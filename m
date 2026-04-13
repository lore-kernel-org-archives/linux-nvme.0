Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E70F34C64
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJ3rUJh5CWsw1EiuhWHmgUssDs4YQJ5kj165j8Ld5Kw=; b=xXutv0Vh5vOn5eHmJ4nJfAmb17
	A9YZIej7+PVcP/SH86yf6sQ+o90chuHzlDcb1tu2f2kLdmjr9fxEBukOip4sDyHWBapzWZqI7SxLs
	/pX7Jzdo/9mDMSXGQvS4mZWOiwb2j07FSxfLAM3TMOb4b9ijbbtYKe4ej5Q/nM//YNJ98Q8PiBhdb
	Mx7bv/O63+OXDEerPaFvxpbs4SGrcuHeyXmKAXb4f9/MQUROh8lGPdKjDPeqbtnwmPpeoUvU7/afw
	qepWourEb852+CK/qlPzFWOOvB0cB7WF0j6s42ookCPPPA1LCFJekIewGjpTtB9l3xJkPUvauhiOa
	ClASQiIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKE6-0000000G47t-1ByD;
	Mon, 13 Apr 2026 16:33:30 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCKE2-0000000G47W-4B1H
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 16:33:28 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-12c19d23b19so4816559c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Apr 2026 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776098006; x=1776702806; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ3rUJh5CWsw1EiuhWHmgUssDs4YQJ5kj165j8Ld5Kw=;
        b=X6mDPA+QryW7LDMBAkjNcDW3bIKkbQC4eLWLgUwdrHoFcUA1er8LAVzsGxJwr2Lrgw
         2RNBj8ZRm1xxtxGycQdVzuUyVKCbM1/5yGwzo64B8JDgKGMYfhYW+oiyxRWQwzyGWTc5
         zh7sNnzvyTJ6uOZLzgUrztoaK4Y3CV7GopyAszm9Z71pLGqw2OAKSUCN808I/XRJnV/Q
         6tkFxpo3GFy4s86cMP7gVQTyIfCREebWuPUlXMF413GID3fUrJPh6m+/awLDWv4PlgLa
         Ws5bcb68/RAGN9udgsFTrLi/RAglqiB8q41xoY3NxF7nk3RzFrExV9S+c8jc55uIECBz
         DMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098006; x=1776702806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ3rUJh5CWsw1EiuhWHmgUssDs4YQJ5kj165j8Ld5Kw=;
        b=tEHWwDFtmHdL//hKIlDM5mnZpEGpu9LXNGNiIL7F35j3VTc7r1LbrrGiy6IRZohGG3
         VW2nwNX9JNpfUkrGuPAmnGni8ctNXOFmucPYMEEkdHHpTLZJzbstAKpzc+eVK412Tfzg
         gOOdvrigaTtifYPClXZGh6HI20XUmt0aoGNT3YRYY85cReUgrWUYwYOQhqmBThWPQDTJ
         Z0gigBEsuFOjYj3JEDCWPfubWa2ubSMSj524AMXGuAwkJ7tBMPBLoJauGJIgydP9br2b
         r10qeGdld/IQiJ4BV0oUwsH5kGSJfji2tZy3MJSI+vLJWpHTaohEkqZoT2oqc8zD07i+
         Msgg==
X-Forwarded-Encrypted: i=1; AFNElJ9z7xDLlhbqOPm1DEU5o/Cuum6jwLRNGJSsbNUSHO4EDykEBZ7ZNK0+5eroA11ju9Lf2ALNQgyz2n6d@lists.infradead.org
X-Gm-Message-State: AOJu0YxBOOOpt1a0+CA4fn8Tu3ukI+x493lo25Tmt1FwvF0Yh4mKsKfs
	REgZbcjphT6yNyZy3KHVsXwgV1Dt1Kh4YJ1hp6z11Q9h5v8dgro0nkKQmPmTvj7NpLI=
X-Gm-Gg: AeBDiesg2lALGQ0zpNmpa7MSc3W4n8NlMc7B8MwJSy8jiHszB4YBiqf7MZCFkXv0LMx
	MHhlNXSPF4CLujg+zC1qqfslDy9aaK8mduOxk+aSQ1K0Nw8JLkRyQkfFwCGPF0wBqo+PivJOMum
	WE+EdWXOg1ePLYOmeyWzz0QqqGCzrtV55+QsSUvQ2iWrSKbyZTSyZekneOwutHJa7q0F3bS38fM
	+rTc4YcZoe8nVab7Swnx5OjTAYU3fWyj5dn8EQuj2lg2NDmwD8KvxXnMh+1qnHF/TBg1pXXnm06
	o73I/b4DBppOx1zea5KPct/Xv1nwKs+fWjCuL3759dnWOIlfWxHer0ppR6FKlmFTfTn5Joql+4L
	+7AzY5YA8xpXn/MmigITGHfgjDN01tqpN+y+3KE4wID1pBDT9y94W5oCUmquiUHU0sk41kbHzJh
	1PRfBXQuIu6G5Pkzax3TBARCg6OJiQaJw5WzayliSH646ltQxMedMgz/w=
X-Received: by 2002:a05:7022:ead3:b0:128:d1cf:8ab with SMTP id a92af1059eb24-12c34e37aeemr7404491c88.6.1776098005293;
        Mon, 13 Apr 2026 09:33:25 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12c346eb228sm15911165c88.9.2026.04.13.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:33:24 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:33:23 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
Message-ID: <20260413163323.GI2861-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-9-mkhalfella@purestorage.com>
 <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
 <20260331164733.GC2861-mkhalfella@purestorage.com>
 <5d3fecf4-9101-4028-858d-bfbbccf3d8d3@suse.de>
 <20260407204653.GG2861-mkhalfella@purestorage.com>
 <CAPpK+O0HjHRJyNE72UCahi9Hs+Pv3v8BNmAXOfMcXgzYPYo+Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpK+O0HjHRJyNE72UCahi9Hs+Pv3v8BNmAXOfMcXgzYPYo+Vg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_093327_211266_1FC73CD4 
X-CRM114-Status: GOOD (  13.08  )
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

On Mon 2026-04-13 08:25:51 -0700, Randy Jennings wrote:
> > /*
> >  * Source controller accepted CCR command but CCR operation
> >  * timed out or failed. Retrying another path is not likely
> >  * to succeed, return an error.
> >  */
> Please do not add "Retrying another path is not likely to succeed"
> because it is not true.  We would need to check the retry flag to se
> the verasity of that statement, and I would expect that check to be
> added later.

Fair point. I will drop that part from the comment.

> 
> Sincerely,
> Randy Jennings


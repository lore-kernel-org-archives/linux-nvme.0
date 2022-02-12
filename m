Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B02C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLLDXiwc1zAowqYr8P91bEBGG8/afaZrRX+wfAwZ1k8=; b=xi2XnV48+upZeI+++nHzeg3jTr
	wK65XudWonwhNExXlOw0Q5f6DAxmB7vheqjFvK9GeNnLT353o+LV7FyWe6nAY8Xdmevlu6OSmPXy3
	+M4lkXChsSWpjTR6a92cqdWbLxfRQ0tG+2FWDmZmknogHevD7oF0DANIecxsHnu4wdY9wV4uB3fj4
	kGAycCpvrRo+M5UU+GmFaZuwn18ltrxNz5qGW/T4Q8QigGdaAOJc36k9O8eH1aQNxleIxtDjJRA6V
	3vRcCBcpaBkCoA/yRl5QabvyYg9uB3+JAvyWwmxpLHJw74M8LlNPy6aZH7g14vpxe4S6Itb+LHA0a
	RQp4suTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJ0hV-00Acgg-4m; Sat, 12 Feb 2022 22:17:05 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJ0hS-00AcgC-7l
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 22:17:03 +0000
Received: by mail-lf1-x12e.google.com with SMTP id j15so419832lfe.11
 for <linux-nvme@lists.infradead.org>; Sat, 12 Feb 2022 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lLLDXiwc1zAowqYr8P91bEBGG8/afaZrRX+wfAwZ1k8=;
 b=p+YZp2LHLGfXp6o+BPTJl97qUJGAwHA/o97ZAm1qp25ZVbwllNR6pzPul5EtBGI3oq
 boOv2B0e86b9q1LsjAelcPh+KiDmPUmXU2RfyYMq0vBon86JogNXrtnsPt3QLbDia18L
 OCQOLpn4sSZOczP/GncLRIS7lrROmbma2gLMGgM8EjB1O5QKAHa8rAm0Cb/LLx6wHpQd
 bIJRhc2M5dS1/FBfCxw0d7/0U9Q9Q+HvOYalOvMCwg2TsvMywMGTgeYOFGoDJBmUrfNe
 Jth4ZaCx9Ibs0x8eInChZcWpqQuAYVqMZXzHQ8InVpBP9pcelNylMl2LUMLWoUZ9cMzW
 9K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lLLDXiwc1zAowqYr8P91bEBGG8/afaZrRX+wfAwZ1k8=;
 b=6E5+JhbzJ6r0ziY3wZs3MWbcVtx8f7TX5rfPQiqtVuQsAYrnNGZihNW27phRYOb0no
 r75lwT666J8ALTcqzOBfoQShgSjH0LOEh1Ph0lCyLyyU1WMjMF7QoBV9dkn1zakEL5bV
 GX3DsnXaoHOoTKz+CxQNX2L42aATTbeUytyBzgg3CWDf2WzFwf2BA+gNjOA/v9648HMK
 J6wAWmXCI/7wm0OaxUmBTKtb2DjQF2ufWBEhZW+o7OuVVBByrUFpgbhk8XpnR2rPaVI6
 KKfSZFGJhC1UAlN9/maWhyoLf95O7yzksqxJ24JhFEDHu8X/XUncNE2IpBHl2avxmgZP
 5E9Q==
X-Gm-Message-State: AOAM532/4cFOON+EKIlNrt93yWN9SmUhVbPaOwutx32sa6SHWf0E6F+V
 U3zigZ9sWI9w/V4vjSbMKjLUtAGxRpvjrmpE0wg=
X-Google-Smtp-Source: ABdhPJwISFy1v4C6ClK7RbYkoj9MKlAxZvU4HprF3RfUlZOm2OsWiHMUcZyF3ApjfahKnNLbjY4LRPYtorxcldClY0s=
X-Received: by 2002:ac2:4e12:: with SMTP id e18mr5610797lfr.282.1644704220387; 
 Sat, 12 Feb 2022 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
 <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
 <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
 <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
From: Matt Waltz <matthewwaltzis@gmail.com>
Date: Sat, 12 Feb 2022 15:16:24 -0700
Message-ID: <CABwBYcazb-2E937U2HeNJXRAtLbyfGdMh3AJarmP9wasyS-qWw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_141702_313969_9AC043CE 
X-CRM114-Status: GOOD (  10.54  )
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

On Sat, Feb 12, 2022 at 2:03 PM Keith Busch <kbusch@kernel.org> wrote:
> That only applies to chaining list elements. It does not apply to the
> "PRP list pointer in a command". The driver allocates from the 256B dma
> pool only for the command's PRP list pointer, so we're fine.

Ah yes, I was confused by the PRP2 definition which says it can be a
"PRP list pointer",
now I feel extremely silly. Guess I'll need to look elsewhere for a
fix for this bug I am
encountering, thank you for the clarity!


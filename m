Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF81C5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7qABXSmuvh113cuh+5e3aYpoNxRnRGX++Rp3IcP6MEU=; b=mfjcP7NU4Cucb2ppqTlDJIvLdz
	uOexxUwMOeh148qRiEr0rpEXhkpwQwdql0t/wqVNqseLZxJ0ZZ4t4xdqXZ5Eq5odzmPWNnEOe2tgb
	ubwiOVQyHqzSCAn/cl8mg/srnQPR2s46sUFhMcil8ncukrt85WOzz8AW+CJbeKhqAr7/6TYkJpzoE
	foRLUk/r14zdaCik4QWi7IRdGUax+XjHC8PI9M8qEfJePxk/8BshpKOh/5SViEZ6qUpzV/IPeJxOx
	o9/fSf7045bFfoaXZYivhsCvwkbpTyGahKicb2d9xyKlMsCjQOIwwtymNFOXmTmHQ0c90ReIyiu70
	OlUjdq8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWpG-0000000Gwww-0Osf;
	Mon, 24 Aug 2026 15:43:06 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWpD-0000000GwwZ-3cQ5
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 15:43:05 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so32798775e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 08:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787586182; cv=none;
        d=google.com; s=arc-20260327;
        b=SAPGwcanEqjof7ipTdOAVuVIcb/8Hxnj8X8DdDC+THNTOBuPq8AQK4eqth/hsScX0b
         2i32mwDePf/emqrMkZ/URhWWn2jlgbcboPXKG3Qvyz6gLLId1M/Sqv//nm/gJRMcS+Ho
         O5I7/f1NheVBIvqm/WjBKFqqwX5cF9qhhv3H3lHgCnb36cgGpmweYx0ol5A+g8K18HuQ
         7SCohk7+obGqSwKXLpqzIQ+mnBGR1ogqUYfdCuRQ7VJFI10Pb2WjyRNOQxVnIHRXukKP
         blkl+IVYgYCw8XB0kWR/xeB54oKgoz1Bp4gFItO4K3oDSPUZeDS0JQZppu04m0hn0zNT
         iuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7qABXSmuvh113cuh+5e3aYpoNxRnRGX++Rp3IcP6MEU=;
        fh=fsf/3OObFRRxSq9kziOVfv5/h96lOXdO1tc0eJB5CUM=;
        b=R/qMMp7nzSYh5eBVaWec48ZywTVvY/bas9wC+5/qlgJtiezZIlaXw2rPC4RLbattEO
         iweJAWq5ZoqSrllaqW2u5PHaUGSqk783gL16SuAiwkPWgtbhd0JgXnx1DutbGvjiQbtp
         EGB4zr3xThWM4iuEsTfsn6dc+xE6raCiENQZnRh1UNjEtLhcDv4zajM+wMWlRNKrk5Cm
         IDfaIkzOkTzoGH+QAceNpdM/keig/qByN4j6IY9sMU0xUI4jOgxpWxXUjCwDS7sDPJxY
         0v5qglPJ7gMTmchPxWnBNiPP9pxZXwTgrJO+bnJ7xqdxMxVSgurJY27HeWwp1PgSbMAR
         6l7Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586182; x=1788190982; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7qABXSmuvh113cuh+5e3aYpoNxRnRGX++Rp3IcP6MEU=;
        b=CTKSmKiQgLEZ3XkuIQ20d9dIrZBbVt8RxmYSixTbzdf43lJUBk9Yu9WCEN1quzT87v
         3pzYsm12lFtqsbXRZ75b5s0IPDZc+qqW6v0rmgIXPcQpSToak87UFsTGcNlTZFj7m6AZ
         w4sB7Z6EnvatGHYMYCXqVtlJ2ilV5GXwyJddFjdWzmsDcwHBfm+zSmmd4/973TAwMq3H
         GtI/Uug6VJPEFl0jGi6yIuoxplLFrXGEDjxNhemXKlqJwbvn5ygx88f6ahp+votTPsM6
         KB7omhomj7RSw7DgMYW72WYopIWCavSI8bwYwL2twec/ZAAEKR0jyyymEiO2e6tHr1pT
         rmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586182; x=1788190982;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7qABXSmuvh113cuh+5e3aYpoNxRnRGX++Rp3IcP6MEU=;
        b=PBRJz9i3nYI7pCz6I6XNPoWcy7ZoofTorDAW5GRbuIvFJIssgMNLO3mM5l9uu3oq1W
         /LxbDP0d00oF0aIS/aMf8drEEGMcF1xyAqwO+fHCY70fLPc45NSZV9oVstICLQ5LaC8z
         pyRb5p0/KRZ459IMXoAkHhwXpCJsr+42+7fW3olX8UlAwZjQLa/seNUGYSrmYIwBM8ar
         srXk6KYucLc/968VQ69R2v9WFx6cCj0xgMdTuCStWrck3xNu/I9gXAwUUYDf6J/iROti
         ShMMPf20HmaWbW0f8A7HdIcQSI2nFQWeWYf4lENVoa9JgZzRG4wSY3DxrblI6cnI+UrJ
         YXQw==
X-Gm-Message-State: AFuF++kOgipNxgNK/cJh9HMZMKZ6dS37Cgc5C8SXfibreqPKAVs1zAf/
	VgMWJJjsOW7unrFGaQRk2Xe1lhkfBlm5RvqvRwF6Fza0FCbE9Fbyd/qkniJiYivTtN42KXCTlwR
	vdg5G5lw34MZdh0FY88076FXP0aDYFAZHvoa/
X-Gm-Gg: AR+sD13zOjUs+F8W3x0X8uu85y/6GzjYkf4mZKDieF3iYiiF9LHv4fts4Cxuuv8qT10
	d4W3chLSd2m3akkztFppRTUprT2YRqrGO3GUgjQTrM8choqAD9YFpxic2pUrF3fzvsOdwWsZyty
	gmv4KtYI/OC7umYlCVcl7PttCclfR5HyU+u0uygzK5LGe3o7fwR6v9C+aLRo4ujOpKHFm8ERqWU
	TDhP+MvocLp7KFWf4x+yHdkDdVLcGoJ0zRgSFfTtzfINK/eqn/1ojbHdwTY1Lc3S0osnLBJppzz
	FFR2jyQjlf9VKO6sj93wUZn7wV+CAbXCF2yGdj9GpW7m7RM=
X-Received: by 2002:a05:600c:34c6:b0:499:5f7a:7ea2 with SMTP id
 5b1f17b1804b1-499c19cbbd7mr230370185e9.12.1787586181794; Mon, 24 Aug 2026
 08:43:01 -0700 (PDT)
MIME-Version: 1.0
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 24 Aug 2026 11:42:50 -0400
X-Gm-Features: AcwNN1V6UEpAVJOCkMs_WSd1HvGbmS8wWmJAAFctpTx3ypqY4WKnN5EW_CzlgUs
Message-ID: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
Subject: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Ibrahim Hashimov <security@auditcode.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_084304_065775_0B6A66B4 
X-CRM114-Status: UNSURE (   9.51  )
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

Hi all,

I originally reported this issue to security@kernel.org on 2026-03-17
(Cc Sagi), Message-ID:
<CA+ysrSJUFi8cHzU8g9Nrbbkcuo0F7vh8CMn3ht15gSk3BbK45A@mail.gmail.com>
and posted the first patch for it in this thread,
"[PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()"
(2026-03-19).

Commit 4a3f002 ("nvmet-tcp: bound SGL data length before allocating
command buffers"), merged for 7.3, adds the same NVMET_TCP_MAXH2CDATA
bound with the same status code.

These things happen independently, and I'm glad the issue is fixed.
Would it be possible to get some acknowledgement for the original
report?

Thanks,
Shivam


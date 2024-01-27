Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE75C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=551MHtSX6BwzXdv5p5aYRatSD325Du0y0iE1Qg36b9E=; b=vkuPTz2adBDtfiFjKtObUXY7SO
	YwLYmPkJEqFQmlDTuHXBFnwY06Yic6N4IGwBKtQYO3hvg62DSsMSHzqLs6t4Aa8omqgrdFWsYRe8c
	sjtrqj+KvpaxFpto96Xp2V5zExBvEs+RGlgcLxfuaeNzt6hiYVxbSYI8NT0j4q3lbvo6cidDbFPLo
	bEyzJ1CndXQkuhAri58/wgQTP/MUSncLBouZfKmCF7pHgbH5345DOZWwScKI6YQQuvfQ2S8CfD3XE
	2ZfLQwFdpnKJNg4wZXnBtYh8MbbqpoXEWKUCpiOQ4GDLbsa60JNfQQvbW5lm3p9r9ttIxxsVW2U94
	TLiNZVRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rThkc-00000007Tpu-22sh;
	Sat, 27 Jan 2024 12:25:34 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rThkZ-00000007TpQ-48nN
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 12:25:33 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33ae3cc8a6aso395333f8f.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jan 2024 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706358329; x=1706963129; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=551MHtSX6BwzXdv5p5aYRatSD325Du0y0iE1Qg36b9E=;
        b=f7AWjpwmENDIvvOy4Nc9+qXjHfdPq90LYAnAVqW4Z8U+8GMseEZ+88VUonJkV/6/g5
         xwS0AADpedvGdgazAPlLSVeWeP7vyttvS2bW9lEpTxiJy3EHaQuRicg9LQU5v97zgaCc
         /UMYawnph8mDaSfKnQRVgByAcunlzcypbxdrCT0rB9XarykyCVmv5en/AeyP6mt3WWum
         xnRmJ1TbJOqtntvI9FLNUXewaJhyBwUuNzVVCa1KXKC7zO4Xfk8lTTc4zavVRwTtZFiL
         se4T90ms5Jt5R+HnTtCanRs6sxgTCo7GXebof3LEjYwMXHjjqcnsBsQHSslDCBN9Sa/s
         sNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706358329; x=1706963129;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=551MHtSX6BwzXdv5p5aYRatSD325Du0y0iE1Qg36b9E=;
        b=tECS1GVtqMLqSybMXbOO67fd7GCQqL/jv9+g8MwQMbpaEOurNmBNA3LAShHkt5FTaT
         FQgLpUk66VpwAn2CN+JbS1Pz4nX1vq0VmY6yjMv8Yo6aYhLmf71qNZy9bgNcKghaM+58
         dkeNfcmq3STtPpFtBKJPrMpgF6Bp3oSN3iTGoqe3ai25fasPYAHxKyBaFwx77BLSPq6Z
         UevxCjR56fDt2IWxInK3waq41U5XrsoGE3rRnMITgXNj1pWFEt5CfRn533VK2PcAKxz5
         sUf/XAVo0GEKWIbkzp9UU2ejdDK+ShGCMN1tqOSfapUHnNms4KwdcxDwdsajI/BXn529
         pU0g==
X-Gm-Message-State: AOJu0YyC0nrZZKg7/T6paWKu/3VsR7MJcOGEX2Wrra/HBd1bwfcWZpUY
	sRGg9c9GwWQmOykolzV/78R6/oe+rstV8EU/pAmz6Ri7blurSP7PJ/4HgzGNhl4JGG7DryyaWwx
	ivQD/zsb8O3n5rS5R5s+aMuiU7Q5GDbpMqUU=
X-Google-Smtp-Source: AGHT+IHGGEvxP6dcqjMeubQLbcSikx3lJlyc6kVUyjk8lnNlsIAqwQ4+/rUNMcyVdp/5y2gmaI8F/V3Xo2pzFJ8Hh9o=
X-Received: by 2002:a5d:5012:0:b0:339:22a3:efd6 with SMTP id
 e18-20020a5d5012000000b0033922a3efd6mr902660wrt.136.1706358328836; Sat, 27
 Jan 2024 04:25:28 -0800 (PST)
MIME-Version: 1.0
From: Nicky Chorley <ndchorley@gmail.com>
Date: Sat, 27 Jan 2024 12:25:17 +0000
Message-ID: <CAG-xSoYQ8S5up0OYZi+_TzQV8rx53x+Yv1gKzQYQF0Go9bcScA@mail.gmail.com>
Subject: Question about bool in __nvme_submit_sync_cmd
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_042532_047378_1573709A 
X-CRM114-Status: UNSURE (   7.85  )
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

Hi folks,

I noticed that in nvme/core/host.c, __nvme_submit_sync_cmd takes an
int parameter at_head. That's passed down to nvme_execute_rq, where
the parameter is declared as a bool (and looks like it has been since
that function was introduced in commit ae5e6886b4f8 ("nvme: use return
value from blk_execute_rq()").

Should the at_head parameter of __nvme_submit_sync_cmd (and I guess
nvme_submit_sync_cmd) be changed to a bool, or is there a reason to
keep it as int?

Thanks,

Nicky


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A94FC3ABDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awf475v5L8HDJn+JWb3kNXX4Vy1fIT4q517NqJ8iR48=; b=ARKYF48zgnlcdNJRlcHc2faW+M
	f8YeB8xh3yjjzbZa5I/NvdBdy/YxLdIP0vVxjRz5/bPJELKhrvs04amfGXNxDYC87NYTnVJ7s7DkS
	RGHPEu5USBm6ovWfTq+6p8p7tQvnvYRFhei/CbsjfIuqCXZYEKoiE7VY+MPf4WLi/WTka1jrWdmNW
	cUVbyHfRzWu4V8OrO2xBvV8V9AzsbGDtp04Gl1KPTJnT8Gnsl3CzFcOF+weHRehbpqPD7fIqdHd30
	4DGBfpdYRdNdCS+6jk1PSoj6QVOtVyahvS93CnBKqLDlaF4XpFmSXWbHsDh6uOwT/c1HzG2jp8pmA
	k6TgXt9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGBO-0000000Ftj6-29Sf;
	Wed, 14 May 2025 17:46:18 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDm2-0000000FXJW-0qkV
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 15:11:59 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so6878442a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235517; x=1747840317; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awf475v5L8HDJn+JWb3kNXX4Vy1fIT4q517NqJ8iR48=;
        b=L8TxlcmIrFqgzpuKvHL0eVlhW3V/h5lmMQRvE15gn1dbjWyYFzq3myyfF+LfWQY7PG
         ByzWuPJ1eOkH3Do7oi/uh55HA6DZ7LFroRg40H3aHy6FLrTPGpfsaTgiwSq0xV5Xst2Q
         3dqWJ+gksb8K281QkqbqGgMxf3NWoD/RwHndcsPAyMyWdWTA4mMzGBuau9qhlRbhIFqw
         PJE4zcqScB4rQfQlSW3V8s0nPJfAuV3EqO+8JoUwwrjNV/xwwZY3bPGu7/QVOgdrru4t
         31Nl9QETg/KWyTETEAZSnGoHFM1Zr+sV1lfB6gSPLNJII3RhPb9UbfrhykJtNu1XOTvz
         URGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235517; x=1747840317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awf475v5L8HDJn+JWb3kNXX4Vy1fIT4q517NqJ8iR48=;
        b=OBAcmQ0ldraAuSW9FQJRYRjB39IyIYOlIpB7Web8af8Gq+WNqfUHm1+6N/J7emxaD4
         EQNuTqaZktMZzdsInSewAs/OeY+tpWdJu1cz70mVqoD33Lpf8Rs60NEs4Z0fipHqqMWs
         JxEYyhz3iMRKMhgdp0G32500XMjlU6NynwbwFg3sliSm9kRcgIJwCS8KxRA1Qj8xac59
         p9Rd0HI92qCoXkj9WAaLHDAG313X91Yw9pNQfY0bkTC98mOLzzueP8/oeMcB7E6UrQ0/
         Hww1Prmvs9g9hVOmHjxEDsbzaCObhVci400HolSEUZkz29rS+TbbJY320Ql/lOY/Umeu
         X3tw==
X-Forwarded-Encrypted: i=1; AJvYcCWSmalWMKVG+2mZZ7x9uids7fxex/p/Moh1049q2BWmk0HmE+9sgRhTdsokdmYGSj+uyfrXDrjATMOl@lists.infradead.org
X-Gm-Message-State: AOJu0YyDWjCDEkpWVqrnyRUNlsY+i8Ypsggdd7okix42cK9O4wZAijfZ
	u7iEBCphwDfx5ev7Gan1TIfMcM1bPH8Dm8EvOeZk3a0soFlCmJVBEMJOWleN/2AE1owhxmv8lB3
	+fhhoc6Pvc+4GpHeiqpD72bowIvw=
X-Gm-Gg: ASbGnctnpERrp2ekDgLCNQvy3lKkaEFgNItB4JQMZjSWAKfEGMnBW++TjQhMEVxGoRp
	UYQ6zIMm7Ud2kdFTvhevcdCk/ZV73W+9hqipCkQmqOCJ95vHgYYitACIdvrV5AOO0DOLdRolcR0
	hCybQoGNrv4i5OlPvoMWvGAStCSCXHKLQ=
X-Google-Smtp-Source: AGHT+IG09TEsTWXm1xnxST1ljuBFVosFHHQsrHWlF8haqR/5NQMLQklS/TRLbG5xiTpv0w8YGq39f69m/tRRiR/LxVY=
X-Received: by 2002:a17:90b:5305:b0:30e:3834:4be6 with SMTP id
 98e67ed59e1d1-30e38344ce3mr3376184a91.3.1747235517195; Wed, 14 May 2025
 08:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250510102130.14710-1-amfernusus@gmail.com> <20250514053802.GA24939@lst.de>
 <CAMraO6-rQsf8T_ocOKbe3yMP+91W=AF6WtRUYVPtNuq43H8qXA@mail.gmail.com> <20250514140738.GA26520@lst.de>
In-Reply-To: <20250514140738.GA26520@lst.de>
From: Ilya Guterman <iliyagutermann@gmail.com>
Date: Thu, 15 May 2025 00:11:21 +0900
X-Gm-Features: AX0GCFuehCtDeRr6vYqnTbOU63IUI5mPaX291tiTRon8_twT5BtCmqjqyV97H2A
Message-ID: <CAMraO6-JdHa-LzNns3TJn7-bzM5LHjB9byovP1q4y9=yt-xigQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 025e:f1ac
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_081158_246370_D1F52DC4 
X-CRM114-Status: UNSURE (   7.16  )
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

my bad, I was sure I added the Signed-off-by tag.
I will submit a new version of the patch.


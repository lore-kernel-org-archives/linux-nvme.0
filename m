Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482ECC55162
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bi6lOmObqnHsSGvL2ycdl2ttKzAx9SMM13LKYT3eU/s=; b=BK3wpLa/TMa6Tb/V4iJxpIynH3
	ByvR+kNLRdCrDDuIXc2KRlJX7dk7jfCs041VaT2myfHgFiMDbo2U2Yc7AMxw5BpidR6TflmjeOZLm
	chYnC2xfeqJMOuRt0mWRm3awPnxURABRRvcQT/sqjbnNVOyGSO4a6A7ALvQVFn97bZ6o0VI4/v3Mr
	LsehYt+sQyPt2+uF+A7diHDKTQpCRg3CqYKL2A5JDf08eAyadTo4y8gAtY9tidcSzRFhmJrrm1+Hn
	SwGpC7OnI94IfCtlewbMwzRCLBeJGdlYdErqU/JkvfgKO9Rlh6O0gF0SdOE58qYxU9QYOSB2pBYtV
	98d+PJAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqaTH-0000000Fuqn-1LnU;
	Sun, 02 Aug 2026 17:59:35 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqaTF-0000000FuqU-1E0N
	for linux-nvme@lists.infradead.org;
	Sun, 02 Aug 2026 17:59:34 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cc891373e0so27030015ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2026 10:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785693572; x=1786298372;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bi6lOmObqnHsSGvL2ycdl2ttKzAx9SMM13LKYT3eU/s=;
        b=I/nZH4xUex3/wxr6cCvQWBdVb0Bl/eE4tQaCz5iQQtBzTgQLwJJco8hdTf554nGdLr
         tUnlsAOss+5QaHvdkEkLArcLxyvCDjpuo7RTlXEWvpsC9g8L7tWDz8EjsuKAjoH1XGe2
         AKZroDOEthiH7pVCMixHmfPp20hS8ToLfOAmzWBLFaCyarxTOwChe1HX/ueM314WkEpF
         4grbCumGxeq4Ic84HSKhX66kRuEs2L30vm7zBm44/r2vJX0dkspF3eBFNs+g2sRhUitM
         hjY9feOWqtDVBLB7ecK9Mh5uJFNa7RpvaT46pD5jeAz0vRy3KbEa987AffX5vohvpk3j
         ZPxA==
X-Forwarded-Encrypted: i=1; AHgh+RrZM3DttaoCg4gB7/LEGjq52zym2WUVoQSu9ZMN9vMOQzNv/JUjAvGcaoKrIKpGM66dol3aAg+t+3Pj@lists.infradead.org
X-Gm-Message-State: AOJu0YySYuOhhxC6aPCTBCMVesDaZToI04blKhdohqeMj/njuQKdmAg3
	zrK3mY3+2xSU/1+XpF2RaNxs4DzzcxWifNJifUECvHod6v1NWhi96HYW
X-Gm-Gg: AR+sD115hdNCWFRLM/q1tm8Ti4es99jjiUNKIw2SivM/eppNnGghiw4jGE69kt/tlUp
	7Zkv/BZHttmTV6Ih8rNttswfMtqemBp+WxG8jt4/KEfUjdwMTyu7UIb39igKvH+J9UMkFYB8VTk
	a3it7lGEDuCSASnbZ2FG858HX3DanUxyvsGdi/DKZKZd4IQG8ndN6dsyqie8LpOIhG0z7SUIEAf
	aKYq2rrikcJ4yXsXtrCs4DvaNLJkzH5vlOx/aYkZDK47eRe0U1Wau6thC19Qu8X4l8ZJdo8F7Fh
	C5cbJP2FdUBYTFbnSJOgEftjIeqgMihj9/qwQcDlonavrPYY49KxwyTicdEBVv/PCbgwrjT9Atw
	ZYrb9WZBvgNbgKbszSqloqeeXC8Fioa8XK7pOr5srut2vlkMCmdJ9akJExo2uZB0O0ISlQBYhzz
	h/bXEwuO9L7tLmfBoNlE2TCPxUNZMb2KRG3peajxssIwSvQ/omGq864FryhsnfXsbALZPgVBLlm
	jSAJF95zUCOEsre9SnrxU87lmEeatZTcFb2vSe3eT+emy51ll9Mk9Jt8RJh8tyf60Dk5SQ+9SwI
	KgzAALD5ljLp
X-Received: by 2002:a05:6a21:1b84:b0:3c3:8298:da0c with SMTP id adf61e73a8af0-3c92a83b3bamr6975458637.41.1785693571953;
        Sun, 02 Aug 2026 10:59:31 -0700 (PDT)
Received: from dancol.org (dancol.org. [2600:3c01:e000:3d8::1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm36442193c88.9.2026.08.02.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
	s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From;
	bh=Bi6lOmObqnHsSGvL2ycdl2ttKzAx9SMM13LKYT3eU/s=; b=aCSQ3fzGqeCA1Pg27elV2eFOIC
	YlSjMLtBxBHCc+Pd0IH2OOTKzatZuxP1ctbIhkAEn9vv0olNjHMAtBnekXhmecD79UkoUqar77O2b
	9pm+gpI6yQRQj4VCXWLA0h2Jl3kp+q4D20ETXQvFhiKsBhFsC//MPS5mUb9kyQVMDO9QdvC15en5E
	bL8HECewdAY3qlBpwImyB/C+KPT7Xyp8SgrKSm9sYs/oikIu9SSTWAi0GGpi4aX3RvvgLttrjJaNe
	kYk956XJQA+SrDs+EVNh9JQW/f0xnHUgboSgwqiWrTJYecjSbBFvCEqu3gAWaFxktCY63eaAKB4EZ
	9kDbjZQA==;
Received: from 2603-900b-c400-2854-d938-4dd8-f86c-c30e.inf6.spectrum.com ([2603:900b:c400:2854:d938:4dd8:f86c:c30e]:52092 helo=localhost)
	by dancol.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <dancol@dancol.org>)
	id 1wqaTC-00000001Wyy-0tsK;
	Sun, 02 Aug 2026 13:59:30 -0400
From: Daniel Colascione <dancol@dancol.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Sagi
 Grimberg <sagi@grimberg.me>,  linux-nvme@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
In-Reply-To: <87qzl6k3bx.fsf@dancol.org>
References: <20260713203443.322748-1-dancol@dancol.org>
	<alVQCljd3a0dRRPw@kbusch-mbp> <87qzl6k3bx.fsf@dancol.org>
User-Agent: mu4e 1.14.1; emacs 31.0.50
Date: Sun, 02 Aug 2026 13:59:28 -0400
Message-ID: <87ldaoh08v.fsf@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260802_105933_348605_626E99B3 
X-CRM114-Status: UNSURE (   8.71  )
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

Daniel Colascione <dancol@dancol.org> writes:
> I mostly care about having *some* knob to turn this off. Right now, it's
> unconditional. I'm happy with either opt-in or opt-out, although I have
> a weak preference for the former.

Ping. Is there anything I should be addressing in the patch? Thanks


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7083CD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlwYUIzVf2KyTA9JuYOr1b3GyW4OWR0EftqUqAkH08M=; b=fujOLMxxEWTLg8a6ykgxgnGMZU
	by3fIp4ssiTOC5ezJ4wkfRi8o5RPcGPD6hDibBxpeqND9bwUzkAZxORUwdJ38vg6Clj8vwykDMatS
	ipRM8DyiMNr9/EgmVleKMfyJT45QWd4DV8rBP0ihfHobGxZRlHEJR094SSiyiexz9YoX67uZJR1Hn
	UhFGwFNuMb1J9F2IbtQ57y/btcVtb3yXBTCBsI1ByA7fzpRr0l10XY2us8lIiRDGbWspKGb0i/Q8Y
	ZbSvhI/F7vp13HWihBprPKxqH/PLJeCN8XGp8GxGAm98Daqp1Lh7p1IhsY5SJH5kh6IKpxK1KS1vB
	QQMeF0Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmR-00000004xFS-1PJO;
	Thu, 28 May 2026 01:43:27 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmP-00000004xEm-0lYD
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:43:26 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36b900f350fso118401a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779932604; x=1780537404; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlwYUIzVf2KyTA9JuYOr1b3GyW4OWR0EftqUqAkH08M=;
        b=IE63a3EerxnUxpVqUnIzMD9ekc/FiZTjaJ2YO3ymatgRS64FtEMfxZXU+iM+4ygH9I
         MCDpSOxjrfc4CTZsTPR72bdBR2JltckUc2QdMRRqPMPobn5gFdzdV7cX12mrUMtnfHnw
         WsG7mztJRpCDiSiFvLMaxmQf+0Ne9uRhx2/6HmoZsLpEYdL98/+m+Ot4HCWKnwziKIII
         mm5og/Swi2Tryv9HtFEejgPP8ZO2fJYufmYts5JYghxokWOu3d5m4LiUGttEp23VfkpJ
         gGMaNcs3t6/R2PElsuPyz9tjQjpIw1wuveTU5N3tkwNJnNS7IdYIVQUXxewR6IYyrl0r
         s8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932604; x=1780537404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlwYUIzVf2KyTA9JuYOr1b3GyW4OWR0EftqUqAkH08M=;
        b=UOx71arsqZAK9h4OD3jdr7TxYSQf/eWLr2IA4Yn1AsmTLdFrSni0hUVJE7dqlnRchs
         a/Fn5tfpfp5TuNBvoBrXl5snZLM55hrkmFST6JZNsy4+QW2g98exT9JA8S+N2R5CzUgp
         tzIXqjSM2OuzxRy24q65MVKhyrz9pOgFVEJ94LjIqwockL0f1/9MBnpkS01lJ+dCkjVX
         I/UKQdwZ2yVvvkdaTNmDL+nTAUy1s68QI04/nbmriPl5bxVfmsx9hUnnMBRenOl7RgwZ
         tQTG45sdlzEh+04R/Xco3TI3SK4zRmBm5O2gk2RNPtOkb+L33U/Lm4N32+1vM7i2gFdh
         b46g==
X-Gm-Message-State: AOJu0Yy1HyOQ8bkeZPTHarYGOuoFw6PgyvhqJwthydHGiYIP5kKrrCtt
	62pVKUe/+DJdEwF4O4evKMC3eitA17tApz0UNtkdsg0DRdkerHjEC3hGmHtVR9GCb8g=
X-Gm-Gg: Acq92OHcnCQMi0fZewAWS/t6eA8HO/7lX+Gmp9UOqth8XI1uthDZ3PH4S36lG7NvgdZ
	d0ywyqlH++M6C1HFqr7iW7hrPWDjTnXDz7AtJUIrCfbnJUDItaUgY5eeIRFbLOcNhPyPOz+Cy3z
	5QtHCaceyrYTdEJDuWCAkNl3Qs6WarZPgpIw4ERtr/HgPDRqWiY9qJhyrCYKQrB5xpVokI/3RSv
	Vl3JVRjbejrnswIAY74rCG4xKcqIGAIJqTMzR40q+6K3fko00Cf6gPLLx542W60A2HnXkfiVRL/
	0Vo1ak6hFAiaKe6g0RsJ2yjXB7nDDsj5sY2yFwiezvyDBpz5f34j1h0pD405gjBKGDe2zc+N+PX
	fxs6EjN9Thoae9N3H3NlSCtj61MJKpJdlMWxBTCUc8FTd7xm2wPg9D1AdDg7s3Z7Uqva1NKMJv0
	zXwf7UzRnuxs/0OL+uuV5MeJ3g5Xwd2c61YmE2iEs=
X-Received: by 2002:a17:90b:6d0:b0:36a:d51d:42ef with SMTP id 98e67ed59e1d1-36ad51d470bmr14328195a91.13.1779932604013;
        Wed, 27 May 2026 18:43:24 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908e4013sm214003a91.1.2026.05.27.18.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 18:43:23 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v3 0/2] nvme: fix FDP configuration log parsing
Date: Thu, 28 May 2026 09:01:00 +0800
Message-ID: <cover.1779930057.git.gliuxen@gmail.com>
In-Reply-To: <20260527133205.GA12042@lst.de>
References: <20260527133205.GA12042@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_184325_224908_87AD7044 
X-CRM114-Status: UNSURE (   7.36  )
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

Hi Christoph, Keith, Nitesh,

Thanks for the reviews on v2.

v3 splits the series as Christoph suggested:
  1/2 - fdpcidx bounds check (>= instead of >), with Fixes tag
  2/2 - validate descriptor sizes while walking the log

1/2 also applies Keith's suggestion to use >= while keeping n = NUMFDPC + 1.
Uses a 12-character Fixes commit id per Christoph's feedback, and includes
Nitesh's Reviewed-by tags on both patches.

## Test plan
- Build: make M=drivers/nvme -j12 (linux-next, verified)

- QEMU (fdp-lab, tested as one patch before this split): linux-next 7.1-rc4,
  QEMU 8.2 nvme-subsys,fdp=on; fdpcidx=1 / NUMFDPC 0 - unfixed: invalid
  descriptor list; fixed: FDP index:1 out of range:1.  v3 splits commits only;
  no functional change, no re-test.

Thanks,
liuxixin



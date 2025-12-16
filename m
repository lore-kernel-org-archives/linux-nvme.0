Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D6D5B87E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Csv85txO/WpjrD43gTeeYhKwut3NypkbnF9Pjh1y96Q=; b=pBIf4thlCW8iEYLMuTPiKgAQMW
	FEbpG46RieKtN3TXmkQ/z/ZSMUS2lDrhX9Lfd/YD03PnzL+S4WPQLu7Zrw4knoRxZte5Jc+TCWfBA
	T1mKTLJr7VmQzNbeUYpC/rHcbP1mSacDjwjebRbZzCWi+eFXRkVtCwBlqAEbtTL0DKQqA/qoDzkU8
	wprGdadNeJXc+kuCpTEiWjx+9upkPSxA1UzTn/ms8nxn0660GYc3PJDvmAqibEZuEFJ7RFgekWGmc
	BJ9MiYp2B5N9Irpx2OgkCnBwLLdsjC2xUesT++QTebs6bPeQOpHwJyYgTfz/JDSzijz6zMkc6qVzQ
	8/yjCNwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVK6S-00000004VU7-2ZuG;
	Tue, 16 Dec 2025 01:43:52 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVK6P-00000004VT3-3UvW
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 01:43:51 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-93f5667f944so2613271241.2
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 17:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765849428; x=1766454228; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Csv85txO/WpjrD43gTeeYhKwut3NypkbnF9Pjh1y96Q=;
        b=V5yaIt+aNKEj3mqBssmN3e7RBIBETlMaHQ0Zz4vvbb8G7jt5ETAXr4oCkZfIPpLem0
         /xa/hxMGt+WIkPCWpfwq06k//dCW7v/rfdGyN4TxNWP4sH8CIw+NUHCF01Jp+HfrLdym
         5KtFaL3inabAKqOeRjqi8Jaitjs/zjCQThexHr6/m7ezhem1AV/JeqLp8J3rpBioywpA
         Ml6ptidjEJ1sil19mJbQkAtmItCIYFC8wKOCyTOFaG6PN1N3yDy6rT0d1r5SusLSpsLo
         AAzWmEJyZn0Hc++ZyUTeulbOnARQzRv+HOlCDpSJnsLdcLtdhU5zq6xe5bee5/Hz/QkY
         opwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849428; x=1766454228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Csv85txO/WpjrD43gTeeYhKwut3NypkbnF9Pjh1y96Q=;
        b=Ebvk7Jfbm4d1721Bje3a3WqJqKDjUDRP6xplLF/9VbjM2oVMi4pSJHh7uGDtaPXu77
         Eehoewyo5QBMLgZFDaGa3zFoPPy67VlC50BuQph6HMz2tNgKIsMHfAd5e/sFC//FgjqO
         Z6pSmStHeBq6/uPW4PY5Zcd3hFtseVdO915CsNV9jXhnqeEw2k4p0q8oNGt63t5QlV1y
         QWVuFe0SfZoyksQ4hzgRmYNZKs1nrTySydj1Ei7t4I+roWDwLTqF1A/BZ7r6rENMSrp8
         OUqhrcyd5fpdoZ2/CK+MEbEF65zOaBgEtFIvKUw0Id01YJbkRDUj9nn3u2LGqJDVGO4O
         Jizg==
X-Forwarded-Encrypted: i=1; AJvYcCWOzuZIZxdoVw8DhqTWO8hoBaTmEBNwWFGGHf7s2gC+7hMBpbVR1m5xIePLRdE1fHkiHCHd3ymzH4ty@lists.infradead.org
X-Gm-Message-State: AOJu0YyDUKA4vaAtHq8OpjBQtCyHdN8iJKKqEqyOJ2XfhUnLvxt2cj9j
	r1bA1169LMb/Jxk8rngCw6Ckd1fDDmmZJEAgLia01qI1NfYPqK1xRr0xoCBfLHkE1YWKmcjV5Hq
	QBjQtqO6AK/2TTA7+SPkedY1YP5Y6yRG5+wDriAxQeA==
X-Gm-Gg: AY/fxX4ZqUs0/FMHLSHbRr6G28WGGiJBBV1pkAeP51VSmz1kOcebbu31qT5WHDJ5TmQ
	8pHxtvTytnyosIzRiU7gj1ov/PT0aXh9zaJ7WJbqe+gL8M8D94v4a0J9g3ouuPql1KQ4h7yKUDH
	lWevho1LGlzYKT22Re+S74D9XoG039bOzd65Wb6VwzXKbDttDH7p6gUqN2t7GyV+92ZsgR+Gj1m
	CvKK4Vr77PphXUTWu5TlHmNqx+CrkYBiy19xOI01faHUgAb7ITmhCgJwJm+wayazDuco+w=
X-Google-Smtp-Source: AGHT+IEHxYNWH5iNKns4Qk0ucWFyU7r07c/qWY+1QV7aR9fYhS0AdOHFEXYIN6ctQP4pTFOD5AUrgdjhjhePe0EgkjA=
X-Received: by 2002:a05:6102:1621:b0:5df:b57a:ad2c with SMTP id
 ada2fe7eead31-5e8276fb2a8mr4542965137.19.1765849427987; Mon, 15 Dec 2025
 17:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-3-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-3-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 15 Dec 2025 17:43:36 -0800
X-Gm-Features: AQt7F2r1ipRlbp9VRsifoaYJ7hBtFhnd1P-nuigxscWUZ-31USKhsZkQotB0a-o
Message-ID: <CAPpK+O1-BGFMobGAcjUU9U9=aaBwC+PLJUD3J1LdEx44cuGaTA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/14] nvmet/debugfs: Add ctrl uniquifier and random values
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_174349_899832_269F6AF7 
X-CRM114-Status: UNSURE (   7.19  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Export ctrl->random and ctrl->uniquifier as debugfs files under
> controller debugfs directory.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>


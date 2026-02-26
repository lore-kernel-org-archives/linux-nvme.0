Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0470CFD4606
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYeiddlSt/e97JeTDQU/H53HrO7Irao8ocaMB2ZBK5s=; b=b+Wol1eLarBe7I7aazORxS/2zD
	oSPlKix/iRPxMCAM723XzKT4Q7FD43777hH0tWFHMs/QfO0mz8Pyqnws6g4lsKI4NtY8sr1Kcz2uq
	g3WIXHE4l/b780Rxj/88wLnNsfJQCyMib7yXCjONQw3LQKbDdB8tW0rQNiW9mzYKCNIYwBZBr2KG4
	1ZbVPQ9uR46p9GlhVr4QuD82Y3xVbxLtFilQ8x5yJ+Bd692M7ImT2H7fpcLi9qNmj+rASEAdDiaDc
	D5H5bWb/V4QUKMU464wNj7V0Yyj21olJ5F24qwLlGSmRxpRwwkWfF6PK87R4Pi5tkPsYxvsPehe+Z
	tAMoEGCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvRGL-00000005G5C-2cqd;
	Thu, 26 Feb 2026 02:38:01 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvRGH-00000005G4o-1rap
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 02:37:59 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-5ff125cba0fso56839137.2
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 18:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772073476; cv=none;
        d=google.com; s=arc-20240605;
        b=WuoGTRDFhiUCHIzUI7xuhd1WAXbvzdgoUvmItH0GlYLqMaPfjrEtR7PSALp4LIKALN
         xxR4oUzwUzPpRUpQyRfH3Ar1cxEqwlPv4BxjSDUJDaR/kQAtigc47g/v0dtGrmuamEFv
         Vcuz9mYylM8xR8Dhbv9EjGJKAS/s83Lev5pJAlbn5YaG3LATVmy3eQS9caxkA9z1yvUU
         za3Kn2rzvZ7SfAkdTzcJxmdfbWfp9RKefnimZEPZxH8c1UyOthZZMVNpESmHrb/+Yspt
         IJbWD0L18cBW9Wb7U7+dxQkk3BW+vT0arb4WtUbhktb0Gi7KNsnkVimZ9P+VU3lwSxVc
         7Y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZYeiddlSt/e97JeTDQU/H53HrO7Irao8ocaMB2ZBK5s=;
        fh=UzXUaG+f3ywR3HZcEIE33eyjAcyeiWzFd+NG2hDN7Yw=;
        b=DbrhzWKLmdpHl4rTObgs4BkYiCbcU2uHhyz7C9Bo66nDyYUWKnnfBrOMNKLSFVSZAn
         Ahlp88/S0wkjxngpHHW7fVAQAYp/O0heSuAJUyTSpjboRo4KQHLYJWcd1SSIKiNwyzaG
         5MxqlmfabRqSLe82u7Dm4JFXPEFpUJJzGpjuOUEEdAohQEDPbi9dQDDPKW7X8mq7NtKP
         yAXLQjaZO/QL77/SA9bEL7UDj9IrIi7sfXeqDqaBzhCEEc04KKQYDCOjwQJaipRO46YW
         YOqioGmnNgNZ5iBvzXYgE/5nZAcVMeXrQLxFdE2dOztTiEjBauY8Lny3pVj4DOYKveS1
         VOew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772073476; x=1772678276; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYeiddlSt/e97JeTDQU/H53HrO7Irao8ocaMB2ZBK5s=;
        b=P9pHT1p7DChicTjYNJo8H8HOHWvuYCmZGjAG0XJ4b8vrofIXgRorFT8Dqa1Y2So8Ag
         6Ah2SR/JMqcPwVUljjVF2e1EBsWFd72CgbB/U/s1b8GjIXlQG2fF/7BBH78jl45Vn1RY
         tyizaAJY9jyRhn0aNBXcO28HDFKuZ7ahq5ygd7b10PyfmVQqQ6lInm1VRi3PCyplH38Q
         izeKlHRwrh1nNwgTkbbi2XZONxIy16XdFsIma6i+nRkac+XEw22mnud9nQ0CCCqVT6Js
         dbUhmWrCvhqXCUu/kcwBKKpAqp9DN4MOFP3FfyhKeMmHIId8j1645jZ2xkg1rq04cHKS
         ZxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073476; x=1772678276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYeiddlSt/e97JeTDQU/H53HrO7Irao8ocaMB2ZBK5s=;
        b=obCKdxjBBb3j62qb2lzJoSDoiaVXsPz7nCoZDw8KLRYWalMHw1nx/LUu3YP+pztjtL
         b0veekBUaWyZ0Ed9bXguauFHcgltU/mJTICC2gEm+NvdTwCoz03AUQ6Iu2sdpi6dHSsG
         1y6ci5MLVxCtqvfjCCsj/OJfcsf0AAUHlTMcYK2vrb/P1/+YYq40GwjFrZx0gVicpim8
         De5tEKnKhkMBSWJFSUaBXY/+3L7WFTidhC/Gz0GOot1G3Q9R0nEDROhQJEwYvKnWRrGa
         YU77IGi4McrLXJOFvR7t+24AN3z+mKbuxATuGfgskWK//JA/hbOPDjcOv3wKADzmo1pD
         g2lg==
X-Forwarded-Encrypted: i=1; AJvYcCWrpXn0B3FSfCoQN5uKVziAnCofJ84SyEzQnIfNKv+BDExFGE436SuFeKFTqhsEWoxnN16EHYbp7t+0@lists.infradead.org
X-Gm-Message-State: AOJu0YwMErovfe3+JhJJ6Fh8ESZTA0uhoISodpLkgQUpaNg/r70LqVug
	rDDOi9NvbVyEq5u7rB1q/Q1uUQv88j0OQCwxxMC6Gx0FDWCAshSC6dTPmrpju/ZcjiAaOEhRonG
	4iTlIPSWLcQ4OtaGi9J/nhwnIMUhfU2wIvIE0xNJmzA==
X-Gm-Gg: ATEYQzxRcdEAZRguZfO94hiSuv384kRwxyKvS3tkFHlXz7jpuT88Ty1XY5slwpmE823
	cP6Vtv/fueTfnGMJihDQT73aKKncPxRABY2oMJWcMxB0RVNw8BG07oQW8ZbGVBNA33grlH0VvrL
	B0rT4+WzmkNIxS9KoBFyuTKBKYT1CMu7jXNkpd9Cps0lcpKHihFQfTPm7/mpvARL1Goqy8QpOW3
	NyXbhnZGMPYAmHkkzHNnLazKXzvlFyZ5BBzUl8haBdLeTQyAxk23MYB4yjHJsldykFHmjJy9aP8
	ra3sOw++svMNZKld4i/RJ0zhD63tPTDenlWypmQ7HOh/GHJuifjwc5CDcANLWwwws8d9Fw==
X-Received: by 2002:a05:6102:c8c:b0:5fd:f509:c97 with SMTP id
 ada2fe7eead31-5ff13eed831mr1186869137.18.1772073476251; Wed, 25 Feb 2026
 18:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com> <20260214042753.4073668-9-mkhalfella@purestorage.com>
In-Reply-To: <20260214042753.4073668-9-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Wed, 25 Feb 2026 18:37:44 -0800
X-Gm-Features: AaiRm51cvr7V4SAhOA_Hp9PQOxrfj-PirQEyjxYmDuwtDT4YlF3Ohlnv7XsJMSM
Message-ID: <CAPpK+O3wwqOM0B8AzmHXTkVYV_8_X4NKwpw3GiGaRO7e313FDw@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart833426@gmail.com>, Hannes Reinecke <hare@suse.de>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_183757_661307_07E140A5 
X-CRM114-Status: GOOD (  15.93  )
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

On Fri, Feb 13, 2026 at 8:28=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> A host that has more than one path connecting to an nvme subsystem
> typically has an nvme controller associated with every path. This is
> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> path should not be retried immediately on another path because this
> could lead to data corruption as described in TP4129. TP8028 defines
> cross-controller reset mechanism that can be used by host to terminate
> IOs on the failed path using one of the remaining healthy paths. Only
> after IOs are terminated, or long enough time passes as defined by
> TP4129, inflight IOs should be retried on another path. Implement core
> cross-controller reset shared logic to be used by the transports.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl=
 *ictrl)
> +       if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +               ret =3D -ETIMEDOUT;
> +               goto out;
> +       }
The more I look at this, the less I can ignore that this tmo should be
capped by deadline - now..

> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +       deadline =3D now + msecs_to_jiffies(timeout);
> +       while (time_before(now, deadline)) {
...
> +               ret =3D nvme_issue_wait_ccr(sctrl, ictrl);
...
> +       }
Sincerely,
Randy Jennings


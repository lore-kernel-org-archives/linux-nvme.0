Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BFEB5949
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUVJMEGd+ndqgjLhdaKxF6UlKEP6l5ar6KN8jzueCzk=; b=sFvqbkdxKJ5GqNfkwRBM4iLb1F
	ds/f7PxJ6eGj+QpQd9iLfuYXBZWm9jUd2VZzTeyKav/w4D8OmJ+vzGBvUKp+oUKiyGJfejYflIvsy
	O5SdAKq11Yy+PDkxyDUzkwwNIDVUX6VTQR1vKESZRtsXLUBgqKvGs8+zY/d5GdPaov2gkySiOf8sz
	yYSd8/PX0tMywlEIZ31ZIgbP9J4PqycL8aTQZFDarKZ861n8hJoQ25EGD5G0+kQM8f00sLF6DeiAy
	RB+vFjRbBpDSxDOJ0odas/BVe+UViAg49M1qs1jligEEX0IY/XKO1XjIrOKie7yKNipq/WQVi6JCi
	sATEr2jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzMb-0000000067S-49MO;
	Wed, 11 Feb 2026 01:49:57 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzMW-00000000671-0Ku2
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:49:53 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-5f178c83a3dso1356232137.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 17:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770774591; cv=none;
        d=google.com; s=arc-20240605;
        b=Ej9dax2EfmDkZPNWOD0qPLyTbYi0YRRCUIXn0I0LpkDuqEqyvZ9yw14IVoMuv6pu46
         aQ3/QZL09TBkqO/bJSxKx+pZmgh12HoXAccH+5XcqJFZ24n7BY/HOrHsoT6DxACNJK/t
         Jf0/Ci9XW+6oTIxG4ajvAE55LS4NXMau3CHWhNckOPBdcPXEB1WLN2pcO/AW6lJ55yf/
         mQs2d2TYduV3F8zgGr2dnA0BsrcQyjTiGB/DKuxf5OWCHS/lBcC5ZM9WVxphVPmNR9zM
         0gf3zZPMg3HzmyTPBPMt9KEgMSeRrT+hDJ82AQf9xjpkvcgpEXRncwvzUdit5tqvH8fk
         WLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUVJMEGd+ndqgjLhdaKxF6UlKEP6l5ar6KN8jzueCzk=;
        fh=AyheCuWESVG86OzCKg05bnclA5abYEMx+CXMiiyW4sU=;
        b=Zcpf27Yj1QzqnoccSC02q7BehI6QLvr3HKzUe+D8QvcQgOVahy214FauBz+yxEgT0+
         x4X8lRW9dOqg/3k9g7uTb9VPZM4700V9FIS2zdfEoXABoiV/IaXaFS2Dsg4NsG/CMqjh
         A6/TrSkSWBmCOu9KHnC3kqmdeWwtR/g4WbBjfgxCfTKtdZEN5DNVmZtPL+zlpMZuoU6J
         8gcVqmsvWEEsr59DL/50PokcKmcAwBkjsJA90/ZIAtQH3AvWwDQ5/Bt32Rir2YttCUvt
         fawqOuBYWigVXhMkURXkdwnLtM/l0nmaWMLqx3Mo9TzwU7hmmj6QrjynIg0EX2uMJDEH
         rxHg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770774591; x=1771379391; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUVJMEGd+ndqgjLhdaKxF6UlKEP6l5ar6KN8jzueCzk=;
        b=SsHncvHcF7bzQvhzYSXP7gGXorUu+uLom5SJedDzkQJc+ks8p4M7ptpPuLd2TulXbJ
         EPdSlp5sItNqhphdLbk0yz7BYy+RhGC7foXkU3LXPK21mk4wpJurwUoW0ILzbl5/v45H
         Of36dhHmerRdFH1oyzVvegxnQWRCJ0PM0l/+SOthFFubz35i12oDhTWDhJlHEcLLe3Y/
         iwxjM3GUirzHfSLriMvy0HWhekoxngGRvjpzwFK+xqxWknZdcPBlRYJh/awf+fEeCaB2
         fb9lrPI+nXUwGiRsTZYElZ+NyF0qENhl6HysckhcSSK/OmDeDeaeg31rgCWvUQK+zblQ
         EMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774591; x=1771379391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUVJMEGd+ndqgjLhdaKxF6UlKEP6l5ar6KN8jzueCzk=;
        b=Y9uYdyGMeCYjDELZ3NHFxLFrPby7xj4+Z5w2qUZklNwdKHiEavZf/XTiVa7ZEBBuzD
         YG7Cg9+6549dDxZeNSqAz2FhYTCVgn/xMNxuvpEIq7iKmGrMA3ju2+p9btBoBbbXoiiI
         +prIKxlhFnsV0DptStVuFP1/N5vCbQdMCCC549Rg/eX/TI2/p4B64fnp4TBUwNlah0Vx
         xfiSIROczT6f3CMMb5Dn1VSYPW9NMYd6Gnx4wTCdYO9CrAXRbaXsMLsCdTrv0ynkS1RN
         DKMPSPob/pP9XwBaEdk9jN0owzY93IuOvwk0P1knQL67Uv+5jq2YGlqZ0C1BPvizU23B
         ZMNw==
X-Forwarded-Encrypted: i=1; AJvYcCVYgM1MawDVZ2x5YR1uITB6jwhRKkTV20WzsSzxxAibMwWcyl4quMMhZyLeqZHJ60qnrDi+/xCYzDEM@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3/ViuJ+2SeGcx7VkAAtXcDIvm4dbhRse4nJCZjQOWf/U4K6BU
	vEYuHT2Ojz8C4nC6hlnQC6DkWNnt5k+KJS78BhXyiolINCzGN3FGkfblKKu9SIGGH26sbJ9v6l9
	Rl0UaRbeCGmaAcfj+oBxSE7nyKKp49bGAue6e+aUc8kvR6DEZLV2ICeqN4w==
X-Gm-Gg: AZuq6aIGlEQlY2cIjopNdE8ZwrrsrdOwA+uJQ/POtHIhLn3kvHn4usQVW4XjCq+PGMt
	le7GAHXiJgGyOtyd1HlVILyGkIPttrxodpUYkGGwn5f16CH1S+1MdYWVGCYeCftsLgTP1YzLTBe
	sMsvHGaS4oaMXWJQWmsaPRAgkrFL08Uc8av0ARXaLBE6HqrDPJ00Lo/6qUA2A8Z8nnAwYI1F2T1
	Vy6ss3EdWGXC7nhY45JW20peGigxrkLs64PkIUKcKRzUGJXK5cNdyu+M+nu9quxOkZ+7y2Wgd+b
	4HO45yI=
X-Received: by 2002:a05:6102:3f0c:b0:5f8:e2d0:4b24 with SMTP id
 ada2fe7eead31-5fde4179728mr290577137.3.1770774590624; Tue, 10 Feb 2026
 17:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com> <20260130223531.2478849-5-mkhalfella@purestorage.com>
In-Reply-To: <20260130223531.2478849-5-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 17:49:39 -0800
X-Gm-Features: AZwV_QhcHWjG8wLq71SRI7cj5vUfZq2rIU72zT0FP59mvCMMlnpbDQ9RHAmI9fU
Message-ID: <CAPpK+O2MRLj+KjukiENPkzkHJHosuQ1xa1qy9apV0-=NXHPguA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] nvmet: Implement CCR logpage
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_174952_252358_C8422CF1 
X-CRM114-Status: UNSURE (   7.69  )
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

On Fri, Jan 30, 2026 at 2:36=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) log page contains an entry for each CCR request submitted to
> source controller. Implement CCR logpage for nvme linux target.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13E9CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mO/rZtlxzjgTdfRb7BP9Glz+fz7pLgDy8NW7+JtTTFY=; b=upCrYoNttL5nj1a/tZuU3o4w3S
	xEb5xxwERbDhtgx47W0kRDwH0ojeMAuCTBxa8h06sQ8UUyiOiwyJKfuZxc1/0nakaWvTmWq5fonxG
	DA9WTrJwi9nAIrMcOeVxyODnvq4oTQ6vc3gehUeY4V1IoT/zOWSJQX3Fz3I0Ya2wEpjY395Vrj0RC
	N8itH7D1T3UuvfKPpS2rNfmLC+0cPz+4bmMJ4eGNwHSZWaHh0cL+24xhq75C45EOigp/XvRD5bxa1
	ZmdTyJ7W/lsDR/Jjg2xB666+zZxPjxbss4IQd5/fR2csxki/GUHTdZKzWx2F/E54rd+r+2HG56/g6
	mLFCnIPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNiLW-000000077lh-4AiU;
	Fri, 15 May 2026 02:32:14 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNiLV-000000077l8-0Zj2
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:32:14 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-631333ee9e4so2540634137.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778812332; cv=none;
        d=google.com; s=arc-20240605;
        b=UwZM9PjwCF2mQKa28v8aZ8+40xu5bB8f78D7P1wwMok0rVKtO0H4cT3aXjz2IHP089
         W8jhNSc29NtyOCiFkxSOIRZcFx+Y70TIU43+hevBwSkYH8PBOy3OoMIpvOlZt6VmbSUL
         UM9UVtDAwl3A+9ZPWFIASnNF3EuPJXOiIKdrSyKhKotgKqXCU9pL/9GjMK8cOOjcQBTO
         ToUwLUHVAQ654Y5WsdaK1f+6bSowyrJtE3R5fXUlXqeoHNRCK5V9I2hdDiF7+XHoouxw
         aI6VLQTVC2xi/xMYltFMnrR730xgtfCEChhVItkQg5AIfUTOGadpqyVR5DUpkSvNUp3W
         2ejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mO/rZtlxzjgTdfRb7BP9Glz+fz7pLgDy8NW7+JtTTFY=;
        fh=641X4nFSmiLeDs6+aEM266lQLvXLDnNd3mZ9TO3QkVg=;
        b=IOEWmdZAZ4gW6lBWU5BnfCAdmCzJEpHRB78l5JErjZbKSm+lnTgUKsIkA1iSiRlBVB
         JYmSJOYyM5lj+uBcBU3ZYBd5XGbIZLSGOkX5lkUnLf8OzZwp6gYIE8lTjqAl0EyddRdR
         xYzLknHC95Kj4pcvzu8kzNG9sphyPVYWR/SABcwWBb+m9apHay9JpaxyK9gOghedhZzT
         diWJQrJXVQZaYwqW0ZuRzhlG0iGKdxOeevmGKa2pH1avoElzrnAedxQj8149eI5cCTfN
         xj0Fhw/8CYHjxUr0KLgQHUFG0VBWRVp5K84w48XBjMY1MKtMXSuYWeJJr5jAEk0BQhNu
         V6eQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778812332; x=1779417132; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO/rZtlxzjgTdfRb7BP9Glz+fz7pLgDy8NW7+JtTTFY=;
        b=VX24gO4+r70G65dJrp5ZsBi9qimL8BUmabkRlsdJmNhc3WIy0EqNjGogo6j8zCtg5D
         w2dEAL+lPB6HUVxgx1zWp3ZoFGcQfvqdg1TGvM8SlnTQQmYWLUJ+HUZE1p18w8CPPl/4
         z1e1Uzx2IyF9DvAjcGHxXGlQ89xXp//a/ZvE4T03TLY0Y0/q+7TqDkpH7ovZgmT9wM4P
         +kvJobyzN9pX1uPb9psqM/U78dMRNCgFmSMRmikptQplfYl1Pih//9jUIl/aSrFzt/dZ
         6j+YIlffOS1hUXI9Kx9r45acJYdv3jjT3V1ecnWi8xud7gglSWgoOkNuCsVN3E4syO/6
         csoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812332; x=1779417132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mO/rZtlxzjgTdfRb7BP9Glz+fz7pLgDy8NW7+JtTTFY=;
        b=o9aM+Wuj0Z23r5Ohp+nTYRCPKMtpNlXcatNXwnqD7KuY2vfMPdghVw6Yh2ELZO8XE4
         MRVkBQxTnvfExF2ouuLPMjMPaXVBzKzUtxLwCOqme5sdC44U0RyLpOmXFRImVHJ/yyNS
         LjkxClTco8QfnMvlhNnv4YnXIH2Um9qsx5gB7Mc8dnknqOru8AY/BCQn5TOl4vE34NuZ
         ThNydzqYq9W2UewOTvPwHEulxDQS2BMDSiLdAgCqwwEWYH30/hQRVNTOwi76h8z8Jcbi
         aLIXM2tSZTo0uUrvSDfD9ld+eJBJOuWCTJTGX0tA8wc8YH8gIovYmVeuRLCiDQRriBA6
         /vVA==
X-Forwarded-Encrypted: i=1; AFNElJ+GITa0NuEefmcjXIScb7tUkFtey9TdmaCzVuIRARxBsdyoJ7cZiHGChEcoG2cf1wBeqZpJ+vQs+ruf@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/lCPLIp8ARabgEotHu5F/uswpapnrk+ooUPDDLJ8aeOvqKBZZ
	5C6+OEiXE0tZi523U18BUzpK1hiRkFRH/h+f7b1YnLgPmYEoo2sJJq2nBlKAIfHaX0JHW51cFlC
	ErJtu+GHSFdqq+AvCMVNmakuqQhRCNGBWbs4pCGeNVQ==
X-Gm-Gg: Acq92OEtdxpbAuZJ9DYFYNIUK/fXkImwXIuXzJUG6NTbaoAVOUWnjOt01roNja/JVHk
	qwgm6nYHhH/BCOvmfwzREavM/IaG/pjHEMx6OI/4kj26nsSjcK1sEa3vi8AvM45UJuF3VMujYRP
	piXQgekipZBW2BiduW5r23kMogjhCj3jak41QkRJpBUqZJLgO8FFtS9EZXUCa7akOrADJXQGCyP
	SIHaDE0z7MNC1uV3LtcsnWFnR1ORic/HU2pOqiZdIPMczNakVDrKmwTJ9ZODgDGV8SZ9dsJHLLI
	1KM1vwA56pwxg2rWcVJzBikMtdvt5BW/N/8OKT7MVkcup4TpXT32YRi6wIg0UEiElxIsmQ==
X-Received: by 2002:a05:6102:3588:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-63a3d019168mr970300137.1.1778812331802; Thu, 14 May 2026
 19:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-9-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-9-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:32:00 -0700
X-Gm-Features: AVHnY4KWJbvbePO-wmJFvDwpVaCf13kORjMvPiUC4jvMMGHgSsx7T-JPk4blN3s
Message-ID: <CAPpK+O3eb86NAGUwgMMK3GuziN9EmNeM8VEXZn_5C7cwZXe40Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_193213_187342_5747A23A 
X-CRM114-Status: GOOD (  14.44  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
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

> +       now =3D jiffies;
> +       if (time_before(now, deadline))
> +               tmo =3D min_t(unsigned long,
> +                           secs_to_jiffies(ictrl->kato), deadline - now)=
;
At LSF last week, we talked about skipping logic here and just using
the rest of the time (deadline - now).

The arguments for shortening the time were dubious, so simpler logic
seemed better.

> +
> +       if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +               ret =3D -ETIMEDOUT;
> +               goto out;
> +       }

Sincerely,
Randy Jennings


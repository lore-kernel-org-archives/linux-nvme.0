Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEECDF433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySqAqUSM04VBMU/BCwRL8JvwWCwHHEszaCkijjEEauA=; b=HPH8P/tH+VZ9EgneGLN6v805xD
	HMs6cqWkGxX1oZiUe2jpaAg+m521ts16G1UWh7ZAvv1UJTQLATQHTt2jrA97YGPqAVdtrOqCewoc1
	AFa7DIhPO4wHIvPbREUlVWQa4+2k+MvcmZ6+PrNG4CdJ5pAW+AjER+3OVbb5ApCzchLWI6QKeNqmU
	YwuYbh+CTd+unYK6GyLDjDyzhs+h/yn2jbrK4qb3rND+cuEz3wkxHrO+NZwqeSMMLBbtStjlpkAn3
	0Z1XzP0u2bXlJmo5wny8zZ9DjNqy4mtQl1Eh1SlGtMDzzNSzVLWGsVxUZ+zACaslLsuCseBpVUwQ7
	K3iabIWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDFEi-0000000202q-33ut;
	Thu, 16 Apr 2026 05:25:56 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDFEg-0000000202D-1JG3
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:25:55 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b9382e59c0eso1335529466b.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 22:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776317152; cv=none;
        d=google.com; s=arc-20240605;
        b=hKyoUrCpaydTmx3tomWzypGHkygWygzN8mPyKr59aJWEvGUgeNvIF6XhRA1Ri6a4ez
         7ZchJfhOW/IEET4V+HmztLRPrLhpdt7uJuyTfH7MmtJIAc9vhq89ImCPRFsfrzIRxPvf
         m0Eaq534AfWwK0eC4uCqLlTJVLmC78IGvU3qpo+5lBS5KqMXBXLgem0sWN1GL8r7fHvY
         N1yqJ+y+aXFxWRIBznq+d1GEvCMrHVdUpdDTo2DniA6h6tjDVmr3FaJFBc0EmFcNJ9H6
         x3nSMZcyf4Y9QbwnSe0EJfPCqgEqorby7SwVeyb6RWmT1io7CbzMaA9xTRIkrih7wit6
         bjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySqAqUSM04VBMU/BCwRL8JvwWCwHHEszaCkijjEEauA=;
        fh=k2PxJQxENcWz/0bwhTO271T2emBhXcUiHDBEkDq8Ol4=;
        b=h/noVWTYfJdgdfvkC62focn2HtIhXxB+gvZju2T6IdAC5ObA6uF5d63+PrS0Xn2qMP
         Bf5BLcdHojCpYZfTsrQ/BzZeJgweX/2afJqF1ej0Zbh+DHJYdKvxzt5P7qQ93GdDnpOs
         jP85yK6Qdrr+RiHcxERo/C1acZD6EK0+jhEEMcRwlj8UDvu8Kcb/dL2IBOtStg6LAPk0
         xK22N5AOjSurzCJXgfvDJOtpYfJjjj3DKX4DMSxDO9VcstX7ztS6mLY/9Ego2gvQM2xX
         OfCgEf+nbJF+HaiL5GEF4VpLaYPU79gijATpZoX2j5X3Z2mTRyEMEkp7g91xwI4teHIg
         x9pA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776317152; x=1776921952; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySqAqUSM04VBMU/BCwRL8JvwWCwHHEszaCkijjEEauA=;
        b=V7kDVvEpmORHX+yPYAhouDYSaRSiJq4xdzShavmv+tLxygKE+u6+yYmq81FOl/thN6
         lDaP+Gk7A+3RTNSktwJhHW3gZ8UzDZ42B0mBffbGKbFJiiuldeCHM1dKxSop3WSY9fnZ
         G3TTPzdzrWiSmJpdS+l+N/A5vBXKMerypvjUx4vRCptalkrpo839P0AP39RKY3njqtEb
         VSonO0fdBSWtgl+PkoWkbQO3/yVK3v7H7ukMspo1ZpFWnVYomB2oQkSbaXu8nT7nm4y1
         fY6gkhoLG76jJ0kT4e2Mn/ktjMjuSxlztft/UQQW6LFTZsoNP63v3odKv1atpaXD14BS
         2HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776317152; x=1776921952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySqAqUSM04VBMU/BCwRL8JvwWCwHHEszaCkijjEEauA=;
        b=j2T3N0+mm4q6ZrKXqC5+xQuwZknhvLjhlu7aLb7r7SBvGb6qa6MEl7n1VVKqdWtE6P
         pvJqr0dUSrnUWn3541vbaABnOVDGP77RJsQ7sGyd/33fMSCcKZZrkI5B6FeMypZabfYo
         G5YgOlctjXsGtst0ReEyWe3avdtcAbZXrmaVxvNu9ael5DpLXLlg7Mp4+duR3RATRbUX
         RnjMngbKu6a7Lp6HFvnxBQZr44BwchKQPIAAI8tUCRg6eMlq4Id/5pJZy5tnKxs4rs36
         TMHXiq7/cakpBI9IotggXqeJf3AOqB5RqdXBNmSG7d2gXtKKMZCYmDoCwUzxZOKjcaOO
         1FAg==
X-Forwarded-Encrypted: i=1; AFNElJ9XVpmV/tn+n7K9+3r0X/WOUkZNQZMwsSECVUL9EDlk3mhih/0zPjBAc4+15rQnF3Abt94Lx/+RA8H1@lists.infradead.org
X-Gm-Message-State: AOJu0YxtlLpQzg19x+a70u2OObCGn/HWC/QGiBvUxRRVsPbBB35jzGk3
	nUhsi+VOxOgma9SQqQpUVRgbfC93dJOIRcMQUzstP3TKeDzFLuK/lRBQNafhjIpBQL54a5BzYJ6
	ZXBPOIZPj4B3+8wq+upv6QMCw/ji9asc=
X-Gm-Gg: AeBDievXXOy+15bw7Iic6DZxX6k/ZriHqv7zKxXHgdvjbkKkEyiq5Bzi8GPwK0C/TEp
	RUeglzdEHcUj5eSMKyua5uYDDjwu8pvOquc6BSkr8Z8vSI3Y7SkLPce9iosRfFrTpywFr+ttFky
	dZf1XyaST6tOs3csFhdAqko7VeeeMiFdl2UzOU3AJHPQN+6J8xKLOaPSWYtwjsNY8WRl3Ua5u/I
	nkS3d7uvreP6klGfVXZEfon9QgpND4vqixXdiIjkTFtO520xutF5I8tkhuuOzHVS8FNI4FXPgAw
	lUA7pp2C5kM+XwstwEXKMVnjECTCZrDkbva4SQ==
X-Received: by 2002:a17:907:8e16:b0:b9d:6cef:95fc with SMTP id
 a640c23a62f3a-b9d7267e295mr1386245266b.35.1776317152196; Wed, 15 Apr 2026
 22:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260415230824.2790058-1-alistair.francis@wdc.com> <20260416051627.GC14802@lst.de>
In-Reply-To: <20260416051627.GC14802@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 15:25:25 +1000
X-Gm-Features: AQROBzAOhVcYDr1UVP1LOTgShqnMVOreG7T0v-dnm_GJj8D1qpu9My2SAWEyh6g
Message-ID: <CAKmqyKON1MoOU-MQNK8EEVwVWmSJZ9OmxH2M_mmYTadmcbVyTw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_222554_368780_C4E9FDE2 
X-CRM114-Status: GOOD (  13.58  )
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

On Thu, Apr 16, 2026 at 3:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> > included in the Response Value (RVAL) hash and SC_C should be included.
> > Currently we are hardcoding 0 instead of using the correct SC_C value.
> >
> > Update the host and target code to use the SC_C when calculating the
> > RVAL instead of using 0.
>
> This looks correct.  But I guess this breaks existing implementations
> in the wild now?

It would break an implementation that is using non zero sc_c and
updates one of the Linux target or Linux host but not the other.

Note that similar changes have been made recently to "HostHost" and
didn't seem to break everything

7e091add9c43 nvme-auth: update sc_c in host response
159de7a825ae nvmet-auth: update sc_c in target host hash calculation

Alistair


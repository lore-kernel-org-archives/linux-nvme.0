Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD49CCFA05
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=; b=OcSJOs302jgV7v0Ft5JWNk03jL
	hEYXxFb6rVN78ld37wWRuhrELyUVYPC17G/V0aoRDW8fouMYlGeSJAJW486W6sGEytQeGmQnDOdV6
	3TxFq2uNK+PqGA03i3tYbkNUTQQxuhomSiPn8Set2sYF3R1BVGhuvLAs5iflH0Wq2eK+ou9I4ao+s
	zGpthtcmNDdh6GTRPedwe6zbBoJE/ZvyefbNi1ENpiskgYB95SH7us0BUhUGj2BbheFIjl1l7XKT4
	vVMYKkbaXaTN/PJ3XJg6Hf/qKFkm/+VcV0fPcqZ3FuKf1B/KhaU2LJNWuF2mmL3zdkMXUUQXxlQK8
	2M283KDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHNyH-0000000HYoo-0QJ6;
	Fri, 07 Nov 2025 15:01:49 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHNyA-0000000HYoN-0oK9
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 15:01:48 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo741837b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Nov 2025 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762527701; x=1763132501; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=;
        b=cbEvdR/TgzcTx2qFDjNzKjm/1I6W9gr0pHoN0IvObLNVTVeqjbIHiIRFBZiOozPoyc
         XBGJBB8ulgC+JvgkO1kaMeJKETzUx9helP/CTq+/33w3TdbcR1HRyHUjIO+pyACIZdes
         FD4OFiZ3G1DEcVWQL22zUjXGw/F5V0H2UQjQGmTCJWJMLnQz0plWPv+FrfQO91ZIfnaY
         cO8yzSG2yLWM7DUX2Y49weC1DnoSwnU13BgM6iS427Ry3y0J34YIIyHX2t74HuGzD8Jw
         rAVsiMPR3OTNoubeppSCWDDtcaI785nhfKDKrNpxzQJkNtea57oJklGi48RGjITCUEMu
         MLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762527701; x=1763132501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=;
        b=YMzFB+FlKBv75r2wEG5PekXiegl19472X4zOzy7vYd2Mf+hMkJMQyn+hhKEDiXMKGW
         KmDdYpo+qQ4YpKRZQy9DiBR+LrHo4ng8XLls9uA9Ux3X55xmyjsoOsYBgayW9t3vZZ+A
         e9bsRVNoGhsIyuJfTc7t64btaMl0yiOZQktP1MG9h7A3+fDly3Y6qVCoOWOb7kP8VsOr
         PN6okmUzwSeEom2L7pdMbFKAP1XifCPZeIyvXIPxab7dzyAAXlzUCaW4YJCTHlc0s0xV
         JF9r1Hgf93xABs5OwR8FtHf2Y1mO2bPnM57JiEQ+gpNPDy3WR4PglUDyWECV3auDHots
         g5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwhtS48VAJxTzVAH7lKKY1yPP8GaHC1+LP4Q0ak+lq4gQecfPnhDUn1hTgFQXR0mlyUsUe7n0y67N0@lists.infradead.org
X-Gm-Message-State: AOJu0YyVT8XczgwTOvRnqQzPZ6RbMKMxTqQtJFm0SxHTDrK8oWCNG25i
	zGqNCT9KqTmiTlLdaL/znE0fyk4qWGvt0Rintqj+64mTEczc6GzYs5bD
X-Gm-Gg: ASbGnctIl8c6NVDB0QaBGVAjaaxY82Wc+J5ceNcsS1IR1eAT38AJg5Qdq9GiDjtWRwH
	Ap2HgY8Lg0T9UQf/kX/auizJ4hkXP2udcHQbVPzJV2lz4dmBKVhwGnaSgKTof6mMZBs9kzP+DB5
	FO1UodxKOVRYrKykrf9wzyheueA2t0ks09d87/9W1zQcJNXzfjML60aK1Qm477EmrA9mDZZcB2j
	3OC0WjAmu4K5ancCJg5W+U5zh4yqI53qV76YyNV0zIGVQw5JbTR5Wa6RF9xRJOVDoZNi7PfhjUb
	Iaq/llp7TjLPXaZNkZw9QkzvuODbPb5dfrNTvS8jExYh0SOFNeF7kwFmFSjGP5sbTk0gHXybdZt
	/O7etQqYdmv05hx7oU8obZQR9emPz+Vls1haY2mnGIp6zc/lQf3wwcvsxzcScrxHY/sCmk93U1I
	/5qVCXPIe5Q1fdT9iuKkBmKcYjYK4=
X-Google-Smtp-Source: AGHT+IG88KPp78g2Bc2Y1K0gqv0viNMPATKjIaOzlWRHWeja33iSDiag+qbCUqfP9TmPF0GSPqj5cw==
X-Received: by 2002:a05:6a20:918e:b0:33e:6885:2bd4 with SMTP id adf61e73a8af0-3522a16e933mr5431340637.29.1762527700725;
        Fri, 07 Nov 2025 07:01:40 -0800 (PST)
Received: from 10.0.2.15 ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901959a47sm5408443a12.28.2025.11.07.07.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:01:39 -0800 (PST)
Message-ID: <214e350af7da3f870e1da306c9498f80f1e90c07.camel@gmail.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, 
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 07 Nov 2025 20:31:34 +0530
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_070142_235322_9019259E 
X-CRM114-Status: GOOD (  13.57  )
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

On Fri, 2025-11-07 at 09:17 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host
> response.
>=20
> This breaks secure concat connections with a Linux target as the
> target
> code wasn't updated at the same time. This patch fixes this by adding
> a
> new sc_c variable to the host hash calculations.
>=20
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> =C2=A0drivers/nvme/target/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> =C2=A0drivers/nvme/target/nvmet.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A03 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Martin George <marting@netapp.com>

-Martin


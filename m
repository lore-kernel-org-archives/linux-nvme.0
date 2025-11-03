Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B6ECCFA00
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 02:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMfJ5Y5GGur5h0c/aW8X7+pRDgjg9Cbc6huo+2E9Af0=; b=sBzQQiJOTkLq6Pv67x4KdcZpgK
	YoOMlqwwcW1mRN3wdpuX3WaSYJ3MQ+d9If/hIHB1Vw+FfIarQjy0saXEzZonvV+Kth+1ZLmufZ4vp
	9QxyUSH+lZPb+nxINQELcm97EvNOUjGJrAbQk0Hxi62Hmx9vGz4vE4e+rU7anOP26zmUFP7iAX4ta
	JOuLqzZy89toI4BsVSjZf3ORnkgp9CFITzy5+MWypAXTh/XhUd0/+m6jFoascxICSWctCDFlKR7Qa
	SXzVEw4T4Uj4PFbX/EHZHSjLUIcL3R4OQi+CGAbjtNfap8cuNd2KF2JWuuHuREOfK4LAZjbG0C3L9
	PJOsHKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkJ9-000000093wE-0pzY;
	Mon, 03 Nov 2025 02:28:35 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkJ6-000000093vo-08Sx
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 02:28:33 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-786583618d8so15412767b3.2
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762136911; x=1762741711; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMfJ5Y5GGur5h0c/aW8X7+pRDgjg9Cbc6huo+2E9Af0=;
        b=UmJXtY3NCBNojm6gZGuMFkxvc1EdwAQo7GsarmZCLnzn4sLNyHicOMFRd/w6ojZX+u
         ygZj9L5O64ARTg3fDhpcJ6LjunpcylaBw8+J1sHxVLNFNTWB6pO1fWuk0mREBK0itafs
         K1ZYKQWCdpePubcAu6Z/ZmS6DR8w4FgSI/VSWwuAYys+YG3ltwlfwdFCk3LaZGMa0ZQH
         d+BPwb8FFy5kyXW0+U0DXkEvzKPekOWuoC0B7Bir+CvtXe7Y/vovzQ7LusOMLxTq2W32
         rkppfGhxL3qZ086pxPjN42IUuCUiE4X3NoVjQPbNEbORIwJMOhQ37LiTbd0zsViGRhJ5
         DU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762136911; x=1762741711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMfJ5Y5GGur5h0c/aW8X7+pRDgjg9Cbc6huo+2E9Af0=;
        b=hK1+Tj8IUz58S360wEFzYDXsMBVNqXy5AO07ogA8OjnkZirYC5OzfpXx6hE7EsAax4
         Y3KaCRDV+ybjHuu3/BZ4S76NrHjZWMNRfOKj3HsqJ+CY3AB//GFt2k2dpx38dAVnBR7Y
         fhRkeFzZcP3xwCfty3HM3oSrAjFWTUfhRZBjzpQbsawqLXOrACos1IfSB5G9SVsedWPi
         2sFUa680t3NUlCo7jBMogt/JqNnvogQfTLBRCtsEPDe/jXR3xhipKgq1tj9tbG0lhWEB
         qQ/rWGWtfatjhTgB80rFAnLNBlBuDOaPq/r1iPefSuc89TioYGWF6y6kZnHkQTc+pUdP
         8D9g==
X-Forwarded-Encrypted: i=1; AJvYcCXRi4dHqb3U5iNDSmcZa0u/zP8Qyc4zi6dzAwnAdRYjiNfx/du52Tr0k7vNYUwAcO0dWScVmOKvVaUC@lists.infradead.org
X-Gm-Message-State: AOJu0YxPWFz7k8jVMe7bS5IqtEtP2bA1KrU6BH74yINjvo2TUvCJr4As
	uBv2e8sz6RNz0/5YHoq9JhYzo5k/4KdZ9+XF4NGztYNaql9MIAP8vZqHE7bPNqE3/n9ezq9LB5X
	QN9zLBSNYX2yNNqST8o1L3tFVR0tSpec=
X-Gm-Gg: ASbGncv1tOK4+8Rg3TsT6zVWpNxSZkGMXFK/lDP7N742Vnu9PdCy7SaEiZgxqY/F9o9
	O9af++vqg4isgNjRG7/+6oelx1zpeLmeqxdLHdEDU1i6NKxTJjBhIvbtrzbbTKGZSCWSpa/JQs0
	lqkCIJx1h2iUa+SJh0BQbNnHa97GaR4zA9bAOE8EVuULzUYeIuiGxqI+iEFbq/PfemJ2Uv90DUU
	SRVAyG4d3ioFarokhbMgejXhXzeQe9rMjQ7S4V3lh2Z52lOD72eBTi8i9njWQ08Uoe03D/fvdWN
	0GgOjqFlrSfE4Pk=
X-Google-Smtp-Source: AGHT+IHLrHOzvNAokMB1WbxB3gJAY2GfR94UQgKc5aQuYuGXPTzrOGeNvX8ZsL33JxhJZTCgkZ3zL0L7/ZwqDEsTyqc=
X-Received: by 2002:a05:690c:3606:b0:786:59d3:49cc with SMTP id
 00721157ae682-78659d36afdmr72041127b3.7.1762136910786; Sun, 02 Nov 2025
 18:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
 <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de> <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
 <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
In-Reply-To: <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 12:28:03 +1000
X-Gm-Features: AWmQ_bm0033VA11fAAliIqWqNlgaySqgCy5jRslUcbH5deTIdxZpTm8NuB4pXQU
Message-ID: <CAKmqyKN=XmcsAh2M_ocpbZAWKf5OuK0YvTLE_0hb1QpMhw+pqQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_182832_096994_471CE04C 
X-CRM114-Status: GOOD (  22.40  )
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

On Wed, Oct 29, 2025 at 9:33=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/29/25 12:20, Alistair Francis wrote:
> > On Wed, Oct 29, 2025 at 6:10=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/29/25 05:53, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> >>> the sc_c variable to the dhchap queue context structure which is
> >>> appropriately set during negotiate and then used in the host response=
.
> >>>
> >>> This breaks secure concat connections with a Linux target as the targ=
et
> >>> code wasn't updated at the same time. This patch fixes this by adding=
 a
> >>> new sc_c variable to the host hash calculations.
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>>    drivers/nvme/host/auth.c               | 1 +
> >>>    drivers/nvme/target/auth.c             | 3 ++-
> >>>    drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >>>    drivers/nvme/target/nvmet.h            | 1 +
> >>>    4 files changed, 5 insertions(+), 1 deletion(-)
> >>>
> >> I've already send a similar patch for this, which actually should
> >> already have been merged.
> >> Can you check if that works for you?
> >
> > I checked master when I sent this and there was nothing applied. Is it
> > in a different tree?
> >
>
> https://lore.kernel.org/linux-nvme/aPl4-6WQ940kUso7@kbusch-mbp/T/#t

Thanks.

Your patch is now in master, but doesn't fix the issue for me. I still
get failures with a secure concat connection.

My patch (rebased on top of yours) fixes the issue for me

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich


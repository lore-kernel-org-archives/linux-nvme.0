Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E83CD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrCOgX7t8E1TyR8SUTHdSMeurjlULeElh7oOT9ORge8=; b=LWb3LNB1zc9kkc4S6IMa2RGIi/
	VXr0J+s7fXZFQyQTXlfgxMMkelmbOJy8qhIOCm0+qLYOVf9B2xgDoeu6TtidxDGK5Pu/Sw3hrY/ah
	kJj4shdxxd6SrZcfE9bSVw+T0CFODadUJZb/Jm7UQEyC3FnLuBnJsuoskNJB9vCK9EAdYSxus0+8L
	G8qOii+oaPLGjvMLw85gqineW9lfIuFLNqOpC0krK6b+9iB47XY6GbI0yT8y5Y1S7ldSPEUVdivYg
	u3T/YVBDxuAR6QRDse12VP0inSIOmNSilTRoDdN3NtKCRQs0EMTPSoq3KA2juxvoxH4gFF1J6hx4h
	4ORvU37g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRsDe-000000026gH-48r1;
	Tue, 26 May 2026 13:53:18 +0000
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRsDb-000000026fb-1mPU
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 13:53:16 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-651bf695701so10257550d50.2
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 06:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779803594; cv=none;
        d=google.com; s=arc-20240605;
        b=aux2YRFuc9jMYYTJidPZJGpwRzwh6cdVzR0EDUaL2Wd+RcoI/HRbfOSHBCmfeuoxIs
         D0pIF1yRuvEI0qYfCK+ljuwrHNlvcTFyxN22SAg9FoyxQBvxvqOmtCwgdOprUTKltvTY
         Dd+3DSRuE7bVVkzSZkqnQ9nVJVZ2bdEBGXfgURzeRONMckzcn+7TiI6Of3/ZHZC0Q1E9
         aP1kDFqhCcrvckYmBK8O/UD5UOtamnLV+XZbcUFSEChRtrCguZ4D/9LPwTXdl7Q6kLYX
         cNVoduToGp5iJkB+1D3OzjIW1mlLADJ+3JGXS2Z66f9z6P39bbsvnOjRrhcLJH6uE/Dr
         8V1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrCOgX7t8E1TyR8SUTHdSMeurjlULeElh7oOT9ORge8=;
        fh=UPwApUZNA5O0I7HfwHkXsEjVMrI+39A9aToz+JqfR3A=;
        b=cAbFp5uN5SU5RJJe4y8jaM71rUbxXdTKw5MyB0gtr9dIZhMUpQOgkhzpFlDSDN8HSO
         K4JQW8k7NLbjYGSGwLnZhIirF7ouh+ljz6Oequg4HB45S+zi/KB/JoeB00o8jpJoaouS
         GYoFyOJUpT61VJozwe9kLMu9du+foUlnTwcjfpsGW3JumEw9pnV2oUFo0JXSb1ixcke0
         c9tBUq8QYzGflUa79C6rYjPY0q/mp3yKinaCa+1UXaVMDIkfXSibw9W5nDXH45/LURHk
         E9wnCD25ypHih7PzbZBUK8UeH73tw5gCN2wSPP5viDBsvXXmfQTH3IH+C+pfOs8yel7a
         9GFA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803594; x=1780408394; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrCOgX7t8E1TyR8SUTHdSMeurjlULeElh7oOT9ORge8=;
        b=fr3RYWSyMm6HVNGN4b5m0JbJzq/LZhPEZ4fbZCCkk6ZYkglYNsNUWdtoof3MPhQSzD
         LZsxjGx4zmsMWDGauYutXWT5x4kaLdGVR1gd0gfWpzKXm+ETrbBf5wIvz50KwNRD+wQr
         UV5mJdjt/6BDheV9EHLyIz95wMyBOICV6q6GT9GvSovCnbfFnsRx/MjsVwhAP+YUTlSg
         wvQ9Cxf11GJRYGDg0Oz8gNoL9+z4qU3Q+lYlbDB3ZBQDFffh4lLV1+WreZ7OhcCnj8id
         39O4jFQ20IpKY93PDyFtvEu2hlVagHlauOY1p5O986hSvBRiXPN1J84s458OtxSohkex
         45GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803594; x=1780408394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrCOgX7t8E1TyR8SUTHdSMeurjlULeElh7oOT9ORge8=;
        b=BpJkvNkFdmV1Qxv6zA4BlOPUwncJx6Yn5o3OEiigJyZ6mYCp+8+D8RNpVyec9xRGra
         iSKxW/VxAsK5MofaJmpkXa4RulGBcj4KRMKs1eK3EOU+hva7yf+lum/lCtXX5mlixhSp
         tnxVYMEuQE8wnXOKEq8jG5DeA56pceHliNnDkkRopOQXHDDbFc31f3Hq2efheJRnzzXO
         SOd2Siec98rAVJ4Gdk4/inQymwjckl8th+n1fJ3oAcaDC26vpG5IwIDDM7NEfO/x7y9L
         1VEfw3i8W+sqdRI/BKHklXVWvZuSXrv4vhCESpmte3xahvzi4i1RdaIjsblK76zm7DfJ
         R+Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/EEQR/D+e3uVdfmqjE3VO1AFsYoWVzqWD5/yirJqcJDBVak1qGZxvrM+B266t4tlGMCE3jh1YR8gvS@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/9+9LFlnP6+BIsFMwO+EiDGVUX90VHYykyz4D2t+Ld614PEd2
	fxqJc4F9BNyINsB2TFEh5KdPJPwuPwG21jOcbF9FCgX16JhleuVrUvMOOHbV8J1UF3y8JGl5Pvs
	1gZGadgwk5tCxH1BzZbTOnaq++Jbzs2Q7OA==
X-Gm-Gg: Acq92OFWUfkFzWK3h/757M9ZMBzBgPHq0xkzv9OW2UUZXI5QNcZnyoP5WwDjm1I27rQ
	FrT1GQEUq8C4gK6erE+tghdBI+Jj6ND/hYPE3YKX5whHrdL5qZtc0qRavtEfdITQyTAFcZLT8eg
	189e9xu2kMdby8ZW+9jnyd264vZZGTHf6ZNippEE4tCezBBE5lboHaLhkkWwuQlUwxSpcXVmcxs
	+HhNjbPrFZnfKq7DU+iSOkTkIAPW2NTYmtCzsXPLpYvAF/+CoZjDkb+rOO7XjNMIQDV8LF+dOUl
	IQRnTKiUvbnd78NZL7uOYAeE1iN/X6jkmFLI
X-Received: by 2002:a05:690e:1408:b0:65d:7ffc:bcdd with SMTP id
 956f58d0204a3-65ec97f970fmr17169583d50.25.1779803593937; Tue, 26 May 2026
 06:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260523114552.101452-1-michael.bommarito@gmail.com> <ahWkWI5yvuFj232G@kbusch-mbp>
In-Reply-To: <ahWkWI5yvuFj232G@kbusch-mbp>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 26 May 2026 09:53:02 -0400
X-Gm-Features: AVHnY4JFwHek0opkAYAQh6r2vt6e6CTxR9Vfry_J5z2siEendH81-ssqimem8KI
Message-ID: <CAJJ9bXwZE6_wUNwNPmmX2rRn_OopKHPdm+J_ZVH0gv8R2=EvEQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: log when APST skips a state due to latency cap
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_065315_470126_A8E43D4B 
X-CRM114-Status: GOOD (  14.24  )
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

On Tue, May 26, 2026 at 9:47=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
> The "_once" is not actually once for each controller; it's just once.
> Some people have found other similar debug prints to be confusing when
> they have multiple controllers since it looks like the seemingly
> problematic controller is not consistent across reboots.

Maybe it makes sense to move this back to print every time, but gate
it behind a boot-time parameter so it doesn't spam normal users?

My use case has been debugging bad suspend/hibernate/PM across
different laptops to figure out which device is bad or needs a quirk.
It would be easy enough to boot with verbose=3D1 or print_apst_skip=3D1 or
something like that, collect the details needed to fix the hw, then
reboot.

Thanks,
Mike


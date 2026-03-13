Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665C106FD84
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVuuAewx9KZP7XwHYXJgqDSlGK0w4bATAFLnwMOmfT8=; b=oQ7+fRFzYy6HiX7soqx7OLjkik
	teG92PEsCeXALVVEPz/nz5dPKkllSNyrA/db1A8VIiV4Pr1aPXTrv+XEyvBc24nddLv9P0WhOC6pS
	3Fgqh8BiosMbRs4RTvwcFhzbnyeMpUV/FePok9G30NNV2uPikUicbZrB7XxXEdpWvHhb4txEcvZD1
	qxnUVBMvmDI2XuHQRWmQiouZzvn653aks1a26Fe7Wi1zGbhc09NJ3RyLwxjrIoQnCT4kQGsQTyVRO
	+3itMB7lniVJiLFHqSDKKq2GC3xVJyryMvBaRnsC4tnTdjKYLoQi6I+JbeaQnX9raRPVu91WcgF+J
	ZD6VKxyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0vkh-0000000GnkB-1xEc;
	Fri, 13 Mar 2026 06:12:03 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0vke-0000000Gnhe-44S1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 06:12:02 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82995242934so1141591b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 23:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773382320; cv=none;
        d=google.com; s=arc-20240605;
        b=b/XFNmUpEioRNzu1rq4TlE8tR4bcaQO86cu9km52jltLEe/kAqBTsUfglAfyyb7BvE
         4+2qEqWmiE6ib5ATzfAuVh5Guo8/de2Ts6DEfe/eSWd2DZF+rWgm2j3Tkc1l4myj7IN2
         4AddwTkUkvoscq69b5vpOGOm8RAO79+Y0yfJx7Ijgdo9+ht+LKleXSCBNgZDXB6DtmR9
         uxTU3anitqvf+o/8gYmadBpcQLzBiWlfb9Ivvc+UAK/k0fD4dgZN1EYkjNmDXPI3FqV8
         W2T5Bq3h90nku7SHIbSbLSrwUiHRVK+GPjnEhyGsWUocfg6YyWtN3b+bTr3P1+G4TCfG
         pVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jVuuAewx9KZP7XwHYXJgqDSlGK0w4bATAFLnwMOmfT8=;
        fh=jFbNdGth7YkmL5umXbtIcaAvLtNYiMnubDD8odoYO/U=;
        b=TMeXIrkfkZP45QP3Q7aduvXrSttqr4Sut7dVpXkt5XtAIrJXyHbyfLbYKZmX84+bDA
         XEf2BkN/ih4grZvcYZKQ/4LR53afNHVD6Bz1NzXrAQNWO05WHO1gCe+WEhlmiOVwNTjh
         OgtHlRQlrlOQRl8gkTbv2sMd5ilX39xlCAxLKFKJzVlYD9iC92NEDw5GWlh5w3LGT7Wc
         yWgQ9llf6xi2hgEqG7ax3Di6JQL3hJ2B+bw9T+Q4qewIVb5CQcQGqY+eHD4xT3/idNMP
         RMH1N0XRBVjuHbXNM3qaeOECpGvCX+xEpkNvGNI6kh8PJ/IO5DE9tlQ4JC1JLoXjEklY
         wsEQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773382320; x=1773987120; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVuuAewx9KZP7XwHYXJgqDSlGK0w4bATAFLnwMOmfT8=;
        b=I05DKlhgRtsewYW2SH0lg39Hm5xXmvrg4/CaFpJFPpK/aAuKmFn5kMbgdoHyI83Ps2
         M8ZyJU6fAupXqve5c/MZQVip1qWl1fdndGm9gTg3iX3Tb1iCZUcjec/6RYozv/nKFkqM
         ++VutvkrU6eZx5Q8EiqGMAST7X5WpVxq0b6OkEUKpBWV/Fbp9UnSB9qJTMruVjwQYpQL
         NYRbEfqi9ZwZG6aRQKCp0dyMzugQ5+sSvaIM78a+wUKdODWRxAqk/FaWcvAWbi1+iyQ8
         dT4noXweG9lXnBFbM/ARxgc4Vg4/1iaQYNXK4MRR6W1dHfYTFhlVAVtt8u3N7j95w5CO
         FlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382320; x=1773987120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVuuAewx9KZP7XwHYXJgqDSlGK0w4bATAFLnwMOmfT8=;
        b=Al3veVg01mhYCsn4xBzP1x7VIYojGrc+E3np3oBr50VcNMN2o4deVDj28RELVQN7hd
         wutimcw55CFjWZAcN3Yqs4qWqZ9PTzEbGJ/gDKS0eKsZqiqy8AGkMYtwkR7WyaXgJpXe
         61xGtnyy0WkU2qKWqN5jVYeetZYG2J0VgccgDho/+/L4STen9vsjXigyM40ee+v27j4D
         gcNyOG+DFcx/vDh4FGK0yo9p2GGs/bhhsec52tho2dUGNSmDtHCVkxYlGt8yM7qiHMop
         GcLURet6DxoL9rhj/5fDoboLCme255CXjPDOg/vWEFywyYowEZAUEa17IX+wCuFpk/IB
         1mlg==
X-Forwarded-Encrypted: i=1; AJvYcCWE26YWGpssY1IXaPiN/3LmsRwkAuaaHoLK/k1aR5LKhWQMEUxGNEjFjKxAdfXCeU3//FOG+hFMGiMh@lists.infradead.org
X-Gm-Message-State: AOJu0YyqF4aRy+3ZSkV3j8CGj+cKxKSV4dh3mnqGCTYeEU9HI1TmA1nI
	vvz+KPiYfV1pgJWziKYHOLHFD76JKzeJuEagzIuHflznslUzIcm69/ncUfwV+3I75k1bO/6mE+i
	uSEStFPGEBt9cZlyKxNrMOOgsRdzI0RE=
X-Gm-Gg: ATEYQzwhnlNC3BwxYwi//adKLdfWpyWe91912FxnSxufGZyJ/xzOPDFjOXHvBFopOoe
	NXWHmZg/sUBFEeEFmbvPPIrniMzcJG3NKq3xpgMpD4eNs/E4UT0O31pGlCACkD5WkElXapJGbmN
	ivhXg5WnhWzfF6DNjZDCNiAbkIBZjVhfT1VQwaOc/iAK2mM3F+sfhRjvB2i5O2044W5B3iQxb++
	/nCnnsolIoNJAI93+aNzlxDm/b5WTHNNqpFUqmogjhx/KuaEtgyQ517wlUVUVGmpKsWGurXrvH8
	WhgyTF4O
X-Received: by 2002:a05:6a21:a510:b0:398:7796:7823 with SMTP id
 adf61e73a8af0-398eaf96390mr1965300637.6.1773382320105; Thu, 12 Mar 2026
 23:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260211160859.GA11869@lst.de> <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
 <20260310-video-foyer-58fbf3080e9b@redhat.com>
In-Reply-To: <20260310-video-foyer-58fbf3080e9b@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 13 Mar 2026 15:11:49 +0900
X-Gm-Features: AaiRm51ZWnDtHSe8TjxPJnLhc8LthMuL_IcQn3tjKh2bNKhD5FR5qrYb1OrgiyQ
Message-ID: <CAMX6_QFF-8-1ij2cMFsnbxHgprs=raQzfh=pyKUtmuZxV2DLQg@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG:
 KASAN: slab-out-of-bounds)
To: Chris Leech <cleech@redhat.com>
Cc: hch@lst.de, hare@suse.de, ioerts@kookmin.ac.kr, kbusch@kernel.org, 
	kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_231201_015875_2CE2E9B7 
X-CRM114-Status: GOOD (  10.01  )
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

On Wed, Mar 11, 2026 at 5:47=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
> Maybe this could have been struct_size(neg, auth_protocol, neg->napd)?
> But the target code also enforces napd =3D=3D 1, so it ends up being the =
same.
>
> Reviewed-by: Chris Leech <cleech@redhat.com>

I hardcoded 1 rather than using neg->napd since napd comes from the
wire =E2=80=94 if a malicious
host sends napd=3D0, struct_size() would only require the 8-byte header,
and the subsequent
access to auth_protocol[0] in nvmet_auth_negotiate() would still be
out of bounds. Since
the target enforces napd =3D=3D 1 anyway, the end result is the same as you=
 noted.

Thanks
Yunje Shin


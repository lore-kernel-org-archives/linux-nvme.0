Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BEFCDE00B
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=os7UHbYEIjx8lIUymbMlsmeLpHj2njmcDd/byxlYXwM=; b=gbniQF1CyWVZPOJun6zC+B7d2T
	nW5aBya1e/zC2no+kicHV0cxNINnPY60dRyznOOY1odpa0DyPTtHLyOfJ0dYb5ENSZIA7CUXeRIeA
	rpEfZT3oLZYq/N6N/TcQAK2dOKKQWzm6xqd2zD+UMC/LY83S1q8eWcvedv1cuAEjrUmr1x5OaND0b
	1ycYBHQu5H7idGWqGasA4Y/NFJ4RBR63nDK6YjIc273Kwa2HH+KtLJg01B98yOxG4yejqF6BIZd4x
	2LpFL78mPkldEflvk27rM2Buvp+ixM4d99wDgXuLpMq+w/fn8FjdmC06sZIVvHyNGfhiiYX8Rg8cS
	/6dTTtqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcr9P-00000009pYI-0XIT;
	Thu, 25 Jun 2026 20:58:19 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcr9M-00000009pXq-2fmo
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 20:58:18 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-519b63eff15so2457921cf.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2026 13:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782421095; cv=none;
        d=google.com; s=arc-20260327;
        b=ImRJWdetkSniq3imPjQ9IO3UapqDLSGiGrqapXFp/0g/bnjktIHepCm+39sTonnXpe
         eKosSGBaIUpmfnzgTiMYwaKg7qaQNOcBUt3JQv/G0CE9n4GBOZ+YiBIXfvV7Jv2vg7ET
         ULJ2q4to49qbDFPAaF6E3eFyofoUHJGxJ2qauEvpG4HQ4JMfopvateE1cuf1ogKVCcVt
         3o25JRawk00VpG26FVw5yxNMN6kP7ntylP3iwF8lTiDZg4PV5hJo1NFpuBGGfBh8SMT0
         qU4TaqBiBWXD3sZ/JSTZ9CSrkrtkfv/QaFn5EUdD4y9mIMcgc1UE4+zGDmvZ3XkH23iW
         nr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=os7UHbYEIjx8lIUymbMlsmeLpHj2njmcDd/byxlYXwM=;
        fh=XRvgkcSA/IPeEReVY2Ib5P4cWH/YF9I6dg0S1lt+9sQ=;
        b=q7nJvK0dsy+/326eNLODgspB4P+owje+ChCMzvuOt40zLcI9+lXFpAcWUeVW6FuagI
         9aOBUB1+lPwfYrW0kD+gt2D4gq2cm+NXyo6qXLdsy2kCVnfBBiPShxCZ+/6ujQRFplCS
         3CbVbGGcQcGnUoJbnf4w+fIX5DZELHUO1TVG2lzhaaRZR3ZkHgZ8DxikMoLQeDZoIv6d
         pIFiIM1hno5GXvhpJa9/1yiR9sZJ40+vQmEnypzwuq1M1+L6XgWajFz4TAWc6ftmKzkw
         6vCnRVdm2ypAkdg00Yb34ozfWjG+CXnd5vdVRvHYAahKVtxQscTwL8GVJqM3SaTV3Nme
         KhKQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782421095; x=1783025895; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7UHbYEIjx8lIUymbMlsmeLpHj2njmcDd/byxlYXwM=;
        b=JLKxZ95+T6pZM8bWJAbJTfBY5IH2z0hnqipxph+tJlTxT9ZhqEK1VMoO4gnWcnu/V2
         06wE2jR+Oy6O0oK9GgtT5ZbVQd2DNLHzqd4vDIkYD4Ko6jCVRw+c0/NOts6gSXGBsiOa
         aL2GaiEqcvsqTFq6UqlW2aEPgexhSU9/ICh7jyDLrm0PeBpv8ANdS5eqZPnGdooIDt6A
         do8ImLeqtHCqmc26qHE2GTD9jW4Ztlqg0k9U2iMoO6t9jXWXfbak20vE0tedgeLA0UVa
         RJ0PO3SYWA5VUVqql+KRk2K5nPiup/lZmGBesBgG/K+n3YsRKK1AINhbYODl2LAMRIXf
         r78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782421095; x=1783025895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os7UHbYEIjx8lIUymbMlsmeLpHj2njmcDd/byxlYXwM=;
        b=PDgGsnkIU3q6WmTaxfjsknkWOl0FmTSwAjwb0h7JWez5PbYXFEHDEOoXTphebnPHIc
         7hmIY6mIeGDvu5Q2YQqsQe+YkaaPWbUGzRy2v+fAGRBPvBvkPcp0Dmg5CjHJFapjjsIQ
         X09OtnxFdb80ghr0a/1AEA6kyIKE0YLuRgwlbOZNkbnWlveEWi++OS9vTkM8/HrMfTLM
         IJXiNVAJhaU44Bd8PYGYD6WHQ3NPiYDO9DuHRw0OsQYQlY3aLdDuMrH9anOw3yLO6eRC
         nexMKYy5ALGxK5DNwxhmYREYnZG2V7yu8Xz8hQrAGjArC6MwBVMeR8kdAtWZlh1QQeqa
         tvkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bXFgbEY5CNSgialIOv2GUUBwZQcALZl8WySCyAOJCtUrTS7cBnPUMrBt+jkUnn5p2L2E8126Pcwk/@lists.infradead.org
X-Gm-Message-State: AOJu0YywCTrZuu3O2jkCVrVxKTvjOMXWfAFNNoeaG80bPB060XKGvDnR
	bgriv9aTnqfHEV43CUGPg3yTwqCE/tIHj59lNmX4rb31lhCBc1bYqE7UF5XNz6o19ak4DMIq1vM
	gmNh/4BK/8VEx3NafTLPvfp7+sWI2JpWTwGVzWhbdkA==
X-Gm-Gg: AfdE7clDfOO3rcDpWx8xThO0vZnXNBRfxcw6JJit7aNwklWdk2uHGIlkvXXA8dYwMWx
	tFBcnKD3OW8hSoXJguVzx/JHwfUl+xL/Mr+w79QJRITJclLF5OJ6jAu+fqM6vkYgjivw9bK5kdA
	+WWhMX3NJyYOaGZKrUvagWEWn5cbVndK0q9rWGRbAFR7PpA1csb4i1i5ZrBO5Pib1FvpAiGeid3
	r0ganKUwDc2EkZKfML9aiImSvX7832Ddl62EAdo+mbp+Q3RY9ikiIJ6ilXgMWrxidrKccisivaH
	XCUd6XU=
X-Received: by 2002:a05:622a:4899:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-51a72ac8450mr63126541cf.52.1782421094724; Thu, 25 Jun 2026
 13:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604195321.2232838-1-sgogte@purestorage.com> <aihyhdXtMyn2_T7v@kbusch-mbp>
In-Reply-To: <aihyhdXtMyn2_T7v@kbusch-mbp>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Thu, 25 Jun 2026 13:57:38 -0700
X-Gm-Features: AVVi8CfImwR559K99segOz86jkCPHCBGkCjKx-r84hxuPyJF_B1tLhtXiFsHWMw
Message-ID: <CAMof9cWpjbAJvkY6fLSiLLS+uO_NYBAGZNGurA1qX6CMtXEOEg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-rdma: parallelize I/O queue allocation and startup
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_135816_866233_663131CF 
X-CRM114-Status: GOOD (  18.92  )
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

On Tue, Jun 9, 2026 at 1:07=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Thu, Jun 04, 2026 at 01:53:21PM -0600, Surabhi Gogte wrote:
> > Refactor nvme rdma I/O queue setup to use async API, combining
> > allocation and startup into a single parallel operation per queue. This
> > reduces connection and reconnection setup time when there are delays in
> > establishing connections, which is especially important for
> > high-core-count hosts.
>
> Mostly looks fine.
>

> > @@ -125,6 +126,7 @@ struct nvme_rdma_ctrl {
> >       struct nvme_ctrl        ctrl;
> >       bool                    use_inline_data;
> >       u32                     io_queues[HCTX_MAX_TYPES];
> > +     atomic_t                qsetup_err;
> >  };
>
> This new field serves only to propogate an error from a local context,
> so I don't want to introduce a new field for it at this scope. I prefer
> you declare a special context struct for it to use with the async usage:
>
Implemented in v3.

> struct nvme_rdma_setup_ctx {
>         struct nvme_rdma_queue  *queue;
>         int                     *err;
> };
>
> And then make that the cookie passed to the async setup. I don't think
> it needs to be atomic here either: we really don't care if we see the
> first or last error, so forcing a cmpxchg for the first one is a bit
> overkill; you can just do READ/WRITE_ONCE instead and accept the race.

Yeah, that works too. added it in v3.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA94C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOi+AOHNJVpf1Q8y2mLbVeBF5jk6tBfHA7+E1urWPVc=; b=zfPAIngXtk1488yISdXDQsjwO2
	VLxO5noqJc8iy01lHi16F6AsrIXlHAy7OUAO5+jFls2MLW9pwvdF6eE9ESuXGSmIIp31iNxK0lFwb
	qlV9mrOJc8XLtLOJMw0Xr5M3wkjiRdJD3bH4womrIeb0TpxBv446iyoljsZ9AnKuIO0pcp/BN5I/E
	zbE9yLjGLu9Fqm9ifooAYjDoLt/az8fiRCJkgleWB6xlBhNF+WMdSFeT/q4qC5M9jXPosKMKKcydD
	BE7JMO3khMDEx0yM+598IZ3hUok3AVdtmBPx9tzG2FjUj0AQ2KG6csxFRnRPcXhMN7dOJMmFX3VVs
	1xiOWQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0EQ-0000000Dnn7-0ARm;
	Wed, 14 May 2025 00:44:22 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0EM-0000000DnlP-3eJr
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 00:44:20 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-309e54e469cso1059665a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 17:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747183457; x=1747788257; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOi+AOHNJVpf1Q8y2mLbVeBF5jk6tBfHA7+E1urWPVc=;
        b=b/fE19gwCEcoJVxwJ9nMzUzfdTLpYgRReiBKSw7LrHarQu3xdMxDLavf8m+qN+wWmx
         RLy5jq65IrOH5bTkPUbgUW+BBDbF13S4Yk2Y4CS0OFXMUSPcOJH25DX954nT7lguILBE
         bdCW/5Od/bVp207tan4NjtaOqmh05VfXyx5BqRd9gTe9UAwj8V/6d0eGC/6eUHirFyPf
         CbSBapVo4SAWoW7FJ/MOg2As+u7F83p3bCO2fywY7Bx1WHNTuapbqzRAwJP51CP/arV8
         2eYxK5WsvaF/dM/XGVi5VWUzBJUQnPN45EasvUPUlIhMQ94NiRWs843Z9h/0lj4gIV3u
         ZIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747183457; x=1747788257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOi+AOHNJVpf1Q8y2mLbVeBF5jk6tBfHA7+E1urWPVc=;
        b=JUHCIYQy+dEeRoAtSGmHko9zVShTKe4LD0HB+cInNxBwkuFCUs8m1v/BoU11ub86C3
         3HkN7QeNELIYvABv56zbxkKPM6Y46/HSs1Xk+SZyrzGUcM0hmMniHmSWE4M6eWnD7PtS
         jEk+I+7ZJStN/OGprCCOyGv8Pj6fPco/E/st3lBVXgOEslIM0t28NzJriiyg1aXD1xpj
         PmNlKKmHjP/KUpxakeX3auB3vdU37HPRi2nllTZ5zfXCXytVCA/ylL58kmp9UnOI/blt
         ZlmTr9fVRklts6HTH/CMv1/Gr+K/dP+yvfc1HrKam3rqN/a5zpqipagFPo8sJczN3ESP
         Vn8g==
X-Forwarded-Encrypted: i=1; AJvYcCVWsyrG94nPDuAF9MEW21C2qfE70JqT01OuCpJQiL7OceVeffmAb9arb5349t9MRbjFZcx5p50v5PJd@lists.infradead.org
X-Gm-Message-State: AOJu0YyF2M+mxZmZXeKzq2D9GVnWgGDOraEOk7wGy9BosQ+YaL4gn2tu
	YQO8IhkTeF96ZTTDxNI4TdJ1IwXGMIaaDn8MyNOaZ33jTZpKjX6hqbc8agN2U69pGHLl1TAw4jG
	RsO5VixnHy9zkoql9Xxmzt1zS7LlVMCU3wde4Iw==
X-Gm-Gg: ASbGncuTS1z3tg67xHJuYmMpqolIPJF2QU71kZ7CiHU3cABpwC9OFKWFhqESTPjJheX
	EcJHjMW5hruRnxbxLFLHtpNV+pdxDK5lRLXAnvmsnjFuBFK8Pz83ECcc4J/QC+hh+BJAq1OMoNf
	wttxblGzsBorZLxblLJVpF/0Vi3r978hh5G/iAVmPynQ==
X-Google-Smtp-Source: AGHT+IHDu7V+RYx44JF7d219DslywMyeZEt4R8hH/7zv+UjpRYN5/rbnlNmQc4SNhqOHZyYM7jffr3j2T4Nl0iq+9kU=
X-Received: by 2002:a17:902:cec3:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-231981442f7mr7732925ad.12.1747183457446; Tue, 13 May 2025
 17:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <CGME20250513070151epcas5p3f9a1f857f6d7e5433b3281dccebd0dc2@epcas5p3.samsung.com>
 <20250513070025.830930-3-hch@lst.de> <c6e9b2bb-6e32-43da-8a8a-29775c21c853@samsung.com>
In-Reply-To: <c6e9b2bb-6e32-43da-8a8a-29775c21c853@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 17:44:05 -0700
X-Gm-Features: AX0GCFupWLhqeNeiPKMzp1UytnErooLS8VcOdIbMCZlmJXYjpHwF2CBBznWBu2E
Message-ID: <CADUfDZoCRcGKVY5KKfymXDdyHGXLA5esNFLsRf4FE-ywB9MR8Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] nvme-pci: store aborted state in flags variable
To: "Kanchan Joshi/Kanchan Joshi" <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org, 
	Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_174418_939069_010B8D41 
X-CRM114-Status: GOOD (  11.39  )
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

On Tue, May 13, 2025 at 7:13=E2=80=AFAM Kanchan Joshi/Kanchan Joshi
<joshi.k@samsung.com> wrote:
>
> On 5/13/2025 12:30 PM, Christoph Hellwig wrote:
> > From: Leon Romanovsky<leon@kernel.org>
> >
> > Instead of keeping dedicated "bool aborted" variable, let's reuse
> > newly introduced flags variable and save space.
>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
>
> Nit: I would not call it 'reuse' as flags (within iod) did not exist
> before this patch.

Same comment about the commit message. Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E65FED3C0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdRRvkEqDaXRhj1wK9ax0Kl7CerOjC6Wl0sGdeJ62/E=; b=01DT/ynzp6qhwR9asVteDRRnWu
	QBte2O0KHGtncF9jAkEPxyIIrZs0Ywwl+BRURxq5uey/fvl4nTpM24UzoVqK1A1uYc80bQO7LPKL5
	k5GKBVnC+7fS8T32ifGgXe8NQIamuMKNa0gebRNoYzFQ49tyGqlR+V3Aeq3NofA4TkI5K3KiWkv1S
	JX402TWolIBGBjKXL0nKJamyMVHvq1iTNep9O7xvR6G69dxCpoTLIh3P+Jc2Gm8CZpp4Jwa1rxazs
	7aGh3Oh4N6CYCaND4HVQh9Jak+/Ut0MjpTIQTyiWPGyJxE9Z4lOW/5P4Af2ej9+jmx/CztLIU8P99
	OcW357IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGEg-0000000DDII-1GGi;
	Fri, 24 Apr 2026 13:06:22 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGEe-0000000DDHt-0aRU
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:06:21 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-8ef5776530bso399842285a.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777035978; x=1777640778; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdRRvkEqDaXRhj1wK9ax0Kl7CerOjC6Wl0sGdeJ62/E=;
        b=XpPJVz1Ido2V0Lxv/guV1iwGihZ2HsxwKbVflMxcwaz4MdTJ6LFiLPal47jGBj94BT
         I7YILYubhBTZLRx6ctsyog+aR2dlppxB0ryidCjmzTOisTyn7WcDCnIeEYj2If668FWe
         PHBMwCC0DmH1wvbIcbWaUKU531aVNEOd5p8JPlMY/3EVMlWGZw7weiTaP2jeReZw96l0
         UBVkjyPHEr2Ke6NLgX9gHeh0l9KT+Qo5t2PDfwKsb8jzO9mJxPrzh87wNQSeNaqPDaLg
         7kqTenhdFwPG8ohyQLe4Dnl9mbG7UMTUnTSsXJc3xtdFfAOzkBu4C7OqTxPpGRHqdz+5
         0a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035978; x=1777640778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdRRvkEqDaXRhj1wK9ax0Kl7CerOjC6Wl0sGdeJ62/E=;
        b=csXIvo8uNPCcIKcLou0EEXfkO5wMqMggljmtIUSOn/+M4jcOo6gNnB1Xs8/JgvA2JN
         RYmKmXQ+vExXphxBeITbdrfEREOTdRW5M3pWJ2CSGigRnTcCA3X2Ny5lF176hn2kz8pS
         kOraHE7a+Fuf7O+skMGLb2i201PcO4CV78D9UrD1+qWWSdJOZhnUe5WVLw9N3zkH2/MU
         7ZYcQ9GZy+5NIN0zO6Zykmwcq4a/341mi3EIa1NkAIQoNTnZbG79ZnScDRSz5n5tqOUa
         0k7MMyDgD2ko+4lC4/LqE0U/r5Y1b7LAIigWr8kVcBJauxo/esuFkyGU9qtMGOpsieBh
         jD4w==
X-Forwarded-Encrypted: i=1; AFNElJ+z7nJX+MVQ8vpoQKJMeW65ZhLUvCZWUKoUyoKTTN01Xl9JpVph1ASETg8PRUa2/wf9ijWf+xoYbtAJ@lists.infradead.org
X-Gm-Message-State: AOJu0YxGKGDHAntSmKm6Dk2sHJO9Dw5EXvx6bcV0aroZCpNoionhgh4l
	DH+U/OtThvHdCU+rTlwSPBP1FXOoTPxHfwu5e8ikYhavaonbCoWB2AE+H/C1/KH6iF0Xap+GCfF
	pHrj+RyU=
X-Gm-Gg: AeBDiesAKS0gNAHMUyD3HxMD0hGb5IWteRvXjYPJfs8A8h2BSFq9xk0SOZ6Pa5K9Oke
	OBzpU3VKYqlst90t148xXCumpppSH8DRbOjU3Xia+1SD4UgLwi2WvQBsi23C6BdRax21iTnKnSU
	jQStPpSHncYOBS+utikTd4B1iCTyw4zWmmhoHOeAyDCPaOXS23qYWr9euY6chNk6xNEtFPgCyVt
	uFqR+14c4l7C/hnx+8IU6kdtwBwc40cbqahmOW4bfxl/rCPNOqE5cIjQgdKTuwcSMlTI0JnnNnr
	KM63mmRylH9lq2fnHcMOBp+lYguzZOBVODkgABngsjCDOHwEQTASq7uuKjtCueqJIMG6Lz/4rX8
	LkU2KTSeKu+JLxKcXM4cWiMez5i5vKL3aiktJ+Cz7SHY3DgqsmL+JfngT1GRxmxZjsm5i1e4z/Y
	7OMhWTeZsdmxPKo4gsBkGjGvTI6hZjUoA3KEd2ROCN+qjF6IcNcNt3hhj8llg0mIn0WHgu3Ok5O
	v8xDO0utZBz9qUp
X-Received: by 2002:a05:620a:4397:b0:8eb:6f04:f97f with SMTP id af79cd13be357-8eb6f04fb1amr3242464285a.44.1777035978468;
        Fri, 24 Apr 2026 06:06:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe8ed1sm1911934485a.8.2026.04.24.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:06:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGGEZ-00000002Ovx-2693;
	Fri, 24 Apr 2026 10:06:15 -0300
Date: Fri, 24 Apr 2026 10:06:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <joel.granados@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <20260424130615.GW3611611@ziepe.ca>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_060620_253727_A9FAF267 
X-CRM114-Status: GOOD (  16.77  )
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

On Fri, Apr 24, 2026 at 01:37:50PM +0200, Joel Granados wrote:

> There is however, no clear consensus on how NVMe Live Migration should
> land in the Linux kernel. The 2022 discussion [1] explored a VFIO-based
> approach but reached no conclusion, likely because the specification was
> not yet mature.

Yes it was paused until the spec matures, then I expect it to go
forward.
 
> To move CDQ forward, I would like to understand where the LM logic belongs. I
> currently see two options (of which I have no particular preference):
> 
> 1. VFIO: Implement NVMe LM following the VFIO state machine, similar to what
>    was proposed in 2022.
> 2. VM manager interface: Bypass VFIO and implement LM logic in the interface
>    between the VM manager (e.g., QEMU) and the NVMe driver.

I imagined it to be split between VFIO for the pci and volatile guest
state and something else for the namespace setup and media migration.
Media migration is only needed for local drive so there use cases that
don't need this component.

We have many drivers fitting into the VFIO scheme now and good VMM
coverage, I don't see a reason to throw it out.

> One aspect that has not received much attention in previous discussions
> is namespace migration as prior work focused on migrating state and not
> the actual data. Migrating potential terabytes is IMO a distinct use
> case worth considering. 

Yes

Though IDK if just plumbing the entire CDQ to userspace is the right
choice for NVMe.. We don't know what future specs will add to CDQ, it
may not be appropriate to treat it so insecurely.

Jason


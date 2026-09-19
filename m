Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C049C982DE
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 03:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnvAR8q2sSnB4DFCyBNXaJ4MkqZefWdj3cCdrL6j5rQ=; b=bDR7FLekNNm5rF/yx0SAcTWJZf
	eU6aelfLA+6xZx92DA4pgv0PA5hu+YDzMz+9ty4Q/Fa0zj69Xv1CIlADLo/OR6J//hdVmnJ+jMW3A
	C4dQVQ+UGce2L7bfCYt+UanD4SF0qjXIj83Zy8Cdj++aWdoYEM+sYuBPhgAlgBx0hzFWvt+E8/fnQ
	48txxFClVrDpG5iWFmYzSgxQ4eWbxgZpZMABU8MHxBGQXe/hLGByezZ9mlidEcnq4kckm7CH4vP0w
	Tqlj69ebkdk2diUzsMpAaq9GtXODKUqL4GjEKp7osU8I8r/hyPC8OH5IjeMKpL2+62dZm6pNp1w4R
	ayon77rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7lJh-0000000Ftv8-3oGb;
	Sat, 19 Sep 2026 03:00:41 +0000
Received: from mail-ua2-f12.google.com ([74.125.226.204])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7lJg-0000000Ftug-0NDJ
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 03:00:41 +0000
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c6e580fso318505241.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 20:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789786837; x=1790391637;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnvAR8q2sSnB4DFCyBNXaJ4MkqZefWdj3cCdrL6j5rQ=;
        b=Bt6KdnP2Kqvl9VRCYYb27c886Do3SP0c4Eq+1q303onHZ1M3dByjbSBFtUypsXDtD5
         uTLZr27g4nrwAt3EO2vW2HFfQKCBnpFkePnxqrCzH0GTL9Pa+vYbpfxlPy7WugxS/5cx
         f9NCUyQ3+wJzKbrT4J3HXzWi0rjXgVP18BFy89magJFCGgYPk2lfVHaTuGahtqXN7MBA
         NnT1Vbh0OD3FeW23EZfONRg9bUABIT8/hri+LSibPDzwXSk8X46ofarLDxWdwP6uA9iC
         AAwuoFeLrlPuHi6u+q4AOeYAKqnG2RdqsBZK/ZSsUDe4sA5RmBtf32Lrs7DpfzZDrWw7
         mW3w==
X-Forwarded-Encrypted: i=1; AKwUvBxpceHnoAlGHgEudL1IFlnbIkIw/9zpAyVoCnWsRMrM1BnqhSgllKhQQNHYErjZ/+hLYMpqpmeVfMJt@lists.infradead.org
X-Gm-Message-State: AFuF++kz01AmkdOxp0hRWb9uGoQhrq2Vjiw1UayOfE/bGgYbjEAOGx1a
	Oqaat3MUM9aZNJnat2gMSgWQv1+CelsLw9dNHhCnH+HH7unGMe1oAujhv2Igv9VJ/f5jVOktOrg
	ve9euJjXTgQ==
X-Gm-Gg: AYBFou06dbeSwnYWcljBAglbY3wuLAhUGcvCIaIPNU9AvW0aaQ59pxWb4mYZa/EVhb7
	gLi4qXqLzkhxwskR3pXmIRHmgAvX73yZ8lxt3ci5/vX54bT1h8vI4ePX508TgyhrnedrpEIvaBp
	eeG5ZFWS4TDztru1acfs7JbQz0WwSm+VCx62l3u334zibB7wTmHG30BlbL/pKCBtxx0msqIV2Cn
	iU2H50Obzh/Qqnvx5rukMhPobQeKW/uor2r+zZEZ+UaiUBxjSDZUHX+OPkwIawhDMaQPsAjrIrJ
	v2ag7gTRoelvP4gkxc+TVLUXorx4c5VbVBGVfEZRceZyXQvYdxmvYY/gLOAtNJuIbfvvs4Y4+/i
	u6bfsvW/R+SSoyZn06uOxNblYTg1yo8SVOUjJXMrIF6kJmDMpxhDBxAjrRXlvwgqo6HpgA7qZnz
	t1H7sivkOvnlh71Y17D2SGHTTCJ42NdNOCsEGnSbbFte4PsT+ck/fSCYO8uirMRvvpAum9zAG1/
	Lqu4xXnBQeiNfUPR8z2gTMiDddROKTzbgO6SO5ep3KFj8KhrKNBf4k=
X-Received: by 2002:a05:6102:3592:b0:7a1:f980:e938 with SMTP id ada2fe7eead31-7a55d284613mr2150925137.20.1789786837322;
        Fri, 18 Sep 2026 20:00:37 -0700 (PDT)
Received: from [100.96.0.25] (corp-190-12-36-222.uio.puntonet.ec. [190.12.36.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-984d5342f9csm1418996241.7.2026.09.18.20.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 20:00:36 -0700 (PDT)
From: Ing. Alfonso Kuen Arroyo <gerencia@idkmanager.com>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no limit"
Date: Fri, 18 Sep 2026 22:00:36 -0500
Message-ID: <178978683646.43804.6940923486189370705@idkmanager.com>
In-Reply-To: <DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu>
References: 20260829013900.10392-1-gerencia@idkmanager.com,
 20260831005117.142713-1-gerencia@idkmanager.com
 <DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_200040_137051_F2E98B03 
X-CRM114-Status: GOOD (  15.34  )
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

On Tue Sep 01, 2026, Maurizio Lombardi wrote:
> #define NVMET_TCP_MAXH2CDATA 0x400000 /* 16M arbitrary limit */
>
> So the comment should be fixed, it says NVMET_TCP_MAXH2CDATA is 16M.

Agreed - the value is 4 MiB and the comment is stale; it predates this
patch. I'll send a separate one-line patch for the comment rather than
fold an unrelated change into this one.

> Also, it's not entirely clear to me how the target enforces this. Suppose
> an host sends a 2 MiB command, violating the MDTS setting, what happens?

It doesn't enforce it, and this patch doesn't add enforcement. MDTS is a
limit the host is required to honour (the base spec says the host shall
not submit a command exceeding it), and nvmet has no per-command check
against it, neither in the core nor in the transports.

What the target does have is the hard limit in nvmet_tcp_map_data():
since 4a3f00262a04 a data length above NVMET_TCP_MAXH2CDATA fails with
NVME_SC_SGL_INVALID_DATA | DNR before any buffer is allocated. So today
there are two numbers: the one the target will actually accept (4 MiB)
and the one it advertises (none). The patch makes them the same number,
so a compliant host never builds the command that the second check would
reject. With MDTS = 4 MiB, a 2 MiB command is within the limit and is
served normally; a command above the limit from a host that ignores MDTS
is rejected by the existing map_data check exactly as it is now - only
with a reason the host could have known in advance.

If you'd rather see the advertised limit derived from
NVMET_TCP_MAXH2CDATA directly (so the two cannot drift) instead of the
constant I used, I'm happy to respin as v4 that way.

Alfonso


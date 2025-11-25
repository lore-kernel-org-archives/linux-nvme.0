Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069C6D1036C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=; b=oJzFgZ/lfp+rOxOo0LUK3F77jF
	6X36UfAkNFqe/iGyv+H3MTrqjSU05LyQDxu1Zwkptzx2FkTyyhwaHN2KCtFb1E+8buaLiZTpqgwyj
	J7WWyaojUa58Kv75lkipylQQTk9E+SXrJwdM2r4/FEMjy55msDLY0N2q/63DLW758JLkDK1bBnS8t
	XmXAlLXLMTwub5hmwy1fV29sWm+VHhiG21+VfuLWuSAcxdhKIXIyf8AXI6aR5KspZjRFoyphwH4y1
	CUGchuPehjEjombW69TcTxvwlkuf1y9dI7jxa1gjIJNKyin12unc8UW805F5u0tQd+wEef2m2fxyr
	6gaTUIWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO2f5-0000000E4ka-0J8s;
	Tue, 25 Nov 2025 23:41:31 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO2f2-0000000E4iJ-10xy
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 23:41:29 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so4108237a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114087; x=1764718887; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=iXwdtj+rgxKEEV0256j/XRGq28pK4XSOMPNLafoqEAhWeKkDEWt4yzIVN4M9TiiIdS
         r/hVHS0hJaX5oU8y8Hby+s5VIRhA/Xkii+mQoiA9XMZrG7yKbHQE+jJC8NzH7MMcWh4x
         fUYo7t7EuDyT0jBGQRSBdOdvyMHKwDB5GA6VLvv+9uJexnkQcU/johAsn+BdywEZv8LV
         McjmdViGmw4BkSJ0eH+o/ddCM40+e+pSZ1rqSKVJq4IIozoxrriAkG27Mpf9orBilopF
         ruy3gQg3W9inzljofOHqtEAd/Eiswoy7HirYQ+Xw/ojex5CtIwocWex0IJbPYvxGwRPE
         R2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114087; x=1764718887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=S6CdjEI49sXddl56+90X53FDdm1SjTNMRvcC2joEuHXuiXPZpqeGKo23DJJCf4qJEM
         vLDk4bzHQAGS3+4f4eHZBGI/lL7xWp200yWxXI+QzE6itrpVg85EteoIsu/aTxk6jvj4
         XfzncA58cfbz4ey95vK162vCRhO6cG1wMEe8XdLgs/N4vxdl/bHiqPakpf4ezzikmy+D
         yGDqVqCU55G934tl6XO+JdLUkXhTxOqd0a1GqSFjBgOHUsiU/LT43qAtVeeVodG0/+iZ
         +2idQSocQPLYfhZXmrMQeSWSs02y0N4rqjpeDxhl6f3QLh9H4gr+bsuW6vZOlyfzhz/E
         K/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIXbxaM2W5orh2+GKh/SAZ8fIkgVM/3UaYBs0LTBNpFkqMsei/Q33akYuRKNtQSbZM6k+0UIacA39G@lists.infradead.org
X-Gm-Message-State: AOJu0YxEUCQyRKzLmk0W03bJldrcrhpLVrZmjDAPWLgh/2KwsrAFL+Dl
	FMYwFF/AzAQYAZD8eITwdMyyetQiYbb+MKfnUtlzCF4zfUOz5VtH1YHi
X-Gm-Gg: ASbGncusHSxkah22g3/UctEwIGxbZbHH/mUs6kkLpei1Kl6w9abHOn47M4eR/9hNF2Z
	oztp9bOYEQWlTd/65xvPDxIVt5U1WvPnq+a/FeEnnQnhG6KSnOe7Znazry6hA75SDayxcbQ+VtO
	DKwswEtJuubQmx+einf4/evF3Tuh5izg5mN6ylcVDPrft/nvi3hCRkzAqMXsvaLfjaoW41vNBmN
	lRdVXc2AOhByOAKpHW/ck5LpzZAbBLsHORAMWpcutbzoX95vM3VH8jQPZur+0DwYw9h7UGkVzfx
	GphYsE5rkQDH4Lf1b6balvlDkSPlIdud4OgC7aEr14U1ZBPlq87OIqeD+A7VRDggzkzRUJ4IXkX
	Hmqe/A7/Y1dC7EspTEBRDo4DRMF/IZqJ9N2OzXuBItX4yF7bUiinZtLdB7U5Vm8mvSFstSvevON
	HQyNR+hgHG0Yz/JO1yjWdSNyHM6fpAbuQJkIzMBQ==
X-Google-Smtp-Source: AGHT+IERAr6ZaAk8N2XfP1sLPZ8ltdcZpy2by33AewknK2HCsGdLuO/dThk3nDRSpzRLveBkNTfbCg==
X-Received: by 2002:a17:90b:3b41:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-3475ed6ac44mr4636649a91.26.1764114087385;
        Tue, 25 Nov 2025 15:41:27 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0e6c9bcsm19291748b3a.57.2025.11.25.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:41:26 -0800 (PST)
Message-ID: <2f356d3564524c8c8b314ca759ec9cb07659d42a.camel@gmail.com>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:41:19 +1000
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_154128_291586_C21C0AC7 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
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

On Sun, 2025-11-23 at 18:57 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making all error checking
> at call sites dead code.
>=20
> For dm-thin change issue_discard() return type to void, in
> passdown_double_checking_shared_status() remove the r assignment from
> return value of the issue_discard(), for end_discard() hardcod value

Hey Chaitanya,

Typo here s/hardcod/hardcode. Otherwise, with the split as other have
suggested:


Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E46CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sga9RmpfP53rYiBjnmaPnQfGvT74E690u8FkgaINL7s=; b=MLzx94WG2IjjzJLwuyXJ4pxBX7
	em+Xiccj3Vdc4PoqBtke12pSzmQ8jSxSTZh7csQgxrC8zgKFXskE7h89AyhAgSEJGsfXVFURq8xO4
	KirqREG9/LdgvV4ijuTHjYAtjNlHNTeu75Cav7494ZjvW6TlT70KcLuK3U/XpsUbpCGWFAtI5heO3
	Yo5f4U1FZKLI+Tl/UD2+EgO+M3P3Nid1g+ZMmIxgYcQop9Sod7Efsplpw8tOvijgYRM4WEyjyLGEd
	K342AQi4CdtypMW3i6LDQJKbqo9vuv6KRhSYketZD4qkfBF+Iq8G17KouZGAHGQXeIP8djfTRZXmO
	/HnmbMCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRcX-000000054XW-2vun;
	Thu, 28 May 2026 03:41:21 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRcV-000000054Wq-25k2
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:41:20 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-50fc496c8baso137330171cf.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 20:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939678; x=1780544478; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sga9RmpfP53rYiBjnmaPnQfGvT74E690u8FkgaINL7s=;
        b=It3FJmbp6qtFOM/cUf05Udee6aggb/Gyv4NFk/Uu1F1OP1DkVtyVNBozo7PcEkBOKC
         93F0bsziup7U5oJfn71N2WuD2WSYoQn8CLwTgo3E8/HZnYSNGl7NfQfrORLJmx6iKAYF
         gQ3k4+uvyx+qdkDuvjwhsH1WEcr+8K2VsGMYUW+b8qjqczPDY7HESrOR/MRqJKNOptls
         QwNi/mXN/LotwOvp0log0w4DMzULxbncbPDs4rsMOLuvrRqq6opkxP1p7fK+4A8aOxY0
         0xxRpSQXth45YZPThRdM1uk+lww5xkywBl3/ZFlbLQEbEXdvDzwLWmmU4HKyg+moiafz
         6GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939678; x=1780544478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sga9RmpfP53rYiBjnmaPnQfGvT74E690u8FkgaINL7s=;
        b=JE8jx2aoCy/I2HP7qOVT/wk/BDWAKw4y3naTBGr/eACshqm4JaXMzwDVBVlOuk34wh
         MVXzeRaGB1SisMRjA7cReLJPBph+Te2DaTYRBX1/utBdynakl+vWbtqrnZEcN3hMy0Ml
         tFgDXrv6gDXjxnGOcLTv2Js5YjEEx6mjNY1iOJSdUWSVshlAM+cp2ywRtbOjQZyF4kjy
         anxAjkQJshLJrSn4pvNYVIVY7L99O0TZEa2g3t2pCAXYymEY2+rTCe9phRd95VuWj18Z
         /Cb79mddKama66JDpnpbxQkR4Swnx8vTaljVnLGcruB2ql5O5K0J2IJbd7CvtbFszKT2
         8zKA==
X-Forwarded-Encrypted: i=1; AFNElJ8GcnbJL7+cROw9w0Am7icLcfKnyWFTfDPempLR1c97Cv4EZ+EcNcmVHDK6j/fjZYNVV0KcwsEUx/tY@lists.infradead.org
X-Gm-Message-State: AOJu0YwHiZDSi1hEq9PzR2Nf5K78aKYWC6IHTVyCCKg5A+2WHy3IwoRV
	KranJaqXSDvdJxZz/Soetbgzpdx5jA4qeK3TkInlGy4NrN6Hg4n3TZb/yhdRCrr3
X-Gm-Gg: Acq92OEODwMTRvdOAtsxrWeEGyTjLaZWW1IYNSzHxBTOc0aa7tltuKO+ZUL8Moc92er
	kbcDwgm0aVpQ0sUs9U7UOP3BjB+fFgzJlkCSTr7xG1pDWfhY52mPhKtgvNZhRx3Y5CfWAic51B4
	6y07/h6yC9LVYmunWTqnJDeo5Y6c9W6SH0Q1Xwvq9m5KZatxM5bkF855oX6RB3ZmfUI5beimdYJ
	BM9jlq4OD9Kirwc3T27Dw+bS8DEhAPdZG+UXmOm5ZZp6HJksGS/WF/dcnibox6u1iZlZZAYBsnZ
	PRDhX9O0zykaEV9ofQJ4Q9H21rjRmrK/VH20tOvpId34Wtzf8T2VIo4m4yZ6TJXOCBZvbEKQOo+
	LAeNUjMDUHsbQnuvAnDf7K15gskx6CJR+a3fzKXUn4p54/B0H0QVB4unoVb96LaKUWrqdDZeBy5
	n/h935+x7eiVKhDM85xHXXTtcE4Xrt8FiFVTdaAZGA2hY5zx+qJ+Jo3iqJabJ+ktfZtOcvoKbBr
	6uD+JiWkUj7us5uYGr5YA1QRJAVKAGJO1nbTy0RWoc=
X-Received: by 2002:a05:622a:190c:b0:516:d25e:951a with SMTP id d75a77b69052e-516d44246acmr346134371cf.8.1779939678088;
        Wed, 27 May 2026 20:41:18 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b066e5sm60033391cf.26.2026.05.27.20.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:41:17 -0700 (PDT)
Date: Wed, 27 May 2026 22:41:11 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Message-ID: <ahe5V8u0lKx8IOwF@fedora>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_204119_537917_5A589EB1 
X-CRM114-Status: GOOD (  13.10  )
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

On Wed, May 27, 2026 at 05:10:22PM +0200, Christoph Hellwig wrote:
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming


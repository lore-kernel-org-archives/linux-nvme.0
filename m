Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346A606A31D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yvG/vkCJ;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ro8zpR2n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtixGAWabeXrduX02b/RotwSNJOMM5dvEH5fBuXsl/8=; b=yvG/vkCJy/IM0fO9L3c8LC8Qe4
	M3vI6kuEDRldgvyamHIPoxVT2Jzh/qkCiY+Les3WnJ6E6VuAqchPXdO4nGGvMPVij5o3gK7GrvDVy
	ppQplEx9IFIBmSEVXJzctPXgnP+aBeazqGJ+dLg3SxbzDQun6s+y7j0/75aPXXJBin2JUDXkRqWC7
	FKvb2I/CGuU3WTUnXf83M182MB3NM5V7tjQaX0FztwfKIt9ACUUzCTAhj4W70Oa4Dm7jNqhwhYQOO
	idWtxmtqYxT8RpOy0k2P65Ua3j+J2KkT85e5nvrv3XofDAarBnEtzG/3TX9Oiy23T3aL1H4luCIFV
	l3FwQ0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIrkW-000000087w8-0Ffz;
	Mon, 19 Oct 2026 18:06:16 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIrkQ-000000087vP-3061
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 18:06:14 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so826916b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792433169; x=1793037969; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtixGAWabeXrduX02b/RotwSNJOMM5dvEH5fBuXsl/8=;
        b=Ro8zpR2nVnEuSJWScMjp4zuaNKRRKGGgVs1+E1vTHaJG0x3okSWkXiYKADABJ4+j2d
         TgHNSNRC9jn5dBy5TZZCBKJjoJoIF83p/PCUMAaI7J08lfW3zf32PzQdqeLojTb0O+it
         yIl7Rqq95RS2chW1tX88XqpdHCRhIXqLd2Fw5ndN0FRQFaKMY2lA9Zy2KEfKu4P6NqNG
         bn+yY+O9gMw3M7zVDkJyIW8bX8K7Xf2Gd3GNkE4SknTIDJttO2g9xEMKUySKu/LLsHY9
         z+upO0p/W0k40/5he/oEo9xXGpcZxRNgRaQRozLg4TrGfJeCrK8dwdcrLvdp6ndRIxzy
         OC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433169; x=1793037969;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtixGAWabeXrduX02b/RotwSNJOMM5dvEH5fBuXsl/8=;
        b=YzCHU/DbUwh4zZwPOiinnyqnF/Pw2HBfUFLb3U7Az+01CWh+w9GEwBOvDw20wO+b/7
         hO7jmS/HMqZ3QQMj4Dcft24J5XcGOjsRRZBaz2iBbgCO724FLOW7KMYJjZuxGhRUXuPT
         IuwQQiOW/rfbZ4ZWyZRYtKlj2V7IjmcMfvtvIGfInhsBo2yYKo2JSdxGowcSC71Vzb+M
         lUSdtJs7MuFJ9a17AR102rFVQnmyK759Q//EOLDAhE+gXaNr8EGvQ5uG0WECHyC1GoFH
         /FcSn7bNvt6OpKy67/V3bX0bEtyK1CtaEW7O9iRj4F3OCFfxE8kJND/hcMGj1+MkdgkR
         HLJA==
X-Forwarded-Encrypted: i=1; AKwUvBzXgRvU+LSI1Ldj0XMykUwKzkr4VmPppqWJ5mncuBdjnMXQNyTmG5Wv+z49VdjUxlMmgx1XgXbo0BFg@lists.infradead.org
X-Gm-Message-State: AFq9FYJyTJdZ7pRPVMXKEdYBPsnb/e3doSJhAYOMdj4qRXu5l75jwtOw
	IBETAevqXLqzL0FxRevfAh/V2/4ymbBu5awRX9tDF4mkx0pohgPpRf9J+dignckWnUk=
X-Gm-Gg: AYBFou13x02+PrBvEwDnbP/j+/tzpxAxjQ0MqrkBgNoJ9twvLE2mdsYk61JugBr1HFV
	y6VExvwrZXdSHl0ZY4Y5SLMFbnp/0yusVUqZO1JelTCPMgKM4yHJsKKE+/3xLKhn969LeSrSohc
	WQi5zVmCsFay2kvLa8RmUY3vBMTmqpUz1AY/49uEVETITCGiOozIhRSB5pGRtRVpNWjnFyZA184
	bPDibeVpHbaxdIE+Nqu+f1uk9cHFFSqL+kScmHaCafLaBP+FasKaVS7hducM6Y55qVGwdKXqBPq
	A9j/XVuMSD84+q1VDLJOsc6WI2NRIRWRA6S/tojUKPktOYp223XIyHJ1+cq/orzGOBYXjtrzgon
	dhMj9uL7XGeetvzlcPDH61vCwOV5CR0CRifIKqcC2kOXEk/fsGkQUXrl0DDzEUzGvJjPPqt9WpO
	QQfKmgULuurLcHbOKKrk9LSWGNg1p9bq+eShOYiswMeqgzd39iCLZcu310v3rp+7b/3zB3kd8Pk
	X3/iYiV/D7yeeW0RE8Q5mxOrhD/WmL9A6VlPKF+6m3dhEpLwGaCLnsLU0Nec354HwCugN3KHS2p
	lbY4w2s96VpqBEyiTFetMw==
X-Received: by 2002:a05:6a00:21ce:b0:874:706d:962a with SMTP id d2e1a72fcca58-8a04be43d00mr7042493b3a.28.1792433168948;
        Mon, 19 Oct 2026 11:06:08 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-89f57653ea9sm4184034b3a.32.2026.10.19.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:06:08 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:06:04 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 01/18] nvmet: Rapid Path Failure Recovery set
 controller identify fields
Message-ID: <20261019180604.GJ2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-2-mkhalfella@purestorage.com>
 <179206908475.1897932.6636243827945983905.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179206908475.1897932.6636243827945983905.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_110610_936237_B9B26BA3 
X-CRM114-Status: GOOD (  16.69  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu 2026-10-15 14:58:04 +0200, Daniel Wagner wrote:
> >   maximum number of in-progress controller reset operations. CCRL is
> >   hardcoded to 4 as recommended by TP8028.
> 
> The spec says at least 4. 

- CCRL (Cross-Controller Reset Limit): is an 8bit value that defines the
  maximum number of in-progress controller reset operations. CCRL is
  hardcoded to 4 because TP8028 recommended a value no less than 4.

Right, I updated the commit message to mention that recommendation.

> 
> > @@ -1695,6 +1699,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> >  	}
> >  	ctrl->cntlid = ret;
> >  
> > +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> > +		ctrl->ciu = get_random_u8() ? : 1;
> > +		ctrl->cirn = get_random_u64();
> 
> While get_random_u64 is very unlikely to return 0, it still possible, thus
> 
>    get_random_u64() ? : 1;

Good point. Updated.

> 
> would be the safe choice. Besides this nitpicking:
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 
> -- 
> Daniel Wagner <wagi@kernel.org>


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC7606A324
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a5Ce5yYX;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=cT5KD2bD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RuhD0zPFUxb19Y1B4pQUQNr0PVSFn6leg17qgS+Gj0E=; b=a5Ce5yYXK2NjAGb9lr4jrUO2ds
	rUb3GVms2rHm0z+GstauMnKPiJ5j2hnhEt7136gT9gPxX9DYziRgkboVLKT4Pb/prE0qZqDy/1OJO
	VbalweKMSXa8uGsDDsNqnOy1DAISx+ChV7qz7HQuijZFVulNQuZeunpe8OE+7s1camUZ1P5mPdAKw
	LAgxwyB6r9X/ey2Z6Er7PniGis5WQ6ee6r/whTWMCOtUWIyB9Y2YEAYPiAgvCptjkzH1l9GbcVde6
	tv4HtG/yie5rDaXmrqrHEJMOy6L2baAyAc2IhBk4ORZVHiHVlPkI64jRlNT7Bn+wABFxKLpg3cIFA
	1D+ZvY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsUp-0000000CVD0-1mte;
	Fri, 30 Oct 2026 19:42:39 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsUl-0000000CVCR-0smS
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 19:42:37 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1636384eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793389354; x=1793994154; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuhD0zPFUxb19Y1B4pQUQNr0PVSFn6leg17qgS+Gj0E=;
        b=cT5KD2bDOcjwRMRy89OmUmccwPZHBZFMAdb1wwqv/3suZKe6afZsFDbWTwztk+CrSY
         H+ycVNL2zr7V1qPUQaKuL6HqQAABC+b9Pcwu/xDErEsKUFlZ/rK4OfXsAQdf3AGNeEEf
         MS6aMLxANLL+Qcd2x/vS2CcLMIuCDZNQbNElNOwQ0VFgfevs7KuZVgV4vYzjXkeg7W5h
         M7fLcxeeUHu/gp6Dl75z67fPJREmQ+F24FLYPjp7R+9clbz/J3nSmTIsr+SLegDTtx3z
         4HhGEmv6rv0+Py9zgZE3Q+bxj06zVvnjkM2FG+7I2lBjvpbLd9Zo1oi2ILtfL3dRnunu
         PZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389354; x=1793994154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuhD0zPFUxb19Y1B4pQUQNr0PVSFn6leg17qgS+Gj0E=;
        b=qkb2ERQOFyvMYyWIReffmyFPlMwE4PedQzhMwz0LTwz098111BWIFc76VL6x5cMyPI
         ZwSJRRLzh/8Ai12Mku6dY+MXkmYK61QTWv8wJ6jRBv5sW40C2rxALm32hsqLP13GXd3j
         fyR5assZnqYooo21STMsqQeC+wJBZbzAAATywzMGkhu4tP8IuWcaQ+yLj4xkXuu820Wa
         tRo+T8B0ozm6ii6EFDdxY0D66ORE3BHOxRRR2mAa5SxZRsBzt97CSB5vF1q0ErH6In6C
         UvalDnDu20TjCSfZQvipFkFdiPqVw2SSJFFb2qfW4yHeKqPk0ymTmu0D3F2Vn+z+FxON
         cwqg==
X-Forwarded-Encrypted: i=1; AKwUvBwnrIAo0JOhjEBGH0owy+4v6RBL9zuKGcPsCbMIUDH8m46weqrbDbYZHkII0TBsE/sMxtagd0TlKezF@lists.infradead.org
X-Gm-Message-State: AFq9FYLk+CJ3FsoS38wOpYhYVc0fYbru8s36g749uNfelVyQCP95satj
	w5tzGfqzhlBTPzn0Np8hIMsohdmDaDm7n11fgwB9nvrSAj2Yo0/9/58FPcK5/mcSD+E=
X-Gm-Gg: AYBFou0IBKVcb4VgvX47zqQ+k/3f4j4Ng8hwv3QgGkIBO8BrtCl8/oTVTkeGBSJewTo
	YFkFH+/yxXsVwliR+U7sJQk1sYpZl4oNpUjKj2ZQ1J8g4mAfwx/ftHKcBbXe700crO2BlUHZTMV
	qMTidJqtyYuJ19yA1M7nPNR+aCMMVbcDZKYFlpmTmAE+N+yXYYXUM8BZYoYvVEMjiipX/g2OhZo
	bgCXV6WbY2GOG9bxNw/wsB2Mof5R1FEjmwmyS1dzfg/7I1gZYY5SMUVz6O4ot0grk9wv1dpz53L
	gDSbOyxEq1HKM57gdbtitXp9Xm8osb8QkMC1S66oChCyma3l8f9coTAr5jkj4bmp1htiv8gzEVP
	Rwm7RvG01BZiQx83rRpxynE2/SUwoLnm3hAMbEELOWVm/D6gMVYHkefCRs6VWcrDmjVAy037Ulf
	aktkxWmR/e3ugWEQIaZWauMkXigV1Xamo2REzbGTrircZ8eAe5R5myG7Fvh4VLmO7mQw2RpalCz
	DQ/e+NqUH4Yyb3YH6Rqvcv7RwB2FDm1FohQlQS//fAsMxNZjQYGI3vVtF/kY8K1TdfAL02wjAOF
	o5yEOl4vP3QXCL8a8yVHfb2+XUpNaDNfcF/xD1nyilCCpmxVkw==
X-Received: by 2002:a05:7301:e112:b0:369:a113:7578 with SMTP id 5a478bee46e88-36a42217af0mr4015746eec.1.1793389353243;
        Fri, 30 Oct 2026 12:42:33 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm9307441eec.19.2026.10.30.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:42:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:42:29 -0700
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
Subject: Re: [PATCH v6 06/18] nvme: Rapid Path Failure Recovery read
 controller identify fields
Message-ID: <20261030194229.GD122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-7-mkhalfella@purestorage.com>
 <179242896496.3619480.12975259904515722687.b4-review@b4>
 <20261019211849.GM2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019211849.GM2931-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_124235_635196_F5C942F5 
X-CRM114-Status: GOOD (  32.99  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 14:18:53 -0700, Mohamed Khalfella wrote:
> On Mon 2026-10-19 18:56:04 +0200, Daniel Wagner wrote:
> > > TP8028 Rapid Path Failure added new fields to controller identify
> > > response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> > > Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> > > controller identify response. Expose CIU and CIRN as sysfs attributes
> > > so the values can be used directly by user if needed.
> > 
> > What's the use case for it? This is an public/stable interface,
> > it needs a justification and documentation
> 
> CIU and CIRN identify an instance of an NVMe controller. For a given
> CNTLID different values of CIU and CIRN identify different controller
> instances of the same controller. The justification is that the values
> allow the user to identify a specific controller instance.
> 
> host# grep . /sys/class/nvme/nvme0/{cntlid,cirn,ciu}
> /sys/class/nvme/nvme0/cntlid:1
> /sys/class/nvme/nvme0/cirn:42541d24813bb536
> /sys/class/nvme/nvme0/ciu:57
> host# nvme admin-passthru \
>   --opcode 0x38 \
>   --cdw10=$(( 0x1 | 0x57<<16 )) \
>   --cdw12=$(( 0x42541d24813bb536 & 0xffffffff )) \
>   --cdw13=$(( ( 0x42541d24813bb536 >> 32 ) & 0xffffffff )) \
>   /dev/nvme1
> Admin Command Vendor Specific is Success and result: 0x00000000
> host#
> 
> One usecase is to use the values to issue CCR command manually. Not that
> I imagine one would want to do that, but if they want to do it they need
> this information. CIU is also present in CCR log page. Someone reading
> the log page might want to correlate a log page entry with a specific
> controller, so they need the information to be exported somehow.
> 
> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
> index a2f5d0710db4..ebc3634c1a96 100644
> --- a/Documentation/ABI/stable/sysfs-nvme
> +++ b/Documentation/ABI/stable/sysfs-nvme
> @@ -9,6 +9,17 @@ Description:
>  		of the NVMe controller, as reported in the Identify
>  		Controller data structure.
>  
> +What:		/sys/class/nvme/nvmeX/cirn
> +What:		/sys/class/nvme/nvmeX/ciu
> +Date:		October 2026
> +KernelVersion:	7.5
> +Contact:	Mohamed Khalfella <mkhalfella@purestorage.com>
> +Description:
> +		Shows CIRN (Controller Instance Random Number) and CIU
> +		(Controller Instance Uniquifier) of the current instance
> +		of the NVMe controller as reported by Identify Controller
> +		data structure.
> +
>  What:		/sys/class/nvme/nvmeX/cntlid
>  Date:		February 2016
>  KernelVersion:	4.6
> 
> How about a diff like the one above for a documentation? I can add
> something similar to the one above assuming the change will be merged in
> 7.5. Or I can add it later on? Maybe in an -rc after the change is
> merged?
> 
> What do you think?

Added the diff above to the patch. Let me know if you want me to modify
it.

> 
> > 
> > > Also add the nvme_fence_timeout_ms() helper that derives a fencing
> > > timeout from the controller keep-alive timeout (kato).
> > 
> > There is no user in this patch, introduce it when you use it.
> 
> Moved the hunk to patch "nvme: Implement cross-controller reset recovery"
> where the function is actually used.
> 
> > 
> > -- 
> > Daniel Wagner <wagi@kernel.org>


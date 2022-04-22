Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3699CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2bXBH57zZDvmeIOYDk/m7NyaBAKN+vWWjfrVhEZ7T4=; b=IaIamP1CcE5+3onJNEDGrFK4eO
	XHLQ9t2/qxbyUD3d5NIvtIghkbwW4NEZ8aRKj+USGI/SmgHjVks+A1Wpzrt2ecKwT2g7CH8ER6Vqw
	R3Z6F1yGGqXvZwilRcIdWIHuv7lsGWtJnN+4zKOhRlAaORBLY0N3lwLVWqgQNCqh/1hQ1ogUpBCta
	Xjvv840d5y8fZjqWOfNNsaX556BFhP+FqBZlhO2qJRHdpRK6xQAYOqqA2E22H2ndSiOHQFq9ScH18
	CvJWB7jg01L7XxtQMX96zKcr2XupPArxzIZRCIOn2vRs8gsec0NGqObS6+r+r9WTmfcr+ct4HIz50
	NJ9RsEFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhvRv-001BTA-3Z; Fri, 22 Apr 2022 15:43:59 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhvQZ-001AqZ-LK
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 15:42:39 +0000
Received: by mail-pl1-x62b.google.com with SMTP id n8so11696535plh.1
 for <linux-nvme@lists.infradead.org>; Fri, 22 Apr 2022 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/2bXBH57zZDvmeIOYDk/m7NyaBAKN+vWWjfrVhEZ7T4=;
 b=XYZOLh+Jv2kL2sx884zx4C5eFWyZUuKY38ML9XvAYhNcR9BREu4ndvKecAC8kiH8Wl
 2v8yd4kPP2gu4bBvSJJYHpMRWaZdWMCPawASUwvIYLt/36hDOsoQF6/PRGnoA/fP3+Iy
 OdYf/Am/17PxHTlnZSv3KbSRM9TsczBeb1wQS6jyeQwBOuRzRhaolF58FR4l9A1SPpSs
 HkM3GxADfbMO/Zvs8ImLLAeCMjyTOUQSJdFg27FdWbQ+EuDUKbiREIqdpGpAdH81y42c
 dVVAZmsCS7qchIwgGY0c3HnDxcg2FfvolA13AyZ8voskHxh/DdCWa9uIdpnjrvxytLup
 fQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=/2bXBH57zZDvmeIOYDk/m7NyaBAKN+vWWjfrVhEZ7T4=;
 b=6wuIgvVqBV31nbOojljvLQokiNFBZH717Nr5GNVRmb9SzvMjU27d0KqwOGeVzLoopu
 C+VFtKwuOrLUGkHIYq30MexHEBhoufAfW/x7372J2LS2ls+WScO38izPndp7GUxsYHJO
 WHv0jf6l0YF3wNE+X3ieYRICBAnP0j4v0b9n4XxG98DlXkuT7KOiSFcwZKS0PCg5ifXj
 9V4aad2TuBY/d4FsENCZ6yo3AHDgqV7FsIuS4hXkkuekJFgvPvBvR1R+fAkrKAccYPpH
 XLlXKWVjFr64RzZlLgY5NYn+Wp9Y22nn7AGKcV+7/jphOeXTLTZJEMSxFhg2ePeIVfdb
 2+fQ==
X-Gm-Message-State: AOAM532FMmhGdbT4DtEJEWj9V2RsHzoKVM8xxdDeT5shsOCVQK3Q65YH
 U8ahnpjF2TyPfnWjRfdnxmI=
X-Google-Smtp-Source: ABdhPJxxn+CbIFWzfwls+DC0iuC84aNWB0fSRIoYKEF+syIzU+vM8K0HoUfp8xLLZbd6xF64bDs7kQ==
X-Received: by 2002:a17:90b:4c45:b0:1d2:acdc:71d4 with SMTP id
 np5-20020a17090b4c4500b001d2acdc71d4mr16900643pjb.39.1650642153919; 
 Fri, 22 Apr 2022 08:42:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
 by smtp.gmail.com with ESMTPSA id
 y68-20020a623247000000b0050acc1def3csm3032102pfy.203.2022.04.22.08.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Apr 2022 08:42:33 -0700 (PDT)
Date: Fri, 22 Apr 2022 05:42:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <YmLM5/1+VH5mdQ/o@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
 <YmHQS1pyIglK+gfS@slm.duckdns.org> <20220422042318.GA9977@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422042318.GA9977@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_084235_796970_F7AFDC5D 
X-CRM114-Status: GOOD (  23.85  )
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

Hello,

On Fri, Apr 22, 2022 at 06:23:18AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 11:44:43AM -1000, Tejun Heo wrote:
> > The patches look all good to me and I'm not against making things more
> > private but can you elaborate on the rationale a bit more? By and large, we
> > have never been shy about putting things in the headers if there's *any*
> > (perceived) gain to be made from doing so, or even just as a way to pick the
> > locations for different things - type defs go on header and so on. Most of
> > the inlines and [un]likely's that we have are rather silly with modern
> > compilers with global optimizations, so it does make sense to get tidier,
> > but if that's the rationale, mentioning that in the commit message, even
> > briefly, would be great - ie. it should explain the benefits of adding these
> > few accessors to keep the definition private.
> 
> Mostly to help me understand the code :)  between all the moving to
> and from the css struture it is a bit of a mess, and limiting the scope
> that deals with the structures greatly helps with that.

Hahaha, yeah, fair enough. I don't see a reason to not apply the patchset
given that the code is better organized and easier to follow afterewards.
For the series,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun


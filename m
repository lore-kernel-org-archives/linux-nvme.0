Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49D606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LwGJSu17;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LeYlLJXV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K2Ycxsi7bQUBl6s3XkEfGjThxfYRK7mN668VlKr8sgY=; b=LwGJSu17XyFO5TPimP0kZ4U+sm
	xePJbbcn8kErb5CbXbEMELmx1jvnNpegN5zACdoB8WLd7DVBenmvcQc7GS8k8o8IpBpet8cI7Ddrg
	F186CHG40hc3fdes1Reijp1p/5mW+evM4Rnio2b9iXuXJNrY6inxaNjmrhQkwYamhg0cuphOKp1Pg
	RGpS0agLvDv7MKnufGBgShfhPIobBMTwkJMfHCGeTkDma7Ub0ZMORoa5uU+i1vHesQVqPYjgM8GuZ
	rIJunYwhqF17E3o/fI3NzG04GabeBdiab4wZJ7iMPRC9byafwj6ssFqD/OdeHRvM8hSvOobRfzqIX
	GcdA7FXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4Li-0000000D3Kn-0I3l;
	Sat, 31 Oct 2026 08:22:02 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN4Le-0000000D3KO-3Z9G
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:22:00 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-369f33df08eso2970246eec.0
        for <linux-nvme@lists.infradead.org>; Sat, 31 Oct 2026 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793434918; x=1794039718; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2Ycxsi7bQUBl6s3XkEfGjThxfYRK7mN668VlKr8sgY=;
        b=LeYlLJXVRyPs/xAQisNzZwwVCChfD0UWQC1Kb6Gh44yBaSgxHjYSJbp5zljvbwNCMC
         oVWktmvfqc6xA75O9tQbA86X8iCpQJByx9R+Oniqd5IrkmDvn/vOdhVPuQ/CmVEG8kWX
         lhzwjZ+n9rdhoo9NeT8ADYWUHryd2Uu1wR0VEY9K1o8e+FSlhm4KVgtP9V1x3ZSaK/Vh
         grmSdZrzj2albbviKSo8iyDFDwvoHtqPV52RTpSICew7ZUUqjOMWRcrfYUtuOYhozZxp
         uAvV+AFN5XfUeNq+cvgSjTQYSpMdybWdJ92nx7FdkbMOsQAMswY756TnOmWU3GoI8Agb
         s28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793434918; x=1794039718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2Ycxsi7bQUBl6s3XkEfGjThxfYRK7mN668VlKr8sgY=;
        b=weTM29QDj1R3GRCHuXGNZv+9LbIdngwxYtOfucTaP87s69EBezDH1xMdsH00dzx27y
         f+d8hI2pDH1lE7KN7yimHIYbOPexGptwzzVyL58AZuL8H7iYL0eOK2tdHr2HgnMWjjta
         Sj7PhsYOCdZMcsAB+nInmzv+m9gqNg1LYKC/3nJnYVYYWWSk/VaVJHw14Vtymv7uJtDT
         7JvJpte8nz1wkOSQxYaSd1kWxSZnAXH3fkmsT3AUuDDSEI0+FvBSo224PpT0EOw2zT+8
         i0xf0Akgx08WpX4J5Kr8sSX4an0ql6F2LK+rUn3j6R7MvYrRdmbPH7+pa8fUbDsnyRrA
         609w==
X-Forwarded-Encrypted: i=1; AKwUvBxYT9OkERSTkjqL0yufj7zgw5iBzrC1F0bUpjou9AFE074ioNZWFgPZ8+zKhncneeYF37KepUiyYme5@lists.infradead.org
X-Gm-Message-State: AFq9FYJwrWNrU6U5xTvBYwcoAaU29I+NoYgWfw0P0ajp6QRB9Mni+8QW
	eSkLTK9FKYYHet7KFtKuSuw0ZgBrHWKO6J1WLcZpomFqp35jQLrK8OmlHYefxMZgUjM=
X-Gm-Gg: AYBFou1cL+YCh0MOVq//lBMiKNxEGYiP3N8ZNnFHxqf8SWj2ZdLQ2KNsXNLVpVgDxM1
	bo5YDa3EU3/oBWuF8KbdpnBZDkTzye3e+p3c9fyT/tyAZiNf5BMGZ8fEc2NPypu8lV7aiAOc0yB
	+strYs2nomHV7cZDEfm3IeDIoEHAZtkA55tFnIiAf6/xb2kCDKrmPhr1Oy0DWNSx+6wLa3OJxhR
	63dPsvhfJJU1nCACXNm3ZuNOHZ8dv8bWl1UIgAiwxDTaKA32aIyCHIraw0n8b7EZCh2sioeoPjX
	bf6SSpQOaMqVweA5gD492BbqH71TdECWshTloy+P5hEaMZF9gbhxNvV+vHlDVmobDeCTeuzBLPt
	FeI5sBTfKwaxMSxJ2cxEHF93jhFfJeDb/YJgltawnsa2fFkpCXtGhVCI25/9oRgy82cU10cxGkh
	1Zzn1mU2dXT4FewSaHfxrJplMAbYVTu29oHWgOVG/IrXQxFBvpkOIXqh4Lcn1f/1KJKdvXZCBsG
	Etu9qmpxP+3aWVOjEbf3SFlhpw/lSFV8HHh/a6dBkga7Rb1yrxSqteQu9vVzV3+cpILImI9ooiJ
	9CyqWiRqbbFeERfvsS3zryaPcgcfl9X0Ats=
X-Received: by 2002:a05:7300:e9d3:20b0:369:fe81:a575 with SMTP id 5a478bee46e88-36a4243ab94mr8009376eec.35.1793434917521;
        Sat, 31 Oct 2026 01:21:57 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb92:580:a705::6b74])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a42902649sm16685719eec.11.2026.10.31.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:21:56 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:21:55 -0700
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
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Message-ID: <20261031082155.GC34016-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
 <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261031_012159_070936_51BA0B79 
X-CRM114-Status: GOOD (  19.28  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 10:55:10 +0200, Daniel Wagner wrote:
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> > +			       unsigned long deadline)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, now, tmo = 0;
> > +	bool completed = false;
> > +	int ret = 0;
> > +	u32 result;
> > +
> > +	init_completion(&ccr.complete);
> > +	ccr.ictrl = ictrl;
> > +
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +
> > +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> > +	c.ccr.ciu = ictrl->ciu;
> > +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> > +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> > +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> > +				     NULL, 0, NVME_QID_ANY, 0);
> > +	if (ret) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	result = le32_to_cpu(res.u32);
> > +	if (result & 0x01) /* Immediate Reset Successful */
> > +		goto out;
> > +
> > +	now = jiffies;
> > +	if (time_before(now, deadline))
> > +		tmo = min_t(unsigned long,
> > +			    secs_to_jiffies(ictrl->kato), deadline - now);
> > +
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	completed = true;
> > +
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	if (completed) {
> > +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> > +			return 0;
> > +		return -EREMOTEIO;
> > +	}
> > +	return ret;
> 
> 
> This part could be made a bit simpler and there is no need for the local
> completed variable:
> 
> [...]
>         if (!wait_for_completion_timeout(&ccr.complete, tmo))
>                 ret = -ETIMEDOUT;
> 
> out:
>         spin_lock_irqsave(&sctrl->lock, flags);
>         list_del(&ccr.list);
>         spin_unlock_irqrestore(&sctrl->lock, flags);
> 
>         if (ret || !completion_done(&ccr.complete))
>                 return ret;
>         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
>                 return 0;
>         return -EREMOTEIO;
> }

 701
 702         if (!wait_for_completion_timeout(&ccr.complete, tmo))
 703                 ret = -ETIMEDOUT;
 704
 705 out:
 706         spin_lock_irqsave(&sctrl->lock, flags);
 707         list_del(&ccr.list);
 708         spin_unlock_irqrestore(&sctrl->lock, flags);
 709
 710         if (ret || !completion_done(&ccr.complete))
 711                 return ret;
 712         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
 713                 return 0;
 714         return -EREMOTEIO;
 715 }

Actually, this code has a bug. It does not correctly handle the case
when CCR operation completes with an error. I added line numbers to show
that.

- line 701: AEN, omplete(ccr.complete), x->done++, x->done = 1
- line 702: wait_for_completion_timeout(), x->done--, x->done = 0
- line 710: ret == 0, x->done == 0, completion_done() returns false.
- line 711: return 0;

The problem is that wait_for_completion_timeout() consumes the
completion. This causes completion_done() to return false leading us to
believe CCR operation has not completed.


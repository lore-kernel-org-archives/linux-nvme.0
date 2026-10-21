Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A15606A330
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T8NI9wDl;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=RWvaW8cb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plcuA3qVi85xQIO4mh6Ev7EJr32wMKiIckXkpumk08A=; b=T8NI9wDldJDxXZ4Iz3BUAMkq7R
	Z/nmVvaF1ofKcEZyo/HmjkIQyabX39xTE9sgVq9yy1ZoQkbB/jZz9TaoUVVRI3QQLJsuTO4e1n1U6
	TVgJeMAQBTZJ4vKY7pBPXHnigugZur5bzJWC4hpACJ6S/GZETe7kimctaIGb/A41vB63CXvGL1bHJ
	uT3SgV7Zmc04kc3omhn7mWqjQAuBwIEMol83LP5kOluuvj8GUfY58GWTvkajZ4Djkabl9x9V6+HQF
	6WiWbozJ60dTOAR09x0enJxyyUxtZq4EIOrf7q/0nN9a0EMTyv7p7H7OpdDzo7BKYqwgiLoRdK3a9
	eJnE3U5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJb8V-0000000CesG-0Ewp;
	Wed, 21 Oct 2026 18:34:03 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJb8S-0000000Cern-2qnm
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:34:01 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-156cbe59622so762430c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792607640; x=1793212440; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plcuA3qVi85xQIO4mh6Ev7EJr32wMKiIckXkpumk08A=;
        b=RWvaW8cbmtom6tkyBQWpwNvjIHnkVMhTuRUH3xrTcCyR+vhhEBtSW+wvQKA4mRGkoD
         6qfVnpYudqHGPSU+sJcN4Epjf7EjmQW9UPevB4E0AlLU2IMVBA+eGZFry4QwnLcfOANQ
         JmaXegC+wzUoFLzrs92bj06XGSx4QFlCbWUNmkgg4rx3lX9ZLaM7E9LNu8AFEgEnAJVQ
         9ICwu/TcxjWgmOsq/Uz7Vol1sOnm3XwwDCINNdMLGyVgdcazs1FO/ixWcy+ibTluGW5r
         ZokhvLaYJ8oDk++fPcFdHcYiKA8Q+uqO0oJ4B8WnjWjKmapeXHEmp1TIPUVQzzym5hNA
         /OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607640; x=1793212440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plcuA3qVi85xQIO4mh6Ev7EJr32wMKiIckXkpumk08A=;
        b=V0bUoBWvGMOwjqfKD/jg+3kmlgfVNHMW84tnGeAs4b+12BzLehi97Ekbvpm1A4dFah
         hMIRpGJgiB3N6Z2g5DSKcpvjUotii5w/gBXgG3RZufEhD69ILy9A0wHxiOlKWvGo0r+G
         JBYZc1SMv63LrYVAHNZ8RFXByMnqiiGaD0aRPNm/pJ2eM9K/Tq5pLukgI9gizuJaquUE
         AgqFYAHEa1UQ+l14/7memP8VPzkd3yG/IzefPOhqLGaYIgkDcz8ZNulDMviHZzNZIgBy
         WXERkr8YX8CsfW5jbBea81GOVaXFZNCGE2j01g/oqVG6L6tN+PDFRTvgSs0qlil9utye
         MaIg==
X-Forwarded-Encrypted: i=1; AKwUvBzBM+46ebYDC3LoPL9YX8akRJ4hderTQY52kBB9ammnU6V0zhlNOeMUsICPUBXxXz0mellWpQHezQn1@lists.infradead.org
X-Gm-Message-State: AFq9FYI+GcH1AX+6k8UfdixB/otANYohXgS0fpEIqJSmd3cbnNlK4+sE
	FjbB48MfhJB7o81svgUF5abpM37k1IQqNhP50CtzELKzUU9lvXlNJz/1m7fci2UrToo=
X-Gm-Gg: AYBFou1yb42XBh33zY61+H6pWM5WJyNkyfFo+ze4/njCVtPfWZ9OdOYwyClFWBtiEoW
	V+aGWil7GDsLcSwjk8LtQoVX6SU1Snfprkg3f6ww6m6ZM5fP8B9pofRPhayDDq/mzKE2lpd7+Ts
	yigwuxeWXzLtqe+dQuH84kOwKS2OTh5QbUvfoIR60yWb2OqYKLwRU6jsxyIfN3jTT8bEUmEbBWa
	eTsQ73sj87Tf0tNjoz9Y2+FrdC7uYU4uc/oJlg2P+VaOAuGrwMMIpd1s5PeEtTEOtFy/v5j9Iv0
	Z7N18A1+t4xODcQvRPyp6iWnS6EniT8yErQ/m1dWVzWJ8pFalQBfmgL1uss3QSklYGGq802YUGz
	1kWQSnNQlAlYy56I0n/VF790ExqeFqHmZQpXHHJb3ZyK8nVsM7RRxDcciEdg435FPaIsBAWPvNg
	p6jy9jl9lHuS07+Q2mx9IMCom+F/ggXX8XtWweuA+27DyH5yY76hY65fswN9fgDSGYf3IsqAqVy
	GIgQLRAn3NZYsSZEYcQIiGSEMzHSSx40QHhUUpCAO1iqjUlMJznsthrH75b3pM9qPf3haKAEHBo
X-Received: by 2002:a05:701b:2059:20b0:144:fb31:a597 with SMTP id a92af1059eb24-190a738126dmr3541263c88.47.1792607639443;
        Wed, 21 Oct 2026 11:33:59 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903aff3481sm8406817c88.10.2026.10.21.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:33:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:33:57 -0700
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
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <20261021183357.GX2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
 <20261019212630.GN2931-mkhalfella@purestorage.com>
 <7e73057c-698a-4ce6-b153-3b8b1077f77c@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e73057c-698a-4ce6-b153-3b8b1077f77c@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_113400_736980_43683837 
X-CRM114-Status: GOOD (  18.13  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 15:10:11 +0200, Daniel Wagner wrote:
> On Mon, Oct 19, 2026 at 02:26:30PM -0700, Mohamed Khalfella wrote:
> >  Description:
> >  		Shows the current state of the controller. Possible values:
> > -		"new", "live", "resetting", "connecting", "deleting",
> > -		"deleting (no IO)", "dead".
> > +		"new", "live", "fencing", "fenced", "resetting", "connecting",
> > +		"deleting", "deleting (no IO)", "dead".
> > 
> >  What:		/sys/class/nvme/nvmeX/numa_node
> >  Date:		November 2018
> > 
> > 
> > How about a diff like the one above? Similar to CIRN and CIU, I am not
> > sure what to put in "KernelVersion".
> 
> I think the KernelVersion is when it first appeared. I would leave it as
> it is and instead extend the description
> 
>   		Shows the current state of the controller. Possible values:
>  		"new", "live", "resetting", "connecting", "deleting",
>  		"deleting (no IO)", "dead".
>         v7.5 introduced additionally:
>         "fencing", "fenced"
> 
> Obviously, this is not idea. If someone starts to complain we might have
> to filter out these two new states.

Is Documentation/ABI/stable/sysfs-nvme a living history of sysfs-nvme
documentation or a documentation for the specific kernel release?


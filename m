Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C02606A31D
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a7pAQKTT;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=RuxlzoYu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WFZOXzn6veCZIAF+JkkHH6W85OOUZkO3tjuMxrK8z4M=; b=a7pAQKTTUGO7wEVMK9y70dxyjY
	4DktMZBDm9zxRVeyBgbaY5rYdRGa8hf+YZsSCRxocme19zha51YYhgRxWZZEDTYagpjYfbMBnfd5h
	ljTyVtVHychpwc58kj8Q4LsXn981cSeTvA7uF4kq+tCTxgstSi1oAPdQofilQkT5+lo8TBP9NZrS7
	8YbM+PA0W8kWlk+WvlI33qJ3nlqy+cY3B1i8hOfQFqf64ckDMXuIeq23vgo0gV6CUbu3K1MWwn6AY
	yfdTT5SYWf9byZmqEDuWqUiJ0DPXwkqSIBg1q5FReEIcGYEnu5L6kC5ATLITPuHsAKCzUDp1YYlQG
	h/sVUc+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMs89-0000000CTpy-1IXn;
	Fri, 30 Oct 2026 19:19:13 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMs85-0000000CTp4-0UOV
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 19:19:11 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1adbf62dd31so869869c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793387948; x=1793992748; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFZOXzn6veCZIAF+JkkHH6W85OOUZkO3tjuMxrK8z4M=;
        b=RuxlzoYuT+opoj09cycq2CSrfUY1/F7OHa03ojSQ2E58NN1Wt3MwPqQKvIzfQKmiZ5
         p1L0JMyAXPHdBx6+VMuAcicBVPKpE6UMGYyX/BytJYLsM6ubiDEJlSN7q/oD/HzCjVmk
         BOuGoqLh+n/oofC2G+pCCqROw1LsRYl+eJd4S0SKvcEyqF0TxAT/POG1q3yj8tXURayz
         LA6xp313B9xT3ZIusUJULd8n5ciq8HX0OIRKdPbiQ8WpTQNoLIgxfpPMPbxoE5iymYBb
         9MH7XXknghcg8lZGWYLP/VQFSLfXI3kx/B50nHEeTEK3CiHTVxBzjUiVALUKeUkPe3cC
         8IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793387948; x=1793992748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFZOXzn6veCZIAF+JkkHH6W85OOUZkO3tjuMxrK8z4M=;
        b=G+EuFqPyIFygd09KpKmZrcfpihCOXgSC/4M7Hir/Ww7DtNKlG3JWUia2GR13feBivM
         mK0ofmmQaYcRnIVQi+W82oVmU/Z5PI4cNRP+WwAv8XOclZFkgS3rZcDJ+3b/h0zPxXuM
         PyJrZDzSE3fL4bPp+z0xfIwLLnLaHCz8+UsDtYMEYNVkP2myhJn2M8CawDyuTI7mPujO
         KgfAKEXcyn7aEkZRrxQ+HQO5SbL3RrQfdYFntIEw6mSi5kIvacMdLaT0zCHDSaxmhgQ5
         p5/QCJQz33KTpP4qV4OrRIsvPm3XFSZCLx/szlV4saWqGekfrrD+NVADr3MNSiH7pHOw
         bbPw==
X-Forwarded-Encrypted: i=1; AKwUvBxfwIAqklIAT6h+s4huSGt59kdE6uz9k4XEOdPx5c68P8Zd6iv2YcD9dOyJQ1RUpfQpKdgyUIXwiZPx@lists.infradead.org
X-Gm-Message-State: AFq9FYJaavzbS47d+4cXlS4gYJtrnWVvD6fOV7gJsLZzhXwXnfqoEJIE
	ZuZoXEcRS5v7UKce3l66G+w96K9jVhG44/k6Je4i8+ZBeQqPvA3uIfY4YLopzNH4J/U=
X-Gm-Gg: AYBFou3YnPY00EidIIrGUhzkm8nmW4DihXFoiUaWPXvfOIDVP7hOInTMbrXrZ4WmeBz
	+LTJ6yX5DBhzLrNuPsqXzGDFA4q07/9bidOecdCljzxfnI03f/1DI8pMBp0ByAn16uCT+vUC+pi
	f0tzl8Chqj+cTBUUII3vyZ1tQiGJzSHtxcTbCyrD1z9C054mr//3xCx1dKTjx84MXooXiRlRL10
	wLYfIjf5DgXla85V50P8ko2OylbAwqiFpnrBk0MwdMeSM99pGVBvVv5+UOZQ1LCsMeIoUyel8cF
	UCJaJ/6hAi6yICJHq8ymggHLwhjoQuAYokP/mzamKmNgrk0DZ5lUJ9fPMboHkDfS+Sb1XQG7O3E
	Bn8sUOGLj6bfhDFv3DDDwnlrzmLZmeODw5JWDrx7pf/ffJlFm+pKsUXXEIwZ3zFHnANMiOysS7+
	faxwANkcpv1qEaVOOiH3m8+PkYVcgkpKqfC9QHd9pxdgdVE+/Lr8h1370Z2uxKMgQluAoFh1zpE
	xlZlZhOt9dxzlxRWberPdHT0iAn7Gdd4V+yCmAgX9AU7CEalOPLmF5iSnnjqYEURwdD2i7w3GIi
	PE55T0yyJCxKZ5jgRE360s2LCyWvEGHIarFjXnSId9hIwrgRrtw=
X-Received: by 2002:a05:7022:f115:b0:1a2:1a28:9348 with SMTP id a92af1059eb24-1ac5e22840emr3810130c88.37.1793387947237;
        Fri, 30 Oct 2026 12:19:07 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm14623889c88.10.2026.10.30.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:19:06 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:19:05 -0700
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
Message-ID: <20261030191905.GC122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
 <20261019212630.GN2931-mkhalfella@purestorage.com>
 <7e73057c-698a-4ce6-b153-3b8b1077f77c@flourine.local>
 <20261021183357.GX2931-mkhalfella@purestorage.com>
 <fe4f3c98-492c-418a-9ff2-b3c6cf5446cf@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4f3c98-492c-418a-9ff2-b3c6cf5446cf@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_121909_487331_543E226A 
X-CRM114-Status: GOOD (  16.57  )
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

On Fri 2026-10-30 11:32:52 +0100, Daniel Wagner wrote:
> On Wed, Oct 21, 2026 at 11:33:57AM -0700, Mohamed Khalfella wrote:
> > Is Documentation/ABI/stable/sysfs-nvme a living history of sysfs-nvme
> > documentation or a documentation for the specific kernel release?
> 
> I understand it documents the sysfs API. sysfs is supposed to be stable,
> so adding a new state is factually a breaking change. The document
> should document the current API the kernel provides.

Looks like changing the "Date" or "KernelVersion" will make it like
"state" attribute has been added new newer kernel. That leaves one place
to mention "fencing" and "fenced" are added in newer kernel.

--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -145,8 +145,9 @@ KernelVersion:      4.11
 Contact:       Sagi Grimberg <sagi@grimberg.me>
 Description:
                Shows the current state of the controller. Possible values:
-               "new", "live", "resetting", "connecting", "deleting",
-               "deleting (no IO)", "dead".
+               "new", "live", "fencing", "fenced", "resetting", "connecting",
+               "deleting", "deleting (no IO)", "dead". "fencing" and "fenced"
+               were added in 7.5.

 What:          /sys/class/nvme/nvmeX/numa_node
 Date:          November 2018


I added this diff to this patch. Let me know if you want me to change
it.


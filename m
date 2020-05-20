Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E5FC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FAA2072C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoYPJnlM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsipvN1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FAA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+I+Ls3c6yVYDLwpbSRJgxemggVJSzN8vBi0Oc6P2JE=; b=XoYPJnlMuUtdPU
	Yyful9DauH9U7wlOmsHbDOBkYgz7TZycTEPu5Utic1djXZd7lfNYsJcbG9y56zVJkqCiSY6xUTiFJ
	GBJcQYyQytN4LRrYs+AcK5VCbGqKQc+cZEbqIWMiaFhOmIBkiDcdzH6U3UrlVxZoIaoVREsS4bI4f
	aO+G7qBjxLZiv8Kt2v/bMaLwrCYRyu64m68DKtGYHaeqgPjwxtxIvSG73+KhhZcpwFDPcxi5gAXUK
	i6cVXnozkSOuVf7P2WUTTN//Nv/wT+sXSLZsIeck/cTnOMS5qt9MigzOJ0wwUOSH1sWp4kpu3jl+A
	y9u7MUxOkRXG09cMdedw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbYIz-0007dZ-DL; Wed, 20 May 2020 23:39:21 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbYIw-0007cf-Cf; Wed, 20 May 2020 23:39:19 +0000
Received: by mail-qt1-x841.google.com with SMTP id o19so4081482qtr.10;
 Wed, 20 May 2020 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=usgVE9wGsTmR3Ul4KmzuJXmMmNEoxcCV+K4pKCDDnEw=;
 b=FsipvN1GuGM9UbR7VsW4XkubLiUqC8Dqtu7L937s2qadx/bxbgPsMl9fWYiJlizujH
 c9qxkVWOxpVMlAT7nNkHzdOL6XRXbCOpar1C4DQC47Sws3swXaaqI9YAuQyLubSZ0OK0
 rRko/wzRAKCkIy15w/nWQBRVBLwMvtGjJCE2gisIPTfPY2zdgnpj1FMzVNCnVI10QH79
 YBAX7tezDRj2K0TOr70GJg9yP9kYgu14VxvOjzih8uvep1FVSB5EojcU0QtKwd0T+IdB
 hjRKTNxmgJ9liw0vUGr1peJpzaW/R/f+lsktCjxXTndLxOoBi3/frCJqvNi3QaPXR6GX
 kpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=usgVE9wGsTmR3Ul4KmzuJXmMmNEoxcCV+K4pKCDDnEw=;
 b=Zag0grC5Yb9ko1JUuSINyXvdAXNFsK8FOWawLUx4atU1VY5tFZvVWynnXmHPvH6RLq
 7qlsUqmJDEEpBAsMh2A6osamygGsq6c2ASDZbnDL1k2EpQLZ2qN8tcTNudpyxJmT4DhU
 jLKuag5+LDeetIRCu0YP6rScm2lIUnUDP+nNo9ZMEI9sdUrsogzdqAOUzVF9pJBW/wc1
 btQYZxHEomw3G0v/dtWZyU2DCjgPteFTWCAfs0dtNH4AO8EToFLIXBf2RQ0+Rp5xN9G5
 uDreItfwyEuiUl0m/RweCGrvoi8/MaXtPOH5Ek+yKs+lnTPoZFLYoTQ6IWyI/mveLO5Y
 A1Ww==
X-Gm-Message-State: AOAM533x+EGuxsFJDHZSrxwopLvFjHDl8rgssoAMo3Nf0U7EAo1xx/am
 Ds6/VNrF4JQhTBYBo8rvNPk=
X-Google-Smtp-Source: ABdhPJzb0RQavdlFPdZ2esbonBQnAnxuJh+Wdn80ZrxdL0NcIMXKvb5xhinFWySzKcTGVqX7yVkgxA==
X-Received: by 2002:ac8:1af3:: with SMTP id h48mr7625941qtk.371.1590017956516; 
 Wed, 20 May 2020 16:39:16 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.225])
 by smtp.gmail.com with ESMTPSA id z10sm3685208qtu.22.2020.05.20.16.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:39:15 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 43E1FC0DAC; Wed, 20 May 2020 20:39:13 -0300 (-03)
Date: Wed, 20 May 2020 20:39:13 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 31/33] sctp: add sctp_sock_set_nodelay
Message-ID: <20200520233913.GV2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
 <20200520195509.2215098-32-hch@lst.de>
 <20200520231001.GU2491@localhost.localdomain>
 <20200520.162355.2212209708127373208.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520.162355.2212209708127373208.davem@davemloft.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_163918_446361_D4A08281 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: edumazet@google.com, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, hch@lst.de, cluster-devel@redhat.com,
 kuznet@ms2.inr.ac.ru, kuba@kernel.org, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org,
 netdev@vger.kernel.org, vyasevich@gmail.com, linux-kernel@vger.kernel.org,
 jmaloy@redhat.com, ying.xue@windriver.com, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 04:23:55PM -0700, David Miller wrote:
> From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Date: Wed, 20 May 2020 20:10:01 -0300
> 
> > The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
> > Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
> > API could be a bit more complete than that.
> 
> The APIs are being designed based upon what in-tree users actually
> make use of.  We can expand things later if necessary.

Sometimes expanding things later can be though, thus why the worry.
But ok, I get it. Thanks.

The comment still applies, though. (re the duplication)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

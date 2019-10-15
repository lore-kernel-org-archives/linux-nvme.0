Return-Path: <SRS0=iuM4=YI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D222AECE59D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2019 23:09:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62962064A
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2019 23:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNMTW5iD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ndzXv4fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62962064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4tQeWRvkErFEPEzxuw12Kq6rLt+POl145ZYbijBI5x4=; b=kNMTW5iDhYTFI1
	dCLeIo2/tTPKJVkj5srZODhHbplavk+OmHa9jfoKl0TypvKWRw+9APFrInm0/BqDJcaJG7rex1NkF
	nXkR3MatWqUUQeXB2wwG+pVyj1KzH/I2q67rnddY//BHWZmMLOgsRjaP7ovSgwdLuaOqUMW913IUL
	bJVrDCf2dheLA9PY54Yx6RF1+z/cbAJGRM0Iwo5fDKh+/2aouZ/s1OAOCIgVLOHd6CU8w0LqWH++M
	kvrWLvFPEK2vc3VxDeaMCjUqQAeQs3DwIDJyWsmuCOJV+Gda7FDzFrpdupMLrsLD9CoLzcUcKTrh3
	hREU9Esvkro/t0nDuREA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iKVvy-0005HF-R7; Tue, 15 Oct 2019 23:08:54 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKVvw-0005Gk-AE
 for linux-nvme@lists.infradead.org; Tue, 15 Oct 2019 23:08:53 +0000
Received: by mail-pf1-x441.google.com with SMTP id a2so13420933pfo.10
 for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2019 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=T15lTYBpQbYj/G8GLCYZUILrfB3Jwz4M9cchF+mKnB4=;
 b=ndzXv4fzXaenGVr4iNtuiIA6JUMRYo0CY+3bD4OohadcchwE+pJHBfmkNBhppQ+zdj
 +SEZ5IFpzwvCjA8EAsQhMLRzc7C2JIN5s++7Qbyz1FIGMNvxnX1xHrznCO/rT3DJL2SV
 nWkcqFCzdBpQ/5XWbzYVWRRmk8J0vhoit00h1ogNhC0Ogqir0CeJxIIaYENPdzse0L3p
 KA7Wi6c3Rn9pYCrNDq/PPHF5zXja2oHRA6uK6BXifqgMu46NMQwxiMJ6jnUCTG7HRnCn
 Ul8qpxTOSvabMtSWkR7W4Ff2koEZ5O16Z3+R8XKPhTHRpiec4upjzqBxLh3JJIRhXK/y
 Folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=T15lTYBpQbYj/G8GLCYZUILrfB3Jwz4M9cchF+mKnB4=;
 b=fqWp8r0OkuN4GPNdi1taucOSuvvGLXzCXbEDggceA9aKXrgloB/qwCUuvrtXaebuna
 2ovZY04V6dQ4ACpwooTy6Y8LMNPr9S7P/sgT15+IxQmls5ovkI5wGkoYMEX3jm3EKCm4
 bsuwIq+gUfzDLfzKAF7KZSlq8X6k6D7x56WguCXkSIXidMYabuOESIIZygo/XtdGDztT
 gnh+VO8b4jVhj265rtk9Ioc43/+gxnv6h8zTgytzUJVq6s+/OIFy9tTJsEPu5F463Z3y
 Y4K3ty2GVby0rX4mHNPXjYW89D15AvEPmbCTBtxNrX5OC1We5IDDgN/hUYFgdNbR2iWh
 sKXQ==
X-Gm-Message-State: APjAAAU0Mfa5fCikEJKoW6vb+8vBLMR/vJI5M1B2rQhdAOqmysvF1c3s
 UFHT6obJawFk79crXeiBcQj+7g==
X-Google-Smtp-Source: APXvYqz/PanUTBoeo6JC49Cmj7Rc9OxT37Ow1lArdnJ9Uwvf6ZqrLa+p3HUtf1PkSS/7UvNX9VXK/A==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr42328040pgb.416.1571180930873; 
 Tue, 15 Oct 2019 16:08:50 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3e5e])
 by smtp.gmail.com with ESMTPSA id n3sm24944514pff.102.2019.10.15.16.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 16:08:50 -0700 (PDT)
Date: Tue, 15 Oct 2019 16:08:49 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Message-ID: <20191015230849.GA483958@vader>
References: <20190911172021.5760-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190911172021.5760-1-logang@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191015_160852_357479_40596536 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: linux-block@vger.kernel.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 11, 2019 at 11:20:21AM -0600, Logan Gunthorpe wrote:
> A number of bug fixes have been submitted to the kernel to
> fix bugs when a controller is removed immediately after it is
> set up. This new test ensures this doesn't regress.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> 
> Changes for v3:
>  * Drops the double loop_dev declaration (per Chaitanya)
>  * Collected Sagi's reviewed-by tag
> 
>  tests/nvme/031     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/031.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/nvme/031
>  create mode 100644 tests/nvme/031.out

Thanks, applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

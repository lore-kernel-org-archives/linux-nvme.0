Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410BFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 16:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F275360E97
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 16:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F275360E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=34KqGsADswDnjonTJQq114bRqQgkKcPCrw08YN12k1U=; b=D/SJcbqUclSPDQgdHT42MCRKfp
	X+Q00TuO4q0wKOjB+zUhn0yT8iQiqzYX6cftv0OcER3EXMKpmWPTP5U1E8GGZjDDjl87tfAcThlU1
	DFErZtT7UwHDv1IbIULcJphG710F7gUeJrsg4dJbg4bRbo3ZwWKXtZK6U48BKnua2hj35EaROziFs
	hIIoSWZ3AEW18QwT6BWW6qDfycMo4bmEE6hNubPRqWSvsy9La92o/060GkmVTeFDn4CgJL4Bi0+ZI
	L5Ioa1vRMjNAcEqD5uC1ONltOmoCj4Dsx8dDUOGTJn6MfDSLiaXhCaLUyjKCgaUcRfJzBLE/ohUBD
	3RrAzFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mf3Fs-00H7dO-PK; Mon, 25 Oct 2021 16:55:24 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mf3Fc-00H7af-Sz; Mon, 25 Oct 2021 16:55:10 +0000
Received: by mail-pl1-x634.google.com with SMTP id r5so3772241pls.1;
 Mon, 25 Oct 2021 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=34KqGsADswDnjonTJQq114bRqQgkKcPCrw08YN12k1U=;
 b=ArdZ9P7fyJ7zJHFYx1+AQE02HbDLJAUvr4erZl2mwbBhtH4+TimE4u+ugqvNFdwh8d
 3/k33Em4/TsoIsweBaglse1QZQgHs7wcFn8ECUkcngi4ODPtbQO4Nm9N6HsFFQgfLYjO
 RePbywXUgZ4jXqcZxI7CJfFNDy98/HjjX5D5DC2BF8G+I/IOB9VG5SIpJ3tDITv0dJRl
 sUJ6d+ibD4KBuChDdczeAcIBzNl30xwnxblX9PJBRPoGnixLoKyw7+/sPO6a5ErIzVMp
 go4JYUYLmAuef1oHBLR/IOfONu/74SlIlF3dwUs57Wqyht+Hr5rXw+CnNSGJhGpEkKIr
 iTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=34KqGsADswDnjonTJQq114bRqQgkKcPCrw08YN12k1U=;
 b=QHrCRaS3pqccmKr3kYDb+WUaf/udc01+xssE9dFquupKwZCTpbatliMM14g53szZiW
 361SBoVl5HZ33lFlePWbSu5tTN3a8CDZijx/GLuB9o3Mtka5d4VoeSFnY52xpBwcSY8D
 0UEzH5PGelybhkyrU+oTX4m7+ShTtQJETffM55kFGXqd91j89+JAPML3NHWv64HK9zAT
 Kax84fvCG6YFGxiO55GTF1ui866uOu+CJnSZKmkokHMohkxjqdgqQ1ovz7QsJacvqXsu
 N0ojVsRldND/gWkTLFQpe36AxthMCyib8h482vgpLSXcbJQI10Dpr0f+CsTbgN6dQ/Xg
 9bHQ==
X-Gm-Message-State: AOAM531A+BXReSCFpAEP77gB8DFcS7zqxJBlQ5dZeZK30NCeJErQafkl
 Jh7AYXKXcaSHczpX+uc2Clw=
X-Google-Smtp-Source: ABdhPJwnOC5S77AdBEAZhaiGNLZ1LAMQYdWuNPBpW15141iALB0JrDnj2gFivuKTGQtzXuB/cou/UQ==
X-Received: by 2002:a17:90b:1b49:: with SMTP id
 nv9mr21773068pjb.134.1635180906379; 
 Mon, 25 Oct 2021 09:55:06 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:676:677c:1b95:77a5])
 by smtp.gmail.com with ESMTPSA id c15sm9853456pfv.66.2021.10.25.09.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 09:55:05 -0700 (PDT)
Date: Mon, 25 Oct 2021 09:55:04 -0700
From: Minchan Kim <minchan@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 ngupta@vflare.org, senozhatsky@chromium.org, richard@nod.at,
 miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] zram: add error handling support for add_disk()
Message-ID: <YXbhaO5QAOi96E8j@google.com>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-9-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_095508_968179_E9AC6437 
X-CRM114-Status: UNSURE (   7.95  )
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

On Fri, Oct 15, 2021 at 04:52:14PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>


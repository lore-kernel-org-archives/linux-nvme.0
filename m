Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50BFC982D0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bB1zlv4QaH8z0SQSRals0luwjzNLh9auRznOToW/aY=; b=n1bAevT8UcX9Zc33pb82l0ZI9x
	8+3iCA3b9sw+mfc2xARB9FcjBT3ZYWHEtb2+XO5yILPDZeAjFV2jDeU/+nM9eCwqojzlc/m7zWtsB
	XWDKCeTT1a60ZX9cu6D7VLrafTNLJdhbzKKa8LHd4jLMgFvCK6hfiQYWWJ4JIO8Y1lLeMQ+HAojdR
	21XS/S7Z6CNJ+lY67INFSnhWLgyEn8jr3Zcls24z4D+yd57MiOyfDpem+YvxwAjiSlnx7yHphGDGM
	9f8vkEjeWU6P7DN4kd74Qa0uC8XSJODua0EISepg0mpgZjxHhSOL+hZhUH2In5P0Q8PfpAQbZoH8d
	2X3lF6hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7IAb-0000000CNNK-35av;
	Thu, 17 Sep 2026 19:53:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7IAa-0000000CNN3-1en8
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 19:53:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D3D6C601FF;
	Thu, 17 Sep 2026 19:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3A1F000FF;
	Thu, 17 Sep 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674799;
	bh=/bB1zlv4QaH8z0SQSRals0luwjzNLh9auRznOToW/aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9ciFUqs6yvARJwh1q1NVSH260DNVgqwTys+21WMhSZUgeoN1SIZVT1wsT+hx+MYS
	 /cV9cA7fZX7rTDcwdJP32zhtjmJd4a7GVTIfHNcW0lupQKjheg3R6zgVOujyVI2+/p
	 +WmjNeNTmkvS+ePJdDwP80RkXDDDYCFO012RJAy+kPQd6GZ73KiScgOGep1bSAU1wf
	 HSKqA9YkKAqPMzvUyQ1h4jN35JPaNzL4+ecuKTJPgzltQJ2RMXHAI3JTj4e5TewuAr
	 e1Btl4XCdz1WSn11PlxTnBIBmEIA5AkdROX/K9jEP/TD+4gcwPQZSayJkUHw2JCp6G
	 N2+2t+GT3Sviw==
Date: Thu, 17 Sep 2026 13:53:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: work around all -Wformat-security warnings
Message-ID: <aqxFLAyJPD4D1EVC@kbusch-mbp>
References: <20260917061459.1486026-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917061459.1486026-1-arnd@kernel.org>
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

On Thu, Sep 17, 2026 at 08:04:03AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sysfs code passes two string variables into sysfs_emit(), which is safe
> in this instance but causes the compiler to warn when -Wformat-security
> is enabled:
> 
> host/sysfs.c: In function `cntrltype_show´:
> host/sysfs.c:682:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    682 |         return sysfs_emit(buf, type[ctrl->cntrltype]);
> 
> Print these using a "%s" format like all other instances in the same file.

Thanks, applied to nvme-7.3.


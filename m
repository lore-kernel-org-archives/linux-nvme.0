Return-Path: <SRS0=orSy=PL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94855C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Oct 2021 20:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB6F60F6F
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Oct 2021 20:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BB6F60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAlMTScHP+GLU1q/JYvLVP9zm8s/Fm0ZgIYHVoI/Q6E=; b=zz9xKu1TtcwtrV8Ael7f+xbQfm
	lrTwJhnKL7l2IQBPYEMR+9n6R9ic2vW67W45GldFY/BVLVqSDheeHdgIi0uQMPHCXcaC9zqQcFABz
	lUshxMbU8LqqwMc+c9ZamMZq51n2sjAgfGHkmldppKzcg81bIaNMIgyP5PUoZ+LJKBLJsOSV9CENH
	VxSUjRRZAlR9/3VNe5oN4E/SqJFiELskIz19lSok+ZF4bvKP9X1Xc7WZK4gFlvcGT9dQOxPHfrCJ8
	GfpGbHw7XbDwCs+gZhoTVNtE3JD4uTNKYZJqR8XYlFe6toWGMXaxKiEoVjAmT7IvM2VREoaj/OD7q
	L8ELnMVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1meNL2-00DEZU-Jd; Sat, 23 Oct 2021 20:09:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1meNKz-00DEYo-DP
 for linux-nvme@lists.infradead.org; Sat, 23 Oct 2021 20:09:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF86D60F8F;
 Sat, 23 Oct 2021 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635019792;
 bh=Z2UnwJI+9oAgRIyuriM6ZijPMHqaj6ZBWEKOVaGHMWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MI+Ep3nBT4owULahLaCWGl9KL8jzCcBz/ZEosBSx7FLahUdwTcQNw3Wu4g5YhLNtz
 V3KzXIiGsv61oCtvhyWPNGUyGxhlDRycHGnafuUibektssYpNCNqihcJUuG8QbU7Bh
 D6TYdVMecKhdz90iTBabrAv/Fmztee4QjsE9G35wFA5rmeRjiELxwH9nhfa9TyiHKg
 3CdQVNgKWekds4RqZSoSq25DI3eiDyh7G3N8HNZe5zlnn4Oo2iUAcys2cdm2RtrYGK
 QaboQ9+tbgRb9U5glvxoLoryoksyEEjsq6Y4gk3dZc6RHA+gNcCMfpUg2NO4bZUnON
 NssDCtkbzUIDQ==
Date: Sat, 23 Oct 2021 15:14:38 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Len Baker <len.baker@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211023201438.GA1405616@embeddedor>
References: <20211017095650.3718-1-len.baker@gmx.com>
 <20211017172357.GA1214270@embeddedor> <20211023112838.GB4145@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023112838.GB4145@titan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211023_130953_499498_3147A672 
X-CRM114-Status: GOOD (  12.28  )
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

On Sat, Oct 23, 2021 at 01:28:38PM +0200, Len Baker wrote:
> Hi Gustavo,
> 
> first of all, thanks for this review (and all others reviews as
> well) ;)

No problem. :)

> I think that it is better to use the dynamic allocation since in the
> future the struct size could be dynamic.

Yep; that seems sensible.

> it's not one single element. The "sizeof(struct nvme_ana_group_desc)" is
> multiplied by "ctrl->nanagrpid" and then added "ctrl->max_namespaces * sizeof(__le32)".

You're right. The whole expression got me a bit confused.

> > drivers/nvme/target/admin-cmd.c:267:    return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
> 
> Ok. I forgot it. Apologies.

No apologies. Thanks for your patches. 

> Again, thanks for your time and advises,

Anytime.

Thanks
--
Gustavo


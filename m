Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FC0D35165
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wi1S7xf4Vayw52wAegLIpvCpfBYGMI99r3G+BHSsSxg=; b=TzGIkMN1DlnsrZbeXBPspHMmbX
	dGOE1e2uoTlBRQUBU4qxdgJQ21OKx+Mcq3z/TlcdkX0dWtybWBJGbzwHTMGxyq29sacOY3Qui5ibl
	DD+D2TKcLM1C3jTTsZPE3D65maehZm1ngVeAA1MjMvJ4CgXp8A5wjbS9HO0a2tVYiqBX4FND76wXp
	FSQaOl6oqGoEqOSsiUiD1aOSaAHH8gooD1VKIbnfisXWLnZ7RWyJjF755kkczSdsWpI1cc9voAyqF
	HDyyUfCAtjggjmn6EgWdcYfMuWrSt4jVHbMjLQ7AJx5yBO+VB2ID0aZFiRVueAbbV9t539NnB0T65
	y54KO/8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yZQ-0000000FkHt-2hge;
	Wed, 01 Apr 2026 16:37:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yZP-0000000FkHX-0JIR
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 16:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wi1S7xf4Vayw52wAegLIpvCpfBYGMI99r3G+BHSsSxg=; b=WmcoPh82YqjUdSEKTzBZRBQs4w
	5S/hur3AJkunPgUab/9vPRNhFfve3ZKih9wh0FSXe1ZcKUDG/paTLuufgxpmQneI2CDwhx9+uUUEh
	2E1rDE5dDJpfyZ3obYijXyz2yhT1uuHy3mg8CoSQprHqrMNfPLOA8vSEVC3xJqucBS4BHrI/pZdkA
	53ekwD5iv6jC+vZXm232ljpaDtgo3aOD4ubMplmRovidDczUxvw8TjNv6aSeh4WRNh5Xwp/IFkPBA
	AZoxPhDHBvcYwCmCNnKYnKuaASwOaY4b9paYeguGTRs84FyuVBBegOQmRG5zWXIXd4mxD+UJHeilX
	DxDE3DDw==;
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yZK-00000000uI5-0fXa
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 16:37:30 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5852584eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775061443; x=1775666243; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi1S7xf4Vayw52wAegLIpvCpfBYGMI99r3G+BHSsSxg=;
        b=DjKoxdLyd6lYe6SABZdgZm1znWCGdald8dpRGn0yp/grCYaaj1nznuhiLBa/OpHLGF
         sjyrHkdPB1UZNFBYGi6vq8g8o2ws0Uw+g6nypgJ8QSSSDOTMGGAPUoOFGbZ+AAin8Ffl
         S5mPyLtbqY2oR8A4FxAj1N3MrsiI50nZhfa/yMVlcnCbczQBbL3/x74l1WxK3DA8t86q
         64nzIVpJyYghvJbt9NorkEEIPccg5KCZtPXhdzO71MxTCZsTnLTGef0C3Cx9gkm+1/0J
         B3DpL4sKBK7Uznzd16jhrlRBOCAt0GTa2ogZA09zIzrj2mVaKNK/4th7o7FfhysEyia9
         uLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061443; x=1775666243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wi1S7xf4Vayw52wAegLIpvCpfBYGMI99r3G+BHSsSxg=;
        b=a0RCXDTWAas74sdkny617MJWZVzRULxBX4p6iiMmoXFxs2q2bM7nB4LkDrfl1m21fp
         zkbf8uVQf1OjJ+u/JW4f3fU9q8U2Jc7trydOtevXE8iEYzjE89QxsjfOS8VLHoXX97zq
         124iUVJ9Ugq3FbkzuFyRhBDCDaGH3YlyxIubByIE8JeT+cWt/HVDAQVA5FsR0qbMkpk5
         lU+wIdiY/PY4OQHquPVBIStL20AKO9gLpzB6IrOIiJ5nXTRWBKFKi2c1eLKOJPheWQcB
         tW+xteJDYTHr4IUCNDkoHWkZj7ucgAnwBLOstnVi82Y1GwrJm0QLjA8vTnxAYpia2JG4
         aMSA==
X-Forwarded-Encrypted: i=1; AJvYcCVtl8xQyc8cc4/aqN0FYe31lm0j9FNI6FXp6jC2Lomqr8TB+SeEnIAAjUWUuWy/y3j4yxU3405tyMyt@lists.infradead.org
X-Gm-Message-State: AOJu0YwVtfVq/UIZN/6PlWCBn7Xo4PoNqLfrwtf3YQwUkyV9/jHYgkxD
	dMbh3JX+coPHUv/0kTXed2R6XmqClgsVyHDNFH4dV9+J51qkcQdAJi6Ilr/hevQjeIY=
X-Gm-Gg: ATEYQzwE6Y41jP1dzOyqLFJQrxACuDAQn9XngRHQwqO2CSkRf2XMLwW/9mPPrWX3Dz7
	AneUhfWCFn87/synyJ1ooa7S/+XJ1vKhteT2OODc0qXLDwNGkmq6H7f+adJ7Q9sqcJn8gChkFaa
	Hkxo1Gi06Oemyt2OpjPBFYn3QmM2COrSRK0DR5XN49ttZi50DofyiW32850saUE09aXxiohta6x
	65oCTplE/MDTQ5qveMvKeGvwfJYA2V/nmctnuQtQlBgDPBWL5dvPFwkESWl4/VNe8Cn0o/bwoRe
	Q9PEqQSIdlUR2nwEgKpBK//PYEHsA1F6oVf3TyIucwtFXRvp90rM+ISytcOSVmNNW4ZRDeb9SX/
	8KLTbLDgamNtfL230fTU0T/xu9jUlQJ1pgbG1awKSoPAwuXLyoaWUu9BSRQi2YX4mJu9131/0dL
	IDTGFAiDfxLjI3yOixANLkmvV49nO56Hy9K5zm5Z36JYwL
X-Received: by 2002:a05:7300:6d1f:b0:2c8:1d56:3410 with SMTP id 5a478bee46e88-2c9326aa372mr2348227eec.18.1775061443235;
        Wed, 01 Apr 2026 09:37:23 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2ca7c3010e9sm257309eec.14.2026.04.01.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:37:22 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:37:21 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/21] TP8028 Rapid Path Failure Recovery
Message-ID: <20260401163721.GE2861-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <MW5PR19MB5484E4CD6AF55ED833981C19FD50A@MW5PR19MB5484.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR19MB5484E4CD6AF55ED833981C19FD50A@MW5PR19MB5484.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_173727_089538_DE40224F 
X-CRM114-Status: GOOD (  12.90  )
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

On Wed 2026-04-01 13:33:50 +0000, Achkinazi, Igor wrote:
> Hi Mohamed,
> 
> We tested this patch v3 against Dell PowerFlex as the NVMe over TCP target.
> Below is a summary of our test methodology and results.
> 

Thank you for testing v3 of this patchset. Can you please test v4 [1].
One thing to note on v4 is that a bug has been fixed in CCR nvme command
layout, so you may need to do similar change on the target side.

1- https://lore.kernel.org/all/20260328004518.1729186-1-mkhalfella@purestorage.com/


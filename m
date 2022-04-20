Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09809C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=61FWMBiIp/oHQjo9zys3+M0sljyptQ7R0Qf5Z5MBknc=; b=k2LnsmnvPiTWZLzUeJUnJgSnVO
	Emt/7jXX3dqpH4s95p6bR3TDbgILdP47JC18M6DSVL5MD7Ujyl99YE0PNeKW2F/mtiBlz0vOO79P5
	MQ64JlxtLJ5Kp7mNGzrkzdAZVa3zkOxijqpBmWRuL4X7DdjZpVSA34Js16XTb0fbs9WkCUNllId+d
	nsdI21QXoyhRRIXPg/nh4vMVbXSzxp1O5CK0qmzRRXqtvNcUNcrUOuLiPolhlPU85hPzBtrgqmFEl
	W8MdSpsDemAjIEt4Ub32QSg6wCoLbVKdhWozFOrQJg00qoIaRIqNx6iYDDn0rsNRWc33tyzEakVDf
	O/ZVLnOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhCGo-009ZSf-Tu; Wed, 20 Apr 2022 15:29:30 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhCGl-009ZRP-Mp
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 15:29:28 +0000
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-e5e433d66dso2300617fac.5
 for <linux-nvme@lists.infradead.org>; Wed, 20 Apr 2022 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=61FWMBiIp/oHQjo9zys3+M0sljyptQ7R0Qf5Z5MBknc=;
 b=qfNMbgXhys2URznuKviywGFhiZ668686N57iwamEyUpsg6K+8Akv9WmUP8JSXHvMeq
 yR2RgAVUH7lz2laj04BwucqPLvDlwoozfqrU+X65v0XJDcqHLYN1CbhKEqmchJSECnf+
 bsc+AUzGz3Izx86rlagi0hkmDCCf1rc9h666nI3ifRO8yPETkeaa/AvqYkODLvVPtJMB
 fhoDHF7Ptx5FQxTxBOasz4txQWj2g8CwXR95cjqxFrpKPAQVQalmKEu3LEumbvWZcQ3E
 XUtN5b+KljnfaLAJJ4mbWA+msrFfSGYMoSlAicfOMN6CmLxdSOWNyRnYD+D92OiftegJ
 ilMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=61FWMBiIp/oHQjo9zys3+M0sljyptQ7R0Qf5Z5MBknc=;
 b=vpaN2Pobbx2MdjI59V4DhiURfET4lJtoNbmWgO3NOJFsuPt/H828LOYsxgTrTVpBIH
 ymPVgeL2VdIZKISpnlrmqbDl5dWzR/P6gy7bngBzJOBAc2ibVFKsAfgwnVCVmKbznMec
 XrYZpZVFXCdQV7hKPUwjG5eGY44v65YSp/qX1q2YUhCtQc9XdCBSw84OGUX930Dk131C
 szrXFNF2MgMk8gBMW1go4rIa/udrUi81frixdHpLky5eTgDThHtbw0DGRjwf5Ha3Cppu
 /PaPbcWV1730IBul7OpqF4R/n9wSFhNAxxR6qInkhQ+hOQ1F9GUpdIMV+ocJuWqQqk3M
 Ldtg==
X-Gm-Message-State: AOAM5310vroUOY7V1ZXPO/dSjyrvocY4vtchqpBtJ8rmiRN0gP4TfLIu
 Ajt8cKqFIqQL4p02p5PaRGl34ypsbVawWGt5cN0=
X-Google-Smtp-Source: ABdhPJyJir+zz5lALNTrCHI37Thw0c7JMdw6PttB1W2T0kT7Nu7IbPDTjNIPoeyBZNpGwUGQL9JrhoOXBbLRAf86Kvw=
X-Received: by 2002:a05:6870:2190:b0:e6:26d2:abe0 with SMTP id
 l16-20020a056870219000b000e626d2abe0mr1750858oae.15.1650468564716; Wed, 20
 Apr 2022 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
 <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
 <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
 <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
 <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
 <CA+1E3rJHgEan2yiVS882XouHgKNP4Rn6G2LrXyFu-0kgyu27=Q@mail.gmail.com>
 <CGME20220420152003epcas5p3991e6941773690bcb425fd9d817105c3@epcas5p3.samsung.com>
 <586ec702-fcaa-f12c-1752-bf262242a751@kernel.dk>
 <20220420151454.GA30119@test-zns>
In-Reply-To: <20220420151454.GA30119@test-zns>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 20 Apr 2022 20:58:57 +0530
Message-ID: <CA+1E3rKYapc2_un9F4MNB5Zf7KfRr9=ATqonGnvcuvThLFX2vg@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_082927_769962_F57CD5F0 
X-CRM114-Status: GOOD (  11.65  )
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

> >Just still grab the 16 bytes, we don't care about addr3 for passthrough.
> >Should be no changes required there.
> I was thinking of uring-cmd in general, but then also it does not seem
> to collide with xattr. Got your point.
> Measure was removing 8b "result" field from passthru-cmd, since 32b CQE
> makes that part useless, and we are adding new opcode in nvme
> anyway. Maybe we should still reduce passthu-cmd to 64b (rather than 72),
> not very sure.
Correction above: reduce passthru-cmd to 72b (rather than 80b).



-- 
Joshi


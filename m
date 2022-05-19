Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CF9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References
	:Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTIQet1MwfaPkuVkZ6VAO4F74yKlRL1Luu8IUjHxYMk=; b=QQ2TmgrVzm6iSRGoJURBaQ17wf
	bA4mjj1B+hp/rvrB07RhbKmGhTWUOIb9MD7iSaXWGxOKCfCXU1dRG2lCOrf3UHoxSAipV+ONQ0tOG
	fvJRyxDk0nSDFnfe9qIYK3iZeZbFvYNE5aGor4K8L40HjqIR/hBo9hcMjOLleYgwZ4+y8Ix7sDyGU
	4gsFyGm4LI+R2GoxVqdnRwugT8XkwdHp8KXz7emwT6DgPMcA7hlKamXMMycbtdcfTIX7igPhxyYlA
	64saKJWo4ndPLeil1tODtmfKjVajD6n+qFJaxdJKTcFjqDxk+CyC5XCIpwAOhK6PXEn7r7/zVGaJJ
	WNNywm+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nri7W-007y9G-4X; Thu, 19 May 2022 15:31:22 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nri2E-007vFy-J3
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 15:25:56 +0000
Received: by mail-ed1-x52e.google.com with SMTP id j4so3003162edq.6
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=QTIQet1MwfaPkuVkZ6VAO4F74yKlRL1Luu8IUjHxYMk=;
 b=l5svAHMFi6jauc3S7FX1DSGsV4mLJ6QQLIh3+rvFHlDUF24PdDRSfAjzgFwm49iJA0
 NNE97fjiMLBGBtFHfDtvXWYYjbqJi8iEGw3rJ9JZ0SfbRfZxVUjm+1AcAAGsQiCmn+ee
 89gRyY7ZHIuDSeuO9fuwbQvPzhQmzgICC/Zi2cvMq2Lohgjpg55kK0iwP+n2k0T3yUlz
 q18HivfgFoQnhbgYxOH73LlZzlbv2CCITUbrLuXpgXq0vqfrPGH3EtRYLR0iE9Cf3tIo
 jDXJ3/g1yY1JU1XpBiIE3iub60yT7wRm4Z2jDiczHn7xwf/pOKwY8+kEsQfKRV1mJHdJ
 KpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=QTIQet1MwfaPkuVkZ6VAO4F74yKlRL1Luu8IUjHxYMk=;
 b=iQpaAp1QWKMdY6kfZAxX19jCsSGTOhANkvnKPZoi7bfZOLysbi3mtTZidgp3eIo9s4
 9fEw196THg03cfpAK3lL19VqRIbIVHo/u+g3En3Qho7cM4nkrHQOBNrI8XTgFYjQpu1p
 N0SRgkGUS5xGkwpAG4ddnDduYTnFEgA3v1j/s+EgNY9kHbrSiRWVyEMKDdwh/TZsLxfu
 PqLk2iCrQ96dvHzgaUraS8kcozEw8HbHw3Di1JlF4FEKGq+/TM7Zh4LIp3gZVeyIXlQK
 ySK6ij2V6nK4LoMb4Rmrr9+WvfeKEG4XKp/HPDnePpv3apzjUQZQlQsUp75AkrxkO5nF
 NDtw==
X-Gm-Message-State: AOAM5332KWsVL+wuUqf3PaJFC5RN7ABUTHOgYG1MVTHN+/dMdVFAyMVT
 bV4RiStzKOOviKL/B1g7e+O/6g==
X-Google-Smtp-Source: ABdhPJxqZsGrBLw1XfZ4Nx2omW80JrXR4I67dHiPrXDO/V/6B5AKsOnb4m6w+WedzFlbburvxrD0kQ==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id
 z1-20020a056402274100b0041f69dc9bcdmr5928160edd.239.1652973947883; 
 Thu, 19 May 2022 08:25:47 -0700 (PDT)
Received: from smtpclient.apple (5.186.196.163.dhcp.fibianet.dk.
 [5.186.196.163]) by smtp.gmail.com with ESMTPSA id
 ca7-20020aa7cd67000000b0042617ba63absm2892556edb.53.2022.05.19.08.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 08:25:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Date: Thu, 19 May 2022 17:25:46 +0200
Message-Id: <40FFE5A8-35B9-4707-8D8C-A24254EB9A9B@javigon.com>
References: <20220518080020.GA3697@lst.de>
Cc: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, pankydev8@gmail.com, dsterba@suse.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com
In-Reply-To: <20220518080020.GA3697@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (19E258)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_082554_898498_52690E53 
X-CRM114-Status: GOOD (  10.14  )
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


> On 18 May 2022, at 10.16, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BFOn Tue, May 17, 2022 at 11:18:34AM +0200, Javier Gonz=C3=A1lez wr=
ote:
>> Does the above help you reconsidering your interest in supporting this
>> in NVMe?
>=20
> Very little.  It just seems like a really bad idea.

I understand you don=E2=80=99t like this, but I still hope you see value in s=
upporting it. We are getting close to a very minimal patchset, which is also=
 helping to fix bugs in the zoned stack.

If you take a look at the last version abs give some feedback, I=E2=80=99m s=
ure we can end up with a good solution.=20

Can you help?=


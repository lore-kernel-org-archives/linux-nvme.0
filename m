Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73031CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66xaQjwwj1DSC8zMv7g6skogb4iqDm/A8Jr7F9vtkEI=; b=xTK/K6/qh4N+zNeSMBNHcpWEu7
	HPskknkHMC2Jp80AejrzH24G63XLxO+HCUCc0/v3J1dMXwG4HH0vWhWIxBP5KA1THvs9dE0qAkaY0
	gmXiDRDtQyRBYMWF6sukgVLWTmzwOrRSTRPjf1Hk5NvQDvwyCewnLi516pkAB7nhnlrTo6VAJH/Zg
	Gv/rl0ynNdEVBwkqgZwFdmvrZjoAVx2ad8dHpz46Y65HiZijCm1s45GsPtXZK7BfH5917zeeIXoc/
	2ISuv1Np/9Ug/KxLzwMonPPelkjGxC9QigiultTsG92b1u+XB9ZNcNnPHVL8vwUHJn/+u2SR1AfLF
	HiVFS4Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSFD-00000001eF6-3D0z;
	Wed, 22 Oct 2025 06:22:47 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSFB-00000001eEd-1t8k
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:22:46 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-27eceb38eb1so66270715ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114164; x=1761718964; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66xaQjwwj1DSC8zMv7g6skogb4iqDm/A8Jr7F9vtkEI=;
        b=T//WywXWN72Vh9XvtRjfSKoT7IeXhqRVlG5YImTWuKjiJ6WfImw/gHpBdvXMCQQbbV
         UAvCp6dyiUoq2tRX9JIPxKGnTvqP0apvsD292L74OFa/raZdjEL7mXpKxHqfDBLFuOZi
         fRBTer3paPXa/qQWwwyNpvt1gmcQJMLTQXUReOGgx/gPD5AiB5B4R6pLRBdbifdGOVDa
         0klnDk57rW4HagFeZWwBbYJtwHY6KxBNhf8/ISh2qRYZsW3JwWK+aQS0MSTXMd7GpuFW
         mm1WF9JskKuiVzJ7MFW00FbwwsONA2oWyNtuUFLx7R6yPs2egHPxf67Y2U1oHWOjaG3n
         e34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114164; x=1761718964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66xaQjwwj1DSC8zMv7g6skogb4iqDm/A8Jr7F9vtkEI=;
        b=PpzgzKY4AMNxPGKwlzuRmcKHoK0Ki4tdBvmxHM9sxfDHYcQztnVNAEhBCDYPznn7GR
         PvHKdA2NpjlVwUJT51RvSYC0e6flX9PGiRUy+EzMRq1ZQSknzysrTmEZthYltqFJL9EY
         2Dt6xs9V54iR9ue4eRGNcq6RuQzbASifoudfzQojB4kuHxJJWr9pRiB7jnsnPPfY/W/5
         S1anbK0PNGlbGqpPORJguLvPHOJt0+Ul7g/yCERjM21hPmRGLGAgAlGz4hH+8M6Seaod
         yslsRTIdzo7HzGdM5ROlXAPeYPnPyj8KA7l5eBqxgF95yR8F15CGtjHsJqxRfdyKvZY0
         T8rw==
X-Forwarded-Encrypted: i=1; AJvYcCVNkpfo+Fax8SDySNDzQIa2MIP03A0ZoQurPykj6uiTled/yvrSnjm7RryEpxyj8E38aXIJWLwnIHPI@lists.infradead.org
X-Gm-Message-State: AOJu0YwOSlBbuowtnzU26dDz6+AIpDQoztKECe8Ph4DfFfzCrhroaifs
	IpKUiwcGEgAFsMJUnB6D2vAM0UQyws/g083I72bQf/P4AxTjSrg4KVFi
X-Gm-Gg: ASbGncv9Cl1cMXaPZXNnJ1l+QE+tpLA74qxmxtjn17eul9Y+fyUNhw7qKohirKN8bGS
	6CsgmBg+ZbJz5POhAEEGliJR+sMu6s2eiIC408NQ6+VAH1rgeuaog4CNK4feoX4WOdyIieqAJQs
	xVjF6PTU8K9lK/SoxH39VbW1mCd2YPnIPoxVcm6TFqI4hDLvpjnNl3egI0gwL0N5BT6nd6BXAMI
	flAbBlJKGuH+C9MDR3FcwiiES55PBFwH1LsHjVN4j/s19ycokctIbt/9DysytJd9Hk2aml4cqi/
	TAWnW96Rcc+QXQxcFSPLCy+/P5RSkqdqyLGGQAulHJnf+JzIJh2i1So/vDFiLuCv5AKQ0jpiUzy
	cneN6O6hTlom3Rr/wJV/tw7MUcPFCX5VbOw5u1bDLZGei3Z/IxV1cbiTPFQWX3abxWSo4M8CF6u
	cqGdKtD4o+d1hJPpFhkLRq1AsJV1V5fNUrvJkTxpZb
X-Google-Smtp-Source: AGHT+IHu2r/Kai1JDZIkhOth/5ZzefnErwla/yQFec1EB8fhz4Cuv3VnlejE3F+2TDlKzVO3OAm7Hg==
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id d9443c01a7336-290cc9be17amr232330815ad.48.1761114164378;
        Tue, 21 Oct 2025 23:22:44 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5850sm128748075ad.66.2025.10.21.23.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:22:44 -0700 (PDT)
Message-ID: <49ca09ea3dce52fa7bd300f930ba3eec4b9b318c.camel@gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-nvme@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 16:22:39 +1000
In-Reply-To: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_232245_506035_4EDB2678 
X-CRM114-Status: GOOD (  14.28  )
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

On Mon, 2025-10-20 at 17:29 +0200, Gerd Bayer wrote:
> Add a new error message like
> nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> that makes failures to probe visible in the kernel log.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> =C2=A0drivers/nvme/host/pci.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index
> c916176bd9f058b49e6e6768675711df52b15765..7544c4bac2c4a230d32cf729abb
> 9e94bf93a921f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3519,6 +3519,8 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
> =C2=A0out_dev_unmap:
> =C2=A0	nvme_dev_unmap(dev);
> =C2=A0out_uninit_ctrl:
> +	dev_err(dev->ctrl.device, "probe failed on %s (result:
> %d)\n",
> +		dev_name(&pdev->dev), result);
> =C2=A0	nvme_uninit_ctrl(&dev->ctrl);
> =C2=A0out_put_ctrl:
> =C2=A0	nvme_put_ctrl(&dev->ctrl);
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D40C5AD4C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2L9RZQCLrY6hnoGQSRaHIShkzJvXSmWVmVciwD8dPI=; b=TZoIi50j/8eIJk9IcFKpI+dry8
	sJmn1Mr5z+7khz4wG7LzXerEV7MmZKTnRErQXyYm9jMjPJ9YCMZk7jCBwwemFq/sOCbdWBvJ209s3
	0qS2oReiwFBdXi3NNvvivqlBURRhTO7gD1RrhgH4/hQqEOK1xtPlYUBPc/fOZXu3jIzfxakO8BtUl
	mlqB17K1GfPpK/KqwvIIiaACv4WqK7F470BA1tsSmrNHgS+RxXqqA3rm2rszjy8DsY8wz5mlAXY1g
	XTIcqIxcpPiDPrcvSQWumvDM0PNDxxB1/Gh4wqwl99loHlbgNSgaYAkplMLssSoFwDb9Vx/VSHJ/s
	YdOsLBzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6B6i-0055AJ-04;
	Thu, 23 Nov 2023 14:55:08 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6B6e-00559Y-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 14:55:06 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc2b8deb23so1702265ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Nov 2023 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700751303; x=1701356103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2L9RZQCLrY6hnoGQSRaHIShkzJvXSmWVmVciwD8dPI=;
        b=W4LKePetgv6G90LmMlj+crVeE+mRszNXIvRdYDiRtg4eW6pIkIoKmkoUKpmbun0bFH
         Tw2Bd8lT0+ntZxpuO5mqnEfzbYaUwvL4pQf+f6emGOFQ5Txfd6lZrYd9o4CJJ69vbCBK
         zJYB0RAdFO4pfeqXbHt/GOtUwnJDyVMyd+WNTy7bbIcr7u53fnfDPXN5nDTmWHQEvuWl
         sMz4kupcuNfH3cMn+h2t/5Lc1VpMNz/OatLRUClKOeuJEwqoYuybS3EGS6mfjMDbnAvi
         9iL7de6nWGGRSG4M2iQCX0QIO2tHxaPThlNeSnJzx+mGbA8loiNY0RolbU8HFiDUb1PU
         52kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751303; x=1701356103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2L9RZQCLrY6hnoGQSRaHIShkzJvXSmWVmVciwD8dPI=;
        b=jtnfi0vfiEWzCzoxJgHssoFf1JBxj0FBTUdi8EbPffYFtxYUYCwrOgyJrpDybNf5ks
         jchBCLw6CovO39YSkIfvdRL+Zl3dDEtEpAERQeOeUlwrx03xU084jEh6584B9WGgLnIA
         s8AgAMLSv0cnAIv2enbZJ9Icsxaw7ogwqJoKZHQLJL/E1aiY8+8335sJsIxyPxwzx541
         cAQa2Gkg8gYbF3nGpqBRLowR+2l/NIvdNA6Nh0uLJ3kXT66zLDCd78Qi+nsNHLnwNQ7h
         XQUGfD1tBneUMTjSRZIJ5EKayC8drSykUGC2ErTuC+TIBb6vYD8WAl3ZRIHSyVglKvdR
         fzpQ==
X-Gm-Message-State: AOJu0Ywzlbo/r3jj7Csi1Mb6O734uwkP/707wumaNIpaEuzMY8oVxlJT
	J5ZwIA5qZstPUuBGL5To5FKsEQ==
X-Google-Smtp-Source: AGHT+IFQYMG+AU20J3AxvuSv1xousG7ERMkfwLb9nS1M6laQRLzK1D3gA3xh7TZXiTiUPbrUtQ9S6A==
X-Received: by 2002:a17:902:e808:b0:1cf:732d:fc0d with SMTP id u8-20020a170902e80800b001cf732dfc0dmr6296045plg.1.1700751302634;
        Thu, 23 Nov 2023 06:55:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001acae9734c0sm1443035plg.266.2023.11.23.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:55:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Message-Id: <170075130149.89858.13911253468594961473.b4-ty@kernel.dk>
Date: Thu, 23 Nov 2023 07:55:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_065505_011262_2CB6B6E2 
X-CRM114-Status: GOOD (  11.15  )
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


On Wed, 22 Nov 2023 23:47:16 +0100, Arnd Bergmann wrote:
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.
> 
> [...]

Applied, thanks!

[1/3] nvme: target: fix nvme_keyring_id() references
      commit: d78abcbabe7e98bb4baa4dea87550806944790ed
[2/3] nvme: target: fix Kconfig select statements
      commit: 65e2a74c44ddfa174b700f5da2d1d29b4ba6639b
[3/3] nvme: tcp: fix compile-time checks for TLS mode
      commit: 0e6c4fe782e683ff55a27fbb10e9c6b5c241533b

Best regards,
-- 
Jens Axboe





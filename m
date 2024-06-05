Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787FC27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 05:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=ZU5yXvvw4QEEVKZugbz3LPWCfb
	te/EqoxhAgJjoUSOOYAKjdBMSKXxZhhGUU3I4Cjf3J+kkb+XdvGoexsqaHZKu+0zgxXRO1QOTcjKi
	UmYvn3Rl2gt4GKWtOpT3BUvVe2wHy1zG6UJ8885m4xxHFLG7ZlzFtDco0dbs+JsjMVSqwYM/yCwea
	38lCy8eq6V2iNEK/yDBKaN1rfhMQTawkNW/HvT1Yi1u6sKB1FHBjvMscJWUBRilLTEAbY8en+dnkl
	BHD0hfIMfNPk77Z8c/d+8fBe/m+jpggdM+AI5B2Rurt/Z51lGyViKWkR4ZGc2uSZgEQ6KIuiTXQ87
	Dr0qvChQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5Gb-00000008NC9-1kz2;
	Thu, 06 Jun 2024 05:02:25 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5GX-00000008NAN-2hbX
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 05:02:23 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6f8d0a1e500so336459a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 22:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717650140; x=1718254940; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
        b=WWqRW9L0QsCwfySiudVf9nhEBSqHNZOEdj/TiXAyZV2FUjdqEhbvPt75a27z1UIOqR
         73yvHR29oY9inYUSPmAfmjvp6/P87OzDKBP8YktYcpFnMWIsPLU/sZ/tBZdslPBmjmzf
         XCG2FSJYV/bXCxoIkhgihs34oFbenrcD1lSEusfZpBb/HVOTlKoiCa1fdZA/fodbtAfP
         SmfeJuaNwkGsTe7RfkRIRrf/xtoVBX3iuzth2f4mxRw2ntPq8WFGdSClzNvbz5jhyV5S
         iJqAn0/OoVuXmFIG9FCp8PbNUE1iV4SntHoZ4TaqO/aWeXTqJlRn+JrBK6KklkLGJLkr
         MsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717650140; x=1718254940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
        b=qJ9cnEm7B/EiP+IaLflbM7KXPmqpkXY+Y3/yh+PgciNiRUXHinV+EJoUaggzGJnXKB
         87f2D+QNf1nIwhg8Fo/BPTOV67sczpKP75gn8pgd3b6sBJkUYU0Jt56Hi14rthABGgQ0
         Jar+A0b/iLT6aYwqpdjxxbQJHNcPp9mjjlf+bXQiw3NwQVcUUv5dnY+j+3P6uIyuijaJ
         RTFg7ywVhwlcOOGzH2692sutXL5J+tVrEAxd2zKZiAneFlL77g8dlr7HDL+RGud9zZO4
         JQFahX1/G8nXr4/jXNEkz2itUPSOU4/A7JRx1av3d7On2BuYjCwc1igVV+jY8nRLLNqu
         TYsA==
X-Forwarded-Encrypted: i=1; AJvYcCV+KvHjJBhfCLiw8naB8B7HT+8qUy5lI44WdvlfzmP2kYEezQ/Y4ew6tSUdFk5zRn6dPdW3gh/klk+Z0GMvoS/PC1zSHaebGUJaDc+Ii/0=
X-Gm-Message-State: AOJu0YyxH1RqQBPGTTv0DS3owtzKrj5N4GtzAxjEzYULjWOkTue+qsf8
	0NiSbEXe78CRPF+9PJEProA+pTtwavfFicqIaPI95+fZqoiGITLi8wT8yRX8J5kvRjuF8+j5Ke4
	DKAWDyvTQn41gObEtQvnDrCiN4oo=
X-Google-Smtp-Source: AGHT+IHPqrwGLrOpiYOHRKHF6jjAJEe69uLlr8JRuR9rDqq7Rjpi5pT7mqAtKEV0L+JskZqRkbXl08yzChKNyWs0Mrk=
X-Received: by 2002:a05:6871:79c:b0:250:6be5:1fc5 with SMTP id
 586e51a60fabf-251228adf01mr5001314fac.38.1717650140012; Wed, 05 Jun 2024
 22:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-4-hch@lst.de>
In-Reply-To: <20240605063031.3286655-4-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 6 Jun 2024 05:01:53 +0530
Message-ID: <CA+1E3rKjG+kG1Z1N0c69Z_P5eNq9BzshKqdB5Ee0ySPzJGg-0g@mail.gmail.com>
Subject: Re: [PATCH 03/12] block: remove the BIP_IP_CHECKSUM flag
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_220221_689711_FA0C909F 
X-CRM114-Status: UNSURE (   7.06  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


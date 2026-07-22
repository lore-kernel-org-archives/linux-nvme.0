Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F70FC44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=; b=08M6B95reWpFKuEnbTFRR6cPbZ
	RQvCHonniC7kSjbzy8QSQH6EiimKE7O16CfVoNr0AciQwWZIsVnUplwt7w93ow3CpQnaqTxRokRbq
	DJa+7ZR0JsbkeD29ScdQkutjQCLuhMCW9XYmKXNJXdmflxNVSDNeC1fwrz+0RIlMRfhEaFe1baD+4
	dCEoFMQ6e1OItcG57edIizlA7K/+7bTOpNe5H/2Gut9ZS1npERRn/bzDETp9RYUpIDEOOWKiOhjzE
	YQOKJ5linaOflswTGmCpm96HrfW1BAKLHBXsrR4u9gLhu2UhXxr6vSR7OCl5t65tXWc2tqxuz5YUm
	ArDBqtBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcxa-0000000CfIZ-0s7j;
	Wed, 22 Jul 2026 19:50:30 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcxX-0000000CfIE-3WBZ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 19:50:28 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so12087522a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 12:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749827; cv=none;
        d=google.com; s=arc-20260327;
        b=RuIBrjkA7nXstKVGphfg/0/0YQj7gKTw/T2nycsxzjPlYauJzBz9Hu7X9K8x1eCOLD
         rzLk5ALb8DDMx8GX0iZ0Qa22QTUVgJJUATmvdcXDXvZiy4P6j/JULGxq8ut95jKzb4Jz
         hC4igFwps0zWU6qLbITc2VhmK6nMlN7PFv6X548CApvKY5T0MPNQztSLBzyKQnoxpa5K
         fQ9TTZ8b+VX2fbcbZRxQlJyYcVJUhDh2b6bQTLp2R5ItiutCPrjc1pQ/asKGsIkffLxX
         6tUhS8jtpg2qUFLPw++Xs+69zj8xui7mALSNXAamOj36wF4k7nm2vUYNtU0/J1ASUZAv
         5Vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        fh=aw5I5uCxImIMsqML3bUO8jELLRDRx6m1pj7rDGZGos0=;
        b=DdqopaMDWmwgEF68CfgRCC7CVsCfxR04DqW2gDhxIaGJFmVEsMsG5DgctOOC2RGhSi
         0z4YG46mKbXj0482Ly/hyBei1rUo1EfwlpPNw5Q9i7z/Bg4cPfGkRmqjSO1sERZxs8VS
         h3nste+/CF7nB06dGHQ86IAnw+J1+NyVvoqCgJc9sLFgma7bDj5NhdJXgR675eYWeS4c
         u+FrTTe+DxQpt7hDDz0jK0xAxUvbDf2OBU2+r00wWSNMZ6jM6NMJAb4fIxw0zBdzcnTT
         v8gINR0jvAVMymOi1z0tgwJHiZUwpm3qgRKM0dvjCemadZ3Q97gxHSIjDOUOyO/ohKf6
         xtAg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784749827; x=1785354627; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=kkFOAhX4RPGLFarYkmBuvFDSlnD5hbE1HFtmW86CkbJ9j0vGUEiqEpDBjLRwLpPc9k
         1HSzKBqYNr0yHllYxU/qZKpj7JaY/u7OMEjHhJE94BFvm5OtRz4eijJRk8pNpyGuEkAo
         xlwDHO0WncZdZH4oAwwA15fhC7wnIwDX253PsJk/HdTFUo48i5fQnFml52jqULvi0f07
         E6akCW48PL25L+meDIBOISEYeJxiswTN9u0C2h+8CxJZeKbABvX7XHUMwMViKTOiSys1
         xSTjxBcYy+RSznOCDTC/1+ieF9YzEpM8JpFgOfHOtJyZESpLj9JIi7CIOt5Wpi7OOv/2
         PUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749827; x=1785354627;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=eThhh1pZP9u9UdRSNLwkZKZxLZga4ekeldtfx2QkjKTcZSJtFCnuv23cFxV4TFVX4W
         kiPTmHfSyD1s1XhqayBPZ5/ufN4NDiJ4vqi0QrTlCfaGPMRQs3TwtVpaDdnNer+k2t1f
         7p4LpSTHJYbgZyGJeGSs1LeSuPhMNqtl2WBFrDv/uqSqP2uOd5B9T2opUY8W/ny9q1W6
         sjmq3UuPgRrbpd7FrtSGfw7QKetSGERXaOIUK7drTiTmyaJ0I6xaUDkscEHqdsU1HnK1
         NGKJqpdKtLrGgaBAUdk61rVFIYlp8cGJtML95bdWk3kDSPBRNfTiBZA7mGcnJpGmzCHC
         38oQ==
X-Forwarded-Encrypted: i=1; AHgh+RqC9AtYDXKR9MclQZJVZOBu9cLRtv6WEVUFUuXr54avs5mg+owzX/9j75q+0kBPgYyCNIQQ2R6LH2cL@lists.infradead.org
X-Gm-Message-State: AOJu0YyPsAEfzPnW/g44+0CB6IwIvCfvPkRhCoD7beTg0awDZo/5HJbE
	0RSwfFLT70LCwf6GcsbP8/JXEF8k2Z9JFmxDlSuYxo3X1NW6mXG8WBxLJzxrgKuPK4CpVrz3t8O
	GEpIni+KR8tZORUZWPvEcfQbE2+rCFw04CzfhnM10
X-Gm-Gg: AR+sD13Nlg/DtJFrBqWqV8/H6GaKSlgXvL7Ej2GB74XHD3rzmZPU+Im+AADEPXGfobc
	hGoknki/+VD182LaGf41ZIC3Hu75Buko+SAwKqaH6sy7GckNWO2A7PdVaoXZ0KsgtuwsNWFXs6/
	e03PPRNwArVHf6E/qMAsy359Hvn/heD0BgswYBb1J+Pp59rEPq57yoJZH0FuwavSlKR+uf4D7Kp
	NIRmHGTCqWk+jq0GqlJuOY8vechasJ3E/+ZPrA6PAefqL7l1BSutra//guYcXMGRe5dVFOj0aOf
	4LqzErypYVomjd25EOZQptdRXUExGLSr+/zZTjaP23+t3aGGmkgs0TsV93XpG998THBQq6flAj5
	w/GGgxATs8mvIsiczoNNkXnwJN3t1
X-Received: by 2002:a17:90b:518c:b0:38e:b3fd:d582 with SMTP id
 98e67ed59e1d1-38ec6657a87mr93881a91.39.1784749827092; Wed, 22 Jul 2026
 12:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-8-mykola@meshstor.io>
 <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
In-Reply-To: <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:50:14 +0200
X-Gm-Features: AUfX_mxD5xjrC5SGVG19NWXUUrwiVViRlgsz7kddupZQwNnofwkXgV0KRRHwCnM
Message-ID: <CAPzsNDtmEFf2uyJr+gSs4iw_E+LYiH5+3uojxhGMYKYku+fw+Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_125027_910722_62450143 
X-CRM114-Status: UNSURE (   9.66  )
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

> Maybe drop my authorship from this patch.

I will do in v5. Any other changes needed?

> I'm not sure I follow the point of this new comment here.

I will drop the comment; it means the failure covers the whole bio and
won't change on retry, so we record  whole range rather than per block.


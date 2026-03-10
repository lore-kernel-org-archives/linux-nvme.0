Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E9AFD2D79
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NvUtZVR+FIPOoBFUXmYubmz+HUENbKUiEI5TF4zE/jI=; b=ttLpP4OFbHPBV988/lo7iIKmdC
	ldCFaN1JMQe9zGu9hwUPWjmJq76HnOmQKmjbrn+eopNw7h4HfgyxdRQ2WNuMzN0EbXeH6jz2yaBYX
	Xcu5lmKE8c+oCPGvYVGye/zWncWBjLpQNfGD2bL6Fo38925W2YNi1fnYkx68yozrmMrBZ/umT0wyF
	v5p4uPt7g0rVWaTJHcI3+4hBb4VdzZJuwFuWBXJhmBoRcSxTZcaLlpI8pNt3xJ4kZFaBkID9h5++n
	WB3bB9+L5aSH+kdFUJM00ahPKELswYVIF7kt7DQ47RF8LpTHGeLDxdHqsuxr9hxneptb2xiwz1r2H
	A4MHqNJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzws7-00000009YwK-1jry;
	Tue, 10 Mar 2026 13:11:39 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzws4-00000009YvW-2V09
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:11:38 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-467161c4ba7so944500b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773148294; x=1773753094; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvUtZVR+FIPOoBFUXmYubmz+HUENbKUiEI5TF4zE/jI=;
        b=F3ZJvNsauBIg8NjiJGzLLwwou9NlOm/Gzizb/LmMjo6tf9V3hsG2oPuYqv5hWCkFNn
         pfUglFSfgi/71LBovGcHVHQkQSwHlTFPpNosCA3erBiI/sR5GZeLsRi+BKNgCO8fzIFA
         UM4q1ZYqYn6187URas24ED1Dj3YzlpT0ROpGcaZS+2fZRSQ2Usu2WW3nkT9WzE1CisuW
         c/HARb7GdTSTNzreYA/m6TM39auNUb2SJskIBOB0izQDjjIGYCLhnCMnlpGSQGGlzBDm
         Fj0/2y7AN2ORdK7JWgovWLi1Lul3Mwfl69szdDR/A5/nVpKXXTxHubtKrhDecUM5DZzb
         zmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148294; x=1773753094;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NvUtZVR+FIPOoBFUXmYubmz+HUENbKUiEI5TF4zE/jI=;
        b=I9r0PnCpYk5fDuqBz6Ma5ZcRTuvBcmTf5slY7zDNmOVJufp9f6Cpe8dyZSUAkf1mTx
         08CSjV5CkE1I43cSzGXBPCVsXnLhGrbaAzLR/KQt8rQh7dINYO3QMbjuNxel/wlkaEQD
         QtKMsi5Bs/JnHz/dmvNnR54KQnW3wLknUoHd3Rymffw/vXoCjripy4NA7hTP76OfOsSn
         83dEOInr7qwQeCmkrkrQpyGrtSjwy+o6H1+9ixjjOTUAs+3svJ7SEszDDtGUurWMT7Me
         w2wwTwVm3cyDzrIYp0MfmYlmnTY9Iu/groUSnc/5Xzz7MHbpfdgQWsOGaU3RCvjq+1iP
         3m+A==
X-Forwarded-Encrypted: i=1; AJvYcCU7tUFAyt2gKVRDwd4Mvlr0BBHuNFqQdPz1tJuiB7DDC4/A1RNKoeOtUFvLM/Gz7c9phYlD5ZVIMlqx@lists.infradead.org
X-Gm-Message-State: AOJu0YzlFf46p1SJ37QwdbeB64TQ95rhzvqLbkGdlp0GvAJaL7WFBmgN
	Fd12HMdsY+XPAJSda9ngMDCCXsY/cJ3Ohse3lcyP+BKMFoub1K6EUOpVoKAgsxahHX0=
X-Gm-Gg: ATEYQzy/sxnNVzm55ElbtG92Ni8hu153zfNklLcLUU+ZU635a/TjCAPdPiw49XpAl5l
	WT1T7hFVwQYj7e+W1BYM6igBifP0x+vadQEe0RPulO21g9HHnZhu3e8ih23iQZqegfA2mJru4zW
	YcVSVVQr6BGQHwjWCFDtLU2kmtUMbK/ONshx+NL9h2pbDbUj+z8hZB6N11e6WeJYHouqUf5VFZw
	AQSkvZecd5qR9SExGtwMs2yPYkQRLNi8G2+vf4m7dfgUtrdkx/3jyVopgbQOuSNzJhntQIksBRz
	jvrap2TOqXgyYfDddWFLGwAq7YY6xXSWjjm/ESgXEF6Lx9Z4QywtzuoQPktl2p89EDQSXzFOmGL
	iVog4vLD0sLP77DolcA9eNnHBqcRCIyyjXuQuY+Zaxs4avUEf6Yw7rvm1cWgswCGwX3y5GS9Nnq
	h2tDV/MT88wQYahQRXnS1+r5mnAMqhsOk+f2gcqgnl436i4Q2KdXxo7nvZcyWzUF6/fzHKOtnwE
	MXA
X-Received: by 2002:a05:6808:d53:b0:44d:9f05:7159 with SMTP id 5614622812f47-4671bff16d3mr1834384b6e.29.1773148294265;
        Tue, 10 Mar 2026 06:11:34 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm7530612b6e.13.2026.03.10.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:11:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260226031243.87200-1-kch@nvidia.com>
References: <20260226031243.87200-1-kch@nvidia.com>
Subject: Re: [PATCH v2 0/2] blk/nvme: fix NULL deref in rq_qos_done_bio()
 on multipath failover
Message-Id: <177314829158.50843.17536784441934486414.b4-ty@kernel.dk>
Date: Tue, 10 Mar 2026 07:11:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_061136_906504_7F69957B 
X-CRM114-Status: GOOD (  10.84  )
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


On Wed, 25 Feb 2026 19:12:41 -0800, Chaitanya Kulkarni wrote:
> When a bio is processed on a path's request queue with rq_qos enabled,
> it gets BIO_QOS_THROTTLED or BIO_QOS_MERGED flags set.  During NVMe
> multipath failover, nvme_failover_req() redirects the bio's bi_bdev to
> the multipath head's disk via bio_set_dev(), but the BIO_QOS flags are
> left intact.
> 
> This series moves bio queue transition code into blk_steal_bios()
> and adds a patch to clears BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
> in blk_steal_bios().
> 
> [...]

Applied, thanks!

[1/2] block: move bio queue-transition flag fixups into blk_steal_bios()
      commit: b2c45ced591e6cf947560d2d290a51855926b774
[2/2] block: clear BIO_QOS flags in blk_steal_bios()
      commit: daa6c79858e9ca75c548452bf71db8a9e61bde42

Best regards,
-- 
Jens Axboe





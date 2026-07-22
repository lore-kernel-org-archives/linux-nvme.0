Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE6C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=; b=bb2sVte5q2LZanDD/JkpYvrnsK
	GeY54lKGSA06ztI7rqWOxqZHfdhsOL/w7MiWnYR+/fSv6UIVOPNcOKZbr2jzpK6Ppo5v9g9scm8uU
	MGX4EEQgSxctCNdwrGZkqBc6rL5VcdmBfT1CBsxEKhK9w2waRQneUNYY9eEz1FoyPFQSTjbRoOcuk
	w31TpAiLt6mYDoDOUZbMFmp/R+f5XZBlrGM4M72UnM8V5NrNSc9/gNICjS03w5s9Ns8sylNUnqBHk
	h7G/cFQeepWcrg/vPxF7Nae3+fqKsu21lYPe9+drLFoflroZn4cbJuMYaGalw+PdNupsjX/rZ6t8U
	0J9YVi0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcBG-0000000Cbw8-1HVO;
	Wed, 22 Jul 2026 19:00:34 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcBB-0000000Cbtv-2HjV
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 19:00:32 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38e58034d05so5088352a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 12:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746828; cv=none;
        d=google.com; s=arc-20260327;
        b=NBrKJwp9/Jilw6o3my9CBAfU4szTH/hNBcyX2sdli4QCH1fuYIlIqSMTEabrjFT2/G
         S4txeaOHE9GAMbqbS1DvM1iy3kB1xdBlB5uIpBKEjXRxqZ81o6M73akED1Kp89gyC0D0
         IkiT+p4fqnopriEyslZzkPGYZhbUcy213SSSnlru/juWLncS+y9DOe6q8+QBk0PgRgkM
         wQYX5mhu4JqhVqeyNQjIvyGsd18ci6uRmfGA49KXuf05HeDDsH7QTInih63aMaZX/8vJ
         q/jViku1UT0YC+jtbDPc5nqspNPzgO2/RXX7JJQQ0bBww0KIC80UzD1t4o8ZKb+qRV1x
         +o2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        fh=8HKHkCa4hYUl1QLmPg5BZAYLUESVV5vXYhRwUBlfW4I=;
        b=Os2P4dM/dE/ZsnWr/amxNAT1MaHRUpyorxLz+ak6Zeas8astcFW+CN0plVtTEik1CY
         XtxeU16kqxwD5QFyef4FqwmaKPbpZyZVhS1q2I90QLWfz9r0citTNwYjVmpafSJtQ7UY
         emb3LNLAm9XYlFJpVkBU2VA8czi0NgNCBFGmWMu8jQxIHxhCh4eQNb5hjRE28TrUJkMc
         UhtVSFXGI1r509DSOms63WeU4wK/cXN+XhDWEmH7MmEBBbLq9rUmQQzD884nb76AwMx5
         9CnfMPeNGHjZWd0qT58Hogz7uE5zaeoH4OCK/ZqAAvjGRG79ysyboxTxtbnhYpOKkTY6
         mEXw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746828; x=1785351628; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=IzTHzJe+X8PCXv7bAx3N6zNJ87bO+hrkXkz5lEu/44qAqOdBpcsPg+DPws3Sf/bS3m
         9jsAHxhNgsR094CpufVJZi9bE5f4mCyOXCbHcGS/VFFKSQiGBqpqs3B9LPkgEKQh6h7F
         r+SEMJd62wM8Vo1Spi3hHVM3QqHe2rr4WtWEh/cytZfmkZkrJL9OyWJjhYPqqeNVtQJS
         dT3ymKa+YdOoRS3RCVLYqyOHuwUv8JUkyWYTFTeI3t7uqbwcihIW42Lmj5j94M7ray4W
         Cio5Pr1Kj/2Va+rypLPplaiYIIMOF1jA3Of0Ef9mU/o+lXQ6anNjq+b6GZoWGK3h3Ch3
         pmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746828; x=1785351628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=oh1jBRzR5xIPj8/1K97ecQ2LVXAJ+43s5eC9PQ31+qG70JvmGSapv0t23Vav09+eJU
         b3/evapJyzh+t2+B3YEXFeeeE2cdq1k82gYC+8GOFrCTh+t5ZuwMdFBveMkvoVkwJfw/
         jAQYIWNcc5giFswY/oI8DXEBMBJsV5qWtk+oM7ZHUP8lGdWHzPdYx0hT/iLavM87SkH5
         /4QprM42HK+ryYPQYHVdSz50F5QffygZU8yDhW6bsD/Yj3a0Q+aEYp0u9JirRpTkRDug
         E5i8MDPoHZOzFjxVXEpjU1iETqc38LWJQHZtYndxehPmUQ0/gsKkEGzudCST0DVI15ep
         6/Sw==
X-Forwarded-Encrypted: i=1; AHgh+RqC79le1Fz8h0LU7GL3Gz+YVpUSWnC/CxHX6gY0CeI5o+n9bl81v3ohKc+35Z5ls+MlBPgItVjK7Hg8@lists.infradead.org
X-Gm-Message-State: AOJu0YzcyLcbz1ptYRIa0mMebPA8b4i9PBeVtCrqi5foXx1IpohFtrzx
	uL3rwnvnKaboN73kUA8sZbvgvC6UoN6hfABMPwwo0UOXhfNSX87nAIyIizxiSZRHoNTSqWtdxsD
	W95ksD1AN5Q5hZSG1YUfDEEqtfnpGz6z52ecvA2wR
X-Gm-Gg: AR+sD116wLlqj86YyQTep/3FtR8NJtpc3ASNwfZSLcRH2cFFDwGfHxwOAJyRcnB/5Jh
	S9hIycx34BhwWkq5yDHrm3vdGXPLCavG0XLVHFc00DL4j8hMkjoSrapF/ZZgaj6C32hnOWc+tgG
	r0HAdxwD5c+kR+S4hFEFvbSw/9wO6qQ31AjCJRofF3XyccBIFY75Cp66tLv1dqTxhs9EHXhb+o2
	na9yabgfJYSosKpKovStz9JUE9OKT2W/UN1wBVJFGLYxF+IqvLQRmYcbDMjiyW91qkThr4igpSF
	+5oH0YFMOri8VedqrzxlZIRuG84spBbcgKMdV5XzMfaNsx8arw62VwVtj3SuTKv39HjmXmhihPe
	cJZbt1V6MNAC0mMnAvbqk7P0C3lYm3kJgrHC3MPU=
X-Received: by 2002:a17:90a:d40f:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-38e4b430c6emr27167946a91.14.1784746828497; Wed, 22 Jul 2026
 12:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com> <20260722083015.GU110966@unreal>
In-Reply-To: <20260722083015.GU110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:00:16 +0200
X-Gm-Features: AUfX_mx6Cta37C8DCF1XHW6rVQfC4bnrtxly1T6dzUQd_16ovjA21XsyVTPdIOg
Message-ID: <CAPzsNDuGfneEmx_nWqw5vYLyPyK8krfWChNRcsxO7icTEDDX5g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Leon Romanovsky <leon@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_120029_584559_1299B05B 
X-CRM114-Status: GOOD (  11.75  )
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

> I had thoughts about this series too. It seems best to avoid
> the P2P path entirely unless all legs support P2P.
>
> Can the md/raid code determine P2P support in advance?

Yes, and it already does: the block layer ANDs the P2PDMA queue
feature across all legs, so an array with a non-P2P member
(e.g. an nvme-tcp leg) never advertises P2P at all.

But that flag can only say "this driver can do P2P in general".
md cannot see which HCA device does the DMA for a fabrics leg =E2=80=94
and with multipath failover it can change at any time.

So the up-front gate covers what is knowable up front.
This series is about the remainder.
In mixed case, one local P2P leg plus a remote replica, with it:
1) a failed read just redirects to a capable mirror;
2) a failed write records bad blocks instead of retrying forever.

Mykola


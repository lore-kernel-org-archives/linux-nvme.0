Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B7CC54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJDfkgUwozZzeZBpK+xDymRSUD5EkwZtCEbmySTlTfw=; b=gaoB8J0gUu0ZGCF+ihJTlfuJuO
	G/KnwdYIa1S/kl9o2hYkobAcbWdyKT51jfwTeYCqYKgQF5b2VW1296SJW/jzOHI6SGDuTTSBoInZh
	trSKn6h9dclYACeJY0L0xirPaYFivnnliFb+yL3EOj7AuNyym/Flju74Rkio2tZvYbcjvHL/HuPIE
	FY3i7wg3YErwpTs4xpKdLSX1WHmEf/7aq2LF94XLakOdz1V+uX8zPJ21tStOwU6taUvLlhpOA/UFk
	Q/V2kH5ABaIhRmzBL/3Dvs7eK/tpSSKKEkFUv+05GR74KgGzcT1G0p67r77vwK5MCcVF4vYP6v87n
	LqS6IwEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITtf-00000004BCc-3Wyw;
	Fri, 23 May 2025 15:01:19 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITIG-000000043qw-3RjC
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 14:22:42 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-231f39b1b7aso4721295ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 23 May 2025 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748010159; x=1748614959; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJDfkgUwozZzeZBpK+xDymRSUD5EkwZtCEbmySTlTfw=;
        b=Jj0ksJOd4PoRyKUBtPLFrcHLt2Bm4+PqnPAc34U4+2AU+7DAmAUBpscKtqmOh1TlAR
         gfAOuqqeS4jTD25/POj6tvtVrN2W81n3c47eXWT/IDrqtr+imf3pugUXMcdhVkB454X1
         +UoFvAclTxg6DW62I9IJgEK/zj1rpqTH8vOC/CvCKOllEZCnVMrhg04zJKpLeVRBbof1
         HIz2kPrP4YNPMmd2zeyxlg9O4gSX8ndhC4t5C6h+83UHfOUqxgqd+m2XAnJtPJjcg96F
         KoBQb9JcmhlBuGQR3nG159eGZIomae/VfrJ8bs4z2lGNdu6fbEVJMsBPUPE0Vxe0/mI4
         HBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010159; x=1748614959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJDfkgUwozZzeZBpK+xDymRSUD5EkwZtCEbmySTlTfw=;
        b=uD7e8T6rt3ThVPD4ime5UA69Db/h/jAmJpens8nsk73ynv3xCAJ5LlKrXzdRMEjG51
         wY0XWtgoiA8KEgAJ85f0DkOgtoroMSWRSZUde7B0UDc53wwm5tFKQsyaEfSuFdRQK3E/
         HKmkjpu3ZU0h7Yrl0d44Bg87iNNqBctRE/z/rMIUEUPQwj3yGG0iFF7GGDR5VeoHh18F
         d+X1opSK/ngaP3f4fE2KgRmyR7iefJFDcdYNcvCJC6KHY0A1sx9pu9kVy7ybQ6bciROs
         9NdkviB6mmA5WG1Fz20iVd9i2o7aw1LMw9Rb+hWrxC4m1dnuG5Sl4plvW9J9+Xt+o+c8
         wtZA==
X-Forwarded-Encrypted: i=1; AJvYcCXSwdNeYw7LbyNUmNWCSwMLCfKbs+NWocqbfZ8Sad7ErTfVy4wDFC9CY/xKYKB0Xczt5q4dK+Phx0W1@lists.infradead.org
X-Gm-Message-State: AOJu0YxfOTzYkQwr7D+2aBMVQ46LnGNmsFgrRarvnwnMfmuHRK+KH7fw
	TnY2+Hqwqg8qNpHVe5TuA/vhG1TNJrh530ziYgnkxXLDGSFhl5fHHcV8vyGh/IYc7PdMUeaZKLG
	KhBv2eLWFYMlzpHWxpNkQGY6L0wGo4pzGmUJYt4Xcmw==
X-Gm-Gg: ASbGncvWDJZaRZSs+Gs7z78OYEr4P2Nh+RPhhONMXvmWpwtmWHg3VzWBvpQPUpmra1R
	TT5xlgViizG+7IRv1nB/xR+xW6EXWQK2vMYSvlzEI2jGKb++QmTxCtatU9tjNbaXjO0Ce0g8IYD
	LyZfQCZaUTlt5ah5Xgq9Os+VhYaixqKl8=
X-Google-Smtp-Source: AGHT+IHVjcBX/czUHf7pHZJvI5G11eB5EPBJfllY0Y8QwUzFZTEC/O8svL5ryEi2wpmnQsiLzD3bzULjV8c0BQUJT2Q=
X-Received: by 2002:a17:902:fc43:b0:22e:62da:2e58 with SMTP id
 d9443c01a7336-233f36e4923mr17730315ad.10.1748010159343; Fri, 23 May 2025
 07:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de> <aDBvHWPjYQwJQx7N@infradead.org>
In-Reply-To: <aDBvHWPjYQwJQx7N@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 23 May 2025 07:22:28 -0700
X-Gm-Features: AX0GCFsqtdzTcd53wJfGkmsKkSxEdxSzR2SdxOJ7MSkj3OZ_tFnZBmaupGbQwss
Message-ID: <CADUfDZr5n1whmFszEWaY3hjSHQAiLYjfvEAA-VHfEB6_b4m=hg@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_072241_002426_55F7A670 
X-CRM114-Status: GOOD (  12.69  )
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

On Fri, May 23, 2025 at 5:50=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, May 22, 2025 at 03:54:46PM +0200, Hannes Reinecke wrote:
> > > +   if (req->cmd_flags & REQ_FUA)
> > > +           control |=3D NVME_RW_FUA;
> > > +   if (req->cmd_flags & REQ_FAILFAST_DEV)
> > > +           control |=3D NVME_RW_LR;
> >
> > FAILFAST_DEV? Is that even set anywhere?
>
> That is a good question, but this is consistent with what we do for
> other I/O commands.

Looks like it might be set by blk_mq_bio_to_request() and
blk_update_mixed_merge() for read-ahead bios:
#define REQ_FAILFAST_MASK \
        (REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)

if (bio->bi_opf & REQ_RAHEAD)
        rq->cmd_flags |=3D REQ_FAILFAST_MASK;

Best,
Caleb


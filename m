Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A3C4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=; b=L+nwCpidQslhnoRoEJ4EIUeiYV
	cvrvQqVf4dL/uCdeYHGGz02CsScWpzqVZqKxiUqLy0I96/ExzfUjTLgG1OgenPkR7Rsvj6p7BxZPw
	FR2wM6P54eYqMFAv5nMzn3X1Rljdqm24zb4sG304hY8Rffih95HiBJ8MQCJgXHfZ2Y4KJIX9XUKsp
	ot/VIORU+Y+vHapCat/EtTN4re1ykSV6rE4cDr8sqKgLVhMN142LFB1tsTamHgToJS8LNT+D3Eg6D
	Zdv2tqneXcwbQlFgvJPkM21NIaWOwE197qmdyOqn4BMd7ZW+lq+vCStgAcyUp2ZOWH4cHBFbVhXAZ
	XpGx/aZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcAh-0000000CbUm-3o3j;
	Wed, 22 Jul 2026 18:59:59 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcAf-0000000CbRt-0d6d
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:59 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so9398205a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746796; cv=none;
        d=google.com; s=arc-20260327;
        b=l/1CERLnOIL0+aVROeDrwyjCLkiSkodp6ZROOmIrS3gcw5u8iIjfgqusdFNKQpAA66
         3drQHBmu0ZBoL6MZ5YAoFAeQrF4EoTidgUQFTfKo6ZqSOvzq+CRRtJegnO1Bxj5X9eOz
         7DYAMWjvpsESqw4GdSLfzVPlYVfr7JYddh19qyLY0uJbw29RnV1eToPbhGd97C6A2C6l
         eT9RWxQYJY6/wtnkETLMb1G4BYgQypii+6ptbGAua7Wux5s1+muPtkIIo7whM6JmArwe
         CldNfr2yQZjhkS/F+o5GkBoaI/FzVkp4NwgiLthv0YWmQ3YcYda8f/SVLpEY40hS+y8N
         OY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        fh=p0kQbc/rtkX3dioIGQCltCZciHLIDknrL3SBTzgpBE0=;
        b=nhT9z+F9RaGKOtgNREhlE+QgGZHITNkmxheNu/gWY8hqYx24ILRU7rqjyht6JAfx1z
         /CU5133tHO82yRVq5UcCGpsN5dxRL46eETRu/iQgRkOijBDgwugyzSJQpTcyh9tjFvjN
         1Lh/aBfBNvcrjNb0E2bP/WHcD2SaEfDH61esVqa2g+IF+AKYGt0ztdGkKySkzXD/Cuii
         JN9fxPuGXtkMMhBbJjPXOki9YiPZwo9Y3OXzElMmEkgpsXz3hrysYAQtXUafPXXtruvw
         9C+uqVQS6SwFWj7JBUqK0DixhWvsG7g3kgckJ9ayOiMB3YLabxscvUp0Ab6EHvxTwJUB
         RiRQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746796; x=1785351596; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=Vz8pL9CnN6U4+AxEjJdnOFPOlgzhrkGVnClUzf67vvjjbaOuLkX8xKLNyM216yuKfA
         EAGaeOLh0QAnlXScVb+OEH4M1W0imRvx+r1DWW36C684kxZu6JGoBwRpFu0aoux7h3RW
         jP6/PGmpSLWZW0s76LON2iSKt9OTKm8GOuT4rYFudnuQnISC7nxJVow6ONq2CpCDF6ZP
         gDzR0pgTMNc6dQTnIyc6oW08chBp7VLwfzTnBKxIHh6gnGSMs+/hIAhi4zx0x2kO/9KS
         U7fjkIEC8JOqWCdYU7QDcQgYpmZ0baOJXDlQNp1juzwcflZDrIpQuJ1rmyvna77KOLim
         60Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746796; x=1785351596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=WCBJyUaH2enl64V7MI61Qu7/OhvxdCJ4baQyP26W45Wn6UgSMnPW1wRnKHqCTGFnp9
         uFuxJnuauGjrBM9+Mhz+741CK4d5sPKzaDgqc7xwm3Sd5vtoCdVoqH29+SqGieOw5LQ5
         Fh3IpyfZonKZtDOfeHChj40IlXnzmeLoYToNllQLnSH3IDdHvdAYp/I+tLHWDygf+ra/
         qLnpRUzn5Qlhgb9OfNl8KXNU+RE86wZ1Eqb1aPIyzTeUOhBYHgeEAeXEg6fPuIrgKRbw
         MizxLXa2ft3QW/h89YrF3COnlWAt0vodyzSwZBOlB16PtS83H/I+NTSz5QmTnkPwKRp3
         WWtw==
X-Forwarded-Encrypted: i=1; AHgh+RqqvLMI64jNWIVZ2GK++JNOs0qrASILzL/c+4V5kjw1QSViueI/6/HuTYesCvPvawcBs6z3khJytdRr@lists.infradead.org
X-Gm-Message-State: AOJu0YwoqYkwukTACPdsz5gFjittjv32e+9Xa7yyffT9h8TZBjpAmAgQ
	WuAtuTVoksyaKN0MjzPcL9a0btM+/YIVR0aCc52QcfuB1MpkmvVITy+3VQ/fFebtCCd9mwER5zT
	y6+BVc/09CJJnAtP0Wj9E09ySdrjnYLEgUGcu9mmS
X-Gm-Gg: AR+sD11uW52UdmsoO1p9NDnNYBGdJ43rxQGoDETmEHzk4G9LO1zeRKPn03UgZWibHl7
	3Rzh1yLAYjFiwD5uIcGpFAdLUd5USuYulridvVkCHtiwgQKBb9UxCjeTfa7Q/gB1oE43uMhGttl
	ped8IrIRQqqq65WvbGaLhW78noggJKZg5bjvZo6P6lcdfa7DPl9X8WcYJaCxTNw/eoCH+yzX+Bq
	VSVLqFU6ps3p88N3aPzl8SdzViyH6iBpUiRLmH2ZIGX86o4IiomkAuSR6x8pt6jSnHVL/s5myKc
	rMbJJi+L4VIYD+Gs7BIC3QPti4v2tZHl1enj6LBOtn9I/r4/6aNbWxVaZZv7X2l4K06W4VFJ13t
	anl7bDW+Je7zhrwMUkx8vhS3RoikF
X-Received: by 2002:a05:6a20:c70b:b0:3c3:7427:5ed8 with SMTP id
 adf61e73a8af0-3c3ad5fc1cdmr27667795637.8.1784746796289; Wed, 22 Jul 2026
 11:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
In-Reply-To: <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 20:59:44 +0200
X-Gm-Features: AUfX_mwIJDNeayLFRjPiK4AAbt3mZyBzoLHgFDE5c__6SI0eByKP37ZQz-8Pukc
Message-ID: <CAPzsNDvv9eavB73xZt+LxjqLkah4CfiCJsAq-4vxDrhW13z6uw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
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
X-CRM114-CacheID: sfid-20260722_115957_208262_0BF7C387 
X-CRM114-Status: GOOD (  10.00  )
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

> Instead, I think it makes more sense to introduce a new BLK_STS_P2PDMA
> error and use that. ... simplifies patch 6 and 7 significantly.
> https://github.com/lsgunth/linux blk-sts-p2p-err
> Feel free to run with that.

Thank you, it is much cleaner now! v4 is built on your branch,
your patches kept under your authorship.

Two things I changed in them:
1) read patch reads bio->bi_status after bio_put(); v4 moves it
   above the put.
2) for the narrow_write_error(): a P2PDMA failure is whole-range
   and deterministic, so v4 records the whole range as a bad block
   in the completion handler instead of retrying block by block.

Mykola


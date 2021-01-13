Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29088C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:43:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89A023370
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89A023370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hJi/lr9KNWTmjQ3hJcyXu9ZgzR/YZMcMiY2kO3TDwVE=; b=z8BkGU6B/a9zZDSsM1G9sdhcc
	l2oJTlY5XbptkotIww1+G4E1i9IAmZJKOJXMPlseesBF+VDk8noHZr9R0otKQjPULRrCvXOjwNDvq
	Yw0eyVLOWP92K4lwseWmTyPPQ/EgXRfT+Wf1dRnRIU3Lsks/pIQqNa7fbhTncGPFz5/w/K13E9D1h
	05dgdUsEshtkqK/zv6yYOezEYJAx+l4ziVkl+Kx67v/+VCTg6VAIdGDN6mSR3TBzk0YlT/wuzwJTz
	0Yag+ubHU8GIYRNam44/Rqgq9AfdOuHhmp/SX7I8+/P7b3swInUUtms5QgPjJN4rV8tY9yUAl/zrh
	OcTyGjzxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzorN-0003WE-H9; Wed, 13 Jan 2021 22:43:25 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzorK-0003VN-OS
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:43:23 +0000
Received: by mail-pl1-x630.google.com with SMTP id t6so1905869plq.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9tMVwHSUMQoAyIhGC+spEfxT4ow3j6MpdgZXU/uvjzs=;
 b=KNUe7khMhLFg5gzAUmxvFXDxmT6cw3T0gRDd59tpbvq/Qb8imI2WgDI7MvUFIC8zDQ
 Fgg8fnok6aQl1bESWZSZ4jEergRcGP53/TopsbaA4CHde7zNwHOHdlAPLfffljAd4Qyl
 mjL74eC0nddKjgE7h2htkrbkIZGJlEyeIzMJJp3YvaIkb2+yfun6BzIGFHoCV8mhZQ/C
 6hPEY2oPLxZ93hqlYVSy+GVxT3XPlUAQkd7tFjr/7OPDwnFoIvMacuIbzABDgk4AczrY
 kTxAt2sm+CLnojqg9ufbvYKDP1UVM6ZoVulThReiJS8Iwoef3LiSrRUUv3ekphrBJz7h
 I/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9tMVwHSUMQoAyIhGC+spEfxT4ow3j6MpdgZXU/uvjzs=;
 b=ara3Q3n92LgVzoUvlsXfr1ER92iefVKQLd+fFr6EmJJw+rQwnN5J+DHU8Ts+LU9ENZ
 n0mzQKu43eXis+CWWEjG7/WBLVXYOAxZ3I4C/jBQODfeqhRwCMUv/mtg+SVPnGRuiN0O
 N6shCfCA6fK0vbtkjBIrKBUZxi6oP5X9GG6aniZIdvBOBQM/kVvMd6zl1cMjTO7JBX8U
 4ypebHTmwh77lLm6H4HX4W/dVzNmgBJgM3xPY3NOJc7QmI9P57pPplEIXUb/Pj+2lQGf
 YOhhMKA6flRTQMYqw9cJrz4+JV2dB3t5WFgz07K3dl9KBkXOXDt3GO4OZHZ6uYgWEUks
 KZQA==
X-Gm-Message-State: AOAM5336aZ+mnXS7nXyATnyoFcqSdUoY0LskhXf2Y8NtARG8dNasYgrI
 NCx9gEp+zStv3O6S4NRQt/eDEEvJSebOOw==
X-Google-Smtp-Source: ABdhPJx5oduoZrZU3AgYVQjColbWaqDIUoFbB9KXcaBsRkkBI+ch1V6Jx87bV9gPrr+qGlQtyc0TLw==
X-Received: by 2002:a17:902:a710:b029:dc:3817:e7c2 with SMTP id
 w16-20020a170902a710b02900dc3817e7c2mr4693325plq.0.1610577799621; 
 Wed, 13 Jan 2021 14:43:19 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id i13sm3560277pgd.32.2021.01.13.14.43.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Jan 2021 14:43:19 -0800 (PST)
Date: Thu, 14 Jan 2021 07:43:16 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
Message-ID: <20210113224316.GA4094@localhost.localdomain>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
 <3bd35739-c309-b04a-fbd7-90daee5aeae7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3bd35739-c309-b04a-fbd7-90daee5aeae7@grimberg.me>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_174322_841611_AF92A062 
X-CRM114-Status: GOOD (  17.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Thanks for your time!

On 21-01-13 14:20:34, Sagi Grimberg wrote:
> > Introduce acre flag for Advanced Command Retry Enable to controller
> > instance to decide whether to retry or not in error cases.  This flag is
> > set if Set Features for Host Behavior Support with ACRE bit set is
> > successfully done during reset_work.
> > 
> > This patch also fixes nvme_decide_disposition() because all the nvme
> > requests are initialized with REQ_FAILFAST_DRIVER to req->cmd_flags
> 
> You mean for passthru commands, nvme doesn't control this for other
> commands.
> 

Oh, I forgot to mention... Thanks for catching this.

> > so
> > that blk_noretry_request(req) is always true.  Check ctrl->acre first
> > and if it's not host path error, then it will be retried.
> 
> I suggest to split out this part to its own patch.
> 

Okay.  I will split it up to two patches:

  - Introducing ACRE flag to controller
  - Check ACRE flag in nvme_decide_disposition()

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

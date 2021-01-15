Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83637C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 18:41:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFA723A59
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 18:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFA723A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fEiISAJX2+UMDXMWflyVkOfWsK4Q7ZE225mThpLDA0E=; b=uHaf51fqxwEZVUoXgc4oKWVUV
	vpnmtL2TJd/GEFpKYGUBp7+2//bZMyb7owF755rOMswe1MeISc1mJk7S23cFHewssrJNwPbS67LnY
	1eIdWRrgW46oQJfAnc4hreJh1wCac8dw7Zi+YCdjhc9+WXYWT+xYdFj54Ty6p3zJ0OBi5U8X+FYlb
	5/Zzt+epDazVwzyGVMIXp5vthrJ9+a5psfrt+CsT80ecAJZxziNeV+q/n48YJV3j/d6YaFyK9RQVC
	WrZHX6FQVWDWGae0lODV/CnDsHYTYZ1YHsTQwTrgvDBWR68J18DlFwZp7ZaGkuIBTKFAeYdpZ+bJk
	+3LoQ8cNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0U1l-0004qZ-Tw; Fri, 15 Jan 2021 18:40:54 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0U1j-0004pv-FW
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 18:40:52 +0000
Received: by mail-pg1-x52f.google.com with SMTP id z21so6567897pgj.4
 for <linux-nvme@lists.infradead.org>; Fri, 15 Jan 2021 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NUza5pyQ1SosuzE40H6CmTthk2y9w84o6m4oasSYKbo=;
 b=fnxhQot5MegUQPbkBV5fvA7qRyPTtybjCRQ/zbad3RPuWXl+Nkm7poS1hhQfi8EPgt
 2ZYmOrutYHAMmUP/p1hKigobL+k8n6kgM1m11IJXXbghPYdeEwGShP1b1ZXm6Wngfvta
 cK3olUBaYVdm4Jt7It9zpnyXVBT2Vu57wIaUCLPES6hHJTMRNiF8glu6JvTb87crqBpX
 hhHW8juFq7k0OgegUS8ChDAOuLINDzWuDSdkiDtEZfJ38HoW3/jJy4CS9br3+dmuaSwM
 G+9TSJuX90aO+43R6aTZ/gzdqBMu+jh3fF95Vg1Rkb9kJeH1mbbrGQrfmOPAt2jGHAWQ
 V+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NUza5pyQ1SosuzE40H6CmTthk2y9w84o6m4oasSYKbo=;
 b=SEkOdKmy2bJp35x53sIHR+wOkqqBG/DKSVXDygUCBD+wTS8jEiryM9f1UYLtg9N3sV
 4/GfhwFsEze9UetjN5+/UstW4xVnU2Yn47ak/PDC69elP3IoUNDMPdTMHSY470w6mB61
 Pe65RQs0gLJC7n1BgvQxaJFenSMLu3WU5LuW5rj3TzjRRPLdYy9Alat4tZBMZPIWWwsS
 7jSftXPbMRv0PcMqLdmZkXjOLgE4jrCZtm3hWHBkE98m7TBnwXJ3tGeuVxwtLB17Ym0y
 ynXMBQqGexD2d5n0UUSoGiOcdo6nbZq8DoObuLj6oFg+O4ZGuSWeRnK+MyOhCBiAOL7X
 +NLQ==
X-Gm-Message-State: AOAM53366Yu8TxoSRqF6pplpmaMgWiggqCXZdr9aQnQciyfIOdsawL7t
 jtkriqckn8EcExyNUOY6O6w=
X-Google-Smtp-Source: ABdhPJz5sgDjCe1LJBispQUl5hxAZo5sL0kXx/PzyIXUsw+EsGoPE48ht42QO6dxZIrtlmItx+DPUg==
X-Received: by 2002:aa7:95a4:0:b029:19e:abd2:4a88 with SMTP id
 a4-20020aa795a40000b029019eabd24a88mr14217614pfk.2.1610736049410; 
 Fri, 15 Jan 2021 10:40:49 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id x15sm8296530pfn.118.2021.01.15.10.40.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Jan 2021 10:40:48 -0800 (PST)
Date: Sat, 16 Jan 2021 03:40:46 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Message-ID: <20210115184046.GC2822@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
 <20210112080653.GB24949@lst.de> <20210114072254.GA517@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114072254.GA517@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_134051_604751_828FBC91 
X-CRM114-Status: GOOD (  13.80  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-01-14 08:22:54, Christoph Hellwig wrote:
> On Tue, Jan 12, 2021 at 09:06:53AM +0100, Christoph Hellwig wrote:
> > Except for the little wording issue this looks good to me.  I'll pick it
> > up for nvme-5.11 and will fix up the commit log.
> 
> Given that we never retry admin command right now I've moved this off 
> nvme-5.11 into the pending queue.

Thanks for sharing!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

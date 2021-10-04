Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767ECC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 16:46:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F7161213
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40F7161213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BRKihA1ka1/onTEVqTsmt1kVwM7p6E70mCnPq5QHg/o=; b=JJKHM8C9qDnbJQ
	4byHgOeDSohnNgWkNHnR5FHUWxmCV3wo4jb2t2hN5QoXTRExRvYRPpgGlFveBGZYXq4o2KGxv7Pg0
	GwkiuAfAjC4L0OFABK3pJTVtBT+0ouso7IXm43SMs8OCeulV+ObAfe/M0crVMuZI6ZYgOsHQdWBi/
	bMFmzzgyKMjctpWSHnroAa++1Bqc9bY7cQTEKZIz6V1i4BKgxmo10VuXDLI344B9RrPFOMAwQ4slZ
	TxAg33DZ7e89vh2r4tcxHr96QZF/LdxusSN2iwA6m5ZoKCpM6o2Oci+iL7U9fuoNBuogt3tlsXTZK
	t4PGuZ+lK8JIikGYfGtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXR6h-007AgH-8P; Mon, 04 Oct 2021 16:46:27 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXR6f-007Af7-5v
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 16:46:26 +0000
Received: by mail-wr1-x42a.google.com with SMTP id j8so1488573wro.7
 for <linux-nvme@lists.infradead.org>; Mon, 04 Oct 2021 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Q8YlDgUTAE2L8IuMx1QtYLGzvoA37MPrano2yJ7TaQ0=;
 b=P5HkP6Ik9+4pwFcNJqtEsdF0w8C1ScXlz0RBtHbv2904SLnQQooOABihgEVZIV917y
 a6ngUK3PkdEmFf4n5bxktZ/sEPQqz0HYRD97OEPu+9OXMz9/sm3cI7jPpPOHiimSmg/y
 8srI2SuAKA1cNuIoGIMjv2vS2oN7elPUUX1SDoXNcxW0pIC2WfLeE9vbDt42U8TXcrCQ
 bqU+lsOj/s8G2MW2AbYeq1wE4V9vwcQfGVNQrbTACRLisqsBU4xZiTLwOd9TQTRHMs9f
 BRr/cNkCtGD2zM16qpGTzDXL4pKHFX4HpZlF5jPOJN07ZJ2QmXBO9SGCKLaxhRgZO02W
 94RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q8YlDgUTAE2L8IuMx1QtYLGzvoA37MPrano2yJ7TaQ0=;
 b=wk6o5GdadR8RbowedBKx6asJ+LV1V5gZbOkuUfIoQ/75pW29x7keDr6lJ1mKi+1kA2
 /h8TUxOsShcM95J+r6X8TvB33gOWqhw9xL81ZOa63VQOP1xznwec+WZXQNDbjpmy7+rz
 liQzUnC+CEExWvabnemnQEOFjXQi8YLwbz7STvxdMsWMcQ8tOw4OyvVYbPdKmCA0yt0G
 QvYBdC8+UacpxJtLmD8T+KOD/XwedH5K96yfqo9efqhnmCt0k1+75JJlgdfD0URoGIUG
 GMHFjSFq5pUSNrixaUQKy/SHYZ88d2mzlPdFXaflzWHzRAwwW8vxxwn3AkKNGEATseGV
 PLDw==
X-Gm-Message-State: AOAM531ZmtJxnbatjEMJ2ZOLWF/YUSGAP09Utunv3Ci087y3OSbFYYva
 JLcMPjht0Rna4PJ4ghgh77Y=
X-Google-Smtp-Source: ABdhPJyWZ3G7BRA8ndUKuhHee6efKb8LblTAVPXxouuN6CatgDsWUtaz60Pw4NftiIwQf5+INVnaBA==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr15979358wrv.148.1633365978259; 
 Mon, 04 Oct 2021 09:46:18 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 v13sm12003999wrp.64.2021.10.04.09.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 09:46:17 -0700 (PDT)
Date: Mon, 4 Oct 2021 10:46:12 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20211004164612.GA1475751@anton-latitude>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de>
 <20210920145336.GA489494@anton-latitude>
 <20210921071527.GA24837@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210921071527.GA24837@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_094625_283388_15B3E4E7 
X-CRM114-Status: GOOD (  17.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 21, 2021 at 09:15:27AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 20, 2021 at 08:53:36AM -0600, Anton Eidelman wrote:
> > The wrapper is to:
> > - follow the naming convention for mpath functions called from core
> > - allow the implementation to have more logic in future
> > 
> > As for error propagation, nvme_start_ctrl is void.
> 
> Which of course can be changed, like all software.
> 
> > Any error in nvme_read_ana_log() will have the same effect as
> > when it is invoked from nvme_ana_work(), i.e. will be ignored.
> 
> We need to return negative errors during initialization otherwise
> we're going to run into teardown problems.

How do we proceed with this fix?
I believe error propagation here is not wanted because:
1) A failure to fetch or parse the ANA log should not be considered
   an error in ctrl initialization.
2) Such error will not cause problems in teardown.
3) The same failure is possible in ANA work and we do not take
   any action in such case.
4) Adding support for failure to nvme_start_ctrl() adds complexity
   and does not look useful due to the above 1-3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

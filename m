Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C9C433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 06:00:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AD92075D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 06:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c1vbNlDB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0qJu9pLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AD92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G23hfHzzMlWlao4/yNHPLaZri4K8gQxWY9pXhSfneX4=; b=c1vbNlDBtl5HbhlIBVRGAMDlw
	qdmAKOUDVE9xJT5rcqtYKPqhQ/FV580APzTdWt130TWgyAgoVjFz29N2Z/JP49hcetsisSgqZ7S2Q
	D7R2e9L8CwtwwbZ1kZIhTCYVSR7r8/WFvj3j6/iRuGpqmdPovyg/KgrnJzZW7xKXuZ4/CIzsDw9CX
	TUACOvoaBPFw/j6GW03MeCPuGQWyNgUSSqkATm46WmuRXmW2/kZAHbS+ib8XojmlTuN0x23GGh4pZ
	S3bx3tau2wUHeKS7kKk8RdTDB4KVDSyJcPgVgBhOtNr9FnPnmyA6WOTmWZRscRfZrZcB3BSovPQVX
	Xx3joPQrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDLoW-00071E-S9; Wed, 02 Sep 2020 06:00:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDLoU-00070t-Qs
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 06:00:07 +0000
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55110207DE
 for <linux-nvme@lists.infradead.org>; Wed,  2 Sep 2020 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599026405;
 bh=qB+hJ64dFeZRc55gn05GV3vmMdd4XqXGRfV9RvpoPjM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0qJu9pLJ4E1vrW1ZCOrx22K5hPkVXWi4ywQze2MMxFBe/K5cPfkOuOqBNt9LPwaDg
 ZLrPaLIh81y83xpORfZ+dCgHhd49hoeXv9J8ZgsfKcp/G5G2kRmTyYl1K895tjJKXX
 QjIDXFUXqjS0LTSdRPNSKdYJnpJZkVkN2EyBpTcg=
Received: by mail-lj1-f178.google.com with SMTP id y4so4390904ljk.8
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 23:00:05 -0700 (PDT)
X-Gm-Message-State: AOAM533Wu1jJIqHAMecQ9HsibvngLGEsmnzV3BO8prQVsO2f8XXBFc/2
 NbQ+T8CqOgRDpBavMXhkmg/Pbra4uqE3zNj6EsY=
X-Google-Smtp-Source: ABdhPJwf3HULiufgbpwKVoPwmf+LkIKFmte7J3KnU2uOXqQt3v5M5F/QoyNcLdziLtm9PrTb/1L0NAY4kWOOlCFV810=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr2427127lji.41.1599026403505; 
 Tue, 01 Sep 2020 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-10-hch@lst.de>
In-Reply-To: <20200901155748.2884-10-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 1 Sep 2020 22:59:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Subject: Re: [PATCH 9/9] block: remove revalidate_disk()
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_020007_030302_4C91CA87 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid <linux-raid@vger.kernel.org>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-nvdimm@lists.01.org, open list <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 1, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the now unused helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

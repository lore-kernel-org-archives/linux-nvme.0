Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8DC43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 03:32:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C696D2076B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 03:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4OtXgw6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmywM6Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C696D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8jM8BqigAFNMt4xewufyDx4Wq85YQ1IyBqH5iejQGtk=; b=m4OtXgw6R/287NMu8QJjgjzU2
	YYLRcKQ3pL2feSWB5hutT/ATZsBpXr2Ztb4up5FfcOTwt1//unteLP8ldIKJSCbj2cOF6I6jA+fWN
	K8V8487R0vMx+pF/k4KNBFEEriccA2AkomnuX05OZETIkwdwPU8Xx1E2LgsfEn6oPjgWuxxxO3hLV
	JIUgQe3CYJ2nvGC44GINm/Ux8mK5U1scWkUurv6SbZRBNThDbj4sQqw4r1Fikiex9AAq9gH6XDvKE
	UEgMRqWkGP6LRLbFOCRB5eFSKcyw41OUfThWWPtTeYg4oFsak6YxAkh8/IFJdbb/V3Q3U/m0xynVF
	9CN5eqksA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ78N-0003bq-Hb; Fri, 18 Sep 2020 03:32:27 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ78K-0003b7-PK
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 03:32:25 +0000
Received: by mail-io1-xd44.google.com with SMTP id g128so5274113iof.11
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FPfn4rdBew7aKFWhRQjD3cboCteJKrBsGnCZeS8Y5jY=;
 b=cmywM6Jb7lPoDpe6aana4LL4RyOMq8hdEPqtllD8pAM6388lg0hTs6WS3jq09PKFpg
 /lXsYf3jDOSs1CsDoaSOOOFw/GZOibUdXA5JNiLV/4HKV4V/LltrshVX0i9T3p5Obu5A
 iIGyV7K3p+FtvZAJBTxqNWjhnHygt7+rhBvbVx/1ygmpdgbTIxNNClCEQ7HxoaIF91uf
 sUAx2V5q4Um2krAgBz30D1ohEowQGYJG4Q/o1jdWCpsMd8XKatmzKiT989C/a4WQU9UR
 0v8hZ5vt2qgioSls7Nk0ZmcpsbXc3ToIt7+n7kTI3xRhVu5l6GtE2Y58ilFWMVna78aL
 qJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FPfn4rdBew7aKFWhRQjD3cboCteJKrBsGnCZeS8Y5jY=;
 b=onZAxbpZ6+wZZKtIz64Jm+91tlMfUIfLdr9KCO/ba1y8jSIEOYJc/LxuxmBsgwhRbv
 rFP2tgkdl9xAtOxA2u4OOqTbRtEm43WBLc8YLOSb2x/dOef2H9I/uxWX8px7iEk4LAl4
 77Q55ZvnWWqf9ewyVZDJQriz89DgvakrZA1kGx7aKZlqCmzZ+wuW7/x46pt9uJPIOAv8
 Bxjt1h93x+C4tJ0FfvVb7r7hP3XNqtLOCYuSlk03Rao60HiOXIvNdMRdgOfVwSvUgipv
 OUXPufE3mIBXgmPFOQe9Ik7cqx7+0VhydGP5Q1ziO/+RU+UQjvOapG2Q1Alls1qs/T/w
 cECg==
X-Gm-Message-State: AOAM5302vAsRdz7+fIGrXxeDh0ROEI+M/tM2UdgQZWev6ov+gxKJKSNr
 W+4VgDkLfQD8czzYnhK4aDoL7IaT5B1qJrov6no=
X-Google-Smtp-Source: ABdhPJyxwieaP7FDRYrpmgKiq5RdWWk10z+MLIfwDM6zwC/YS/veccRpviZw8Z8jGyKSsBfC9tEy52kKKdpzZq/OmL0=
X-Received: by 2002:a02:a615:: with SMTP id c21mr28913596jam.106.1600399942791; 
 Thu, 17 Sep 2020 20:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
 <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
In-Reply-To: <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 23:32:12 -0400
Message-ID: <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_233224_940520_1769B106 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please correct me if I am wrong.
After a bit more digging I found out that it is indeed command_id got
corrupted is causing this problem. Although the tag and command_id
range is checked like you said, the elements in rqs cannot be
guaranteed to be not NULL. thus although the range check is passed,
blk_mq_tag_to_rq() can still return NULL. It is clear that the current
sanitization is not enough and there's more implication about this --
when all rqs got populated, a corrupted command_id may silently
corrupt other data not belonging to the current command.

- Tong

On Thu, Sep 17, 2020 at 8:44 PM Tong Zhang <ztong0001@gmail.com> wrote:
>
> Hmm..Yeah.. I see your point.
> I was naivly thinking the command_id was the culprit.
>
> On Thu, Sep 17, 2020 at 1:14 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> > > The command_id in CQE is writable by NVMe controller, driver should
> > > check its sanity before using it.
> >
> > We already do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

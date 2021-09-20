Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7BBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 14:59:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF4B61077
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 14:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CF4B61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6ckm6RBlbbX/DUHMCoN8LoTZIleIfyJDxVw8UrqBTCg=; b=YXKQoWEFQRo/Mq
	BB2ilobyBDg85mZ/qzgK1dEob41De8Dur0Q2t5vxuiKY2QO9oWinxOvIyu/ZHaEDzVaOJRS45KnX2
	11mPZiIB8w1P3jKwBIR+Go7Ip7/n6X/HZJpvXnZ3kl2eqrWjQy0axvEXXd0cdw6PQE+IvE14BCpJs
	qrYjyLiyDU7DmQHDL8Ucz5VKBmnJVVpZGSULgpz4y8gzlT/0xNvO150AX96igTwKGCV+RlxaQz36B
	ojbwhkVUWVlY7f91zjgHOWpQEjd2f6Py68wRrP4DXXgvkxMNFIASVzubI9iJNRYp4TZ8wo29EuF9p
	9rYhUg1u/hWAn1mpbcBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSKl8-0026Gv-5W; Mon, 20 Sep 2021 14:59:06 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSKfw-0023zc-Vb
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 14:53:46 +0000
Received: by mail-io1-xd2b.google.com with SMTP id z6so15734847iof.5
 for <linux-nvme@lists.infradead.org>; Mon, 20 Sep 2021 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N3CS2tH8R/u7Uz6A3O+THyOE4x5rnQ/+nqJkTyG04zM=;
 b=PQLBQFUv09+BWlpCwVvKKXjw+zmi4B5j1GI+YU8XQKSHdr5mJwHEnnzxoYiIKQHucT
 3WLf9V13zPYgsuH4mLPViMkM+DM8xL3E0qbhHxc66Jl1gnLrIqWiO2Lytq7fwgeCUHmF
 Ys9Whx2t7ajUv2bukSIhMvyUQ1Gusd3zUHq2zJ/+H3ud2hrSqVrY13ggGfauysQe5qqc
 GnWcmyvlpfEfIs8v7GA3W5fAXjEbk09CB2m5OTDR51Qx4JTBZ9Tqd/4N+MdyXMn09idO
 rAFfqz3tJGF8bNCWA8m5xFu2aWXm+vHxJ+pi9IT6RQxltD8uIEHMf3frkAGp5cUa9b/o
 mSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N3CS2tH8R/u7Uz6A3O+THyOE4x5rnQ/+nqJkTyG04zM=;
 b=vvst8IGg9Rb0OwimRNGSgyPk5cRb3TG0Crw/ZLvxW+H7gp6nNCS6dp7zY5kfxWpUg6
 V+8FcB516BrP090BRBqFNQSe+1SgvMkW3bi7+1RjEENn4A9AOrZzjRSEQ/izNskoCAld
 H1KQ60C+XjmHo8Jkon4nsvqSzb8lORXlomwBhuXIbghGouDKTzT3RIDd0Ft9sSJ91or7
 IQfkVrMfKhCXfHPe/BOAtR5Ac7zEyqTs2AnLq5h1bcgwdCr6+Dw7Min9Gejyd13vF2To
 z6GFVfL7GnLmc2c1qiSYzWdqd172lsPA2VhOIbsLuUOxDkVXYxVJGBdNNASmppUrqB73
 igOA==
X-Gm-Message-State: AOAM531DAiE/0cYfyqvQUHBl14H2hG69yv9mpYG5uM+sPgX9bhmUM6Sj
 Tpmqk/TLRgQzgjxoAbcnFGQ=
X-Google-Smtp-Source: ABdhPJw4J0CKvj4CNt9U3ntR+fm31nhuDvoZ3CMNDWcqSWKEVgYQbzqCX7FZNXIpqgUvlB/BGRDojQ==
X-Received: by 2002:a5d:9493:: with SMTP id v19mr2700127ioj.34.1632149619799; 
 Mon, 20 Sep 2021 07:53:39 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 3sm8905821iln.79.2021.09.20.07.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Sep 2021 07:53:38 -0700 (PDT)
Date: Mon, 20 Sep 2021 08:53:36 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20210920145336.GA489494@anton-latitude>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210920063534.GA26999@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_075345_120304_1745D739 
X-CRM114-Status: GOOD (  12.75  )
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

The wrapper is to:
- follow the naming convention for mpath functions called from core
- allow the implementation to have more logic in future

As for error propagation, nvme_start_ctrl is void.
Any error in nvme_read_ana_log() will have the same effect as
when it is invoked from nvme_ana_work(), i.e. will be ignored.

On Mon, Sep 20, 2021 at 08:35:34AM +0200, Christoph Hellwig wrote:
> On Sat, Sep 18, 2021 at 03:57:29PM -0600, Anton Eidelman wrote:
> > +void nvme_mpath_update(struct nvme_ctrl *ctrl)
> > +{
> > +	nvme_read_ana_log(ctrl);
> > +}
> 
> What is the point of this wrapper vs just calling nvme_read_ana_log
> directly?  Also shouldn;t we propagate the error here and through
> nvme_start_ctrl?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

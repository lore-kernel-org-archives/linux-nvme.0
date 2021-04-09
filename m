Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C60C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 11:29:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99ACC610F7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 11:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ACC610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mf7LPqUqDdV/bFogVEXWTK6XJBD+L6Rhlltmc5ohoG8=; b=DYky+0nr4jTZ+I3vtp7/7C9xE
	lPd/+z29lSNn+m5B/4QpTbs8fo0rtE7R/G+RyuP4UV4EZcKsMbKTNDUvuiIC3+ZoyTNwKv7BKnqbH
	xcjYh8/pC/qn+RGPUO4v1XHQYb9RqAOM2wP4ymF6N1v6PK2DNZPGAr4U7UoLW0CMkAcZcWdHgLUqZ
	UolMVrbfFi5lctAhcvaVKZbnN83K2TT11e41hnj2CIITDDUrcmfFKWFrysymcRxKPoQbDw5+mM7nu
	VpNFVJhGIDRDi8nSzEfnZLQJHKgYC1EaFCRxUVba/01lv61JHzzrQKdiL9qySFb123Cp05vwjSI4a
	HrIoeWJNg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUpJn-000c5B-Un; Fri, 09 Apr 2021 11:28:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUpFA-000acS-A8
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 11:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WtEAl47Rhj1Pwr/J3acnSRjWMbWiHqFd4+hJfzVvKw0=; b=sAhzxpEuLt1QDzSOhKYiigAzCd
 ILMWdcxc8KOkFx4q3xOKwcLbXyQPjEHXnEqPN8gDcb6lIaZ63J0GKBRSBCtc+u/aimbIJHQUk3bfr
 etQerkyIFaDqnuRuBBALW9g98B8+4oP1oZiT3ZXrj+1FmDWXcrzwEzXA8dnb3L/9Zlaiaym5NlZP2
 H5UNAfLWGEU2+pQmp4seor/ksxZ7vcmqM7lhMEa+XSPuhUbnwQanmOhHHLmswEWHxjoNB2E9zv9T2
 cRaOQJGDfvLeNB+LN+Y9hC3dTrepQK6ql1NN/GC+pwpQ32rnYlkWYOlqtZM+IIb2pA2JpN32bd4n8
 y7wjecuw==;
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUpF7-004Sgz-Jv
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 11:24:06 +0000
Received: by mail-pf1-x433.google.com with SMTP id o123so4026241pfb.4
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WtEAl47Rhj1Pwr/J3acnSRjWMbWiHqFd4+hJfzVvKw0=;
 b=FNqJ5SgW2mszjVH71YtXw5olFoI7zBm13GifM2nTnFdGXWL4CyncG7SSd+Sv9WnaO6
 Gh9AHZckWXW8gQCMmi9j/+pT1175KHCviQx10akk9WvCPNKIEBszW9WML3OXdjjzn6d3
 GQsUcUTu+jPxmp1dHwqO25YS/5uek5F7z7kpZKJFxS+hZFq45liCzLLJRhwtScdYMYKE
 kex0lnUEKZmYhMebSHMOOqpPSgmWxqmpsxlO+iH6hK+clievrwZqiYswkFk2vz0sDWE6
 Qc7K752anTieHEhKP6NoCI6hFIfMJVzXxLFvOxG8xBcwkkwNC5/QiFOqW9PYD2BXdAFX
 yFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WtEAl47Rhj1Pwr/J3acnSRjWMbWiHqFd4+hJfzVvKw0=;
 b=W5pNx2N+2RkdHaIToKdWgZtC7h6yAdG5yS8RgBOa0Sj3z5E1XCGZPBVtc6qZ9FZHSi
 NSUSLNsfCP0/ZwAKTE8LZCDgJNuNi75d+MAgs0dXyjEtfYLl6w/OXVkHQ68gqqfkFvPS
 p07wUaAKgIx4D7+ODbidIoypIxhdU/v+iLtt3851Ms9FEmtCEACGB3stFRnCyXvoJiKX
 k1c18+1QOhwSo7f4WNNQM/MHD+MiPRcU3Af5pRDgwRJscmzfYI6IJQgOCmiBPo3ubiki
 GTcvDXnPSALfrLFuXMtFsqUSkxNn/mJZ0OhAZ9HFF15wnrDclMJoEWv4ulYkiNf60Ttg
 5XSA==
X-Gm-Message-State: AOAM5307oueQvoQZ194BZ79YzdRGjxXpx+R9Qfr2OYqVMqCjFdwqJ/dP
 BvFcaKSWsMgefuz3EqxFauk=
X-Google-Smtp-Source: ABdhPJzz2XBTIi5/tyOoZudv4hopiljDhOaFovfUMmQADyKebDdoD0vPI9mbkD/Lt4dZtLCO9Pjnog==
X-Received: by 2002:a05:6a00:1510:b029:221:cd7d:90d8 with SMTP id
 q16-20020a056a001510b0290221cd7d90d8mr11837364pfu.61.1617967443230; 
 Fri, 09 Apr 2021 04:24:03 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id g12sm2180187pjd.57.2021.04.09.04.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 04:24:02 -0700 (PDT)
Date: Fri, 9 Apr 2021 20:24:01 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409112401.GF2085@localhost>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
 <20210409072901.GA2085@localhost> <20210409075415.GA6991@lst.de>
 <20210409080214.GB2085@localhost> <20210409095205.GA15931@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409095205.GA15931@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_042405_697016_8C8D1467 
X-CRM114-Status: GOOD (  21.77  )
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

On 21-04-09 11:52:05, Christoph Hellwig wrote:
> On Fri, Apr 09, 2021 at 05:02:14PM +0900, Minwoo Im wrote:
> > On 21-04-09 09:54:15, Christoph Hellwig wrote:
> > > On Fri, Apr 09, 2021 at 04:29:01PM +0900, Minwoo Im wrote:
> > > > Tested with namespace-specific admin commmand (Identify Namespace).  And
> > > > it fails with invalid IOCTl because we don't have a route to the
> > > > controller IOCTL for the generic chrdev.
> > > 
> > > Yes, that is intentional, as supporting the per-controller ioctls
> > > on the per-namespace devices is a mess.
> > 
> > In multipath case, head blkdev is also per-namespace node which is now
> > supporting the controller ioctl by nvme_find_get_live_ctrl().  Is there
> > any different policy between the existing blkdev and generic device in
> > the current series ? Or should be just deprecate the controller ioctl
> > from the head blkdev ioctl in multipath case ?
> 
> Well, the multipath block device is supposed to be a full drop in
> for the block device, including having the same name.  So I don't think
> we can just deprecate it, even if that would really improve things.

I think if we don't have a route to the live controller from the
multipath node /dev/ng0n1, how does application figure out controller
node to request admin commands like Identify Namespace before their
own I/O ?

We have sysfs, but it does not provide every information about the
namespace.  Or is there any charming way to find out the live
controller from a head node through sysfs or something that I missed
here ? :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE6C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:40:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FA661285
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FA661285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bEagYaKdbg52VW3mcxgsS1M9UaBc7ZOoAIcj1V+k8Rg=; b=Q1kye95uxyKo4I2/A/daC3tA5
	MQahRP0mbwLIGp7yAJm2MdNSlHw3gdy1emPKdDV2Ia6ZMODCVKvldrsH7buztVp9R2/j6B+JdVwO7
	u5K84+M7Dxezonyn/sVoq7angGWO0HKgaMkKxBdX2QmlCNaw8yR5JX/SkV2V8fARvXK5SgC8LIrBk
	+t8v3yhamn4yQYtPsuNPSBUU+2Cz+WxXLvr5GCmw2p/Vd+0RYj9mO5ZFW9JDt10L749AHVFHV5d1p
	MN/Cq4S/ENZpp9kC6aSsjNZPeEO/hshmJ3bGwWojRj/oTW7UycAr/4IU5oOHnPhMf4RGe4jYg9X5U
	4zbl57yVg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligHs-00FY8K-BF; Mon, 17 May 2021 16:40:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligHk-00FY7w-Ic
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 16:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mJg/+7GYl1kUJvfa8nmmRMcNriQOvuN6MAq6Cn+ONao=; b=WpcNOx2ASmcR33TVeNGsd6DcNg
 Idp/vGCpNyUZnqYPJaF5NeDgEYnzCU/X7SFGd1Hg840PqoAk4eBxaSRTAeVLXrxiZ0gAXNVbosYlP
 KAkp3uzlF2RsDQSSJQHhrso981zssvuUBSmgDOuPPcQn5UBo/JdOUtILb2QTFSfZxAX6pdhCOQJyo
 fvL6hV97XgdDNDhV5rSHWvbCvC/CP2npDsUMviaZJ2uf+gOO/8prCqOZZ1MAaSCcv1hVM3wGHCJTf
 h6lAG9efb4nXYVtkO61z7owA2b2gOe1YFbdDAL0wjhe2+Vma+rRmvxyLb+xrkZX5tPqMe+Plwo7Dc
 +f0fo1jQ==;
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligHi-00DzEw-2s
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 16:40:03 +0000
Received: by mail-wm1-x333.google.com with SMTP id
 f75-20020a1c1f4e0000b0290171001e7329so3983246wmf.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mJg/+7GYl1kUJvfa8nmmRMcNriQOvuN6MAq6Cn+ONao=;
 b=QljiQ+uaASZtSxfuEI8hK1tI3a4Y6o+6ZIacfUmOJb0k0fVi7Sqo0U56LxQQ9n0D7H
 OxzEbcNqyB3z1vQNEnR5Zrv17/IW60UCKTt0DkFBfAkpNKRBn3/qqDDNQHQ+gKicApoK
 IEUakbF//Mlmww+fZRhyglLfSqybZ2w6kt78ttIvat3UjfCgjAdZre8u2bdxxvh7b7Oh
 0OORdS0W6PfJcfoRcPXrwXLnXkv26W4BkQolDkROWbWxKCd0pVsI/yPSXNZS74FXWI36
 09YJ3c55dOmix4700cyb4PhvAdUTQWISqO7u6Nx5VlJSOoo6z2UJd6lpY5WpnMFD8J+Y
 H+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mJg/+7GYl1kUJvfa8nmmRMcNriQOvuN6MAq6Cn+ONao=;
 b=RiOfsMMR8FPPmzR0fNgjnr6FMwuDb7xXu3kNQPNnE7xYdatYMFv3RNzDLuQ0LSeWye
 Gy5FngQtCld0MqL9Uekm09nh/hmD6hZb3lXSJZ3zhCy+FgdUwPzGpjnek90xc216l9xl
 Ym5/n7L9D1UOPOxEXsNKbaTatOn2XhFg6QuVlWJFXihz5sxao91ObN/0fmhlxUPTBf6p
 2z3mRakcHIHExsJVRdlpp+XQob89K5jzSInBg1h6alzINwtufqxS0DhM+FtcM4R5WJA7
 xKWQy1Hy/9R7Zh39jvL30wz8wfCjdj5O5eYL/eNbrdJQzaIwtxgqpC5IqkRECvoVMU+/
 I9AQ==
X-Gm-Message-State: AOAM531GQ0QHup97ZrFHbjo2+3jv3O1PODIAoL/1Bd68KUOqmtzDSOQo
 LyAgWQvFzwZjPxQ9GwPxvQGtEd7cOn0d/9CIXSQ=
X-Google-Smtp-Source: ABdhPJztcjSsj0J/JNFDHQf/JgaBAZUnQRFLtkWcpXIR+qh9ia6xfQrYTY+eZZzHSaCUmybr7ASuRfMEoFGty1cPlx0=
X-Received: by 2002:a1c:a442:: with SMTP id n63mr510553wme.25.1621269600181;
 Mon, 17 May 2021 09:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 17 May 2021 22:09:32 +0530
Message-ID: <CA+1E3rJO-HzZu5q+8ac1wxsnkGeST1epE8Ro00RNBAF340Dgeg@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, 
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>, 
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, 
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>, 
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_094002_144183_9846D4AA 
X-CRM114-Status: GOOD (  13.75  )
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

> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
>
> I'd like to propose a session to go over this topic to understand :-
>
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
>
> * Required Participants :-
> -----------------------------------------------------------------------
>
> I'd like to invite file system, block layer, and device drivers
> developers to:-
>
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.
>
I'd like to participate in discussion.
Hopefully we can get consensus on some elements (or discover new
issues) before Dec.
An async-interface (via io_uring) would be good to be discussed while
we are at it.


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC65C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 16:23:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F797613CC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 16:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F797613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=REFULA9tKxUFHOUsKbpPBd0FIhbxIYC3Ho4PpmhMZ94=; b=mmlV+PGbIkGBLKpwFt/AwI1s9
	BzdDhIGk6E6IXIvEvKNAp1iNBZ5hQq7eFnWmRABTQ2OX0b6VeSXzZPGmKTYrVDUwesMPaSybumw6N
	8tIYMcUgPcZAwPdNCPHJh9J+o//xnvsRM0txlQqF6GhqIbgD7NiQky9VyqPpZh4sKucZ1gy3FyAGu
	4f8jWYlThuLwp2x5eg5J3ORG57ix7lLvPiUpubbV/HqOtnQCo57m6iO4rWlQfoDPxVkJ9oAQjYt9U
	F7JWcdkfG2RCA2D30dsmFJixGuuIkQBJv7ubARiLEFlxg0TYsAE6C/JV4wBT8O2UoUaiiwBXGu4BV
	GXJZJZeMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lToUA-002zzV-Ew; Tue, 06 Apr 2021 16:23:26 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lToTx-002zyH-Tt
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 16:23:16 +0000
Received: by mail-pj1-x1035.google.com with SMTP id nh5so5988132pjb.5
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1UggVNT2YVYuCLqyv2wULpEXMgP8ksekyVi6c3LAsSo=;
 b=biGwQQgT6I5EkvoSEHQB91YY8VEyugVKLxATbWaBB1gHWpjlQetzcEoIrWMDuPF0RX
 cFncNnp1YsqCESQXdj5keYSS99PxDP0Jv9ZrzSEKM8d0OWJuFlSd4qf+VngloS3Ivob/
 HHb4X0qs9RNTxjcanPfRvYuyzXnGkCspXAvJyr9ZCpAdJsJ1JN2tgugWCpro340iW3Nu
 rHVScf/P31pre3LtlkVAHKSy9MnpEIjdvuLW/JQGcih+FV5hTfn20PmuZBPcsWrUPpg6
 BMHbMf+dJMHMVzyWhywanl0Eme0czrcq2qaYy8//8la2pnehEV/qzEZYhglE2vrGxdzD
 yP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1UggVNT2YVYuCLqyv2wULpEXMgP8ksekyVi6c3LAsSo=;
 b=cN89e7GR/JusMPO8VZJ9Xs/VH5KBzGKc5gwnz+ozFqtJMd5eR4ErFFrDeDt2EioFDl
 slVp/LTFCyBX+PEfrs6NP6YhHXX5Pbr//vJQA5G21kyKlfOE/xFAcR7xsGv/uD9GOOww
 G8ziXi+ZA7STWtb+GqhcuPdyTFM63RyyRISELAKjSywC+64hNVSRfHboUQIbECJbIYnQ
 UZchZUMRzcjktiTCOmJLZVW/KWZTwlNndi2dAQRtbYL2iXd8yc1INDCcqMbnrMao8q7I
 8166CmbH0lU5Vh7cII2RgfTUe6YtTgdDNEpHK3lgwtsoKSXT8FF3mZn7HYwrfkYGS+pz
 UOqw==
X-Gm-Message-State: AOAM530SOp6vy1+Rx6RPo4sX0lTcFYVn5yFoytccYLUubAW/SVpmuCIJ
 vhoniYDnxfaXHTXpWOWgeTw=
X-Google-Smtp-Source: ABdhPJwnXXsJi2u9HTpy1/L6e6HCFtd58gj6fSiTCMP0+v0DB8n+zg3mlWaNNC+MvV+zmBYMzni0iA==
X-Received: by 2002:a17:902:968d:b029:e6:faf5:8d0f with SMTP id
 n13-20020a170902968db02900e6faf58d0fmr29403525plp.71.1617726192220; 
 Tue, 06 Apr 2021 09:23:12 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id d2sm2923141pju.5.2021.04.06.09.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 09:23:11 -0700 (PDT)
Date: Wed, 7 Apr 2021 01:23:09 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210406162309.GA165675@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406145948.GB7790@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_172314_075096_E2699F53 
X-CRM114-Status: GOOD (  25.46  )
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

On 21-04-06 16:59:48, Christoph Hellwig wrote:
> On Tue, Apr 06, 2021 at 10:35:33PM +0900, Minwoo Im wrote:
> > > with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.
> > > 
> > > I think that there is value in reducing the confusion for regular users.
> > 
> > Agreed on this point.  We might have thousands of namespaces and it
> > might be making confusions to users.
> 
> How does this create a confusion that it doesn't for the existing NVMe
> block devices and the SCSI disk and generic devices?

Okay.  As there's sg device for SCSI, nvme-generic makes sense not to be
confusions.

> Morover: why would anyone want to expose these huge numbers of
> namespaces to a single host?  While larger LUN counts in SCSI are
> sometimes needed for scalability reasons they aren't in NVMe.  I haven't
> actually seen 4 digit namespace counts in NVMe except in synthetic
> test setups yet.

Sorry for talking about what I have not really seen ever.  Thought about
this one in case that might be. :-)

> > > 2) Only create the new per-ns char dev for namespaces that were rejected.
> > 
> > I prefer this one which is the major reason of this patch series being
> > posted.
> 
> Which doesn't allow us to write portable programs just using the
> char node, as now a kernel upgrade that supports a new namespace type
> or feature will remove the char dev.  It also is very different from
> what people expect from their SCSI and ATA setups.

Got your point.

Thanks for your feedback on this!

And here's another questions for your opinions.

In this new series, we have created nvme generic chardev along with the
block device(e.g., nvme0n1) which is not path-specific (e..g,
nvme0c0n1) in case of multipath.  I think now we can say that it
supports multi-path.  What do you say about this :) ?

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

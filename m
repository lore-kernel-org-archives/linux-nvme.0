Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA679C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 04:33:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63BA61417
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 04:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63BA61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qvsDTnzKCFkEgV2vjRr7dy5kZwVJJsv427gWqUVSk/w=; b=er+gkFbgHJKdplhpRCRZaNhHf
	dQ5BaNeQKvCW2e3C2RhA/86NhngHMFTMm6v33ywBmQQJ9J0efirAs8fYw0k1PCGiDR82Rd2BTOT4a
	wCaVsaJnE3pw0FKgJlXWADNCeqF70QxRFTYnCIxgjX71W7IJ3Ip/yi6pgMNaBUchZzZT5WCxXVB1F
	TVGVPmw6Yl/YRzMXZwcztrjDRCyhpZehPhj8GkISUQErUT90HpHgjDu2KS7gLtQsAxmJKZmXKE8wd
	ympJR1NXBQHcd89YBhQnQazfGx3x+ZkFkUVUcGpBBqXYix53UrXz2vrBBYN80G7mKPA/c49oQ1/f+
	FVN2MKEvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZR1v-00FqV2-O2; Thu, 22 Apr 2021 04:33:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZR1r-00FqU4-1E
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 04:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NlR/GC12Ant3qA/m2EG7aiXOZv1rWEA2puHWoOlThvk=; b=Yuwkd3u6YTCWrmywb4PgK9Ayu4
 /Pk4VSrpomf2FN9b6Cko4y+DWkBnPZ+OkQK/OkJi47HGnsKASsVL8odIkNgQPA5OLw12cu3OXK1QJ
 2bwK/DwE/l8GaNRfJulNSotmCaMb1+ryFRM7uBEfy8oI6kvHGs+0is0L981juHQMCeqwUBzkMtDyg
 nj5yhVKsgMgnpOXqPO+dQwUf2QpRd+40v65BQgvz8praCt2CcB2Un5MIM423BWewJliFxiGCkeZvN
 Mpz+DOzgbKJVan39JSz73Q8uAbdKPk6xjXB0xmxqozUVVDNKu8euMelhpGLryY1gRhhSVd7ONbuvI
 5ECVtZGg==;
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZR1o-00DMfh-JK
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 04:33:25 +0000
Received: by mail-wm1-x32e.google.com with SMTP id
 f195-20020a1c1fcc0000b029012eb88126d7so2349909wmf.3
 for <linux-nvme@lists.infradead.org>; Wed, 21 Apr 2021 21:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NlR/GC12Ant3qA/m2EG7aiXOZv1rWEA2puHWoOlThvk=;
 b=AcOyQ13RQZOaL8pki3f0jF0uXahdxZVsZy/3WLELJUgS9r4/HX8ymH7eZ/I11yQ4vS
 RFczBvTu6XSOIOKxSXqf2uugUps2ZK3JGmL0hJMNIj8FqdCQAaRulqo6QeV5KXRt9abF
 iWrhNIu2339/g+wGHv+EHjb4d9cROuZGjXjXMjMEW5o2rCKJeS64Dgd7kP+EO/s9PxsY
 CumvsQdLm79eEZapy5wUsKioO2pROEmg1hDWkbvlcgiL1TWo/CsoJNpPBjA6d8g4ICSD
 iOFc6HQbKvTjUQoJPQ24L6yNshNiGwzG8wqGBJDOPqVrAhJvRq8H+YyrzzWc4DXyzH84
 tINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NlR/GC12Ant3qA/m2EG7aiXOZv1rWEA2puHWoOlThvk=;
 b=tpZlY6ywIhJdrehDn66QS/ZHA6Y/zI2J7Y4sDAk/n5ULtMszYv/YPms/GAAOwP2Hh1
 zQTDbYnfXFvVh6AvR/Z/AblQoPGR7FjXSbC9XufjgeOKQtPTAxwT9iHJl4MBceUHCUbi
 naFLvhEORyLnuTn1C9Oya/CYTNtNxvtVouR9fPgyvNPBX5Et6Jc0Fh+0q6r8av3uAQgw
 5Aa7djWNrCEcIdKk34ownBqAi4rh5lbFdeK7jEuAao+d7E17ZIGGc7sHP7cRz/NKY8dl
 ngHS6UY/3bbBNXK5aIvwe9sNdLGmgwqNz9jgYaMK8ouo/rUTa+ZLQYg1YAuZd9+P56DY
 vcTw==
X-Gm-Message-State: AOAM533nwGrGNPXKSt0Up+hWC/hlhsjH/d1u/ZwCyzUZmoacffSgHEUF
 zi/VICJQkPg/EZKRjx4OscfGMKORSlciK1/buAQ=
X-Google-Smtp-Source: ABdhPJxlFZlMH4/RwDxHGn0TmaGDscWKIkmM65u0I7O18VbZyKglpI3N2Dmu8109b6xquQZlsL/c7UbTpYvUmriIzLU=
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr12939653wmi.138.1619066002313; 
 Wed, 21 Apr 2021 21:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421074504.57750-1-minwoo.im.dev@gmail.com>
 <20210421074504.57750-2-minwoo.im.dev@gmail.com>
In-Reply-To: <20210421074504.57750-2-minwoo.im.dev@gmail.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 22 Apr 2021 10:02:55 +0530
Message-ID: <CA+1E3rKyFtdrvuRDDOhNmsWKxUE1F1cguek=2p0mgi8vTMGOVQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] nvme: introduce generic per-namespace chardev
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_213324_680491_8A48D2E3 
X-CRM114-Status: GOOD (  14.55  )
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

On Wed, Apr 21, 2021 at 1:23 PM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
>
> Userspace has not been allowed to I/O to device that's failed to
> be initialized.  This patch introduces generic per-namespace character
> device to allow userspace to I/O regardless the block device is there or
> not.
>
> The chardev naming convention will similar to the existing blkdev naming,
> using a ng prefix instead of nvme, i.e.
>
>         - /dev/ngXnY
>
> It also supports multipath which means it will not expose chardev for the
> hidden namespace blkdevs (e.g., nvmeXcYnZ).  If /dev/ngXnY is created for
> a ns_head, then I/O request will be routed to a specific controller
> selected by the iopolicy of the subsystem.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>

-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

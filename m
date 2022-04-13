Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F64C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CP/ShUgEz3hGfuLXYLYOHJuLvNzIwOaBQUi6eoZGsQ4=; b=ORmIk8evLh3puaiynLDfBIunso
	geOKomp3UcAGEM9iGjgIl3XtfzN7PYzPJy6IzlSL9SFVPK97SGiNAcaDNByyiCsKKSKCddPcnsG4O
	9VQs/t+X3B5ZWa9Vd3NKNynUXjiq5X6zUNFW//vx0rHATU2qFPFMSYJ7nEds+cwLbSO6VXaBqIhFu
	li934xU3ZTrYKC1G/sOSHf2pQrDFgUJIXmnvzNPuNpcj6SWa8OfCi22I4Nrv8umfvbnb2KXL15TUo
	tpDx76gBMxYQR8GQoiMUmLpqvIWTBdPCDX4qGrIPh3im8zP+8KeegEbiyAYtbe7H7SQgmWu+gbEXe
	l2L/IlsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neezl-001bqo-RR; Wed, 13 Apr 2022 15:33:25 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neezj-001bp0-9c
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 15:33:24 +0000
Received: by mail-qt1-x82d.google.com with SMTP id bb38so1627912qtb.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Apr 2022 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CP/ShUgEz3hGfuLXYLYOHJuLvNzIwOaBQUi6eoZGsQ4=;
 b=UfPSrLeJ1wX9rxwivW7q8Xj1gWZnLNdObN1ay9AplmU1pV+fJ/B6aoxD/Avz3mCD05
 +iirVS6RJxrl+ViKFG62p9/VXgIWBs8by//lIsZvkCkGAIMgjnovJ5axTwjAzsMb56vG
 n2nQJVwWhkp6TC3j01ARtLrWbVcSJ8b3DxXmRvRhynyH4tgLbfR4mUazXz82jRpFBjnd
 ygFDbVKe3lVFp572WAb1v+hZXAE4yGtlMZ+SXT3OWcM5r3BKGpm+iwcQIsrev26l6YDR
 JG7blW36u7aOhU4FPi2Wbqd5RqJRQPwEY5o5Yq2KKMWFpp1wHvsQ7ONUjwweQkfuTw5D
 esqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CP/ShUgEz3hGfuLXYLYOHJuLvNzIwOaBQUi6eoZGsQ4=;
 b=OFUK0HxsTWDjIrxCATrYLKqjw2PI5ygXRd9TQ4ADg4ja1vxpeo+NWzxl1VrnDIl43A
 LE2JdevLjixO4dZoREbKMCFu6qF0ARBNucb9wUHmmT9PZNQFgYSe0U4I44KsfTZThBdG
 PyFLqxCfrSj890wp2NiOV45P6VJdNO9IZwFf06bnZ9lmX9py3i1SrwLJMFqyzgn5t8YW
 yK+tuJf1Yt6/PFBCwXkG3FvCeholH/FBtGhuT6YhobhOhbjNNO9mXOQO5jlMHd4pXWy3
 2iNZciomKfC4IKvN9bxVm97An+u9+ve0B60ZZz5wurNPMls2/QgV+NZs9onyG0eaXwk0
 /f6g==
X-Gm-Message-State: AOAM531q59AE2GEGyPB5CDevASYzxvdHTV79tXKyWgmaFaSobd8jhtuI
 oILvKPRGAKbue11DiyT2yj+dIQ==
X-Google-Smtp-Source: ABdhPJyFbysCc5+lrVtBTWljqavmdMjrO2deJmL18DhfybMCpNTalRiikBHMLQ9d05crlDN+tFCHfQ==
X-Received: by 2002:ac8:5f46:0:b0:2e1:da61:9734 with SMTP id
 y6-20020ac85f46000000b002e1da619734mr7724566qta.205.1649863997638; 
 Wed, 13 Apr 2022 08:33:17 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c091:480::1:5987])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a05622a029300b002e1a763dac1sm29000360qtw.9.2022.04.13.08.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 08:33:17 -0700 (PDT)
Date: Wed, 13 Apr 2022 08:33:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Message-ID: <YlbtNrIZ4pEgNPeY@relinquished.localdomain>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_083323_591002_852E18AA 
X-CRM114-Status: GOOD (  11.74  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 31, 2022 at 02:45:26PM -0700, Alan Adamson wrote:
> No matter what was passed in with nvme_trtype, the target was being
> set up with trtype as "loop".  This caused several passthru tests
> to fail when testing tcp or rdma.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>  tests/nvme/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


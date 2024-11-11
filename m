Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C19AD2E9D5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiKwMDavE0Kq8c9ykbojMaa6POsVYsPkZQQqGOgNLKw=; b=SZYsbjPHSPAeJ5Bo37H+1aS2dW
	GzeD52AdiLXhAtfw5KADt8/wWxM2gbSlWFFojoN38dni92eXgiaM5NQPBdbuVfFKefLuRkCHsPdQl
	h9B3vZd2L+um1WnlyWOZfzX7fnMObI3OxoPx08XgbdJbNF4kT9CpaU54AowjpahYA1MlraZ+8qft9
	JkdVWLiWLVTWs0MNtg5/KHeUuD8hMKtfK2FbkRrcBJ+on5uymfUn1H+UijRaQ66Si74eWlmVqOOL1
	N5/W9B2QdKk4Og0CEhmDLdxkosl9GRWmRZ/tchcusJmCJZ7Jx7g2BCt0QtuoVjAnJJP/Go59Z/Ath
	vEAEesWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARyk-0000000HM1n-0pzJ;
	Mon, 11 Nov 2024 10:49:06 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARyh-0000000HM1P-0dXJ
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:49:04 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so5714724a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731322141; x=1731926941; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiKwMDavE0Kq8c9ykbojMaa6POsVYsPkZQQqGOgNLKw=;
        b=tt3XwZdA1CuIz/WwxSXaMYPVYUjGuJJJsuVAktIst7PQ6CnwL2uI1lmAjYlHxZ4foE
         MqbxmfGz7rRKtKYnhRpJP/7VDTyHuJ5LZi+Asq6Q4LVEmoTiuSCzLhJbZenX3RHnSQOy
         Ij8lX23X+1kLOup9bFerKTT1IsRU7EtSNHcuUVeJLm8z/KkTJBACwp2A2MOv/vVj2tfr
         sU+RUbrThT2nphAQD+CffIBXcS4/J7PDjK3rEBKZOo0RzlVu5FPWxtConwzdMdM+p8Mj
         FmzS3lAcOBnQo/+BwrGrUDJ80IWmrpEw3fwZK74AJ/SGqZWTqmrylkl72DORiFVCw8uJ
         X3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322141; x=1731926941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiKwMDavE0Kq8c9ykbojMaa6POsVYsPkZQQqGOgNLKw=;
        b=n2lVFbfMviu95IYL94Tx9ZAskD6gToOVTlNALcX2q9f49/oyMmCgqPL8EFs31ndfN2
         3sslUu5/TT1Mga0T5/+YwKPlbzihdsXlykfOzfjYsch52SRMFuvzIbVuilB3ZSzHxn9c
         Ns/CpY+jKTl/xtYw/Bt3N4PKNSaSubExr2SA1Zl1WADz472S/yB843LQrI4jSx3qt6rB
         Ypi3A1RZeOCfVQVXZrnQPcA1+lRWMRJjjjqzKsBoPuAiY4V7wzK8izuc0OPFRzbeqAHV
         FRjAETgi3JODujgZioRVAo5/dongMUZvcZQ/xqKPZVPgmrzZ6KwgItjUE67V9LRpVx/D
         ItXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxkiHz30u6UMbTMW6uB8GFPyL9Jbeaof+hcsN8Rtyw3DNz+pP68jLSC/fHXO327g2e2LUPsrZ9X+jz@lists.infradead.org
X-Gm-Message-State: AOJu0YyknIyreMrFnpqvSe91K+rdS1W9aTJ9w8IfZvuShEn/aBY2qYgS
	o40YBXOViP3zUod1JSW5Yw1HJoTckOSBgWdcocKD4qcyYoWs7G54lawmBw5cq90=
X-Google-Smtp-Source: AGHT+IGKAUF9p1z1VW/AC38KwD61jBHbbtopi+iHnRoH4aSUgaxyItp9800qusnbCJWRILFlGW0mbg==
X-Received: by 2002:a17:906:730d:b0:a9a:a5a:1d47 with SMTP id a640c23a62f3a-a9eefeb27a3mr1192531766b.2.1731322141215;
        Mon, 11 Nov 2024 02:49:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17651sm578830266b.38.2024.11.11.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:49:00 -0800 (PST)
Date: Mon, 11 Nov 2024 13:48:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] nvmet: fix the error of point math issue
Message-ID: <f4ce4ae4-fb33-467b-937c-444a46eb6f02@stanley.mountain>
References: <20241111104035.31770-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111104035.31770-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_024903_224464_59D2B657 
X-CRM114-Status: GOOD (  11.94  )
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

On Mon, Nov 11, 2024 at 06:40:35PM +0800, Guixin Liu wrote:
> Fix the wrong place of parenthesis of ctrl_eds and data point in
> nvmet_execute_pr_report(), switch to "void *" first and then do
> the addtion.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

This needs a Fixes tag so that the stable tools know not to apply it to old
kernels.

regards,
dan carpenter



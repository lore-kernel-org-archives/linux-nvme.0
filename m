Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C3FC10F04
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dVg37Ua/Fw8B4HenbavCwGuNNfMvZwQLsawmvgiFEY=; b=ksjdlu1Gzwwo6qgeSi/wZsK+Ua
	naLZJ9Dhb6A+AcNzTL9DXrEZo2NXdRWBZWBJk6IAuK3rAKnx+9udE4Mx2A++K5b+LTXlHyxFkIcnA
	YBqFqpoC52kTI+L2H949rYlRkfSmWYkmVFQYSWjxhu4vJuN50XyGM7AMyVKrNeeKWb8c7qR7mW/8s
	uA1zWWpPkixjj6HfRhTTXbk19tL1ZmshctBzfTfkxqQ8O9yjpj5kTLE2I+GlzsrHHBrfEp27sV+cy
	kwG5gPEupNMHXenL/7E5ImFalt9lYlOtD6h1x3otkEeaIrp0b1oa2jbMcyzBYagPvLogZUq1GsdsA
	BZACYKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8p5o-00C0ho-0y;
	Thu, 30 Nov 2023 22:01:08 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8p5k-00C0gO-2X
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 22:01:06 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2855b3d9a9bso1233843a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381658; x=1701986458; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dVg37Ua/Fw8B4HenbavCwGuNNfMvZwQLsawmvgiFEY=;
        b=oNLojjuo8T8I8xT+PESGfAWQjRe8NNnuMd5Hi1harRChH/fF2Rz5AY5J/mzxNRLBY1
         aaw3wy96WIHkGD/pzYcmOFh20THr5lVT79zi3KNQv5J5q/6WZYTXYSdzgP9jhoNpMWk8
         pbR5M9Yf8nlFCxHckuWfNSdzgsNE0HYkkb1W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381658; x=1701986458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dVg37Ua/Fw8B4HenbavCwGuNNfMvZwQLsawmvgiFEY=;
        b=ZPRKap3CjpP6CM8Mosf5XzvhDcZcm+GOSGKvQK5JPg8oAx89qphOf4TDfagxDu9Pos
         hA+j9+vOTDKxpEoWdLYqUhXf0IPny8xSpUNIcMMy+FnO79EhtGbNxb65Lf/MUAMmZLXT
         NoYnfIlocjtOuGB+lkPN+o4klCxQO3xYDqiCETwgBAiT+MNBFYyeYgjxoryVw54Qr27N
         ZZrwoP/125BlK7JU6KceZDCyVnhwUwePe1e0wvJTQwQdH0YdF25JE6+OWeEWI/WhF9c3
         OhnGCUr7JHe6IqFiRamtvLgRXDFkDC1o4ufONoB1OfZBWbbmIkV4lpmXpFvjzUR5T+jE
         nzzA==
X-Gm-Message-State: AOJu0YyUjABswKI5fLmdTaIBev2N8sEbfgMkM93gDqvEPnCXxfXmV9BH
	vWEb+DJjNOUO5QUV0djI7sq2bA==
X-Google-Smtp-Source: AGHT+IFVQzyt3ZEAJi0Q3FYVK8pWYeRrbWgsx+Kjpk955Jz4SeetOEmMkauMSk0Wlc5GDWJ/xhk5wA==
X-Received: by 2002:a17:90a:717:b0:280:2840:80bd with SMTP id l23-20020a17090a071700b00280284080bdmr20463973pjl.49.1701381658572;
        Thu, 30 Nov 2023 14:00:58 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qe16-20020a17090b4f9000b002864ab4dfffsm895373pjb.11.2023.11.30.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:58 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:00:54 -0800
Message-Id: <170138165207.3649333.12518532307083460238.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_140105_376695_EA60E869 
X-CRM114-Status: GOOD (  10.74  )
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

On Wed, 18 Oct 2023 22:48:49 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
> based on their usage with format specifier ("%s"):
> fabrics.c:
> 322: dev_err(ctrl->device,
> 323:   "%s, subsysnqn \"%s\"\n",
> 324:   inv_data, data->subsysnqn);
> ...
> 349: dev_err(ctrl->device,
> 350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
> 351: 	 data->subsysnqn, data->hostnqn);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvme-fabrics: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/5ef935fd5520

Take care,

-- 
Kees Cook



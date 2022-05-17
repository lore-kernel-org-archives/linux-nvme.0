Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysJF4XM43y/fSy8sU+xRfX8p6G59gQY61NVV4iA9+hU=; b=q1XjpQZEWqShFaLHdRW2u2B4DL
	cdvRmjQTsklGJcNaT8FLWcRyPZgoP9GyO4mfaP/c3CF+liVtaj5wjx4zz3kK7bszMBSpBI3+Gn3jk
	X/vviaLujHIii/ywkytf7U2pRai5XevTDAYDPJJ4JdmmI4cYREOMBAzIhaHyYZcL9664cJVtiPg+F
	WZ40ENRt4wLXYQGC34xjxIODPCzGNmDJS7P4IKRfqZ4g9rrjHeGHCTCwVGJZcb1TnbY6yRB5hyDt2
	dj0Sqnd+2BMw+3m5Yymew/mm7LlK8XhexgGx2r6VExmwjnpaKaYv8Uv0IXpHMAFnFmKrHRZBg3vS2
	D2tCQeTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr6uh-00GIEY-5E; Tue, 17 May 2022 23:47:39 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr6uf-00GIDS-5s
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 23:47:38 +0000
Received: by mail-pj1-x1030.google.com with SMTP id ev18so339618pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ysJF4XM43y/fSy8sU+xRfX8p6G59gQY61NVV4iA9+hU=;
 b=J+IvTmSTGYb9oKhTFmuSHbmJI3fA1UkjQGFnRIAi7lkIgccNLk+F4B20Sf+RrKbijf
 Os4ZhCKGywUxIcncZgWlocJg7+O/0Q57pvAymnkZSd1zswwAmBrbyGuwnFpJRsZVO1Mp
 yWn24T5hFvm+ES+sHjexWqfN4DH+zF188o3lS2kWm2yRsB21z2WFt+A/bmp+dQWpsZVZ
 ofaE38DWc6T4pf1W1ECW0DGhCzD0HOvW5zhk5fsFK/gqdfQ5gastwEyqaIT8g8mqfitL
 tsQVViUzvEreVPLVYZfqiMe8qIMM/egoc4Xjmu5fECcJsHPmedxq8ZzdDFbHL7eafiqS
 e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ysJF4XM43y/fSy8sU+xRfX8p6G59gQY61NVV4iA9+hU=;
 b=yT9qYuXjt941E5msVKV+GM8C5e+i5naQgXHAorN4AaD9NuvZHjheGd91gSe8X6m/56
 P7roUAmAh0oPd5WyHQ1WNL7Q4ZZQNKT1DgMEnbdumMMNcICWYi6UuTUtevzW0CRXLtsr
 XjMOFAAkr3/Jk7QrcgHTPDZJ1GgMjIwlmwtfItJeABM/lBkvelkzRXJkYmJY2+SXiKo7
 94K3bULr5ERDiWuHtL15cKUxVLS+KEsB3a4wTJGerXoUNXlQMCVcdWlm1/7q9XUOTFxu
 0g+zeMILcdWtLI8gP8/N8bPQYLcvSBFm3lGTxndt0VI2A0PhrFqV0qOLzFeffnf7e1aa
 Wz0w==
X-Gm-Message-State: AOAM532tHQ1dHgL6fv9QR4hOU7dOJk6QC+t8yS/dBY8cvRefVmLMhEaE
 QWHEkWN8lFks8EcRa/+4Hrykwg==
X-Google-Smtp-Source: ABdhPJxIFKvrloDcf7qqHK4BK4ip+opxD5ldCHH2eEfZjbDmlDnRzuf3LRF3xen18akrgPg1UnAslg==
X-Received: by 2002:a17:90b:4a07:b0:1df:7c10:7d3e with SMTP id
 kk7-20020a17090b4a0700b001df7c107d3emr7780600pjb.109.1652831253175; 
 Tue, 17 May 2022 16:47:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::e2ec])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a17090b018600b001cd4989ff42sm171449pjs.9.2022.05.17.16.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 16:47:32 -0700 (PDT)
Date: Tue, 17 May 2022 16:47:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: Re: blktests v4 tests/nvme: add tests for error logging
Message-ID: <YoQ0E8s6gFczuppP@relinquished.localdomain>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516225539.81588-1-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_164737_245311_BC09F440 
X-CRM114-Status: GOOD (  13.23  )
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

On Mon, May 16, 2022 at 03:55:37PM -0700, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
> run with or without NVME_VERBOSE_ERRORS configured.
> 
> These test verify the functionality delivered by the follow:
>         commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> 
> V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
> V3 - Add error injector helper functions to nvme/rc
> V4 - Comments from shinichiro.kawasaki@wdc.com 
> 
> Alan Adamson (2):
>   tests/nvme: add helper routine to use error injector
>   tests/nvme: add tests for error logging
> 
>  tests/nvme/039     | 153 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/039.out |   7 +++
>  tests/nvme/rc      |  44 +++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100755 tests/nvme/039
>  create mode 100644 tests/nvme/039.out

Thanks, applied.


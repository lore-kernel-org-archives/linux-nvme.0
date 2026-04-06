Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E13EF4EC2
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=; b=KbRob9xmnapcrMlBX8YmlxwRH8
	4GMkO35/WCwS7YL9JO1LeB3UTlckKGPCFp6jtRkDq7XdGX2O0/a2EYvKk1LzAVddGBB6ljvvQc3st
	dbymsjIj77s+IHndPYikqgcW0o2dNVtWKrrX18sgx23vTKcFYacOqXc8H8ZND3VuICChgCUv/M0YF
	FZjstuib/BoMZKVA0IYrWNFZFGaIsLAkin6crQ8M0/o9V3vLgWpd6iOOiMdDVnVC5UdBLgpnZs7C0
	SJ2HkENR7Ac1mvT/3x/u6bO36FPs+4eESAkoobWmstyLJOPLdHfcU+2PvSRjlOZpqG8Tp2bseLFdb
	tyM1HSWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9g3I-00000004x5r-1NnH;
	Mon, 06 Apr 2026 09:15:24 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9g3F-00000004x5E-0pdj
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 09:15:22 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-50d864c23bdso548001cf.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2026 02:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775466919; cv=none;
        d=google.com; s=arc-20240605;
        b=fBEcUiWtkgDzP5vGV2fzyf6pjSH3nz3Ve0uh0S0tA9Av5UdIBHa/fE1FiK7sQODlBd
         JOunGoVglKFAtYwA3JrC41AfFqRlG1BoWiwQQaS9T7VIOaABNj7Lg1l7ihxFqbiKD+b/
         f7w8gSHg+tD7gSwX++I8Kk2i4huf0P1ABH70nNWtofOrHESF1EGinjTYcyigAJxQIfI7
         sPVIyMrXoGAPUdjic6mySS6cECEycncE9H8xeoIADH3Qth6VGrYMKj+sNXYQkGcU2/yT
         ap2SYJ5ygh2LWBTlisjDYmtndRG3hrhr8p3c8NpFT5YrUoiGRzSeYnu+FDYBTUVdRWlH
         YH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        fh=lIrReXBuMMSQ8DislkYgdZdVMxpc66zN8hNBSQjQld8=;
        b=M3k5wHxjva4LAGP2tXAEKvLzJgctQ72rQlopoo0P30V28QK3C/a1K+SQ74bwdXYWvu
         9z3l433DMvVFE1lJVa29ZfzcTL/CXEY6tXZH/VEmiMCqcJl4ahd0NQeQgUdRycPygG1C
         xbYxTVA8Nyl7AoUcUoRgRaRQPpAk61nczDFzyQr22aoOSEP86W1/qMTPRfW6RTHx9Cfn
         cikP/W0m0U9SiTMOU7peeY3SwJiGykZ93AWbjRwqPSKnZEOhbRBnteY4zZE616u+6OIK
         3QndBsz00ZyCNJvp32ajGs61lr96hbb9qmyhI75E421SEgr5XDCi9eYTXKa+lrXVvcX0
         OcoA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775466919; x=1776071719; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        b=exyjN4LrAlOtfY6p/iKfw4gbmCcZi8yvD2MmWSBHUFSr00k5VV3NSEidWWHLqdxFEN
         IquYWl6B1X05Xdt8GQb5x1A7CTV/vc6cClhVo7LsYxNSA2Ss6Bp363CXEmG3HVSye61l
         MiCTDAEFpCVUVaAT3TRjEdBnyVMc7BI7oncWRxLXczWfBM6vl7vcWi+tX05JLVeAXLwe
         yfrJe+PGME9oDdP24Z07LiHUZ7j7r/g9xguMTriHxpZQJ9DX7ZXq8l598S6u/Pppx4AO
         kWh9AAEipZGN5ZpRiBwaBLtdU+NZvmogILXt5+B+oQghNd7xJpUAFrly7mZhnhtk8dRS
         Mkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466919; x=1776071719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        b=qrAlcM0OtLblJ3wwveFozqzUujXCDs1d/pM7QGLkwObzY+Ild85UDfECJ83979Xu8d
         wL6F3/gC+CjCWdtFOdlaXTJhN3gCP0EyzAOIxy9hpUi7onIwntKJaK57CUieGLfuy4y3
         KBL4w5YOo9grtYrIv5lVzBL8J8+R993EBat/hMe1Tf0G5Xw+OG8XR6VM+9lHzeYuCaK1
         u9ywll+9rbRPp3WjKKIxTFh76S+79fSvf/8smbnGn9CeXuB6crg+DuLtEkhGompVvWBq
         /CG8a2VzB0btIN1rdY+ewcjQU1LS453ssAAGVH74PNkNjzdNDQwSciGhnzQqZwqp6uSO
         yDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXeeeGSGSFC92okBMY7cGhqVuwamNmDHbrgORxu/OlkhXu4REVlzepsUQPoKexiWb8jn0VA8iAWUAH0@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9Fe8PA1AVIdhKIk19Pr1lCG2YVZvc2uXUYJAK3hqxeg41t8SJ
	bvltXsUlmU32Vqqk7Kq+KNIfodMnILb8AU1dS3hwOrbRl4lgHjFttM9MEK+lMIhhoa/O7uJTPMV
	kkCrPE6XK79Q0TtJJlv6akNAbFQi0bxA2S4H2nwdD
X-Gm-Gg: AeBDietQO27mmzIe0RjmwyDKnzHe3R1KMdYFZf5tC25RIigI03iub1suABcoy0lvs8x
	uU9nt4wH/0AuDKNHDZvLUt71EwZ8S3wfWtJR4TWIJ6SUnQ2MirwgUTVYid2oFBXBAVY3weVqEFf
	1pxp0mD+rS+UoKOfx54UzU3AMVvzTmt7V/A5BrPKMiVwDm6Mf5xIIyMYV1cwQjNNr5T0atdyjbQ
	y+EW33VqqeiMSdH6J6Vyufb9F5UNEF7cTBPgeR1kdtL1V1ciJON6yzHUoqwH0aLxETP/YRVY5lK
	yt/qY4H8D6+R1i34rGo6NdR0xrndtyLjB+B/0g==
X-Received: by 2002:a05:622a:244e:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50d63fa63b3mr36921051cf.10.1775466918615; Mon, 06 Apr 2026
 02:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260402073001.2039625-1-shivajikant@google.com> <azabfvzjn4juc77xdq6qhszd6py6hkb35jgi2xymplpnkj5ra4@vpjpaoeenvlu>
In-Reply-To: <azabfvzjn4juc77xdq6qhszd6py6hkb35jgi2xymplpnkj5ra4@vpjpaoeenvlu>
From: Shivaji Kant <shivajikant@google.com>
Date: Mon, 6 Apr 2026 14:45:07 +0530
X-Gm-Features: AQROBzCBoFtSiCOZ2D6lpeeNP-4-fqlKvW0e9IW54BqrMes9KgUGxPB7EiJOF20
Message-ID: <CAMEhMpnjmbT1YWDstZfWnxOTU8nwreUziYcz6whsxv1TK7KuTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>, kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_021521_356132_A481B8E4 
X-CRM114-Status: UNSURE (   7.35  )
X-CRM114-Notice: Please train this message.
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

Thanks for reviewing.

On Sun, Apr 5, 2026 at 9:59=E2=80=AFPM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>


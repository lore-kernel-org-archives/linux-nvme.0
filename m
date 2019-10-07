Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F0ECE58C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84372206C0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UObIx3I4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slYR0rzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84372206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XS4fLmChLNkGgWLEBwAhhRJpnFzK2RPGIbvSw1sCTEQ=; b=UObIx3I4ABF0oO
	yKquI/uM4lMSJ5oSipdkrruFIU1MruUkTb0mi7+HxnrEc28hYfeezvEvUh2YuX1+b54orrj1kLC44
	9AqZsJSd0666vnUt1mGMB8cZAb+JUoF08vjfToLUJyke+klQqi7NOfy1RCqEIpgdzz0gXVs3UdBdA
	OuA4/1ke3yEDQU9SrHZe/X6m8wDcDBx/sID5PXgr1DuUZLylZ/V5FazQpm8p7+r/0nNovcAe4jd3P
	wE8WnzIrg8dFmes6rLZu0JT9R4OKngdPv1NKIrmx3uPDP9GYBwpM4cSIqYEN6/P5fzlsBHLYwWQYO
	SdrINkwWl/rysof3cqNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHYjH-0000n8-Rj; Mon, 07 Oct 2019 19:31:35 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHYjF-0000mO-Fi
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 19:31:34 +0000
Received: by mail-io1-xd41.google.com with SMTP id c6so31144977ioo.13
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LhHD43hXAM9SN5EwDRubtVNLyNcRs0uw6jKCE0kbPZA=;
 b=slYR0rzBVighy9wsS87KqHGB1Hi3N1cVtMo4uSO8Yr5GpjOTEsuuMPuVswDb87+5p1
 x9w4g7+DUtvUrUS8uY7tBIUXL1V4cMpaqa5/ITeb5mlN648Ik4k2HqBCyjCaW9gYGiMV
 nvIpUQATjZ1AYfm3fhK3vAXYRg1NggGTAhAPByQ+vbQOaycsA7f/+9F7fhoHcCrTG6Wo
 ZJFDnBzMBZc+7tOHkCTpeobQGMImAiZdtpzTSSUbBsOoVNzkwctkeF343sKr7DPnewRU
 5uaZS/k5IL6EFMK3moKZvHUALe+7pUupGEThYv3rafxSisuebOqbFTJcXiNJutojWi96
 pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LhHD43hXAM9SN5EwDRubtVNLyNcRs0uw6jKCE0kbPZA=;
 b=TXCBs+5Go1/uKxkltf+60LeFNOjHuLX1x4cm7e70VsE/8GoXwhmhRMdIc/L9rHHaNp
 6p2ZlbKHoa8QTgLNgSz2dlUk40hxPYLN3Vp0NlG+Uy0rlGx2o2/8RH43lkMgVVRaayoI
 nP9v7gQc7k9p4Rp5bDqg+um+2PsVnTiZm+itsT1RL8uSfhMR1XJ7PGQ9NTpx5hPpmHEj
 FA5buUpiWRdt7Hnn5qYEiQl+q1JdSkJ0PLz95PmGpdcLfff2tjYFMzvkaCI8ErsdR0N+
 vwHfF315su/b93xl5BmMy9vkRelyThrKyedF1fBoii5eMiw+QudfsCn3rDoboxB2PuYK
 sF8g==
X-Gm-Message-State: APjAAAVwt4CEaOQorsdgwv1+B9NVempIB+SXlhRUZBZ8Is3nKDWfM+bm
 UfVD+2Qmjut9lLvOyHpU/lqPuVz4SZOxmZ0SqlM=
X-Google-Smtp-Source: APXvYqzckjVc1ilft8G8VvPhGkDBvd534J+RWrtDg2sFhxeMdLxoUi/35pCNvQRY3B7t75p05RtnmurxyTtoRcWTdz0=
X-Received: by 2002:a6b:c8cf:: with SMTP id
 y198mr21700603iof.179.1570476692261; 
 Mon, 07 Oct 2019 12:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007154448.GA3818@C02WT3WMHTD6>
 <20191007175011.6753-1-tyaramer@gmail.com>
 <20191007182812.GB13149@C02WT3WMHTD6>
In-Reply-To: <20191007182812.GB13149@C02WT3WMHTD6>
From: Tyler Ramer <tyaramer@gmail.com>
Date: Mon, 7 Oct 2019 15:32:13 -0400
Message-ID: <CAKcoMVABYHMTPhHUyU_EvWFUxKPn4sqy-DSEM_vn=ctbkKD-UA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-pci: Shutdown when removing dead controller
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_123133_524823_EF2207FD 
X-CRM114-Status: UNSURE (   5.82  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,

Thanks for clarifying. I appreciate the comments.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D5AC49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782B320650
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNxUljz2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mKNgvD5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782B320650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RrcAIXWMy9JMJ7BVHV7BScs/ZnFKZllaQ3EWkFzlm1Q=; b=eNxUljz2C6J4Sd
	OVTze9quP37I7gHR3XsfvTvziTY40iX3c00mAyW5g97VBlNjzSnwI16+5ZWOlj+ggqHUmQU29Ic/Z
	aP7nfdvui4cZNnLYDDQVuWKNmBuxUIS5gfU5KiqpfN2P1jiIXDPhonjy78eqs/HtT0d7AMjxoqdOj
	YOEf6qDmblsB/zTtBwXcm+c6qg7P+5qKikAR/SMzjfIEyWbs63MMIZvcbdHdDNJ+jCpcfgJrdplVT
	w6sUlEbTlDES+o0ZjCdBFsaIVUTkSupbzmFKHawWs0bffjPVeTpJWl770f3fdKuaOfF50HghEaq07
	ht+zEl9JudhJO30ZtcJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9sRR-0006DJ-Re; Mon, 16 Sep 2019 14:57:25 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9sRO-0006CY-Ne
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 14:57:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id w10so147947pgj.7
 for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2019 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7WUNnN9yv61rt6RXUBjyfgyIhNh7aVIJr3pGT7+CnMg=;
 b=mKNgvD5so4AGdkx4mkBeWTYa3r8Fm5dmfCEXgKPu7EOkmrzxT7SeJixToGX/PDai4z
 PouMD+FWY+yLUMyOnetznsuFLfVrdDOHmf7OnhLqz+RCOE8ocHaVL1wk9omdhs9qr7Po
 vTaFA6I6q/F1r1UCPaXjijc0UxP1SDYt9G7vxE1QWGns0SHQYmPCjyJusHH8/UdoI7JK
 daPATNGa6VHYDv7y2HbTRIjiFtmfeezD8xkQjAAT5Q5ZuQs99DgswY33ufxkh9Dc3Sn8
 6e0wkKeYk+/j9ilKR5lmDxSC3zqXWP8LUPWmxqKMnb6XzYAUKz6XfQGSojk9MnLAFVc2
 DbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WUNnN9yv61rt6RXUBjyfgyIhNh7aVIJr3pGT7+CnMg=;
 b=TRGgG2BeBoCsQe9cq7EylTs05P54upFKds9PszVW2OTQKpzRnCMK6XQ0h7cPR/bToI
 YgeuVEttmCTqtUN7MMQJvjAsv5sKqtL67OR2x8jwn7w3vwDp5djMP133w8whTvWaYJ1A
 npqHAJqZ+qv8DZdfoMfHMQRsXRcoyVeioc8S/J4qP0mRCgXNKYeMZ/2WpEN3QsIhpu5b
 Ka09a6m+x45EYIw7H5Hr0HWpP5KwpXc6l5ZeJvoFb75HWJM4JXQU9TSrgemaT05YffRa
 K0vcTM+hMsaBKg6mQBvmoOdeBSNtvS3vBR78Ph6m0et9qAGNpwBuBtuRTtA00f23mnsR
 Wzcg==
X-Gm-Message-State: APjAAAW+4TDw5yu5VweKddDnhJMa0sUO57ICF7n0eEGanpSlU8/kjbFD
 kAoxz61jPOCmhjyglsdmlYu7VQ==
X-Google-Smtp-Source: APXvYqwNJ5iLvpSHH/8GfUPkCJnmc9k4dCLIT6kuDM0OHFDEjWpwYV02cv4diyjelI9+gIvh7UMqvQ==
X-Received: by 2002:a63:6d0:: with SMTP id 199mr25066981pgg.299.1568645841195; 
 Mon, 16 Sep 2019 07:57:21 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2?
 ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
 by smtp.gmail.com with ESMTPSA id b3sm58303667pfp.65.2019.09.16.07.57.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:57:20 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] block: use symbolic constants for t10_pi type
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
 <20190916075151.GA25796@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7465169a-dc9d-ae72-99bd-204e7402c279@kernel.dk>
Date: Mon, 16 Sep 2019 08:57:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916075151.GA25796@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_075722_772775_F644CF86 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: keith.busch@intel.com, sagi@grimberg.me, martin.petersen@oracle.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, shlomin@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/19 1:51 AM, Christoph Hellwig wrote:
> On Sat, Sep 14, 2019 at 11:34:12PM +0300, Max Gurtovoy wrote:
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> 
> A little bit of a changelog would have been nice, but otherwise this
> looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yeah, please always include a commit message. There's always some
possible explanation, even if you think the title covers it.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

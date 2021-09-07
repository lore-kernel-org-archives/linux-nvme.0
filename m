Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EBCC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 12:39:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B7B6101B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 12:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36B7B6101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oAY3iJAfVicgyr9IlFIl4TDhcvz0uhHasAlfO4LeVuw=; b=Vr6VmDNuOMPPqRTX82o5weZ+Mj
	dW28t/at2f5a8xmjDGohCAIef0ikB800RRE28BHwhg12XQ0wgmuqEikuilIbP+/xN+wCNXGAywHDI
	ictSkhZj1cXDb/OziAkSavadwx/+qnjXWEV61ZVKZlqG06Mc6bfJA1FQomat6jsY6CfCMFRS+ya+p
	mml/HMizIyLnh1gyLRoYC235SvhRLUGuu4WCzrAWxwdrxfykbJvWmg5290MAulorfIHY/WJEMV4Lv
	nTIh3+YWaZQz6HzvKx98aot6MbaJKaAQI4r7TKejfU8Ue9N8g2lf9EkIV8v8JiHuJ6QVjiW99OCdE
	MvbUfAQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNaNE-003heB-O3; Tue, 07 Sep 2021 12:38:48 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNaNA-003hcr-PA
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 12:38:46 +0000
Received: by mail-io1-xd2b.google.com with SMTP id b200so12509360iof.13
 for <linux-nvme@lists.infradead.org>; Tue, 07 Sep 2021 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1mflkEVjVuJ7rkfuyl6hyVw/lnvYYsFXrvxQ9eOtxQE=;
 b=IJce+6zdvTEt2Eh1qiGMXYjgQbm+6ar76qup9/aYaGe7e+I/VvI/0Zm6j/tvpDpZDN
 EGekm31oCXQOmMrX3a0dTh7VFxAOpbxIS6A1UuDKdGbyePzXiEwUl812xYE6YixJfajN
 BUQThtLD5Xkuptr+1rtZLAAkBXtIzxm5ETtqdtCuX9Rj6q+D2/0Db9Xd425g2c/C0Xyj
 0AE95yXpF5SC3Pk2fwDHMf/VZS8WQnJ7PZk7mXqor5613Ghq20Zh6hNBXb/MPs/Nl5Cz
 r8QKA9fGeSube1RWMKO4JIWH2RpMZqiPe7RoOSDf90HNhYZpp3p0XZT7Hm+hNEUNjZWb
 oOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1mflkEVjVuJ7rkfuyl6hyVw/lnvYYsFXrvxQ9eOtxQE=;
 b=lX6h+457s3ETQrZvU5rGEGF/fMcT0u/CzdlePBcS2TwV/xxIbIIzbOfMp0S/NsY4oB
 2Lzmxcxxa0DfVF0VjuAzZPfoF1VrfQYo9VsntgRVpLHx5WuF1nAXS6GIwvaCS2HyIjiE
 UFX8BxjxztrPjlb6wA1Cx6z0xJe1IBxKHruZ9AqT+UhdEJVnq5O4grR3AzKtqncvvb0O
 RAn0O/S5crdlGx0s27SY//IqqmS8/dU1TsewWfjddOIMilmze7fr4qpe0oWX15WBm7uG
 EVIVOdEoIJcPPG79xkAJnXCLeJweGiciGCvFzrDb30ekKGLWAE/gu/Nizag7/0UtEbpg
 8RXQ==
X-Gm-Message-State: AOAM533iHyvNr3Q5iEOSkvqtnmhNVdXPR94eULlhXBVZjjhRdLmexzay
 q3/35glubIt9TiXNksiPYtzV1A==
X-Google-Smtp-Source: ABdhPJxeBEItzZjTciCcM7b+I21eel7l2TY19YlyKURreR12ZdSNJfbY4PrmLsnU0rWilmk+TUW80g==
X-Received: by 2002:a6b:8d08:: with SMTP id p8mr13928459iod.150.1631018322482; 
 Tue, 07 Sep 2021 05:38:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id i20sm5170451ila.62.2021.09.07.05.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 05:38:42 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] Fixed-buffers io_uring passthrough over nvme-char
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, hare@suse.de
References: <CGME20210805125910epcas5p1100e7093dd2b1ac5bbb751331e2ded23@epcas5p1.samsung.com>
 <20210805125539.66958-1-joshi.k@samsung.com> <20210907071035.GA29874@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ce9132a-8b94-f9c0-b7af-f540a0c10f46@kernel.dk>
Date: Tue, 7 Sep 2021 06:38:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907071035.GA29874@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_053844_871156_21FA9827 
X-CRM114-Status: GOOD (  17.20  )
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

On 9/7/21 1:10 AM, Christoph Hellwig wrote:
> Sorry for taking so long to get back to this, the previous merge
> window has been a little busy.
> 
> On Thu, Aug 05, 2021 at 06:25:33PM +0530, Kanchan Joshi wrote:
>> The work is on top of  Jens' branch (which is 5.14-rc1 based):
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v5
> 
> I think we need to have this reviewed on the list as well.

Indeed - it has been posted in the past, but needs a refresh and
a re-post. Only reason it hasn't is that I'm not that happy
with the sqe layout changes.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

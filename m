Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C6C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:01:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146C264F86
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146C264F86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ki8M5vtMoEw73VFAwUx7rWHycbp3ieXaMdscreKrtRY=; b=f8GFzL1NOEbuwjMU+LjmkW21F
	Pl0Y8Wv8PXBU2FmXekGURLTBcGwPCheDX4egJyWLdGi0UHG7aeM761PY6NdvT11/2PYb+6K1PQGqW
	DZy9LUQFwX1aSSvYU2JCQDoBrl1/DcJNUDtlrCAaE//3c+Yk/7m12tHqKhNZOytrvwwcUJGA++z6N
	vRYuw87IbEHmQ8FcHHWdaFcO/gDxchS1ESoT/CWujLVaoBT7fqyBDiHvraY4m3NlFoXH1Ll2aWkV0
	ihbnOQFSn8JHTpORmh/Pgg13+gX2QYc6bWprtmM8j67iI/4m+59gFI57LNQ1inr3H9RrlwKpD5Ev8
	wsRpxLtSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKnyS-00CJPA-VF; Fri, 12 Mar 2021 20:01:32 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKnyN-00CJNs-JE
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 20:01:25 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 ga23-20020a17090b0397b02900c0b81bbcd4so11248539pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 12 Mar 2021 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v/UNWIhoMbNZ2UJ0E/ZPfqJfvT9+60zw5SGiKePJ9P4=;
 b=tR4EvNUStAuDoH0p5DW9uLKts2Vr+kbFqtfq1b924wIlp2vsh65kX96+bmNOP6ATsv
 9fhaB7YNCJPPBZl0r7kNL3dcnClaHeODnpUREZFbHKhvvX72HeYliAvlMFCF34SxOM2+
 IpuxavzDW4CIHWCN80nRAqY6Xf3FpeXEmnD5J2h/gGfdmalVZ/Kr5seUQzYUmpdySTVm
 Gc6NcKdU5G6+RkuxLBJ48Csl6uoGfgL4QYUQ+VHo28oM7wGiKaj35Sxgzks9Wml+w8DY
 aG2wPr/2jUHA5/oZ4cHn+JtyzOjrezlV1H3l6uyVV0BEhmgcUzDcxTCEuhZvZ3BzG86t
 wgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v/UNWIhoMbNZ2UJ0E/ZPfqJfvT9+60zw5SGiKePJ9P4=;
 b=hGpCr97viMhDe0vTrRUARHTwKm/SAMU5cxVwgcmt17syVxjdZ5gq8aDjxafakRLvJs
 Eabi1E9hvRbdO12Tx/zQJ1DJ+yvIJm/56Tc0Cl70b+SOzmcNXKHn5JYDxZ5LieEfqNG9
 fBkPZzRPPdlkP43aij7S+yd7cgkoag19PicOSeOHlZHZkdjRPLAYgC4kcmcU6zNHVx+P
 V7HT5+P8pH9lRUX9IrGLyiPlBU/b8kCn9259X5xhjP6nIJKn/ah8I43KvhN8MDmpyaqr
 z/EE7DBZNynKbs4ZWPzB/De99zAdore+TPVcwBiShz16sfl6vlP4R4bgF5MLCE4v/zxV
 a11A==
X-Gm-Message-State: AOAM531ZLiaC+P6+v2gvRxDcrbk7mz0ZEbKmi0kDygt1rgqVcP39sg0q
 S7fvNmjbZxmmPexEAYoOB0lHzpPuidWNzQ==
X-Google-Smtp-Source: ABdhPJwNAeGOkGbc1Usxrnpb7ZPM8m7wt+fqXqNzM9fEAdLRRKmXLi2c1R97H64SSacE9F5tshbBMg==
X-Received: by 2002:a17:90a:5889:: with SMTP id
 j9mr3709168pji.69.1615579280612; 
 Fri, 12 Mar 2021 12:01:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id 2sm6173752pfi.116.2021.03.12.12.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 12:01:19 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
Date: Fri, 12 Mar 2021 13:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312195932.GA2766489@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_200123_841349_77D219D9 
X-CRM114-Status: GOOD (  12.51  )
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

On 3/12/21 12:59 PM, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
>> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
>>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
>>>
>>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
>>
>> Pulled, thanks.
> 
> I just sent you another one liner fixup on top of this directly.

Where? I didn't receive any.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

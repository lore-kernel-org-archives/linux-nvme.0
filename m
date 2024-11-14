Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F189DD68B07
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iLSvMAcvDMJIHYqWDlKkrua+nGTltpWcxj1L4JSgD7A=; b=clqE9VCYEBqpPMElSR5wrk23u+
	NvsSbeCkLVEIE/ypSfGFx8lOcXaMeFETnJmnhUexHEEcHep8nVo0EToaHjG+oIhYWx9tqgPticXt6
	B/xj/zpZQ1jfc7vUi72DrnSOU2emyCoauAgH25Y80dQPjWCBYRx7f3F7X2zqMxrlALThUtYwTXCn9
	9r5GYkhvU5Jgj9ARxFT+vS/CK8TrDwCn3T4AM53ThCCFOFbJgZVNZejdA8zHIyx5IJqxhuWPDiJgc
	+txM2WbnoJzYFTLZtTFu0pGFZ1cSvLIpAo9Qa9esHAJmhYlkptamJzRBR5JTLWZa/AbRPn1MBH/wX
	tbXAX/tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZan-0000000A0bx-3y4v;
	Thu, 14 Nov 2024 13:09:01 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZaj-0000000A0b1-1flA
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 13:08:59 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso114930866b.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731589735; x=1732194535; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLSvMAcvDMJIHYqWDlKkrua+nGTltpWcxj1L4JSgD7A=;
        b=DyfGDk98SCShdaTBsbTpWxgMSTwCZ2t/5zVcK2gkfHWrBhQeW1cMUUPHwqihNjTD/l
         3k8r45SkW8RmQyiOZbte5YRIapmQvO/019hv13tuHa38yg+55H4ltUlU/Wghn9CgNQVI
         mZgNTgEp9IWKR93J+dmBm9A+4Zt1Kkyn3j/jwNGx61uITy/Y1ql2yZBQMRCYC03ZVMC2
         eCaJiudZCo/wObo1ENZBjUMVaNYz3i2+IA4ufVG+t6GtPtOknCLArwvHitE+il74gwKw
         nT/YGOA0M5MynCy5ZqKQu2S9NJkgYU6N0LGcgFGTUSPKP2+1p2WcinZ7VGVKx4fFAap0
         sBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589735; x=1732194535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLSvMAcvDMJIHYqWDlKkrua+nGTltpWcxj1L4JSgD7A=;
        b=ElPtCKY5Z8FaA1NRE3JCUU9AgZ1jtS14iQoT8TnTl9eyOuhlcX0QQiq5W6QGEaG1Wi
         N++pk5ivJL+US6HkdHtcNJ1+0YsWgDdd8s399Z+GkhP7Wa446wsX0FFz96qCtg+VyxIy
         t4gjDnYVeEOHdlc/xtX8E5vKiodZLn5tLyRx2wf+cPFET9XUt8pM1WkIjL+TdzTcNMhU
         WjlwMD7sUdxzeNbIXXPRKrY7LdA85VIdvmLIbdSUnxWvhUrGsB7FnRReNlXTIhIvZsZR
         4i6PEbXW4GOjrt+3/uksIXlxeZtSYFEJ8nXMJyOmi0HVHvpMCsAwb/f0JjNEugv9da3S
         NbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkcy2ObVvOGwyHO8JvvoRRUdQ4JS1t81emcfT1Fhh4ynV92OxyMlUc/VoGY9FxGFiDPTc1iI+bCmnQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwA0I4wC7dNoXZxirSnyK92UfulbelNLtPHXJANyMclQEb6oIm5
	KbTdEiV3SJthPiF24BEfqTMvuKqXbHT8vPPxnV05/zB/2/LMyvzJ
X-Google-Smtp-Source: AGHT+IHYWjN5l6K2Kq+RrDtUeiT+m7+vJWueNPIn3tnYMxsQbh1CD6IGXJhFROExTaUr6np+BDJm2A==
X-Received: by 2002:a17:907:930e:b0:a9a:67aa:31f5 with SMTP id a640c23a62f3a-aa1f8038e76mr646269466b.10.1731589734544;
        Thu, 14 Nov 2024 05:08:54 -0800 (PST)
Received: from [192.168.42.163] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0812aesm60676366b.176.2024.11.14.05.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:08:54 -0800 (PST)
Message-ID: <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
Date: Thu, 14 Nov 2024 13:09:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
 anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241114121632.GA3382@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_050857_477763_18BBD418 
X-CRM114-Status: GOOD (  17.76  )
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

On 11/14/24 12:16, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 04:15:12PM +0530, Anuj Gupta wrote:
>> PI attribute is supported only for direct IO. Also, vectored read/write
>> operations are not supported with PI currently.

And my apologies Anuj, I've been busy, I hope to take a look
at this series today / tomorrow.

> Eww.  I know it's frustration for your if maintainers give contradicting
> guidance, but this is really an awful interface.  Not only the pointless

Because once you placed it at a fixed location nothing realistically
will be able to reuse it. Not everyone will need PI, but the assumption
that there will be more more additional types of attributes / parameters.

With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
of whether a particular request needs it or not, and the user will need
to zero them for each request.

The discussion continued in the v6 thread, here

https://lore.kernel.org/all/20241031065535.GA26299@lst.de/T/#m12beca2ede2bd2017796adb391bedec9c95d85c3

and a little bit more here:

https://lore.kernel.org/all/20241031065535.GA26299@lst.de/T/#mc3f7a95915a64551e061d37b33a643676c5d87b2

> indirection which make the interface hard to use, but limiting it to
> not support vectored I/O makes it pretty useless.

I'm not sure why that's the case and need to take a look), but I
don't immediately see how it's relevant to that part of the API. It
shouldn't really matter where the main PI structure is located, you
get an iovec pointer and code from there wouldn't be any different.

> I guess I need to do a little read-up on why Pavel wants this, but
> from the block/fs perspective the previous interface made so much
> more sense.

-- 
Pavel Begunkov


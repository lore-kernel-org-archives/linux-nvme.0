Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A573C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urglFtLe5OfH8uHGc0CuJYPv61AT6Sa7CBlPp/2sj1M=; b=M4i6e5apwf/CNI5kj/VX2QVyiX
	CMuEJrUn4NCYRn+ZLoOLVE23cdUZpY5GdI6oAXI2WA9bT/wubsu2CG+3/s07ddKAQiV1ifVY5oshL
	eBF4vK2mjjbm33cgfNiMJM4Otr1dHBPJIBBK6dOMGS9hU1x9IfThUwfefeQIXdYiE7gZXTnvU6+3o
	RfstVsmVV89J/4ITCktplMdPGSSPdPR9/iFiflsFlaZuh3V7JdcoPAblhMGbGYdvf26PL9BZLH4JM
	Jpt1XA9427P6SvYEApF0DNqq3WCFOKdsm7TnN9tGEJUZB7g8z66e/xOq0GO86qSMCY58Dpd6hoPCx
	1KKvVI7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzDZs-0095BW-1w;
	Wed, 17 May 2023 09:36:12 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzDZp-00959S-0h
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 09:36:10 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3063b921c7eso38179f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 02:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316166; x=1686908166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urglFtLe5OfH8uHGc0CuJYPv61AT6Sa7CBlPp/2sj1M=;
        b=gscTKoVVCTNp6be2yV6HvSQUdddGShMiJTUsfjapugzuLNkBpW+BN4cUMp6Hx2Uyal
         MtAq+hHr49Ujf31dx2TiCXruMSyNgwna7DMAyxeHP0h8uDrKNAoYVMWmJBg5NbwIIaJq
         UctVdlI+BDnWczBOm1kE3m+DTaSUpU8E5FBjEoZ1QMm3rpbYyNGz4HgE+n4V0J725lWt
         NvbCQO8MaUWyQBe0dgBmcL2elSNFKPJVxzKwN3OAjYfJt5RzONQcnxMRWHwHmKhocwv7
         BbjGn3jgsKGDCGCjbVgApO7N5EUcdZ2OlPHrlTuuRNlJPhcZ1x8dOHnQvqkGdnSBOzFL
         gwvA==
X-Gm-Message-State: AC+VfDzyyc7ndp7sbJ9Co6oiVbeHealFub7OeNWSlgj62I+9RLf1ukZA
	I6FOocjc6ZsLDxGTjfaKWSs=
X-Google-Smtp-Source: ACHHUZ6Tz7t6ZiitYv5qDlOTnkdZKR2btl4wh4kcoAZgwhBaKa7+q3p1tZRO6BPRL8LUnudcUTmJUQ==
X-Received: by 2002:adf:eb4a:0:b0:306:2720:b00d with SMTP id u10-20020adfeb4a000000b003062720b00dmr1321474wrn.7.1684316165973;
        Wed, 17 May 2023 02:36:05 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d5392000000b002feea065cc9sm2120975wrv.111.2023.05.17.02.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:36:05 -0700 (PDT)
Message-ID: <70f0e567-95f1-4c88-a4ca-3357524a5c6a@grimberg.me>
Date: Wed, 17 May 2023 12:36:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>,
 David Howells <dhowells@redhat.com>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-7-hare@suse.de>
 <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
 <20230509174724.4a198306@kernel.org>
 <0097e7c0-351a-b922-dd77-ab414b53170b@grimberg.me>
 <c711fc3b-08c4-6673-0f22-f73bf377a072@suse.de>
 <20230517075444.GA30685@lst.de>
 <4d1f5afe-628c-ee5b-c6b9-59d59c184f42@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4d1f5afe-628c-ee5b-c6b9-59d59c184f42@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_023609_254292_89B3AFD9 
X-CRM114-Status: GOOD (  13.19  )
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


> On 5/17/23 09:54, Christoph Hellwig wrote:
>> On Wed, May 17, 2023 at 09:53:10AM +0200, Hannes Reinecke wrote:
>>> Problem is the MSG_SPLIC patchset from David Howells; that 
>>> essentially does
>>> away with ->sendpage().
>>> So I'm not sure how to go from here; wait for the patchset to land, and
>>> rebase my patches on top of that, or proactively switch away from
>>> ->sendpage() and resubmit directly.
>>
>> I'd wait for it.  It should make life a lot simpler.
>>
> Same thought here.
> Let's see.

Did you test that you don't need to change anything with nvme-tcp
on top of the SPLICE_PAGES series from David?


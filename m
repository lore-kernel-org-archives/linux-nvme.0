Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00831C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 18:22:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88E42074D
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0BdGIE8W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hwnoVOlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88E42074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uyqqm9s9/iGoKvc5H974YMGFxbuwV7Qlwkue2JDKEAY=; b=0BdGIE8W182DWT7z+VMMgZWBz
	uH6CGwx8HaxuUZBo91t0Sj8aR3m6EnWuqCoc/QCV4uuBBsOqqff4wrHr947hDs0XEAnj3jxaDN6KC
	WfzBM4HJl5H1CYSQCzFR3I9jOhYUCx5/a7bHR4Xg+ck6uGSZhbg3AEl4OtNFzeSWua0A2h+EJrjXg
	BjqzzXZwJNTgYZQ1IYtRKoYZQ2pcNGV+4TuIvMSAwNlX7Y2id6NlmkDF7ZXDv2Iwqcsy5adkXT5f8
	7scMHt6wEtg48u6LGYXyQwZ9JHUJ6LoxTIFzJgHXpnZteyELwzxJ8h5nKcKVc48lTCGnu22Ukf63A
	j7XNVFF8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqKtN-0002io-0X; Tue, 30 Jun 2020 18:22:01 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqKtK-0002i1-J9
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 18:21:59 +0000
Received: by mail-pl1-x643.google.com with SMTP id u9so5183448pls.13
 for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2020 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9nMjhxRG610D6xAYb4aZ5VRp2i+EwPdQw1qks+ZgrLU=;
 b=hwnoVOlqAmU5zhHyPngbwhlN1yE0Rso1wSEH5Cjpo1eHOGtwX+AR6fF4SKm61iSSaU
 xiq7Si+fCLVLBMD4J7QWGIGpRMN22P7LkDW6XHYnqvsHwEiKJn/e7f4zxe/RH81FYZzf
 6Qah7lhZ47GF32wkEdApitqRosxk7IcYLclUVGOXkeLM+pP0S9zvuPgq8PcNplpKOkyE
 awjP1mt8uhAMtNOYRMd+Y1yvSZf+ZepFpwCbSYGQZlgNrN664rZd2V1H/xVqglgX5aPU
 phGafx1o9DcWQXNw7D5cKE9cBpAhM0fImNVpDBnmceKAdk/tkJjCm50uuW5RXHV8UW9k
 l/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9nMjhxRG610D6xAYb4aZ5VRp2i+EwPdQw1qks+ZgrLU=;
 b=lBvBdKkR52K+EFvJ/7/W8z9Gmx7r3/cVo2YjcW62ZVttmv6RbMi/jFF4cSAqjQpbsh
 ixGGVRoc44zbUvty2EYLkx5AnHybqIIOwx6cXx7ZsZiCMFo7d1kJngvvEmTofYec0QiC
 QCKHN2+ctF4tzkxAzKl0sLNNM/D74iUenFh+M5YvM0iwdp1G3A2JafeinRjCYHX7CXjW
 tNIhsaDkBUZiOOiZ4CfjIxe+TRbPR0cECQlzAuMoREIO6womFBH0ngvmV64rofmudoTG
 8AoPSp3QlzXrWUGZSEki2WPEB59SizHJOPWSfKJES/zIZHLoLJvYcRz07Mac+AzH1mvf
 2rYw==
X-Gm-Message-State: AOAM533L0juWGWzdzYE44i+sezlWpAAQbVBcN96bn7sv6rurBeOOdl0u
 k/Airz7VHYDwSue3IhH2U8oITg==
X-Google-Smtp-Source: ABdhPJx1eVZzUauHavuDMn/utz58o2Sp76o2c6uyFezmO+u8oFk4qpnRUZKKvG8yetkSCycNIsxDcg==
X-Received: by 2002:a17:90a:7409:: with SMTP id
 a9mr23663497pjg.107.1593541316394; 
 Tue, 30 Jun 2020 11:21:56 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b?
 ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
 by smtp.gmail.com with ESMTPSA id 10sm3244047pfx.136.2020.06.30.11.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 11:21:55 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
 <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
 <20200630181928.GA7853@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f173ab34-53c4-0316-f755-240f00cc7075@kernel.dk>
Date: Tue, 30 Jun 2020 12:21:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630181928.GA7853@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_142158_642180_43D97841 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-nvdimm@lists.01.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/30/20 12:19 PM, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 09:43:31AM -0600, Jens Axboe wrote:
>> On 6/30/20 7:57 AM, Jens Axboe wrote:
>>> On 6/29/20 1:39 PM, Christoph Hellwig wrote:
>>>> Hi Jens,
>>>>
>>>> this series moves the make_request_fn method into block_device_operations
>>>> with the much more descriptive ->submit_bio name.  It then also gives
>>>> generic_make_request a more descriptive name, and further optimize the
>>>> path to issue to blk-mq, removing the need for the direct_make_request
>>>> bypass.
>>>
>>> Looks good to me, and it's a nice cleanup as well. Applied.
>>
>> Dropped, insta-crashes with dm:
> 
> Hmm.  Can you send me what is at "submit_bio_noacct+0x1f6" from gdb?
> Or your .config?

I'd have to apply and compile again. But it's a bad RIP, so I'm guessing
it's ->submit_bio == NULL. Let me know if you really need it, and I can
re-generate the OOPS and have the vmlinux too.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

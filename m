Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0F8ECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Gg6tzbKc65ckqG5OAj2t3ODeKa0AQd2dV33mY+3sOw=; b=G1pa1z71ziJG/tPDyyYqm8X3Ab
	TjRAoZgoN3sOsRTmsujGHp3O/WQRHznDNZEWkKgvMMhlm6O1osFFBTB4Of5H0n3x34M8WMeyWQs1M
	5y1oA69Br5eoqnOLbwkF3MYk2kRhtRKYngnz8ENCtJprRwtIDQ1ropE/id2u1nwMNzw7aJkq2Y3My
	5Fs6CKmfuKij+zqliK0W7CBkA5YPiAJ+ih8jXWd1mTVrDFHL5oXmJ9gQpVNQ5woQtAtwAAyX1BVaM
	8Kt63bGrRkSPMI7NXU6JII88lqkvEMr7kLUpk3nMn6lRieAOfwwfXtENuzWHLGk/iOAHLQqckQqpQ
	XyWYsqxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJKG-00HWJO-CE; Sun, 28 Aug 2022 14:31:48 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJKC-00HWFq-Hm
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 14:31:46 +0000
Received: by mail-wr1-f48.google.com with SMTP id h5so7225079wru.7
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 07:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3Gg6tzbKc65ckqG5OAj2t3ODeKa0AQd2dV33mY+3sOw=;
        b=r1BhQEo5y3BeyWWyDzUrq0lIYtM9B3XPdniiqneQAiWKxajsYtRDGUX7icE8W4zXaC
         8j8oLmxYpjg43LqtrLZBwIwU2uqXEEjkGt0sJPACi3aQktoV+mzdmnyZcYVk6Wgv+c4U
         2F28KmvKoO4M+yuhDXgb+EK4Lkimc2syhDIEiBF9YPLUtgaaxpvLKGew8uBm3qIh8pzy
         YLzfTnSSI9f/14dvrT5W/eqj2fHBCA2qlJnkjYiKq7ENzaCDiWxzGVT5o9jl6KaEb9w1
         eHpPN060dUyu3Kmc1/YYNLDODi53KbCHl/dh73RkksrGSJbtffMo/aSVZPPqgTB2bLgy
         Qb/g==
X-Gm-Message-State: ACgBeo0zUoIBZokhI6A+Z9WXw4An63ecLFuCk34EOy78K7cpXDUMuqzX
	MKs5hEeMvqA88AmgsYAp/So=
X-Google-Smtp-Source: AA6agR4VmWA6eXg/sR0Azf+jnUrZYFRCVf+Jec0+Ho/bl41h0YpKPeo7moPq9j1tqd4zVeT8wNMYsA==
X-Received: by 2002:adf:9d91:0:b0:226:d001:6e27 with SMTP id p17-20020adf9d91000000b00226d0016e27mr4058125wre.366.1661697101152;
        Sun, 28 Aug 2022 07:31:41 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0021e8d205705sm4582637wru.51.2022.08.28.07.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:31:28 -0700 (PDT)
Message-ID: <3e08c8b9-805b-eec9-9a54-467735a27fc5@grimberg.me>
Date: Sun, 28 Aug 2022 17:31:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 James Smart <james.smart@broadcom.com>, Ira Weiny <ira.weiny@intel.com>,
 "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com> <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse> <Ywkf3NJQ7/8SSV+e@ZenIV>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Ywkf3NJQ7/8SSV+e@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_073144_782641_CC06EEE7 
X-CRM114-Status: GOOD (  25.88  )
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


>> As you may have already read, I'm so new to kernel development that I still
>> know very little about many subsystems and drivers. I am not currently
>> able to tell the difference between BVEC and KVEC. I could probably try to
>> switch from one to the other (after learning from other code), however I won't
>> be able to explain in the commit message why users should better use BVEC in
>> this case.
> 
> struct kvec: pairs of form <kernel address, length>
> struct bio_vec: triples of form <page, offset, length>
> 
> Either is a way to refer to a chunk of memory; the former obviously has it
> already mapped (you don't get kernel addresses otherwise), the latter doesn't
> need to.
> 
> iov_iter instances might be backed by different things, including
> arrays of kvec (iov_iter_kvec() constructs such) and arrays of
> bio_vec (iov_iter_bvec() is the constructor for those).
> 
> iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
> work with either variant - they look at the flavour and act accordingly.
> 
> ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
> ITER_KVEC obviously use memcpy() for copying and that's it.
> 
> If you need e.g. to send some subranges of some pages you could kmap them,
> form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
> feed it to sendmsg().  Or you could take a bio_vec array instead, make
> msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().
> 
> The difference is, in the latter case kmap_local() will be done on demand
> *inside* ->sendmsg() instance, when it gets around to copying some data
> from the source and calls something like csum_and_copy_from_iter() or
> whichever primitive it chooses to use.
> 
> Why bother with mapping the damn thing in the caller and having it pinned
> all along whatever ->sendmsg() you end up calling?  Just give it
> page/offset/length instead of address/length and let lib/iov_iter.c
> do the right thing...

Thanks for the info Al. IIRC, I think that the original goal of this
code was to avoid the kmap/kunmap overhead on every copy as the buffers
lifetime matches the request itself, However as noted in this thread,
the buffers are always highmem, and hence don't have an associated
overhead.

I agree that this can be converted to use bio_vec, I'll give it a try.


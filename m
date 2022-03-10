Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06CFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B12bKFP82KugN9uZqFvyUBQMSWOVuw1xLzbqBwtOjwA=; b=cU8MMQXAJR+7u+KX//fqqUDMMa
	JD/j4QRMdlSMu501+ljK2HB/hjq+fGYRQKM2n06rFsnKRVqCzUSGRtvaqtHBAEvBiyKZuN5zRIrAN
	a71lPykDJbv3SGPBtTRK3THqJdfhQPSF6qDt1s29KIrC3GMxxJ3u7vNFQDUoOtAN7NWSHqAtTuKMk
	/G4eLc8Awvb3lC+7UBi9yTgKOsBeKmURZ5631ZziMB81vKjk4cuSTl/gOLV+pb4XLig/QHXIBqX7j
	WGeYPb+F0BRmPUL1P6+z9E/HuS0d31GvWRLI7ANkh5lfxlLbWOmwHIv6kAuRnYrXEZoXv1J1hJw6A
	tUKTh4dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSIL9-00Cqim-SL; Thu, 10 Mar 2022 12:56:23 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSIL7-00CqiI-AN
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:56:22 +0000
Received: by mail-ej1-x62c.google.com with SMTP id kt27so11997113ejb.0
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=B12bKFP82KugN9uZqFvyUBQMSWOVuw1xLzbqBwtOjwA=;
 b=CKjOpapeq4nkxo/2JGrvf9qLObTeY/AhSLUH7gvvSsQepN466vImBZ304U4JSExDmL
 wRHP3XZ7tHOMyqIlxiPbXkdVaxyAndykI2+F4mANu4cMrVNdy8tVR2/9CnXoNKba0sWX
 OkiDZAlev1ZeUUs1SbEqd9lLviQPdgcLy7CxLvB+aq/6zO4SWc/q+vLj9N83D92dCCfd
 JNHRw5rJqsrnLNNS982b00FSCRbBs4HwQOKQcWZ3f+FVH16mggBC5H5+813pVu7Ifdeu
 nfeRyxG6iGMv37+/jhaRvMrIIuUkh01g86MZlRk2XEjH6jP+D99Fw/L/f7v1W157Dm5A
 gS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=B12bKFP82KugN9uZqFvyUBQMSWOVuw1xLzbqBwtOjwA=;
 b=J8a7XvEkAAkEdEB1LRv9CSFnBQOk3uq/rPpx7VZUzkMx9SmIS5Ilb8ZtmJv2hfwVeb
 +6iqgp3UXVcxJ4sCJ4UtEnFxT20GuInAGM70nn/aNJQt7pIhlBPnqrIUp0rW1Gt/swWy
 IVL2K95OGKMg88ruizAqcWGBJ/tQC+ULl3j+IHpAoNLNzp25N1tQN0JnFMJjntz1AkzP
 omd2g4HiAW0PgCNJLVaLB6TJm2EGJJA+FEYua5aIdAO2U5Po3tgkhSWpk8Oy9ikCTk5T
 ZpNNahK7wdVefMwNPP6ZRmNbpNSkc4j1ghfsGIDoc8esAcMMeaiBZKzV0L0XFQlu8DSQ
 eX+Q==
X-Gm-Message-State: AOAM533GrmCXRSMi8KviW3IHV10rxH/0CYJ893ox4koZ8rpAEJFoKYI9
 6Ifo6Y1DlyRvxzbTFQd1OJJ6gR6FBB6v2Q==
X-Google-Smtp-Source: ABdhPJzAYyD4SI6F23GFHxO4Mh/3Lz+yfd1+bZybdEO0OTTfVpk+rrOzZG+AtpSUkh31rGc397MVHA==
X-Received: by 2002:a17:907:9910:b0:6d5:acd6:8d02 with SMTP id
 ka16-20020a170907991000b006d5acd68d02mr4100811ejc.173.1646916979373; 
 Thu, 10 Mar 2022 04:56:19 -0800 (PST)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98?
 (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a17090617d300b006cea86ca384sm1783287eje.40.2022.03.10.04.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 04:56:18 -0800 (PST)
Message-ID: <2af5e88a-0c03-757f-5977-ac27c3953c48@gmail.com>
Date: Thu, 10 Mar 2022 13:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
 <09c807d0-1aaa-b5c0-65cb-05700059e5d0@gmail.com>
 <283f07fe-cfc8-cecc-311f-ca7603e5118e@acm.org>
 <946ca1a5-4dbc-7b49-d234-1136815fe699@gmail.com>
 <22878ead-454e-b680-8946-fcae188f7576@acm.org>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <22878ead-454e-b680-8946-fcae188f7576@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_045621_392660_1471FE2B 
X-CRM114-Status: GOOD (  21.76  )
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

On 10/03/2022 06:10, Bart Van Assche wrote:
> On 3/9/22 16:24, Niels Dossche wrote:
>> The main focus of the analyzer is not on lockdep assertions actually.
>> It works roughly in the following way:
>> 1) The analyzer searches for *_lock and *_unlock calls in order to know which fields are locks.
>> 2) It searches wrappers for those lock and unlock calls (e.g. task_lock locks task_struct->alloc_lock)
>> 3) It determines which field accesses of the same struct type occur guarded by a lock (e.g. A->field guarded by A->lock). This is used to (try to) determine which fields need to be locked by which lock.
>> 4) It searches for violations by counting for each field access how many paths are guarded by the lock and how many are not. If the count of unguarded is way smaller than the count of guarded, then it is reported as a possible violation.
>>
>> The analysis works interprocedurally. It also uses Multi-Layer Type Analysis of K. Lu et al. in order to improve the global call graph with respect to indirect calls.
> 
> That sounds interesting but does that algorithm also cover initialization and cleanup code for which it is guaranteed that only a single thread accesses the data?
> 

This is indeed a problem with the algorithm. I already did some work to introduce heuristics which can detect initialization and cleanup functions in order to reduce the false positive rate. Currently the false positive rate is a little high, but I have plans to improve that.

>> The lockdep part of the analyzer is not more powerful than the clang assertions. To be honest, I'm not sure that it can be easily integrated into Clang itself. The analyzer currently uses LLVM bitcode files as an input.
> 
> This is not a big deal. I was asking about clang integration because it is more convenient to run a single tool (compiler) than two tools (compiler + static analyzer). As you may know the Linux kernel supports the __acquires(), __releases() and __must_hold() annotations that are recognized by the sparse static analyzer (https://sparse.docs.kernel.org/en/latest/). The clang annotations however are more powerful than the sparse annotations. Additionally, it seems to me that the popularity of 'sparse' is declining a bit.
> 
> Bart.
> 

Oh yeah, a single tool would indeed be very convenient! Maybe this is something I can look into for the future.

Thanks
Niels


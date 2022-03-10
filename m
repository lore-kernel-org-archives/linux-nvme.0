Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC05C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 00:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZ7b7+ZEaLBNAYgZtH7sZBPod6ktgE0OBjcGhmH5MvM=; b=wjge5a34efux3f/B3Wk6nyFa3k
	y0IQOfd+GAxzhELt9Oxyfx3iFTnDJmFBsV8ZXForrHal+hrj8dlvFQ2GHWs1rR7FQV/t5eoiegFlV
	IzhtGNixmu0A7CRBMfC5XcqsFgAd/APmBHw9O9HPW1hDNwCW0ODTbLoIV78MSRwMVda2iBwGigwgT
	DB0sgUPUF1XBiq1YmROq05ed6E7iC+DTvL2bKVZ4WuzUy4A6lxn8W9UOtqPAzc/GCwSBdZ1r80TGP
	9sVmkwWbhW22F1SstHLZCyeRz6uP3ZIblojuSAdEZSzLnK6pFOR7Pie/BixIUpkiXt75JIgeO5tMt
	JltW8jkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS6bb-00AsSm-OO; Thu, 10 Mar 2022 00:24:35 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS6bY-00AsRq-HU
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 00:24:34 +0000
Received: by mail-ej1-x629.google.com with SMTP id qx21so8570423ejb.13
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 16:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xZ7b7+ZEaLBNAYgZtH7sZBPod6ktgE0OBjcGhmH5MvM=;
 b=nr7DABOwTsxx7+JKES1hx/Bi8V7BC9FM5+s90KmfUAvj/BqcmxSiYWqCI29LQEIA1t
 Sf0qVhh0ZSCc2zNrKR3Qx+DLhbzA61+B8S8u52UmP7cna4nCszOyw8V2ZBXfDl50XzO4
 Lgg2/mhjD30T4e66Z3RtLcWCTBpQWRu3N3t+THq/SSMnig9JocPLNq/SCBUwyZq5qVns
 LlvL7y8y6CncaFGgKKYsWuzNSa09m9hUX+6p2eJvOiEuIS8IIA+QkZMXq6o8/I9JYFYu
 tHToY7xlhQQEM4APuSSPGBKw48lFQTTd8gTiSEgqPi7dihnpGGeUVwSE6CYYEu2vCrLV
 qAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xZ7b7+ZEaLBNAYgZtH7sZBPod6ktgE0OBjcGhmH5MvM=;
 b=GsBhBvmFLIANUiKsiK2Eg77q5062uorV7riiB8ZgOIH/MVnytxI7RoSTXsvM6oDmn/
 tqDTLkZ1RJYUnnnoLHzm6MEqCB6K/+YOHuWimMmI8KT+S0tBDMTPG4/ZlN90LHdce2XU
 ci7QKJZLG+MML89MuoZNdBRnqWYFDHrbSaUO23sHjM8jnP0//gK4OMnSrue2fSCx0HaZ
 1dFjdUSQw90cxMX49IiZ+LtzvaQCahtJvYGha1HYBmesU8ha7a/pWOvpa/fYgTkliQDT
 sVQy87E+Zy7Xx9kCMZ423BL6EY93zkp7DoJN1D+H09sKzJoFUfxut9V6yP2cvPnwDT24
 H5bA==
X-Gm-Message-State: AOAM533wuJuwJGN5EznRSgYLQZQznXqnzjQSXm7E4YNqbuQ7JuYn3jtz
 YOXR5FfVtOeLPx2eKExZpgM=
X-Google-Smtp-Source: ABdhPJwixSVIoL9/RFqWL9lLTlU7t9q9xSJaTDmHDwbW217C8xFOCPrJngj5toTANg9UDyXZdDHNiw==
X-Received: by 2002:a17:907:97c1:b0:6da:bd15:cca0 with SMTP id
 js1-20020a17090797c100b006dabd15cca0mr1992670ejc.327.1646871867086; 
 Wed, 09 Mar 2022 16:24:27 -0800 (PST)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98?
 (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a1709060e4c00b006db01e2c29asm1234137eji.211.2022.03.09.16.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 16:24:26 -0800 (PST)
Message-ID: <946ca1a5-4dbc-7b49-d234-1136815fe699@gmail.com>
Date: Thu, 10 Mar 2022 01:24:25 +0100
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
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <283f07fe-cfc8-cecc-311f-ca7603e5118e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_162432_629892_FDCEC132 
X-CRM114-Status: GOOD (  29.64  )
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

On 10/03/2022 00:12, Bart Van Assche wrote:
> On 3/9/22 14:30, Niels Dossche wrote:
>> On 09/03/2022 23:27, Bart Van Assche wrote:
>>> On 3/9/22 12:34, Niels Dossche wrote:
>>>> nvmet_ns_changed states via lockdep that the ns->subsys->lock
>>>> must be held. The only caller of nvmet_ns_changed which does not
>>>> acquire that lock is nvmet_ns_revalidate. The only 2 callers of
>>>> nvmet_ns_revalidate which do not acquire that lock are
>>>> nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns.
>>>> Add a lock for around the call to nvmet_ns_revalidate in those 2
>>>> functions.
>>>>
>>>> Both of those identify functions are called from a common
>>>> function nvmet_execute_identify, which itself is called
>>>> indirectly via the req->execute function pointer.
>>>
>>> Please mention in the patch description whether this has been
>>> discovered by studying the source code or by software (static
>>> source code analyzer? runtime data race detector?).
>>
>> This was discovered by first using a static analyzer and then
>> verifying it by manual inspection of the source code.
> 
> Hi Niels,
> 
> Are there any plans to make that static analyzer available to other kernel developers?
> 
> Is the static analyzer more powerful than clang thread safety annotations? If it is more powerful, is it possible to integrate the static analyzer in clang?
> 
> See also:
> * "C/C++ Thread Safety Analysis" (https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/42958.pdf).
> * "Thread Safety Annotations for Clang" (https://llvm.org/devmtg/2011-11/Hutchins_ThreadSafety.pdf).
> 
> Thanks,
> 
> Bart.

Hi Bart,

I'm currently developing this static analyzer as part of my master's thesis in order to obtain my master's degree.
The analyzer is currently still a work-in-progress.
I plan on making the source code of this analyzer available when my thesis is finished, which should be sometime in June.

The main focus of the analyzer is not on lockdep assertions actually.
It works roughly in the following way:
1) The analyzer searches for *_lock and *_unlock calls in order to know which fields are locks.
2) It searches wrappers for those lock and unlock calls (e.g. task_lock locks task_struct->alloc_lock)
3) It determines which field accesses of the same struct type occur guarded by a lock (e.g. A->field guarded by A->lock). This is used to (try to) determine which fields need to be locked by which lock.
4) It searches for violations by counting for each field access how many paths are guarded by the lock and how many are not. If the count of unguarded is way smaller than the count of guarded, then it is reported as a possible violation.

The analysis works interprocedurally. It also uses Multi-Layer Type Analysis of K. Lu et al. in order to improve the global call graph with respect to indirect calls.

The aforementioned methodology tries to obtain knowledge about which field requires which lock, without using assertions or annotations. I manually inspect the cases this analyzer outputs in order to determine whether the reported case is a false positive or a true positive. I have submitted patches for some of the true positives over the past few weeks, of which some patches have already been accepted into the mainline or linux-next.

I recently submitted a patch for a case which was missing a lock, but had a lockdep assertions. So that got me wondering whether there are more cases that have a lockdep assertion but don't actually have the expected lock acquired. I added the ability for the analyzer to leverage information about the lockdep assertions. The patch in this email thread was to fix a case that it found. I checked manually too to be extra certain.

The lockdep part of the analyzer is not more powerful than the clang assertions. To be honest, I'm not sure that it can be easily integrated into Clang itself. The analyzer currently uses LLVM bitcode files as an input.

Thanks,
Niels


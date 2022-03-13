Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C621FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mcouati6Y6N3i3vbkgHk30OyRWYKWgDr+qDETHZTyOA=; b=5A7ReYHklTxb+LPNufJeagR5Vf
	B5HSjNoXCtL7i41JBN6CzahUYBwj0421f5LQlZbkbaAnPjRLOMHR062YL4teEMH2LW8PrLQdmeFpk
	JYUPgr9MiY+t10ZOWdU5ca0hEXjCGvkqf5F/9N4Cs+Gs0HlxKqSuTnCGGInmH4zYl1uEjKuQB7fOt
	hJBEG+W2OdxjqbDgOCivoDLm+FktQ8QJp+XkCbEaW6cVZPHPtjIt9mPUAfv8HvGhTIJ48HaaHzGq4
	vfSdWBgMJQjPBIBVApR3t236mCIHXKvskFH2gmnRAF0LI7rC5UADDNcZV7r/dGyAWuE8+YY7Yn/uU
	y6uW7d0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTXhW-003ULF-6F; Sun, 13 Mar 2022 23:32:38 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTXhT-003UKo-QG
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 23:32:37 +0000
Received: by mail-ej1-x636.google.com with SMTP id p15so30333810ejc.7
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Mcouati6Y6N3i3vbkgHk30OyRWYKWgDr+qDETHZTyOA=;
 b=H5UQHIq3BW3dNReSbgM4F929oD/IDtRZkfn/4fHBI6+KuKY7iwAUHWQuz1Yvfs5lZi
 ElsnJiRja74pOhNRWN8/TTYddwRHki+WkOzM9lICYYPBVBK/sJ2k1Dw4hy6ccewJTogO
 dQy4QI1igROW/annPar3/Jq00hUiGHouo2X9Enp6+Gv7RHOiTUKjcpYqbZUYIaxu1x7G
 jjhAFVmmq801lB42e664zpRKPrBsI8xzq7kIrtmdbQdhWy7YDbpjpbgOCMHN9aw/Pa1N
 fHPqxSd92dnX4mOIAWzAzk8ZXfX0o2TRJZe/K3w953gCVY8G9c85/BeV53HvioC4m6mC
 f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Mcouati6Y6N3i3vbkgHk30OyRWYKWgDr+qDETHZTyOA=;
 b=Jt122fj+iffK5/AebXYOpfkbfCiOxwFGQS1aOmjo0Td5CqzLkS/PdB/t7FgYgPHKcy
 KNJMWxf2npzc22zFCfGUlkR76Fs47cYfuUMoQB8dPIDr5kGPmL3DpaOT/+gBtCnnKC3b
 PKhjxJ7AZPa8rJGbmhmSXPi3BlkxVUaTaN7jN7ahVMbankVILQLwbOiWwVjqLfu47jMJ
 P18J3rnixQL44k7kJw31yFOHcZwDXQ6BKzoVAVcNPrI6kBW4aJFgGG4zCsB2ow5VSXE6
 o3ii2z3ZVBSrsCpiGTYVYMDswaATye00d0GQ8wUULoeas8B5Vdr3EdLwJBQUcSr3slWC
 DqFA==
X-Gm-Message-State: AOAM533pd9kFk1YKGdmDme+d3n8KxEyhpIkFD6Um5zf/riISiPfZa6TD
 yGmTMa+ts0tUC1MM7+bB7jU=
X-Google-Smtp-Source: ABdhPJxUKqsPOEUhikjSPt9UCg8mGCpofehON0v/pBjCYmZRQ77JFLZHQfBpMTkfnDgKvGc2jeazKw==
X-Received: by 2002:a17:906:3083:b0:6da:83a7:e251 with SMTP id
 3-20020a170906308300b006da83a7e251mr16282907ejv.103.1647214354356; 
 Sun, 13 Mar 2022 16:32:34 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:f2b6:6987:9238:41ca?
 (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a1709066d8700b006d4b4d137fbsm6079063ejt.50.2022.03.13.16.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 16:32:33 -0700 (PDT)
Message-ID: <9a5808b4-275d-6348-990e-23b0c5eae5e3@gmail.com>
Date: Mon, 14 Mar 2022 00:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <20220310125130.16786-1-dossche.niels@gmail.com>
 <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
 <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
 <e40f3aea-ba33-f49f-7859-49b47a64cf04@grimberg.me>
 <278c7d10-b361-6d44-ed27-9d3d0ce25b82@gmail.com>
 <d5b1b564-cad6-87c2-11e8-f2d9d92f389c@grimberg.me>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <d5b1b564-cad6-87c2-11e8-f2d9d92f389c@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_163235_891208_BCB02F55 
X-CRM114-Status: GOOD (  13.82  )
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

On 3/13/22 21:41, Sagi Grimberg wrote:
> 
>>>> My commit message in v2 did not clearly state that nvmet_ns_revalidate has 3 callers, of which
>>>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns. The other caller
>>>> nvmet_ns_revalidate_size_store does acquire the lock. Maybe I caused some confusion because of the unclear wording.
>>>
>>> It is simpler to just move that call-site outside of the lock imo.
>>
>> The callsite that has the lock is nvmet_ns_revalidate_size_store. It checks for the enabled flag under that lock.
>> If nvmet_ns_revalidate_size_store calls nvmet_ns_revalidate without that lock taken, but with the lock acquired inside the nvmet_ns_revalidate_size_store function itself, is it not possible that the ns->enabled flag changes in between the ns->enabled check and the call to nvmet_ns_revalidate_size_store? I thought the locking in that function was to also make sure that the enabled flag does not change during the execution of nvmet_ns_revalidate?
> 
> The lock just protects subsys->ctrls traversal, can't see any
> harm with sending 2 aens out of order, twice...
> 

I understand, thanks. I'll send a patch.


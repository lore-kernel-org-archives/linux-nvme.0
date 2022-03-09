Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE82C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PfXxEP+1FJc7ZutsLt5jnUgfH5o0adwRXofXtaXHt+Q=; b=VF/3nY55gvS5+ZLtIPXcm0pYaU
	Noqir3/l0SD0XdWl0Z/vBT/SCK31LLyL4ZfBZhctDpT6P3j7NasNq2RkcBYGAPZi6OSUugs2FJ4Py
	w1ssp7YTxu9Q3i5/wEQJRWHwv+FcfH9CxDd2E4X7xhShovBIML1hW64tXYmps5EAkecGgYi45CQVS
	p19VXFv+z1XEjE4MT0ap+E+IU6SGwUNdjTg/xmeBd9/ONKtVPMvW4TRX/YvHfF+nrgqXdmIHvhL6o
	EtZkS3xSCONAWb+fhnNR0is8NGdPu1U+P8eS5vB+UePOQneceZwgsDYk0IR1YzxGdPU6NirlTVTy3
	ZsyXybPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS4mf-00Af7J-89; Wed, 09 Mar 2022 22:27:53 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS4mc-00Af6j-BR
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 22:27:51 +0000
Received: by mail-pf1-f174.google.com with SMTP id z15so3469166pfe.7
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 14:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PfXxEP+1FJc7ZutsLt5jnUgfH5o0adwRXofXtaXHt+Q=;
 b=UUbH/KEzbfj0amyMvogS5xtgHVKSTTwYU+8D3xbhWjfKV6DJQ5hbtrKga8j5vIsCs1
 zfynWnODGI2io5RMrnZ0/nIXCT9KgOttjG3pElOtf6DOFw4AHH6T6moPJdctCaQI3qSP
 m62cHqWl9xiNxlexsOuTpCToeFW3W6hEbdPoTAzPKrPPGnK1vFVySxUbxKKN2lTSMr34
 8vk2LqhgoFTdLxV8J5kENuDOtnCDn80nSM30XJmmFVOKJT2Do1mt/kFVHq1QjjvcU4Dr
 Rv79KTeeaYA2MNDQBFKx/3c1P6Vemj/JgvfglWSB21nCoBfz+1w0u/rwcPpxnPGuNgMa
 QQIA==
X-Gm-Message-State: AOAM530VZdmz6bFUjx8s8Xw7imTqBkhgiV/pt6OV72i2fgjTHZ6vqbkC
 huhpVhlfWFcdR9SiKVwaMSc=
X-Google-Smtp-Source: ABdhPJxLTKTRJy9H5pTMB96O82s5HQ0A3o1w8TERHAxDGayUUEAAYVsBDsLZtD5LQNtZyWq0U5rYnw==
X-Received: by 2002:a63:ad0c:0:b0:374:50b4:c955 with SMTP id
 g12-20020a63ad0c000000b0037450b4c955mr1516648pgf.530.1646864868352; 
 Wed, 09 Mar 2022 14:27:48 -0800 (PST)
Received: from ?IPV6:2620:0:1000:2514:1f39:9c42:2577:aafd?
 ([2620:0:1000:2514:1f39:9c42:2577:aafd])
 by smtp.gmail.com with ESMTPSA id
 z14-20020aa7888e000000b004e5c2c0b9dcsm4247386pfe.30.2022.03.09.14.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 14:27:48 -0800 (PST)
Message-ID: <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
Date: Wed, 9 Mar 2022 14:27:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220309203449.63125-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_142750_428031_4E2A9F63 
X-CRM114-Status: GOOD (  13.51  )
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

On 3/9/22 12:34, Niels Dossche wrote:
> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
> held. The only caller of nvmet_ns_changed which does not acquire that
> lock is nvmet_ns_revalidate. The only 2 callers of nvmet_ns_revalidate
> which do not acquire that lock are nvmet_execute_identify_cns_cs_ns and
> nvmet_execute_identify_ns. Add a lock for around the call to
> nvmet_ns_revalidate in those 2 functions.
> 
> Both of those identify functions are called from a common function
> nvmet_execute_identify, which itself is called indirectly via the
> req->execute function pointer.

Please mention in the patch description whether this has been discovered 
by studying the source code or by software (static source code analyzer? 
runtime data race detector?).

Thanks,

Bart.


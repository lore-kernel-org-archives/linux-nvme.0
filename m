Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EC6C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 21 May 2022 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KblL3yo06SixK14FpdNzpZ7IZW
	R2ApEuq0/1aQpI82fQ/mUjWQ31H1PtR11/DNXNPE2Rle2rYQ2XCu8d2WO5tPm68Fuzf6Px8yMIzjQ
	vH1ih4FbpIrWQe5JdlnSV2w6sM8RTIkD9v/OqoLosRQodpaOZNGzM0981OAWKCD0ajp4gvUPmhddc
	RgUZvw+Vz6ZBzG3xD7O7QWdTOZmqNSMSNGKkmWIcfe/9SY4XqX8v9C9LMeNkW57xI+v4j14h3AA6f
	vnw19GPLMPemlqmQ+HUlCFYgfq3zOCZAfw2vvIpT0QN9TOIAFCTNMzb/Srwsajsc18YlpXtNxw5su
	NIzRNGxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsVKP-00HNm9-Dd; Sat, 21 May 2022 20:03:57 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsVKM-00HNkg-St
 for linux-nvme@lists.infradead.org; Sat, 21 May 2022 20:03:56 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 n124-20020a1c2782000000b003972dfca96cso4268475wmn.4
 for <linux-nvme@lists.infradead.org>; Sat, 21 May 2022 13:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Qj+C9uXzVXEME8sw8FhzoKUlUwMlZcB+HTmlta6yMr2yRCeGVowQs6sTpwa1ij6m3N
 qfnKySVbkm74Rf5iecSfMQWfdl+k0SZ2QABYhxbRlS40oU3YBffUuCgF82mqK99LyqM7
 lBiVcjr0XDWnfhDnbZpyD8sLsnSNC7S6EDzsUhE3WnSJNfWg33xTzWeuYQBG+rQcZKD7
 1avOwx1qWsyc86cplgXT7Tsa0E3vLRTdeyYDtiiH7A/DolGSWp1R+C0P5LkxME2Vcw++
 F9NNWCvZi0JMrcpEsomQCisP0nE5ngEqliANGuohYy5mh2lOYf6WvjArBYUz1wjRv/p9
 pkdA==
X-Gm-Message-State: AOAM530CbskNf3fsAdv9i8Qt/zrHSR9gQTmE3KmtRAmg6AWzhd3/y4fQ
 DPJj/Jdnjh1N/MbROcoj8js=
X-Google-Smtp-Source: ABdhPJyZW5ziM6UlBJG70zl3q7Tkspea+ORr/TPPzygduyFNRkAiu/KjwAjKQLRTSHiV2m0n2eTG0g==
X-Received: by 2002:a05:600c:4fd3:b0:394:7fa6:2584 with SMTP id
 o19-20020a05600c4fd300b003947fa62584mr13376627wmq.177.1653163432813; 
 Sat, 21 May 2022 13:03:52 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfa347000000b0020d098935dbsm5758822wrb.58.2022.05.21.13.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 May 2022 13:03:52 -0700 (PDT)
Message-ID: <db25e5ad-37c3-8b77-2774-cac27b989781@grimberg.me>
Date: Sat, 21 May 2022 23:03:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvmet: fix typo in comment
Content-Language: en-US
To: Julia Lawall <Julia.Lawall@inria.fr>, Christoph Hellwig <hch@lst.de>
Cc: kernel-janitors@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220521111145.81697-26-Julia.Lawall@inria.fr>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220521111145.81697-26-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_130354_962627_269BAC61 
X-CRM114-Status: UNSURE (   6.65  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


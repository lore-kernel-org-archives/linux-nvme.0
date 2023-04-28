Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC33C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7thGFqsXnUZKI/1GxZfW7o8p/ReedXSSfe8i9pCipgs=; b=ysSDRzfuEmEF5oPAFWpA8NOL/J
	C/rkce56IQub9TVWcEzM9/vv/gH0h+SPoLYcDEUYsdzTTGpPQFu4rFORTZQLHoIdXV9wgp8eTZDdf
	jsuweUv4JGAsXTYsQiT0X0+YAlLyeWdRmNOc6JKWokNn29P6J+L2gxkheXK1yINNQzy7FoIhG1+VY
	U/z9uuduUbP8Nl5terQLSusir6nIUt6x/6fGUWvYNktiUVJ82w536g6u1GyRfpBrW8MpaqCYiTvUv
	+lgCk/GDG+Dxj9zwnvUf4tj6KuIpqP2nT+bpP5CpGGXWAzKSogD1ZBt68gDmio88WgfvyCgrElKLq
	L5A6Ix9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIbV-008Qg3-1S;
	Fri, 28 Apr 2023 07:33:17 +0000
Received: from smtp-30.smtpout.orange.fr ([80.12.242.30] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIbO-008Qdo-2s
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:33:15 +0000
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id sIbGpc4gTOW4ksIbGpuCv5; Fri, 28 Apr 2023 09:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682667183;
	bh=7thGFqsXnUZKI/1GxZfW7o8p/ReedXSSfe8i9pCipgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W/MU0nZsswz7tKo/OpfB9j7+U2zS8ZLcDusNlR+tmaYK5ToFBDm8l0kUCGc5BHcSy
	 JU871dzu1Np1bK6lqhKwYmqZ10xHQwSEdihP+NfHIS9piV+AdIjDyvCeE/7a/Qf8EQ
	 csSgwnWvGxESp9lXBU8bqEcEo1MJKOQ6nDzm+PDLjoZsQ+rcyIOIA39uyprJkLzPFP
	 xY3MNgmGjHRpxoHINrU9/edpEhNzTZGiU9dWZ4xfxZway0HDMUeF6qPEV9Frg33NCp
	 /2K8N2fABk5atlpUTIOi08clwPQF2lBPWWX7kbSGPMuXDnjHlSzXYBUmk7q/ZnTflJ
	 xiFHA6Z2M22wA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Apr 2023 09:33:03 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c704568d-16d1-bbd8-2b59-1d719f2bcf8c@wanadoo.fr>
Date: Fri, 28 Apr 2023 09:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003312_171040_9CC08248 
X-CRM114-Status: GOOD (  13.88  )
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

Le 28/04/2023 à 01:12, Chaitanya Kulkarni a écrit :
> (+Keith, for host side)
>> ---
>> More aggressive grouping could be done to be more future proof, but the
>> way the struct nvmet_ns is written suggest that some fields should be
>> kept together. So keep grouping as-is.
>>
>>
> 
> you can send RFC and I'll be happy to take a look if it's going
> have any benefit, it will take some time though..
> 
> for host side :-
> 
> while you are at it, it might be useful to take a look at the structures
> that are accessed in the fast path on the host side ?

Ok, why not, but can you help identifying these structures or places 
considered as fast path?

CJ

> 
> unless there is some reason for not doing that ...
> 
> -ck
> 
> 



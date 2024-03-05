Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78EC48BF6
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 02:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5AwigbBi0VcC/A5mgAXJXFypMIK45f9oyPWraC9kDkY=; b=a4d0vV5HAtGhKR4uh+MWXtYSZ9
	dmNSpSsXWiKzQrfSWStnt7127CBF/gZ5+hk6JB2F6OCF3tOuPEOgg5oheCYGKz2juDNWmtG3rOcR/
	CgxPAiX7x+ZzbgFAVtKD4MTT+dvd2XM+7wtff7MaPcZr4P+SWgb028ZCUEa/Px/pZauPU//vEQ/yy
	J3nL7yBdQXeP7Y5hoZ0X6nGvJMtF7eiNMuerxJ1N9RrBrBHOQfWvQdeolllI99tSpPfEsLSGA1lQ0
	AWf4Ig1DU1D0STVw6NmRMIoe4TygBbc7/XnQOb6lx9J0lMVYlEcL0063JrifN0sqwx2J0RMEDjMeE
	9Sb2iFGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhKbf-0000000BZNK-1VKk;
	Tue, 05 Mar 2024 02:32:39 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhKba-0000000BZLf-0Ahl
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 02:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709605946; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=5AwigbBi0VcC/A5mgAXJXFypMIK45f9oyPWraC9kDkY=;
	b=BjM96CUfU8nXpxUDINZqbfMRUJep/EuzchS572c2V+FLVUFtGn966C4IYch+JIf7339zxaV8wQ2iEWv4/vRjrOeuZ3dij13FaFd8Df4TxXO9AfKC6FhcNeXi5ph4KKgp0GfSMXG/jN0/pOiBUAON6puf5y4a+T3t+ueMmA1MNkU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1sfCMV_1709605944;
Received: from 30.178.90.144(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1sfCMV_1709605944)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 10:32:25 +0800
Message-ID: <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
Date: Tue, 5 Mar 2024 10:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
In-Reply-To: <20240229031241.8692-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_183234_616540_A021DBEF 
X-CRM114-Status: UNSURE (   7.25  )
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

Hi Sagi,

     Friendly ping. If you have no further concerns with this patch, I 
would be very grateful

if you could provide a "Reviewed-by" tag. Such an endorsement would be 
immensely encouraging

for my work in this area.

     Thank you very much for reviewing this patch and for the valuable 
suggestions you have provided.

Best regards,

Guixin Liu

在 2024/2/29 11:12, Guixin Liu 写道:
> Hi guys,
>      I've implemented the NVMe reservation feature. Please review it, all
> comments are welcome as usual.
>
>
>


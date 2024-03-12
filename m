Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3812DC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppZ0QkMJqrB0UW5Bf0gLX3JDgzSA8YFmZGU5OEIcN9o=; b=Vaf+BX8PobEA9wRLXTh1Die2tn
	wrmrAW/d60THDwI33XbCItNH6yYx/MIZrd2slNE0iltxfUmcn6h/VA72QmVXK2DgJOpQ1KqJb8/Zp
	yilB+vtR2tCjeilm2F64A2Lydabs1m84zW86Ex2vJ3h1ZV7/9kD+rPW+JTKtBSpYoOjgKnBqiybRW
	8Nr00XYOigBUVjSDwThH58KDX0ozUPsFQepT7e2vVvOTFTiLV6l5s+asd1PmKq0zsvh0tQ1yBjRsz
	53YbOBRn1G/HgB0Q1686yQbZpFexEw8/BaAm59wFYrc5SZWG1LwQs8FzeSJkJ6v/Tnt/qm1/zspXw
	2HtCscPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjszf-00000004AcR-0JwI;
	Tue, 12 Mar 2024 03:39:59 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjszY-00000004AZg-1oxo
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 03:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214787; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ppZ0QkMJqrB0UW5Bf0gLX3JDgzSA8YFmZGU5OEIcN9o=;
	b=x8VNwtantSGcfr4EpfTj0DNND9ihh5fv9FLRyS1XgjTzpBPc+NZs8UGOt9Gkbi2UtIJS/6gnKJyJ7fJqOZQ+hDojYa4HX6/pmoufSfsW1ghZCw1LSmsBS2RHzrYZvb/slJtyDt1XwEWQyAOlTczHgU/ZM0h1sTc1UixpEhECJOY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2KNEc._1710214785;
Received: from 30.178.91.50(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2KNEc._1710214785)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:39:46 +0800
Message-ID: <e9e9a7c1-44af-43b3-b2df-8290849eeb67@linux.alibaba.com>
Date: Tue, 12 Mar 2024 11:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
 <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me>
 <43565275-d71b-4c51-9a5c-b528e6387614@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <43565275-d71b-4c51-9a5c-b528e6387614@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_203952_681065_B863AC9F 
X-CRM114-Status: UNSURE (   9.75  )
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


>> Sure, I do think we need at least one more reviewer.
>>
>> Plus, I don't think a target-side reservations maintainers entry is
>> justified here, it is a part of nvmet.
>> So please drop it from your next submission.
> Can you please send a next version with Sagi's comments ? also can you
> please send blktests if you have any so I can run some tests once I finish
> the review on next version ?
>
> -ck

Sure，but there is still a discussion going on in v7, I may need to change

the code, I will send a v9 after the discussion and with the blktests patch.

Best regards,

Guixin Liu

>
>


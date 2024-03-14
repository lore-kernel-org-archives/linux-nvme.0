Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB68C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bewfs7LtkdUE5VYo3YRUADoZIyv9PV7MvGLZllziqdk=; b=rrCUGEsnJd1HV76ehm09sV8klQ
	AIi4mHZixEkgDydTK+fyn9n1l9e/TgymkfLFy0GNNMMnkzT1olZj3FM+U4meHtOeNLGpsvhjD+6ZJ
	ja1n3Wl2PhhuvHk3CdHYPHJ9mI33KugefhdafVJea7ccY/tj++E20PghIY8Tv0usAieLSEHo16/5Z
	1gk4xFZodK8oszfOVufVz7gUazCyDGI2Zlh0cQwt/rJC0qP2Use2pIz3vuxx91aTwLizyqS1h9GDA
	cNhfvp9gWp3tXLZhAf1bLAI3HqNoQeFjorUezJM18iD7G43oiNJA4V6NYHwD3q9inP+UE82I4diHZ
	/EZAP3sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkaR9-0000000Cd2S-3gU9;
	Thu, 14 Mar 2024 02:03:15 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkaR4-0000000Cd1T-3dKH
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 02:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710381785; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bewfs7LtkdUE5VYo3YRUADoZIyv9PV7MvGLZllziqdk=;
	b=DP4YLmUL1RX6UWBcDb7javmcykGZKVi47aooM4DLC3pb7QhqmLVK/Tuxz9tztJLzn05GCM+qZlYuJ24zULWja/Ulf8S00LHHjy2WYS2rdTGnmKe+Pvvqv5Q466yrS9IRhpoX8EJmYvUEmEZAIkt9R3WkRoAsxxrn4bcyeiNXDrg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2QVDDR_1710381781;
Received: from 30.178.90.215(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2QVDDR_1710381781)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 10:03:02 +0800
Message-ID: <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
Date: Thu, 14 Mar 2024 10:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_190311_165351_49F28F04 
X-CRM114-Status: UNSURE (   4.28  )
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



> Didn't say this is actually in use, but a use-case that would benefit.

I will add a TODO-list to research main cluster softwares

to see if this is actually a significant use-case, after my patch merged.

I'll change my code then.

Best regards,

Guixin Liu



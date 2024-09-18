Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589D0CCD18F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RQIT4a5tH1z25/T2USQv9cn355Vk1+27Fc11DhI4WAU=; b=qQhrPTqx7ilfmJG3ufGi0LftmR
	xgWRNMjMj3YJX4a2Y+BefH27BHO6M+rniUf+DCjd9r3XjQiOAikzGRuptiQTYiXwGcMjRkX84E2ab
	j7n80oTKT9bMVIOrD0/3FruGQ39LtSGquSq206J+YW8CFXNTS8E0DDh3Nrlq/PZwY23/SDHtpJmmi
	VWgSXJ9QntIppZWAbxb6q1xiVVqwxApjPEqNy+zybYWyMewpZLfZVij/mZfVcAQ/EfejznG++d60n
	0/bjaAXYyBWI3E8ZuSLvaNEndYHzVVYv3xDa7PCfuZ+qe9FdM82wGxQisbl0WUiUlcExg2LPzQZUi
	FVcvzZMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqq6o-00000007p30-2zLc;
	Wed, 18 Sep 2024 08:32:22 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqq4y-00000007ohs-1ZK3
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 08:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726648225; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RQIT4a5tH1z25/T2USQv9cn355Vk1+27Fc11DhI4WAU=;
	b=ox0loyPeAaiGL0jLKg6AedfJixlPc+CML/qSAXEzvM7WeKD3rVZvCrNXH8OurHOsGUjxe4I8jD0BJ2JEGY/n9GUJMP2V2Reuu5mXcizBVyJWJGKgDPcPs7OAj3Kr91wJaHoYbBnvAPsWJ7j4mVr0NrZiNHhG+/5B/HYoCpVSNmc=
Received: from 30.178.81.111(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFDU3mY_1726648221)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 16:30:22 +0800
Message-ID: <7de19019-7503-4ccd-a283-cfd4f1b7543c@linux.alibaba.com>
Date: Wed, 18 Sep 2024 16:30:21 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
To: "hch@lst.de" <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
 <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me>
 <43565275-d71b-4c51-9a5c-b528e6387614@nvidia.com>
 <e9e9a7c1-44af-43b3-b2df-8290849eeb67@linux.alibaba.com>
 <20240705164532.GA1642@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240705164532.GA1642@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_013028_624318_F879B1A3 
X-CRM114-Status: UNSURE (   5.70  )
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

Hi,

     My apologize for not being able to continue my modifications 
recently, I have been assigned to other work over past half year, I will 
resume my modifications soon to get this patch merged.

Best Regards,

Guixin Liu

在 2024/7/6 00:45, hch@lst.de 写道:
> Hi Liu,
>
> did you manage to get back to this?  I just played around with the
> feature to test my RFC 9561 implementatiomn and it would be great to
> get it merged.


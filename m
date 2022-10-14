Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EF1C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Oct 2022 02:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcjI1z1cK/h/Tavr9Qovc/OJb4JM0OSGrDs/E00EgoA=; b=xvAEUA4Ns25xSr9b00gR+zU+HD
	5y4nEKu86Yg7jLzIxGvqd9AaahK7FG2NdNW8DaNSqWcjNJKgiWjUTAYonbKJAfyC9VY4SvNpPTS7D
	U6UmbMiaaiPPsNgZzuqXk8jw5hoh8rbpTKGn8yXXT23VPdu8D2S+4R3id21QDyV2NXEdoSGs+SFpd
	hhRBFBKA2uslq5VMSsiyUIuMKXlLg+Qdz/XGL+9TiBGR64+PwqLsEK+KU3WcflQqX7DU1+YNZPC/+
	3ufHHZ2t6ZPDX3aKnq1Cs8EzjNnL3621wyLyG7aK5TQrDJPjuj3D7E/XSwBlvNjTjXzGcjEmuAq23
	vCGSz1rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojACo-00DO9w-Ea; Fri, 14 Oct 2022 02:13:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojACn-00DO9X-K3
	for linux-nvme@bombadil.infradead.org; Fri, 14 Oct 2022 02:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LcjI1z1cK/h/Tavr9Qovc/OJb4JM0OSGrDs/E00EgoA=; b=nQGDLoHKCfMvfDSmaqi8f+KX8m
	Chp3dwLLUuJqxpXvarG2BdMtM4qoja0nsJteEsA6pz+OOt1/l6dvg+d/iDO1NmARr180uPtfcvPFF
	VvDVyBx7abGGqmBaWhT6/SoNqZS3IBVL5UaNGTjd1pZz4t+F0T9/p0rCD3cIEGWIhrwm+RNackS7H
	i7JiwwIEcimM9SuF0obNngREeHXTjqsN1xWR/hthZX4mdAIFIm/sJtgrnzqMjh8RtdWihi4YIu4gZ
	MKsungoXeCvg6UOOvuUfVGs81dg44WtAAX9lySX4IwomZvcpqe2Ekl9PK31hxIzh8sVvVv4Lr/F5+
	wLZ8uIMA==;
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojACc-003Gcb-VL
	for linux-nvme@lists.infradead.org; Fri, 14 Oct 2022 02:13:41 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpVCv6jcNzmVDm;
	Fri, 14 Oct 2022 10:08:11 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:12:48 +0800
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e785f247-7ae1-ef26-6dd2-d7379fc739e6@huawei.com>
Date: Fri, 14 Oct 2022 10:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_031339_212337_28FB0191 
X-CRM114-Status: UNSURE (   9.20  )
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



On 2022/10/13 22:32, Chaitanya Kulkarni wrote:
> On 10/13/22 02:44, Chao Leng wrote:
>> This set improves the quiesce time when using a large set of
>> namespaces, which also improves I/O failover time in a multipath environment.
>>
> 
> by how much and what are the problems exits with current timing needs to
> be documented, i.e. add quantitative data if you are posting patches for
> time/performance improvement.
Theoretically, every synchronize_rcu/synchronize_srcu need to wait more than 10ms.
Now nvme quiesce all queues of namespace one by one, The more namespace,
the longer the waiting time.

The test result:
Test Scenario: nvme over roce with multipathing, 256 namespaces
When send I/Os to all namespaces, simulate a path fault, the fail over waiting time
is more than 20 seconds.
After analysis, it was found that the total of quiesce waiting time for 256 namespace is
more than 20 seconds.
After optimization, same scenario the fail over waiting time is less than 1 second.
> 
> -ck
> 


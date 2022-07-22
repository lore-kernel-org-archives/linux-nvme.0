Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31157C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HX0n8fzFvPbJniLBSe2fq8jftoxSDrA+jKIc7iTsWOM=; b=lZEmP6eMRGrMsCa1QNUptVePZF
	pIBJBDjzCXJgBKqkXEO80WDXfBtQ0b56c58iZiDnBbihNPyWrxLKrirKEfYLgOG7OIFB8OVg8Qte5
	abDdJ4eQ29vZpUVHlYhKQGEpnDWDI9RlxuFX7rHonIt0PqZSExNruPJeTBCdkIaRSjbdb68oFJwMU
	YNhgPvE2zxNfoGIHPU4R5vuoxGgbMh1lJrAcpBlzsoegEzdLAqozCyyIqbj8hBuaLxk3WZ5sgpnHO
	pcxl7jtE+lTQR1P1CmAyss1WiVN56tQidyqKXp73t27iBhQPBwXTAuIIAIfjgwOSGY1PJ17nbikxj
	z9VConog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpNt-0025Uq-NX; Fri, 22 Jul 2022 09:55:49 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpNq-0025MF-Ms
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 09:55:48 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lq4Vt4J6czgYjt
	for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 17:52:54 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 17:55:41 +0800
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
Date: Fri, 22 Jul 2022 17:55:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220722094648.i6w3dymag3mfjpuo@carbon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_025546_935909_4868D944 
X-CRM114-Status: GOOD (  10.29  )
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



On 2022/7/22 17:46, Daniel Wagner wrote:
> On Fri, Jul 22, 2022 at 05:37:42PM +0800, Chao Leng wrote:
> 
>> Maybe we should not check the host_iface, because it is not used in the controller
>> management code. If some users uses these parameters incorrectly, it may result in
>> unexpected behavior.
> 
> Currently we only allow 1:1 setups. Checking if we use different network
> interfaces allows n:1 setups.
> 
> Obviously, if the user has a invalid IP configuration etc things will
> break apart but this is true for almost anything.
We should add the N:1 related controller management first, and then add
the host_iface cheching. Thus it might be better.
> .
> 


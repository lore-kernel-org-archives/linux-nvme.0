Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE0C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WDxfLZOFm8LMDUhkoU7IfhmVpmZssV6SOKwzfnPuG4=; b=r7Rxcr7uJy9tskMMw72EttmKRE
	6FwjMbCHO1iPWErvgAX8NXIx8N1NU+J1EMsGXm0WjOmZK8iZGiUKHpHugUCVmSVJ3gmdXjXq5wLLu
	SgHLWSp/VD2azo/gsgKsw6Q8kVelwXkgC/rEAX0BbhdxVcqZRUtNDfWdDor76tH+l6J44lCWMwy4M
	fLuw8DsKKGsA43wS26CxWao+53j1On8/9GXRAFp1OOLC7zeL/eE6P3a45nIQHkdlbMkDtuUuu/Ge6
	L55lopt+XoCU1hlRJN9MZx8NVQMvUwrdKM1lFnzL/2oSfzdM1na/2MDkA/yku9T/Phau7VTA8cm4K
	5I+KEoKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohopN-0009Sd-UK; Mon, 10 Oct 2022 09:12:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohopK-0009RJ-Qu
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 09:12:00 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmCjX7282zVj70;
	Mon, 10 Oct 2022 17:07:28 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:11:52 +0800
Subject: Re: [PATCH] nvme: allow ioctl to submit io command with dif for
 NVMeoF
From: Chao Leng <lengchao@huawei.com>
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
References: <20220803094436.23407-1-lengchao@huawei.com>
 <YuqX7dur94Vr1PIA@kbusch-mbp.dhcp.thefacebook.com>
 <61e30057-2f2b-5f1a-371b-f6dd43d9b939@huawei.com>
Message-ID: <2441ae85-7c9b-ae71-1b7f-6fa4fb13f682@huawei.com>
Date: Mon, 10 Oct 2022 17:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <61e30057-2f2b-5f1a-371b-f6dd43d9b939@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_021159_077261_AA1DA746 
X-CRM114-Status: GOOD (  18.24  )
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

Hi, Keith
     Any other comments on this patch?
     Is there any chance that this patch can be accepted?

On 2022/8/4 11:00, Chao Leng wrote:
> 
> 
> On 2022/8/3 23:44, Keith Busch wrote:
>> On Wed, Aug 03, 2022 at 05:44:36PM +0800, Chao Leng wrote:
>>> If nvme over fabrics support t10dif, NVME_NS_EXT_LBAS and
>>> NVME_NS_METADATA_SUPPORTED of ns->features will be set to 1.
>>> Now nvme_submit_io do not allow the metadata if NVME_NS_EXT_LBAS of
>>> ns->features is setted. Indeed It should allow the metadata if both
>>> NVME_NS_EXT_LBAS and NVME_NS_METADATA_SUPPORTED of ns->features are setted.
>>
>> I'm not sure. As a passthrough interface, don't you want to set up the host
>> buffers with the inline metadata instead of relying on the HBA to splice
>> separate ones?
> If HBA support t10DIF, we need the HBA to verify the metadata for end-to-end DIF.
> So we need set up the metadata separately.
> Two scenarios:
> 1.Test whether the HBA verification meets expectations when specify data and metadata.
> 2.The user wants to use the capability of end-to-end DIF through IOCTL.
> If the HBA does not support T10DIF, Keep the old behavior.
>>
>> If you really want to control this kind of thing, it would be better to use
>> NVME_IOCTL_IO_CMD instead of NVME_IOCTL_SUBMIT_IO.
> NVME_IOCTL_IO_CMD is a universal interface, of course, it can work well.
> But nvme-cli do not support customized commands, and it is not friendly to use.
> We can use nvme write/read simply, it looks better.
>> .
>>
> 
> .


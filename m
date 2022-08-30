Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF09DECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPVp7+lDeYvhmvvs/+BPvaw7ZUijAnPf9adJwqWb40E=; b=SXGsK8RS8v9/SI0c3uPdB0aZJZ
	ZpOhtg93AtOKpBdbEAsAgIR4p2ZJH+dRNgpzpMdcKkglCjqaKHdvazU18UTxlSVRBzESamgl/Ibc0
	rQHAOtKTSkovOYekUmFzVZVmj4owYZo9pY+yUXVw56OdA0X0pREzORR7G6x4fe/gkjofUQPUO1oC6
	ZLeadpyZ6Ax2t/t6+uIJmLKssV1FPuBt+zUJvm65Ut0MLE7Eucq25+jDDfq48rXLvZdeVtdIN3Y10
	kSQPZhl8fxXlGPhWM+15OyovrLtFGsy5xzHw8l9WAHHcg7UpWdvrCJH3VL6p2tS60lowtnlhORmsw
	20TejiNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0CL-00Gm38-0E; Tue, 30 Aug 2022 12:18:29 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0CE-00Gm29-Sc
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:18:27 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH5pV2gsPzkWLD;
	Tue, 30 Aug 2022 20:14:42 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:18:20 +0800
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <d8c62800-bc37-eaff-8af4-9f9b450edaaa@huawei.com>
Date: Tue, 30 Aug 2022 20:18:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_051826_616295_43ABD2D2 
X-CRM114-Status: GOOD (  17.30  )
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



On 2022/8/29 23:10, Keith Busch wrote:
> On Mon, Aug 29, 2022 at 05:56:39PM +0300, Max Gurtovoy wrote:
>> On 8/29/2022 4:16 PM, Chao Leng wrote:
>>> On 2022/8/29 18:43, Max Gurtovoy wrote:
>>>> On 8/29/2022 11:12 AM, Chao Leng wrote:
>>>>
>>>> You can mention that also in iser, if supported, the default is to
>>>> use IP_CHECKSUM for DIX and not CRC.
>>> According to DIX define:DIX = IP_CHECKSUM.
>>> To reduce CPU utilization, the end-to-end DIF for SCSI protocols is
>>> DIX-DIF when supported by hardware.
>>
>>  From what I re-call DIX was protection between host_buff -> host_device and
>> DIF was protection between host_device -> target_device.
>>
>> If now its defined as DIX == IP_CHECKSUM and DIF == CRC please mention it
>> somehow in the commit message.
> 
> Where is this coming from? The NVMe command set spec says this is the
> difference between DIF and DIX:
> 
>    The primary difference between these two mechanisms is the location of the
>    protection information. In DIF, the protection information is contiguous with
>    the logical block data and creates an extended logical block, while in DIX,
>    the protection information is stored in a separate buffer.The patch do not conflict with nvme spec. DIX just be used
between host_buff -> host HBA. host HBA->target still use DIF.
> 
> Regarding CRC vs IP Checksum, the spec also says this:
> 
>    In addition to a CRC-16, DIX also specifies an optional IP checksum that is
>    not supported by the NVM Express interface.
NVMe do not support DIX, this should refer specifically to PCI,
but NVMe over fabrics can support DIX.
The NVMe base spec says:
Additionally, support has been added for many Enterprise capabilities like
end-to-end data protection (compatible with SCSI Protection Information,
commonly known as T10 DIF, and SNIA DIX standards), enhanced error reporting,
and virtualization.
> 
> So DIX support doesn't imply IP checksum. Even if the host device can support
> it, the target device can not report it uses that guard type.
DIX just be used between host_buff -> host HBA. The target do not care.
> .
> 


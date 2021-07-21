Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA33C12002
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 09:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632436109F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 09:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632436109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqafmFhf7OTafEAfzYu9CwdlVkZMuaf5PVcKBEjBQeo=; b=jxDiuGKVB2zPT6jrZBCjqPfMcs
	UW7rBt23vEy3FAD18V0fOlNUMURnkTOxCCA2aKvRnTKDjPQRv6twFY3Bl49VxyJ3lPyRJHjTL+Wdg
	zRIR/FbaBpO8ECoRwBxkRhkuoz8X4pQATYw2a8+kPPDvJoDtbCfaKgqODMJ42JJauxcfJBUTs5+bs
	Vg2+9GIlgMHKQPzoQCvPg2BLO/MURdIo2RbHNYQUhXn4rnEDj0c03F6czhIcZOGpJrMjB4NbYFlZ4
	dlcEv50Om7k/nsUm5OtN00TDPMJzyH+cN8IyB+5GuQlPeatIM/Yivzf3Cmy838fFsBpdxSJpItcLc
	4af7Ez9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m68SU-00F5F8-5b; Wed, 21 Jul 2021 09:24:06 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m68SH-00F5DK-1u; Wed, 21 Jul 2021 09:23:54 +0000
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GV8s41q2Hz6D8mK;
 Wed, 21 Jul 2021 17:08:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 11:23:41 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 10:23:41 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
Date: Wed, 21 Jul 2021 10:23:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPd7IGFZrsTRfUxE@T590>
Content-Language: en-US
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_022353_292853_7BB938AB 
X-CRM114-Status: GOOD (  11.26  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21/07/2021 02:40, Ming Lei wrote:
>> I think that you should see a significant performance boost.
> There is build issue, please check your tree:
> 
>    MODPOST vmlinux.symvers
>    MODINFO modules.builtin.modinfo
>    GEN     modules.builtin
>    LD      .tmp_vmlinux.btf
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o: in function `smmu_test_store':
> /root/git/linux/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3892: undefined reference to `smmu_test_core'
>    BTF     .btf.vmlinux.bin.o
> pahole: .tmp_vmlinux.btf: No such file or directory
>    LD      .tmp_vmlinux.kallsyms1
> .btf.vmlinux.bin.o: file not recognized: file format not recognized
> make: *** [Makefile:1177: vmlinux] Error 1

Ah, sorry. I had some test code which was not properly guarded with 
necessary build switches.

I have now removed that from the tree, so please re-pull.

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

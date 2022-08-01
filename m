Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FC7C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tb5UD0RVTngDo4KAHCL36Yzidj4TqIVQ6b5ghYsbySs=; b=wVo3pgSssOr+pg78nvGX+xKUJi
	+TEqh3IIgshONr6AGOSGXQEktYrF1blDG3LXYid5lGJc2ti4YpnYxTnVUbDnpOKdwVwTTph8PkJXa
	ENmL/wM/htUfVA3Q/71axju0DUu8QTMLLlXAX7Iya+Hp9CC3c1mj6doWNpEqJW50RCEi41CXbfkma
	Q3c/oEyqDAH+wGQDKuEJXytbybjs9Jpzxf2OwaiJZZLr1Si1jQlsAs5QrJlUYyPA0tVJnfB3Yw+j4
	iYO+SDG5RuPAfI3vfoiWzihAjFiKtm3DtotUlUt3zA80V+Zsi+OWuRNBygUA8alHfeTYgXUF6aiOc
	/nz1N1YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oISF2-004luV-ON; Mon, 01 Aug 2022 10:01:41 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oISEu-004lpC-Db
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 10:01:34 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxD7Z1XXMzWg28;
	Mon,  1 Aug 2022 17:57:30 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 18:01:28 +0800
Subject: Re: NVMe write protection support
To: Gilles Buloz <Gilles.Buloz@kontron.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <90b10a73-4c32-4a84-97b4-88f5a926c771@huawei.com>
Date: Mon, 1 Aug 2022 18:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_030132_703150_8994012B 
X-CRM114-Status: GOOD (  12.27  )
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



On 2022/8/1 16:36, Gilles Buloz wrote:
> Dear developers,
> In case an NVMe module has a write protection feature, what is the best  method for the NVMe to tell the kernel it is write protected (if any),  and how the kernel should handle a write to such a module ?
Suggest: set the NSATTR of namespace to 1 when identify namespace.
> As computer manufacturers, we had a request from some customers to have the NVMe module fully write protected (fpr safety). So we asked our NVMe manufacturer partner to add thiss feature to their NVMe. But the problem is that if a write is done to this module while it is write protected, the kernel treats it as "critical medium error" (giving something like this in the dmesg : blk_update_request: critical medium error, dev nvme0n1, sector 977537456 op 0x1:(WRITE) flags 0x800 phys_seg
>   2 prio class 0).
> OK, no write should be attempted if the write protection is enabled, but this critical medium error is maybe too much because the disk is actually not damaged and read is still possible.
> For SATA devices I see that we have a message like that in dmesg : "sd 6:0:0:0: [sdb] Write Protect is off", but nothing like this for NVMe. So maybe the write protection is not supported/expected for NVMe devices ?
> Thanks
> .
> 


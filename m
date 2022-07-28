Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B3C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4DlwrAw0M2kamvORLSYpECKJY1f/zvMl5pLNbxcqBU=; b=qXAtEOxltsvnYOiz4rEwDeylGh
	mWmWcAWQvhE1WoAmsyzgpYhLpQ15KfmBBKguwsxgUtHdppQ5bj4CP9/upCb9CIIDpJo5ALuCCo/8j
	Pd5KXL05pdvuBSYSxfCp6Gn1qJ2LZDL2iSPDztnU1Wxw62ZnD94YOjbJRQfBQHAWFPCXdxkKX1oQ2
	1L33r4uPnePWwI3F9KBccupzka9qOYNW/4GJY5bkXmvOduDoPtQyYHBoCnlS5t2jtpd1gkYK9SYJP
	Is47zEwNVcBZj3D/ark9+AlSfkYtv7QLl9pKszCI9szRpJ2N92xtCD5D7Zv6iNJNJiuk7luwI+FxX
	CDetE9CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGsCK-002I24-9H; Thu, 28 Jul 2022 01:20:20 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGsCG-002Hyb-Dw
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 01:20:19 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LtXq55cVMz9swR
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 09:18:57 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:20:08 +0800
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
 <20220722100932.tyjljbccwv47tg4z@carbon>
 <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
 <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
 <37845bb2-c868-938b-8aed-cbc18594b9d6@huawei.com>
 <20220726071845.i2sq2p3c6e6hoa7h@carbon>
 <dee8e066-c898-1d48-eb78-668a0bb94d11@huawei.com>
 <20220727080304.vlgrszlqmbnbpyin@carbon>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <19f7118a-2028-0d48-c120-8af16d619cac@huawei.com>
Date: Thu, 28 Jul 2022 09:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220727080304.vlgrszlqmbnbpyin@carbon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_182016_837644_9B95F6BE 
X-CRM114-Status: GOOD (  21.72  )
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



On 2022/7/27 16:03, Daniel Wagner wrote:
> On Wed, Jul 27, 2022 at 02:52:25PM +0800, Chao Leng wrote:
>> host_iface is different with traddr and trsvcid.
>> traddr is required opt, trsvcid can be specified or the default.
>> host_iface is NULL if without specified. It is same with host_tradr.
>>
>> For example:
>> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0
>> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
>> According to your patch, the second will be treated as a duplicate.
> 
> Correct. And incidentally this is a duplicate :)
> 
>> It is similar like this:
>> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -w 192.168.154.50
>> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
>> This will be treated as a different new.
> 
> Yes, though if in this case eth0 has only IP 192.168.154.50, it would be
> a duplicate.
> 
>> host_iface and host_tradr are similar opts related to host outgoing.
>> host_iface and host_tradr may or may not be specified.
>> The check logic should be consistent.
> 
> I see. The comment nvmf_ip_options_match() on this topic says the whole
> logic is a bit 'rough'. Bringing iface_host into this picture makes the
> whole logic even more complex. it's possible to use iface_host and
> host_traddr combined. That's why I thought it would be a good idea to
> make it more restrict.
> 
> I suspect the correct solution would be to inference each option set
> which actual configuration is used. Not sure if it is worth the
> hassle. Is there any real harm with duplicate connections, except
> performance? >
> Even with this patch, it's possible to do something like this here:
> 
> # nvme list-subsys
> nvme-subsys0 - NQN=nvmet-test
> \
>   +- nvme0 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=eth0 live optimized
>   +- nvme1 tcp traddr=192.168.19.54,trsvcid=4420,host_traddr=192.168.154.50 live optimized
> 
> It is a duplicate connection...
> 
> I don't mind relaxing the check but the question is should it combined
> with the host_traddr logic or stay separate?
It's really troublesome to make strict judgments. Unexpected repeated connections
in special cases should be acceptable, because the harm is almost negligible and
the probability of actual occurrence is very low.
A bit more strict or relaxing both can be acceptable. but it should be same
for the host_traddr and the host_iface.
> .
> 


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF08C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3If5uj5iVMkkgiwAVWzPfwqhWX+3z2oN2AObDbXF+ME=; b=VbI8PYfqGpSn6bYrxl59yD2Cdt
	T+KZevJcv0ukirRHERLS7jQlxaHqTJEYP+oMAgLE/6wjmmQAIwH8VwhBkfwLHOBtd302JpuEnMgry
	FJOS02VvX5gikr7M5S4EJNlvezEaT26Jvc59mEIYmHWeGI5zefe31JWYaru2W51HjN+7dGD5QXvO5
	5ruc1deH2X7uxZo4fYOUHBWriCmZAPOXrkHRcO98rgEPQyL/1E4cIspHZHx7Ex+7Yu2NluLrHBmn/
	ppP1YyM9sISF3FwvnmO6OENzVNbbl9vSUiOdW6Y+vzNlE4T0euhmRiuGIvjn9yiBFlRW45pNKedu9
	9qINQzOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGauS-00ABUA-TW; Wed, 27 Jul 2022 06:52:44 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGauL-00ABKG-PU
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 06:52:42 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lt49s1Cy1zWfxg
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 14:48:33 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:52:26 +0800
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
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dee8e066-c898-1d48-eb78-668a0bb94d11@huawei.com>
Date: Wed, 27 Jul 2022 14:52:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220726071845.i2sq2p3c6e6hoa7h@carbon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_235238_093917_D9C0CFE9 
X-CRM114-Status: GOOD (  17.22  )
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



On 2022/7/26 15:18, Daniel Wagner wrote:
> On Tue, Jul 26, 2022 at 10:11:41AM +0800, Chao Leng wrote:
>> Checking host_iface is similar to host_tradr, so some suggestions:
>> First, move these codes near checking host_traddr.
> 
> We have several places where we have the same sequence as above, that is
> traddr, trsvcid and then host_iface, e.g. nvme_class_uevent,
> nvmf_free_options, nvmf_get_address. So I'd say we should stick to this
> and not start introducing a new ordering scheme.
> 
>> Second, the checking logic should be the same as that of host_tradr.
> 
> What do you mean with this? We compare the host_iface with strcmp. It is
> exactly the same thing we do with traddr and trsvcid.
host_iface is different with traddr and trsvcid.
traddr is required opt, trsvcid can be specified or the default.
host_iface is NULL if without specified. It is same with host_tradr.

For example:
nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0
nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
According to your patch, the second will be treated as a duplicate.
It is similar like this:
nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -w 192.168.154.50
nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
This will be treated as a different new.

host_iface and host_tradr are similar opts related to host outgoing.
host_iface and host_tradr may or may not be specified.
The check logic should be consistent.
> 
>> It might be better to add a helper to implement host port attribute
>> checking. Of course, this can be considered as a separate patch.
> 
> As far I can tell Christoph is not a big fan of small one-line helpers
> especially if there is only one call place. But as you said, that's his
> call :)
> .
> 


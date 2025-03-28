Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D935C36010
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FHCnRp6GLQ5ORD/4LZmaFUTfEROP2/k4RJrK9bsiF50=; b=2BRNPvSSgTzAIjLiu8xXJmv4Gp
	n06Fr9g7F+02KMVlCYqPNz2S/GcTGfhrIgsFFOCu48PT/nwJ9wI1BSgXz4R5HdHZNDNMkOPl6QmC3
	TEujHK/qZ8j1eCTCqlmlNa4Ikv+cvwcHO5HFCyyPHVelsdl9vSON1lupmwtW750QNuFi+TVPIvolP
	h+BZ8hKUoLbih9cymVW/xr48ToVhwcZEiF6CiJgZA3Zx18OftfBfo/d6llkazupFtA6rijl0U8UJ4
	jkDes2Dnn1s6eFzWjFbitzh3GKaYLau2EbLOXwsLR4c7SpVLNTfa+HKL3XBL/MYAvY9SF6IalEQnM
	EdcZutUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty5RC-0000000CxYo-1PNi;
	Fri, 28 Mar 2025 08:51:38 +0000
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty5R8-0000000CxVQ-3e3J
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 08:51:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 2FF0D7C0112;
	Fri, 28 Mar 2025 16:51:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [10.32.170.7] (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609374T281456915968368S1743151883941832_;
	Fri, 28 Mar 2025 16:51:26 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: david.laight.linux@gmail.com
X-RCPT-COUNT: 10
X-LOCAL-RCPT-COUNT: 2
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <0c713a00741ca5df5945f2cc684f6b26>
X-System-Flag: 0
Message-ID: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn>
Date: Fri, 28 Mar 2025 16:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Replace sock_create with sock_create_kern
To: David Laight <david.laight.linux@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
References: <20250324031708.1687164-1-shaopeijie@cestc.cn>
 <20250324210421.526c1729@pumpkin>
Content-Language: en-US
From: Peijie Shao <shaopeijie@cestc.cn>
In-Reply-To: <20250324210421.526c1729@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_015135_059587_0A3C4DBD 
X-CRM114-Status: GOOD (  17.36  )
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

On 3/25/2025 5:04 AM, David Laight wrote:
> On Mon, 24 Mar 2025 11:17:08 +0800
> shaopeijie@cestc.cn wrote:
> 
>> From: Peijie Shao <shaopeijie@cestc.cn>
>>
>> Replacing sock_create() with sock_create_kern()
>> changes the socket object's label to kernel_t,
>> thereby bypassing unnecessary SELinux permission
>> checks. It also helps to avoid copy and paste bugs.
> 
> Does sock_create_kern() hold a reference on the namespace?
> It hadn't used to and sock_create() will take one.
> 
> 	David
> 
>>
>> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
>> ---
>>   drivers/nvme/target/tcp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 4f9cac8a5abe..216afacc8179 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -2049,7 +2049,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
>>   	if (port->nport->inline_data_size < 0)
>>   		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
>>   
>> -	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
>> +	ret = sock_create_kern(current->nsproxy->net_ns,
>> +				port->addr.ss_family, SOCK_STREAM,
>>   				IPPROTO_TCP, &port->sock);
>>   	if (ret) {
>>   		pr_err("failed to create a socket\n");
> 
> 
> 

Thanks for reviewing. Indeed, there is a netns UAF issue. The call path 
sock_create() -> __sock_create() -> inet_create() -> sk_alloc() takes a 
reference of the given netns, however sock_create_kern() doesn't perform 
this step.

Sorroy the patch for the host side '[PATCH] nvme-tcp: fix selinux denied 
when calling sock_sendmsg' has the same problem.

I will send a v2 patch to fix both host and target side soon, thanks.





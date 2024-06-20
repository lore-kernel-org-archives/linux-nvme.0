Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5C4C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMgpiO7XXJbbO8j3ZAhY3Lys2PBBjFpdYx0jJM8Zwkw=; b=saxyHAkmpDg5LtpdLvB49DqXzO
	Z7YLyQ7YYVMHEXJMSPbTllAb/eUKYLG2MxDg6NfNLrTRMuU7DeykXEDdkRsnnlqheM6gIYUQRO74Q
	2RpkxINz1dUAoebpmB/j+Od6FPHd2ABwNZi/WdOQnpGJrojvshRHJWWoAmN5IVBLtyLOaAsXmDGnR
	8Fdngl5IV1ke4oRCAKsmmEM6vw1osjryR1J1yYyQ0lO0VaZZc+q5TLB/Z/3Rd2B2a6cp66oVCDCnq
	mzwCmn6hNdjdgmipZlKda177Hd/LPbpIJxznQ0RMxK/Sqp6QX+UdovVZEdYOHSHAvwC3qYtb8RsTg
	JMzwvnEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKLzf-000000069cN-0ugX;
	Thu, 20 Jun 2024 17:54:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKLzc-000000069bV-2LlN
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 17:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718906078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMgpiO7XXJbbO8j3ZAhY3Lys2PBBjFpdYx0jJM8Zwkw=;
	b=diTTsVkekuxKjxjfEEszDXlVpfnmgYOD11TZEdlaPA6+MkfDWYXXxB47DsCVqxl6hbTFcX
	vpUhZl+qUCbNoOa7Mb5+Y0oiZr1Z7UPaPY+oFfLQjIY0s4deKGMRMx4GjMoMiXLAywJSue
	CHuxjk26S0fyetJupNvZrGaiw93RefE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-CQAyhTLRM0OCviwsiz3tag-1; Thu,
 20 Jun 2024 13:54:33 -0400
X-MC-Unique: CQAyhTLRM0OCviwsiz3tag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D19A19560BE;
	Thu, 20 Jun 2024 17:54:32 +0000 (UTC)
Received: from [10.22.34.111] (unknown [10.22.34.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F09E3000218;
	Thu, 20 Jun 2024 17:54:29 +0000 (UTC)
Message-ID: <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
Date: Thu, 20 Jun 2024 13:54:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, jrani@purestorage.com,
 randyj@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20240619163503.500844-1-jmeneghi@redhat.com>
 <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240620065641.GA22113@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_105440_709003_5E547006 
X-CRM114-Status: GOOD (  21.62  )
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

On 6/20/24 02:56, Christoph Hellwig wrote:
>> [jmeneghi: vairious changes and improvements, addressed review comments]

>> -static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>> -		int node, struct nvme_ns *old)
>> +static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>>   {
>> -	struct nvme_ns *ns, *found = NULL;
>> +	struct nvme_ns *ns, *old, *found = NULL;
>> +	int node = numa_node_id();
>> +
>> +	old = srcu_dereference(head->current_path[node], &head->srcu);
>> +	if (unlikely(!old))
>> +		return __nvme_find_path(head, node);
> 
> Can you split the refactoring of the existing path selectors into a
> prep patch, please?

Yes, I can do that.

>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>> +		int iopolicy)
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	if (old_iopolicy == iopolicy)
>> +		return;
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> 
> What is the atomicy model here?  There doesn't seem to be any
> global lock protecting it?  Maybe move it into the
> nvme_subsystems_lock critical section?

Good question.  I didn't write this code. Yes, I agree this looks racy. Updates to the subsys->iopolicy variable are not atomic. 
They don't need to be. The process of changing the iopolicy doesn't need to be synchronized and each CPU's cache will be updated 
lazily. This was done to avoid the expense of adding (another) atomic read the io path.

So really, the nvme_subsystems_lock only protects the list_entrys in &nvme_subsystems. I can move the WRITE_ONCE() update to 
after the lock, but then were did the caller - nvme_subsys_iopolicy_update() - get it's reference for the nvme_subsystem* from? 
And there's no lock or synchronization on the read side.

The subsys->iopolicy has always been unprotected. It's been that way from since before this change.

At least... that's my read of the code.

>> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
>> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
>> +			subsys->subnqn);
> 
> The function is not really relevant here,  this should become something
> like:
> 
> 	pr_notice("%s: changing iopolicy from %s to %s\n",
> 		subsys->subnqn,
> 		nvme_iopolicy_names[old_iopolicy],
> 		nvme_iopolicy_names[iopolicy]);

How about:

pr_notice("Changed iopolicy from %s to %s for subsysnqn %s\n",
                 nvme_iopolicy_names[old_iopolicy],
                 nvme_iopolicy_names[iopolicy],
                 subsys->subnqn);


> or maybe:
> 
> 	dev_notice(changing iopolicy from %s to %s\n",
> 		&subsys->dev,
> 		nvme_iopolicy_names[old_iopolicy],
> 		nvme_iopolicy_names[iopolicy]);
> 

The dev_notice will only spit out the nvme controller number (e.g. nvme5c5n3) and that's not very helpful to the user. I want to 
include the subsystemNQN because that's easily visible and something the user can see on both the storage and the host.

Example:

root:resultsF > echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys11/iopolicy
[Thu Jun 20 13:42:59 2024] Changed iopolicy from queue-depth to round-robin for subsysnqn 
nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a

root:resultsF > nvme list-subsys | grep -A 8 nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a
nvme-subsys11 - NQN=nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a
                 hostnqn=nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0034-5310-8057-b2c04f355333
                 iopolicy=round-robin
\
  +- nvme8 tcp traddr=172.18.60.14,trsvcid=4420,src_addr=172.18.60.4 live
  +- nvme17 tcp traddr=172.18.50.15,trsvcid=4420,src_addr=172.18.50.3 live
  +- nvme12 tcp traddr=172.18.60.16,trsvcid=4420,src_addr=172.18.60.4 live
  +- nvme10 tcp traddr=172.18.50.13,trsvcid=4420,src_addr=172.18.50.3 live

/John



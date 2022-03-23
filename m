Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E1AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Em+s5I1UZkD824vgJyPQmDhKlpUa0yHReM4ncvYNG7E=; b=0QRtScEjIb/FvlVM83Vwsp+lNH
	spxahF5qIhHQLIUKE/FSnmaMD3KF5MdOLWLaFrlmO7yTyztrsPqzwHGMc816ahRDUDgYppy+u5DjQ
	K0s9ZEwyyUuhVqmeQVUb26VmEbpb6nzMSfJbbAWN9cls5LbVmPT/Ho1BZRc7SFfmLPlc8sTjAXSmN
	NF7y/cxG7vxhujRyIscwdXzKgEZe5X11l4qqThXYg2n0fqwvkRk35crAxe9PUUkqYwKLMqR5kdX8T
	9A0K/0yxIUTHyBlsTjwlaYdajW8uYXLXh9fmqJKssigmFggxN8CmqrkwdwY8DSJzIqQmGi99BMyfQ
	NyGDPRsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX5L5-00EXmP-Q6; Wed, 23 Mar 2022 18:04:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX5L2-00EXlK-D4
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 18:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648058643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Em+s5I1UZkD824vgJyPQmDhKlpUa0yHReM4ncvYNG7E=;
 b=dGj2Ntgm0SIVgya5F+/6Fl7Wk5N7NoP6ouz79uocZk6gxMypSQ4DHrzBbR097rzkC2O16V
 vpuFT7LHmGPcvjXyPoxEGzu7eD17DMlBZRm0/FrKYxEOOmHvv68S7o1av97sBOTISdC1FK
 8B1Y++uRIlRCBiC/CSIkA5uk8R0edCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-8w0O7YrvMlK7QhAhgkw9XQ-1; Wed, 23 Mar 2022 14:04:00 -0400
X-MC-Unique: 8w0O7YrvMlK7QhAhgkw9XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C7ED3801EC1;
 Wed, 23 Mar 2022 18:03:58 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5094B40D0166;
 Wed, 23 Mar 2022 18:03:57 +0000 (UTC)
Message-ID: <84ec6970-c02a-900e-a9e5-0d39236226ba@redhat.com>
Date: Wed, 23 Mar 2022 14:03:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
 <DM8PR06MB770422A304E46F38AD030A21F1189@DM8PR06MB7704.namprd06.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DM8PR06MB770422A304E46F38AD030A21F1189@DM8PR06MB7704.namprd06.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_110404_561953_D0D9B3A5 
X-CRM114-Status: GOOD (  17.68  )
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

On 3/23/22 13:34, Knight, Frederick wrote:
> Please don't make this assumption:
> 
>    3. Hosts that support Authentication can then disconnect from the Well Known
>       Discovery Controller and re-connect with the Unique Discovery NQN. These
>       hosts should expect an AUTHREQ=1 response.
> 
>    4. Hosts that don't want to support Authentication can ignore the SUBTYPE 03h
>       Log Page Entries and operate normally. This would include legacy hosts.
> 
> There should be NO assumption that subtype 03h requires authentication.  It should use AUTHREQ only.

Well, then maybe we need to figure that out.  I agree that any wire protocol that depends on an assumption is
a broken wire protocol.

> And, while using authentication with the well-known discovery controller NQN is not recommended (and not very secure), 
> there is nothing that prevents the setting of AUTHREQ=1 when using the well-known discovery controller NQN; 

This is true. According to the protocol AUTHREQ=1 can be returned to any Fabric Connect command. But if Discovery Controllers 
start doing this, they will probably break 99% of the running hosts out here.  So that's whats preventing it from happening.

> so again, I would suggest you do not just assume that is true, and that the host still use AUTHREQ to control authentication
> no matter what/who you are talking to.  As for targets - they are free to implement what their customers require.

I don't disagree. I'm just saying, the realities of turning on AUTHREQ=1 with the exiting well known discovery service is:
you will have many host that suddenly fail to interoperate.

/John



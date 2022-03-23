Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6B6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uv9DFQwFQox6VhI0HRr/1+nB0EBKfs6NlpDAC/gp/Mo=; b=xO/Am5vgbdayD4RyBa4Tc66Qer
	0XHfHoiMvo/2Kkp4rA6YteiiKezLPoOaC9HAS8oZum3v7tuRQog1glAp0YbYxMiB7Tes+06YXKAWX
	am5BqiKcOkflq5uCzNbIgwwRzWlgnIIoA3DUBDUYdaDqSj7ediSFpOUepb26HhupoT4bU4H0E58of
	jo7Imd6m7XgTY0mxuDMSmoNyLX+VL7edmPxQSUckql4aurgRuXCjxp+x76CGMdz/ylg2TAXPTdra/
	WHSjVNGxEa3GQxeBtIWcfBSBWTXR7DAro3Z8JIIVEKJLHQuTGjEAnxZSTT9vn9cOpRyxCwN5Hd5zr
	3YmXwJyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX59n-00EVxE-PI; Wed, 23 Mar 2022 17:52:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX59k-00EVw2-DV
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 17:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648057943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv9DFQwFQox6VhI0HRr/1+nB0EBKfs6NlpDAC/gp/Mo=;
 b=IgD9HStl0Tu+dYmkfj/49nZ/iyZn/zLtkqrAzAIDRl9HZNohd7UawqCPMCyt8ZSjc4V4VX
 42q4gfipS7CyNcauxynP2Z8iIdxCU/x7qnSbyVowcsRO3bEWo6Wu3+PMwaWUgouFAHq1eP
 5Ygy3ZFqFFIxvBCFyOZALdzWCQTlv04=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-9MmHzajNNKesSJnEraaZbw-1; Wed, 23 Mar 2022 13:52:19 -0400
X-MC-Unique: 9MmHzajNNKesSJnEraaZbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 362FE1C0782D;
 Wed, 23 Mar 2022 17:52:19 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1D8C112132C;
 Wed, 23 Mar 2022 17:52:13 +0000 (UTC)
Message-ID: <139e5856-591a-78af-8ce7-5c0766addfb5@redhat.com>
Date: Wed, 23 Mar 2022 13:52:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 "Knight, Frederick" <frederick.knight@netapp.com>,
 Chris Leech <cleech@redhat.com>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
 <20220323172326.GA2280@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220323172326.GA2280@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_105224_561405_201EC192 
X-CRM114-Status: GOOD (  15.73  )
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

On 3/23/22 13:23, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 01:17:32PM -0400, John Meneghini wrote:
>>
>> Hopefully, with some kind of a design like this, both legacy (non-authenticating)
>> and new (authenticating) hosts and discovery controllers can interoperate.
> 
> This makes much more sense.  But why would a host that is part of a PSK
> setup even use the well known discovery controller at all? Whatever > mechanism is used to share the key should also distribute the actual
> discovery controller to be used and avoid that entire step.

I agree. But that's not what FMDS is doing. They are basically trying to re-invent
the wheel by adding all kinds of arguably redundant mechanisms to the spec. I think
this is what happens when you let a bunch of storage engineers design a network. Just
read TP-8010 and TP-8009 to see what I mean.

I proposed TP-8014 because I saw the mess coming and I wanted some simple way to make
things work... at least with authentication.

/John



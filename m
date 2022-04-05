Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2CDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2C2rj4pohpt4L1hhyeDmm8YrXyUmRsjwq3zR3bboOM=; b=dYCy1vwwMGxu+BqulHpYOaFBA/
	rSG0bp7GL4perhvRojQMtBcF+wfSMuPECzbgKf3d/Rdsi2/0wJD82LaYVPVGtwjmFY3IzfMRwAJbw
	hzM7cuH+oOz6jXBlDz5Ad/4nncqG6iPhGe7LOnVTzxeDDdLFddevEYbRhF9QFuYfF1WZ1OtCuskK0
	3eDVSuaZYDQeeXb8T9O/4uIzDR9CQxvb0fGzO+8WVc3SA694I6/zWYwhMJeQZ9m0WaaHLO7c3hNDh
	R7ftzSQJEGnpKBAMcf0A9kwPhDiSwJcQ32H1lzV1co8qeuH+GQftogJqR+s+5kjkaaehAqtLvp4tS
	Pg2Cl0Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbmMR-0020wr-Hy; Tue, 05 Apr 2022 16:48:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbmMO-0020vI-JR
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 16:48:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649177328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2C2rj4pohpt4L1hhyeDmm8YrXyUmRsjwq3zR3bboOM=;
 b=fdTFMmBpAqPvE/UnEIuMI9wjFBSzZdm/1TDFeZwb67F+FTFGxmOdY9g3a1GRvnO0GQD6kC
 QYB30JBfdbI1Ke5FdYfj7IBCTQAPPNHXgvLLQc6uehzT2hnMGQKW1lMY40hHDJffDl+SHA
 QhCGEFjBsly/Nh8fONjA7mAUKwpNv9Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-juBYBoGZPlGPnwKkXJfr6g-1; Tue, 05 Apr 2022 12:48:45 -0400
X-MC-Unique: juBYBoGZPlGPnwKkXJfr6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FDFC3C14CCC;
 Tue,  5 Apr 2022 16:48:45 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 049B640FF407;
 Tue,  5 Apr 2022 16:48:44 +0000 (UTC)
Message-ID: <9be1e68c-00aa-3547-9cb5-b3ca302e209b@redhat.com>
Date: Tue, 5 Apr 2022 12:48:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
 <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
 <20220329104806.00000126@tom.com>
 <15f24dcd-9a62-8bab-271c-baa9cc693d8d@grimberg.me>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <15f24dcd-9a62-8bab-271c-baa9cc693d8d@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_094852_757371_D0B8ADA8 
X-CRM114-Status: GOOD (  13.98  )
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


On 3/29/22 03:46, Sagi Grimberg wrote:
>> In addition, distributed storage products like the following also have
>> the above problem:
>>
>>      - The product consists of a cluster of servers.
>>
>>      - Each server serves clients via its front-end NIC
>>       (WAN, high latency).
>>
>>      - All servers interact with each other via NVMe/TCP via back-end NIC
>>       (LAN, low latency, ECN-enabled, ideal for dctcp).
> 
> Separate networks are still not application (nvme-tcp) specific and as
> mentioned, we have a way to control that. IMO, this still does not
> qualify as solid justification to add this to nvme-tcp.
> 
> What do others think?

OK. I'll bite.

In my experience adding any type of QOS control a Storage Area Network causes problems because it increases the likelihood of 
ULP timeouts (command timeouts).

NAS protocols like NFS and CIFs have built in assumptions about latency. They have long timeouts at the session layer and they 
trade latency for reliable delivery.  SAN protocols like iSCSI and NVMe/TCP make no such trade off. All block protocols have 
much shorter per-command timeouts and they expect reliable delivery. These timeouts are much shorter and doing anything to the 
TCP connection which could increase latency runs the risk of causing the side effect of command timeouts.  In NVMe we also have 
the Keep alive timeout which could be affected by TCP latency. It's for this reason that most SANs are deployed on LANs not 
WANs. It's also for this reason that most Cluster monitor mechanisms (components that maintain cluster wide membership through 
heat beats) use UDP not TCP.

With NVMe/TCP we want the connection layer to go as fast as possible and I agree with Sagi that adding any kind of QOS mechanism 
to the transport is not desirable.

/John



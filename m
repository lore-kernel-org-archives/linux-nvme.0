Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0430E7F14F
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPXChj6T7Ido19L24z0k9XpleZe9CHFwg4bZjyoKjm4=; b=zT+3tIZM1pKIWzwOr8OJzsscLj
	ZVtK2yhKPbrfgrcYxbOrB5NwW+i9i57aw8Lsivb6XjetFVg50HWJSyNSsPbHiA9pa5qE/46xutudN
	ObKzQQcu/607Z5O+tFBLDckZ1QRah7I+hkN0b6Nv8gsfgQLqeyeWkiL/MvCekrHuQ0OKLupAD8gUu
	QCL0rOasgmSEGC12fTXm8jQdrhNsmRtyneteLfTrdaF/n9oJlztKwhQvKj2mhEOKBYYdh5tYq+9N4
	sxuf/9s135X1caQqlCNp9/98ueyrOwiR7c9d4OTYq8R8WqU71/9jJrnzyb5OdJocz0p8Jv6iHXEwd
	26SPH6kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUMM-000yxu-13;
	Wed, 27 Sep 2023 13:13:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUMJ-000ywl-2u
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695820419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPXChj6T7Ido19L24z0k9XpleZe9CHFwg4bZjyoKjm4=;
	b=DCBFWDpMBEBf25YpvLv36yN++c/yJw4kEMYuxfmlopwvFTzRFTM+iSLvs87U8Ml+ANiS9k
	FcEC+vdwGyWmvXc7JT72tWZ1sQPEGNSsSRATqn/dkRyziJDyvSAY2v14k9FK4SthG6L3Pu
	yW7oyfNdscq6V/CXv9NMI0h4PfEHpA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-4SMaajh-Np6ao2ivM5CsTg-1; Wed, 27 Sep 2023 09:11:56 -0400
X-MC-Unique: 4SMaajh-Np6ao2ivM5CsTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EDD5811E7D;
	Wed, 27 Sep 2023 13:11:54 +0000 (UTC)
Received: from [10.45.226.76] (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D9F4614171B6;
	Wed, 27 Sep 2023 13:11:52 +0000 (UTC)
Message-ID: <0d1c8cfd-99e7-228f-8ccb-94461a4f776a@redhat.com>
Date: Wed, 27 Sep 2023 15:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] nvme-multipath: add "use_nonoptimized" module option
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-4-emilne@redhat.com>
 <5df9a1f8-fb2d-4819-88a8-a3f3c32cdab5@suse.de>
 <c6c4cbab-9f03-f7f2-6985-c627f2aaece8@grimberg.me>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <c6c4cbab-9f03-f7f2-6985-c627f2aaece8@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_061344_028926_A23B658E 
X-CRM114-Status: GOOD (  23.39  )
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

Ewan I discussed this patch and agreed this is not something we want to go upstream. It was only included here for completeness. 
This patch was only used to increase the number of active paths during the testing of patches 01 and 02.  The test bed Ewan used 
originally had only 4 35Gbps nvme-tcp contollers (2 active optimized and 2 active non-optimized).  He used this patch to change 
the multi-pathing policy and enable the use all 4 controllers - resulting in 4 active paths.

Those test results can be seen here:

https://people.redhat.com/jmeneghi/.multipath/test1/A400-TCP-FIO-RR.ps - round-robin io tests
https://people.redhat.com/jmeneghi/.multipath/test1/A400-TCP-FIO-QD.ps - queue-depth io tests

After sending these patches upstream on Monday Ewan and I built a new test bed with 8 controllers - 4 active optimize paths and 
4 non-optimized paths.  This provided a true multi-path test bed and the use_nonoptimized patch wasn't needed.

In addition, this test bed has a mixed controller subsystem consisting of 4 32GB nvme-fc controllers and 4 100Gbps nvme-tcp 
controllers.  This provided the optimal mix of active optimized controllers paths with different transports that have inherently 
different latency characteristics.

  [root@rhel-storage-104 ~]# nvme list-subsys
nvme-subsys3 - NQN=nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a
\
  +- nvme10 fc traddr=nn-0x2027d039ea98949e:pn-0x202cd039ea98949e,host_traddr=nn-0x200000109b9b7f0d:pn-0x100000109b9b7f0d live
  +- nvme11 fc traddr=nn-0x2027d039ea98949e:pn-0x2029d039ea98949e,host_traddr=nn-0x200000109b9b7f0c:pn-0x100000109b9b7f0c live
  +- nvme12 fc traddr=nn-0x2027d039ea98949e:pn-0x2028d039ea98949e,host_traddr=nn-0x200000109b9b7f0d:pn-0x100000109b9b7f0d live
  +- nvme13 tcp traddr=172.18.50.13,trsvcid=4420,src_addr=172.18.50.3 live
  +- nvme2 tcp traddr=172.18.60.16,trsvcid=4420,src_addr=172.18.60.4 live
  +- nvme3 fc traddr=nn-0x2027d039ea98949e:pn-0x202dd039ea98949e,host_traddr=nn-0x200000109b9b7f0c:pn-0x100000109b9b7f0c live
  +- nvme4 tcp traddr=172.18.50.15,trsvcid=4420,src_addr=172.18.50.3 live
  +- nvme9 tcp traddr=172.18.60.14,trsvcid=4420,src_addr=172.18.60.4 live

I shared the performance graphs for this testbed using these patches at the ALPSS conference today.

Graphs of inflight I/O on 4 Optimized paths (2 FC, 2 TCP) with round-robin:

https://people.redhat.com/jmeneghi/.multipath/test2/A400-TEST1-FIO-RR.ps

and queue-depth:

https://people.redhat.com/jmeneghi/.multipath/test2/A400-TEST1-FIO-QD.ps

Also a included is a graph showing the combined number of inflight I/Os on all paths, plotted with both RR and QD:

https://people.redhat.com/jmeneghi/.multipath/test2/A400-TEST1-FIO-MAX.ps

What we see in these graphs is that RR is only using 1 of the 4 possible paths, and with QD all 4 paths are used about equally 
while the maximum inflight I/Os count almost doubles.

Hope this helps.

John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

On 9/27/23 13:31, Sagi Grimberg wrote:
> 
>>> Setting nvme_core.use_nonoptimized=true will cause the path
>>> selector to treat optimized and nonoptimized paths equally.
>>>
>>> This is because although an NVMe fabrics target device may report
>>> an unoptimized ANA state, it is possible that other factors such
>>> as fabric latency are a large factor in the I/O service time.  And,
>>> throughput may improve overall if nonoptimized ports are also used.
>>>
>>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>>> ---
>>>   drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>> No. Please don't.
>>
>> There's a reason why controllers specify paths as 'active/optimized' or 'active/non-optimized'. If they had wanted us to use 
>> all paths they would have put them into the same group.
>> They tend to get very unhappy if you start using them at the same time.
>> (Triggering failover etc.)
> 
> I have to agree here. This is effectively a modparam that says
> all paths are optimized regardless of what the controller reports.
> 
> While I do acknowledge that there may be some merit to use non-optimized
> paths as well, but its almost impossible to know some latent optimum
> path distribution. Hence the host forfeits even attempting.
> 
> If the controller wants all path used, it should make all paths
> optimized and the host can examine QD accumulating on some paths
> vs others.
> 



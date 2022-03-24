Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB72C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 01:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57/X1s7l/qlSLDj4cGb9Biv9oLiQ0+IJV8gwXWvwJQ0=; b=XNGl0wPguFqXnLDHImxDSpQSVt
	x18G/cv4RAByFe/HDVbcmb0zdzc/7eL8ltERGysuQETzdGQeoXvTb9Rao1NdRuwC2FlKEL+WpyjVr
	ZTyrwmyDc41KWLb2rfElUuuqEYwK6KH9OC0NoJUF5OL4HTjV1TsSEZU/5svjZ6YFtnBbLZUWtLDPc
	HhgtnNZ1ncqTE7LqIEaVtbvi7B99Pnwhy9TggiC2EzBU+8Um6YxoazBCsXCVBQ85wggA3Dpc74D45
	dspRh68G6h6jSrje9lKqD/sMhv3pvESWvmKEE3cYG0DOdiBESDhYkPzolzXjVbDNr0keaVno6EeRr
	KOOga/LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXCYg-00FLDS-4r; Thu, 24 Mar 2022 01:46:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXCYc-00FLCx-L8
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 01:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648086392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57/X1s7l/qlSLDj4cGb9Biv9oLiQ0+IJV8gwXWvwJQ0=;
 b=RgSyB+AOb1GowQZvrU3BuAMmHKC9Q2bHissl/ZJXfikae/W82rOCNkmYLlXOMvW+lYcLke
 LifymhUe9/ZApBwRIaLup0ySO49bXgCLvAG+rB3ZH4/caNhq7OZwd64HKhOhRhy0432ukz
 4czQUZgrvB1FGe+JUGNZpLCA6j463jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-dsdbW1upPDqAB5RzPU0sqQ-1; Wed, 23 Mar 2022 21:46:29 -0400
X-MC-Unique: dsdbW1upPDqAB5RzPU0sqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E088185A7B2;
 Thu, 24 Mar 2022 01:46:29 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32D389E60;
 Thu, 24 Mar 2022 01:46:29 +0000 (UTC)
Message-ID: <4dbf85e5-ca56-e689-842d-9d9c5edc7f67@redhat.com>
Date: Wed, 23 Mar 2022 21:46:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to discovery
 subsystem
From: John Meneghini <jmeneghi@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-3-hare@suse.de> <20220315080908.GB3082@lst.de>
 <42045e78-dce4-2653-e882-46c48cc6e64e@grimberg.me>
 <20220315090030.GA4321@lst.de>
 <c0735336-4c4e-c355-51db-14ac56a2e8e3@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <c0735336-4c4e-c355-51db-14ac56a2e8e3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_184634_787901_08958630 
X-CRM114-Status: GOOD (  15.33  )
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

Never mind.  I see it has been reverted.

jmeneghi:centos-stream-9(nvme-5.18) > git showc 0c48645a7f39
0c48645a7f39 2022-03-15T10:39:26+01:00 1647335676  (tag: nvme-5.17-2022-03-16, nvme/nvme-5.17, nvme-5.17) nvmet: revert "nvmet: 
make discovery NQN configurable" [ Christoph Hellwig / hare@suse.de ]


On 3/23/22 20:52, John Meneghini wrote:
> On 3/15/22 05:00, Christoph Hellwig wrote:
>> On Tue, Mar 15, 2022 at 10:57:35AM +0200, Sagi Grimberg wrote:
>>>> It is a fairly recent addition by you and without nvmetcli support, so
>>>> maybe we can revert this entire attribute to redo discovery controller
>>>> handling, but as-is this patch seems rather broken.
>>>
>>> I think we could, I doubt anyone uses this interface at this point...
>>
>> Then please send a revert for "nvmet: make discovery NQN configurable"
>> against the 5.17 tree ASAP.  That way it will only be in 5.16.
> 
> Has this patch been reverted yet?
> 
> I don't see the revert.
> 
> jmeneghi:centos-stream-9(nvme-5.18) > git logl -200 --grep="nvmet: make discovery NQN configurable"
> 626851e9225d 2021-10-20 1632292519  nvmet: make discovery NQN configurable [ Christoph Hellwig / hare@suse.de ]
> jmeneghi:centos-stream-9(nvme-5.18) > git branch --contains 626851e9225d
>    5.17/scsi-queue
>    5.17/scsi-staging
>    master
>    nvme-5.17
> * nvme-5.18
> 
> 
> 
> 
> 



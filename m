Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E63C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/htFtEdYYuufVafz95ApUj6yn3ltGDpk3/pYODHJ54=; b=JfHRrf/IyyI3rBStm6EQLSUZYV
	5yCmTkeLYNiyq7QQCYcItSLqcuq0v3ov7/ro5nv9bborSm+wHix9wlVXxRvgI9tI9NKRz3wRmsooZ
	0HdpxgPW1dmQlOVx74feW33kyY4dI17FoIjxE55Gc2Au1htJ8XQNLoVvZ6iPAg8lX1X3OsBnTwcKo
	n+xsAshsvh2XT49Nxs3d7u9Dvgf1+GyYR+O8XoneI4jJnnAnrH9zuGOWuGCgiVEGLw6y5ABUdsGN3
	AClTxqELRm2K4I48WmBnj3GFk4UHUjsvYmI2WcTrhOikw2GGoQTvtAQWGr1ywGGsY4DlJoeqvtbAN
	rst7g8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Vb5-002dRH-0s;
	Tue, 07 Nov 2023 23:35:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Vb1-002dQa-0q
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 23:35:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699400097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/htFtEdYYuufVafz95ApUj6yn3ltGDpk3/pYODHJ54=;
	b=dtH2+Ypux3qaT39xsGIxB6/52eyQ8D49FIdLg+spluwwMX/oXzUTaiIm1Mpkc5AroY1c+D
	g5h/f+yJsx13movpumUCb60iZ0cxscF4xWAbciSXkrBlorFP30PN6VULlYJTtf3cXtQT/B
	gSRJELf/PEoXNLzURVSgVra6tSPJ9es=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-PJ5_UjbhOMOPXGA56zRJjA-1; Tue,
 07 Nov 2023 18:32:54 -0500
X-MC-Unique: PJ5_UjbhOMOPXGA56zRJjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90EDA28EC102;
	Tue,  7 Nov 2023 23:32:54 +0000 (UTC)
Received: from [10.22.10.156] (unknown [10.22.10.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C860502A;
	Tue,  7 Nov 2023 23:32:54 +0000 (UTC)
Message-ID: <d87cff63-a0da-43ca-979d-38657b351511@redhat.com>
Date: Tue, 7 Nov 2023 18:32:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Ewan Milne <emilne@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "tsong@purestorage.com" <tsong@purestorage.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20231107212331.9413-1-emilne@redhat.com>
 <e7b8ee83-c63d-4b65-b446-2bdbac0084e4@nvidia.com>
 <CAGtn9rnEqs0OKeg52+UCwkvU2kiVkMKDXe-pxDUHn-77i5e9sQ@mail.gmail.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CAGtn9rnEqs0OKeg52+UCwkvU2kiVkMKDXe-pxDUHn-77i5e9sQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_153459_392314_4AA548D9 
X-CRM114-Status: GOOD (  16.45  )
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

Here are the slides with the performance numbers I presented at ALPSS.

https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

This is the same information I posted in:

https://lists.infradead.org/pipermail/linux-nvme/2023-September/042371.html

/John

On 11/7/23 16:56, Ewan Milne wrote:
> Yes, we have some graphs.  John M. presented them at ALPSS and there were
> some earlier ones at LSF/MM.  I'll see if I can put up the latest set
> for download.
> 
> The basic issue is that with round-robin, requests for most/all of the
> tagset space
> can end up on a path that is responding slowly, so we see a
> significant imbalance
> in path utilization.
> 
> 
> -Ewan
> 
> On Tue, Nov 7, 2023 at 4:46 PM Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>>
>> On 11/7/23 13:23, Ewan D. Milne wrote:
>>> The existing iopolicies are inefficient in some cases, such as
>>> the presence of a path with high latency. The round-robin
>>> policy would use that path equally with faster paths, which
>>> results in sub-optimal performance.
>>
>> do you have performance numbers for such case ?
>>
>>> The queue-depth policy instead sends I/O requests down the path
>>> with the least amount of requests in its request queue. Paths
>>> with lower latency will clear requests more quickly and have less
>>> requests in their queues compared to "bad" paths. The aim is to
>>> use those paths the most to bring down overall latency.
>>>
>>> This implementation adds an atomic variable to the nvme_ctrl
>>> struct to represent the queue depth. It is updated each time a
>>> request specific to that controller starts or ends.
>>>
>>> [edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>>         and compilation warnings, updated MODULE_PARM description, and
>>>         fixed potential issue with ->current_path[] being used]
>>>
>>> Co-developed-by: Thomas Song <tsong@purestorage.com>
>>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>>> ---
>>>
>>
>> any performance comparison that shows the difference ?
>>
>> -ck
>>
>>
> 
> 



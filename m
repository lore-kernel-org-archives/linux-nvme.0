Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBA2C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KyOyMy//HFcxns0f7jijZb/TUu6PDOes3felM7DzeZM=; b=N/LfxE8bfo1o3gM7JuBhOSnjaz
	hmnv58Ltb8rGD5+fgQk1rW5Z0Ux0ho2Pg4yDtY2xSKSQ5yW5qBzUJMmxqo9IQZENVVbUbuY/Bo8SB
	sYVMShKBtcjOeNlmdwOimz+YrhQABTEs2mWjG8Kr3jHTSrQwX5nsysw7e0EqkPbSwnKLL1HteVKPM
	Nw1rj5EsZ8DC5EjMPC2B26Q+7MtMPQIortEsZvIfOboZ7upz6/ZogfazMIaP17J3mDHyJFIovQSwI
	tMttRQGZHWHlRyP6Bp9svl/1sIWw1deAUMtFzy1dYra6AvIfIzQc/u5E2jweFvEcTjo7JlXDG0TlH
	p7zogGMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAzF-00000006knS-0jLt;
	Thu, 23 May 2024 16:08:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAzA-00000006kmy-3Uku
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 16:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716480486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyOyMy//HFcxns0f7jijZb/TUu6PDOes3felM7DzeZM=;
	b=ANTsKeVRH6fM9iuYMI1vxZFbmRVF308A557tAQpgpCnQK8qXH4vluBIzSVFfQwJFdNDhM+
	gNrmTji0jlX+E4XUa6ek065sl5yyLpf3dacgcSh1AyDCw5vGr8ndJ07RzSu874MzPGsgIr
	9O1XczyIEPXg2eGebT/dQvw3Iycp8EI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-D2cjl7g-NJm4Mvu64GOBsw-1; Thu, 23 May 2024 12:07:59 -0400
X-MC-Unique: D2cjl7g-NJm4Mvu64GOBsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3864C800CA5;
	Thu, 23 May 2024 16:07:59 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3D811054820;
	Thu, 23 May 2024 16:07:58 +0000 (UTC)
Message-ID: <f1f52715-78b3-42e1-bc25-9984dd178321@redhat.com>
Date: Thu, 23 May 2024 12:07:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <20240523081443.GD1086@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523081443.GD1086@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_090808_985594_3B6543E3 
X-CRM114-Status: GOOD (  20.95  )
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

On 5/23/24 04:14, Christoph Hellwig wrote:
> Oh, and there is really something of with the patch format.
> 
> First the subject line is completely wrong, this should be:
> 
> nvme-multipath: implement "queue-depth" iopolicy.

Will fix.

> On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
> 
>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>        and compilation warnings, updated MODULE_PARM description, and
>>        fixed potential issue with ->current_path[] being used]
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> 
> Second the patch author needs to be the first signoff.  I'm not entirely
> sure who is supposed to be the author, but either it should be Thomas,
> or if the patch has changed so much that it's someone else the original
> signoff should turn into a Co-Developed-by.

This patch was originally authored by Thomas Song, an intern who worked at Purestorage. The original patch was almost a year 
ago. Thomas no longer works for Purestorage, and he is no where to be found. Ewan and I have both made many changes since then, 
but the basic concept, which adds a controller scoped atomic counter in nvme_find_path(), remains the same. Ewan worked on the 
patch for several months, trying different counter implementations, all in an effort to avoid the atomic counter.  However, 
nothing else worked and in the end this patch retains the essential features of Thomas Songs original patch.

I'd like Thomas to get credit for this patch, so I've changed the author from Ewan Milne to Thomas Song.

As for the Co-Developed-By: checkpatch.pl is insisting that that each "Co-developed-by:" be followed by a signoff.

   jmeneghi:linux > scripts/checkpatch.pl --git HEAD
   WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
   #26:
   Co-developed-by: Ewan D. Milne <emilne@redhat.com>
   [jmeneghi: vairious changes and improvements, addressed review comments]

   WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
   #28:
   Co-developed-by: John Meneghini <jmeneghi@redhat.com>
   Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/

   total: 0 errors, 2 warnings, 197 lines checked


So this is what I currently have for a message log.

Author: Thomas Song <tsong@purestorage.com>
Date:   Tue Nov 7 16:23:29 2023 -0500

     nvme-multipath: implemented new iopolicy "queue-depth"

     The round-robin path selector is inefficient in cases where there is a
     difference in latency between paths.  In the presence of one or more
     high latency paths the round-robin selector continues to use the high
     latency path equally. This results in a bias towards the highest latency
     path and can cause a significant decrease in overall performance as IOs
     pile on the highest latency path. This problem is acute with NVMe-oF
     controllers.

     The queue-depth policy instead sends I/O requests down the path with the
     least amount of requests in its request queue. Paths with lower latency
     will clear requests more quickly and have less requests in their queues
     compared to higher latency paths. The goal of this path selector is to
     make more use of lower latency paths which will bring down overall IO
     latency and increase throughput and performance.

     Signed-off-by: Thomas Song <tsong@purestorage.com>
     [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
           and compilation warnings, updated MODULE_PARM description, and
           fixed potential issue with ->current_path[] being used]
     Co-developed-by: Ewan D. Milne <emilne@redhat.com>
     Signed-off-by: Ewan D. Milne <emilne@redhat.com>
     [jmeneghi: vairious changes and improvements, addressed review comments]
     Co-developed-by: John Meneghini <jmeneghi@redhat.com>
     Signed-off-by: John Meneghini <jmeneghi@redhat.com>
     Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
     Tested-by: Marco Patalano <mpatalan@redhat.com>
     Reviewed-by: Randy Jennings <randyj@purestorage.com>
     Tested-by: Jyoti Rani <jrani@purestorage.com>



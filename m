Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAEFC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZE79ngHiPYMsknTkJKUUOGKy5jq6C5Ns0sjPmwNKqk=; b=zqSbsQzcRC60dP3Ko6u2d9PWKH
	dFq7Kkay/kQfaP1q9OY8kt1vFCOrrxDkexwgoOlUv6hcZ82d59hC8pBloJnooZNgSDFihE1iJ1MjZ
	locXZVSAZHShbqWaHeW5ylDD6lGVwADRe82rY+S+5kbgjllOwzrVz92AjQd9dYHT69zjxM1PXCKLA
	PPi6oI8fYmdNi8fYN3TAh93AKhBkaaoZxinFZvY2uk8H4007ZVVXjqE7S7meboBVZIAnqxO+yZ0sL
	DP5F10Tkbu/fhO6maUuRJ6vGYZNpMoWtH/qfhGlZ3b3gnSVP5+B5tDt5Fcts4Lj+jHbBjdaKxRAO1
	sHK9YKFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Qiv-00000000DSU-21TE;
	Tue, 21 May 2024 14:44:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Qis-00000000DRV-18xL
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 14:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716302653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZE79ngHiPYMsknTkJKUUOGKy5jq6C5Ns0sjPmwNKqk=;
	b=ZD51Cer6X/hmwtWqV4eTwRFJb59s8MlbZPQ0CHHMQK4J9k5+77sCh521/YST2nOTAOHZ4J
	0BbQ7V8VmJ4sEgPDBBuTlslrTpW3F1hP1nDpdyoEBawFJEzah+NGpMicMVNf9eyvQ9HNP1
	Cz6IBlvoN30PLCUiqYp3ffhPCvsYOkg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-eIJdvIDPPYGPxIVEjg4jmQ-1; Tue,
 21 May 2024 10:44:10 -0400
X-MC-Unique: eIJdvIDPPYGPxIVEjg4jmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45D4B3C0C2C4;
	Tue, 21 May 2024 14:44:09 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 409B31C008BB;
	Tue, 21 May 2024 14:44:08 +0000 (UTC)
Message-ID: <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
Date: Tue, 21 May 2024 10:44:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_074414_648187_D18A1503 
X-CRM114-Status: GOOD (  13.23  )
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

On 5/21/24 06:16, Sagi Grimberg wrote:
>>>
>>> Exactly, nvme_mpath_init_ctrl resets the counter.
>>
>> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
>> or some place that is called on every controller reset.
> 
> This however raises the question of how much failover/reset tests this patch has seen...

I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM 
last week.

It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise 
do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could 
negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.

I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in 
nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any 
extensive retesting.

/John



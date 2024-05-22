Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB67AC25B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQOQAWJQIzcAHCNFbYDIo9HGTOvHOu6U/O7t/i3sg5Q=; b=Hq5XFZNnRwQlGVvrCSoNs8T2l8
	L42lhelYxABLdjMutqRykw9pfGYgA0Fekou1Ggl2DQwe5z6jhin1BJ4IWo29fJXgx+CI5H19DJgru
	cujnIzw/nrTpgw0M/IoUX7DGGNyzsX3H2BPitpc1ijQJfHenQ87U49E/Rw1v50k64ZHw48Z36o4mL
	I3WcJd+rbW2tuqV4+BhQTsmmLynazr0YeheHivR09QBJStxUbtFoav3D4BmdgiQGP20ujyJ5ZZVvG
	EamFR8ydq4Tf3MqapgpNmXwn4asy0roSdR4Q9r4ltim4IyzZqB3kMwSkcF9jb6FTfJ4ndjxe1ioeV
	WSkWOHgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9llr-000000031H7-0w0g;
	Wed, 22 May 2024 13:12:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9llm-000000031Gb-06bv
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 13:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716383554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQOQAWJQIzcAHCNFbYDIo9HGTOvHOu6U/O7t/i3sg5Q=;
	b=aLIFVmS2ZTvzpcWi9LqW1RWNTdMYVqUVbRHvJ4zQTGgGZQxRLIzla30pmuOYWP9ehJN1LK
	mvI+8w1UgI11GoPDIXaSjKyUK00fDt3dVZtFHa22tcLbQLB9iz6hZGQYx1njzAJ3+MCpBz
	O1JuWjbsyosIGzBrMeljSCGuTvP22Bo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Oa7STFArNvCcSFCjpvsoaQ-1; Wed, 22 May 2024 09:12:31 -0400
X-MC-Unique: Oa7STFArNvCcSFCjpvsoaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3D94800CA5;
	Wed, 22 May 2024 13:12:30 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED17A2026D68;
	Wed, 22 May 2024 13:12:29 +0000 (UTC)
Message-ID: <f1b7196c-63bd-4c80-91e3-8d44c460c792@redhat.com>
Date: Wed, 22 May 2024 09:12:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
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
 <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
 <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_061238_161380_77B3FA68 
X-CRM114-Status: GOOD (  14.12  )
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

On 5/22/24 06:48, Nilay Shroff wrote:
>> I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM last week.
>>
>> It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.
>>
>> I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any extensive retesting.
>>
>> /John
>>
>>
> I think with Keith's recent proposed patch for fixing io accounting on failover, the
> nvme_mpath_end_request() would be called even for cancelled IO and so the nr_active
> counter shall be adjusted correctly for cancelled IO requests. Having said that, IMO
> you shall consider moving initialization of nr_active counter to nvme_mpath_init_identify()
> as that's common function invoked from regular controller initialization code path as well
> the reset code path.

Agreed. I'll do that in V4 of the patch set.

/John



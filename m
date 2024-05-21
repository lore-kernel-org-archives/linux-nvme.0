Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A55C25B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xFecaKFdNpZIUStP8/Na+T+oYYUztuWZCoP2Kb73pg=; b=kwL2svOuxdmhag5dIQ8c/VdaXs
	sozliNQBC6wzylOR+sjCcRrHEtWcO2Dx0BLp6FRfT2+1IpPomBxmbgI7tT4yGw5Mez2mleG3Ph0dl
	nUboqJao+ZbOyrlyd89D/8sI8YN03+4jAFEbVo1opPJO8Idot5X78rWRtUW0coeh77Fm0OOGB3xBN
	4dhGOi2wOHDCz8B1CJJ+ODA6oCJelP8oms2jTvXle+UWNaAYgVKs32dU+y1tGF8HYgy8svRRPJney
	g08d9NPJR/I4xhJXvhOzyE40RkJEtjg0pqO8sLuGbLve5cXV2swc51oENidiaC8ov3Az6tq7ENJH5
	0qQiY7Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QzG-00000000Gjq-0auS;
	Tue, 21 May 2024 15:01:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Q0k-000000004lJ-05Wj
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 13:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716299916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xFecaKFdNpZIUStP8/Na+T+oYYUztuWZCoP2Kb73pg=;
	b=Bgfg9BMTqM+y9yeEjkMvzeGyzT94m6BSBkTVMBjhAe6ruRMf4uDBU5hk3ajoax/Ju6y/d1
	/J1jEQeb4z9J7KAe4/Aak680iDbRIP79SL7ul2d6RhAjOClv4cKhtjRFFjThEw0JACnXDe
	NFwDd/ex1GNlv/88HDd8J1sxr7XuZT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-qYX4PxAMPmarNOzC7BUlZw-1; Tue, 21 May 2024 09:58:33 -0400
X-MC-Unique: qYX4PxAMPmarNOzC7BUlZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4FCE185A780;
	Tue, 21 May 2024 13:58:32 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 128FD40004D;
	Tue, 21 May 2024 13:58:32 +0000 (UTC)
Message-ID: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Date: Tue, 21 May 2024 09:58:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_065838_373758_DFA3EB8F 
X-CRM114-Status: GOOD (  16.37  )
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

On 5/21/24 02:46, Hannes Reinecke wrote:
> On 5/20/24 22:20, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
>>
...
>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>> Reviewed-by: Randy Jennings <randyj@redhat.com>

I need to fix this. Randy doesn't have a redhat.com email address... Cut an paste error :-(

>> Tested-by: Jyoti Rani <jani@purestorage.com>
>> 
...
>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +    struct nvme_ctrl *ctrl;
>> +    int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +    WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +    mutex_lock(&nvme_subsystems_lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        atomic_set(&ctrl->nr_active, 0);
>> +        nvme_mpath_clear_ctrl_paths(ctrl);
> 
> You always reset the variables here, even if specified iopolicy is
> the same than the currently active one.
> I'd rather check if the iopolicy is different before changing the settings.

Yes, Keith pointed this out too.  This is actually a feature not a bug.  In situations were we want to "reset" the nr_active 
counters on all controllers the user can simply set the queue-depth iopolicy a second time.  I don't expect users to do this 
very often... they shouldn't be changing IO policies back and forth too much... but the ability to "reset" the nr_active 
counters during testing has been very helpful and important to do.  So I'd like to keep this.  Moreover, this is NOT the 
performance path. I don't see the point in making performance optimizations in a code path that is run once a year.

/John



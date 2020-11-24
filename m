Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7D7C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:01:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2A12076B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qa2+jmWy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIiBVRTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2A12076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tkItdecUFDDZruHdZXv74hh9/Azb75YKt4qn37EVlAM=; b=Qa2+jmWy8oz3TDS+sROIFKNu8
	RruRM1ayVOkEySl2XN5dIpl1OWn1jGeWWAHboUK5xAGkjgi5bLdq4agFxJXSHPYYP4o/3hJ2ZlOY4
	03LnQdVFLZTY5eQr3u5MzGLvLh0tAXtor2ourP5SMEmeZhuUQeWYnPMgttdbn8nrNSfTg7brLLmUg
	d7azkyEW56yjiILx2Z/G+r4zLYADzcfWsQRAE9lijz7CYFUzEn0doJGYHPaKp9c7VmhDrNw1AFhp6
	lS9FqtJmGWsVIsRqO1vloBqIn6WjIH1wJe0uTUeonVG05EV+5/YlP1hwlRFSxhQFIf5A1emjLWKIj
	r8KyS1FNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khYsx-0001hg-Ld; Tue, 24 Nov 2020 14:01:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khYsu-0001h8-3w
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 14:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606226491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ybBUCTPpM+IE7e0jQVEPGYP8RejqHf99vC6SEQa19w=;
 b=AIiBVRTI0pyRYwxoRDHuKIp5kIpFbG9TNCk+WovCHMjh6ftrD/LBKEutuR5TMg5a98N54b
 2os8ZF81w6F50RvMVaz94KOAZBrFK/iOQ1c3J6wgEYxLZTAqkH2mRiWvrC6rk5xUTwNfV8
 w6KBNcLoA6mLC7Et4FiUvoiEerSRGvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-d_-hdKFmPs60TbRbsbMUzA-1; Tue, 24 Nov 2020 09:01:26 -0500
X-MC-Unique: d_-hdKFmPs60TbRbsbMUzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBFCE835B61;
 Tue, 24 Nov 2020 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E47B6087C;
 Tue, 24 Nov 2020 14:01:22 +0000 (UTC)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
Date: Tue, 24 Nov 2020 22:01:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_090132_229567_C0127DB4 
X-CRM114-Status: GOOD (  16.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/24/20 11:23 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
>> +	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?
> Is 'ls' needed here or is 'echo' sufficient?
Actually it doesn't work without ls
$ insmod "/lib/modules/"$(uname 
-r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*"
insmod: ERROR: could not load module 
/lib/modules/5.10.0-rc5/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*: No 
such file or directory

and it works with echo, I can change to echo if you prefer
$ insmod "$(echo /lib/modules/"$(uname 
-r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || 
return $?

> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

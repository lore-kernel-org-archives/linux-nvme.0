Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA640C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 06:16:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC23120B80
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 06:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uIcV6f+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYusROjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC23120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qIOzRMep5L1R+d4tzSTmwC13g0PcmEtGNSV1bSHu8OE=; b=uIcV6f+zdpJZ1O9NbvAmPEexT
	J1lv4zVZISAQzIRccsENVcc5o2Efa9QQfIWxUU62fTpkdcskwYy1heL9LSExv8KZsFOUFgHEfkZkD
	Q1BkWZzmFcrHYwz2tJ5Cg6g2pq8odpvZwy4+o6YqPzAtpaFXtdXRbu38GbblJu7dEIddJ6vtO9qws
	WLKdSCN8ZDssnUCDdcPacLPvcYZ9buMCIVVBwWarAQeuYxsb+T1NInRvuT/2HjGieSxf1LnDyZpDb
	4C241eYwVfKJ8uLepEvKL3YpiePFL3CBPxgzqpU1R0LMvfSY5CVHNndY98X6Q8gYFk7TISO0hSXLG
	Bq47I4j3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiAa3-0007qE-28; Thu, 26 Nov 2020 06:16:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiAZy-0007pp-7E
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 06:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606371387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opxi3+VknEuLnVn5NroXrsP9PLuEVvPNB505Ha74F2s=;
 b=aYusROjXx0GUp9ZjTw+plBpEowOxPp7mVsLQJK0cG70nXmLCr8tv9bIiJLS0kLAZe44ynw
 L/89VJLprYtV6UmmCHqs/+rSAyfbujAd1qWjcYOjThFYU+k5HR0zUsYwx34Jz+ociW5zrr
 CkeXM4J7JC3UXeFH2piQUl01tZE+elI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-jhog46PbOmmLzZNNaQPcNA-1; Thu, 26 Nov 2020 01:16:25 -0500
X-MC-Unique: jhog46PbOmmLzZNNaQPcNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C238110066FB;
 Thu, 26 Nov 2020 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C650960636;
 Thu, 26 Nov 2020 06:16:21 +0000 (UTC)
Subject: Re: [PATCH V2 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-4-yi.zhang@redhat.com>
 <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <86f0b36c-b484-ee4e-26cd-d5dde35a46eb@redhat.com>
Date: Thu, 26 Nov 2020 14:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_011630_757673_8FEC902C 
X-CRM114-Status: GOOD (  15.87  )
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



On 11/26/20 11:59 AM, Bart Van Assche wrote:
> On 11/24/20 11:32 PM, Yi Zhang wrote:
>> +# Get block dev scheduler list
>> +get_scheduler_list() {
>> +	local b=$1 p
>> +	p=/sys/block/"$b"/queue/scheduler
>> +	if [ -e "$p" ]; then
>> +		scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
>> +		echo "$scheds"
>> +	else
>> +		return 1
>> +	fi
>> +}
> Can the echo statement and the 'scheds' assignment be left out? This is
> what I have in mind:
Sure, will update with V3.

> 	sed 's/[][]//g' /sys/block/"$b"/queue/scheduler
>
> Otherwise this patch looks good to me.
>
> Thanks,
>
> Bart.
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

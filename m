Return-Path: <SRS0=W9vg=7X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54553C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 07:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18816207ED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 07:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kavDkJbw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4sWQ4OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18816207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=373yH18bC9Ip0uXOLvc3yrmE2yERJENivbYNrDBn950=; b=kavDkJbwNJFAmTqnEAHeiiU1r
	QVJ7DV9by8d6ISRXJ6R9lvDIW0WGx1W2OQgK6Ttx2A4468gp4cwrv2q3YtBCh6mMkpcNQWB14ACUt
	H/+U+9uAwf52ApZ0ShShNY+4j8dU+SscQBUd3uxi0VxNZwtFD4QC5NaicYF4TZ5xAUCR4D971NC8v
	+gDTXxL1I4k2OBpshsumdOpaVspOFW6EvYfS2Y2PgRS9TMOtPcMEtk+FEeJxzQ4GLedh0e1qFKhqc
	/G+fJYsbvy/mHMElKBeinYyuoAIgBz6S5jVYLJAxCceZ11z7TmSuGgOF3a8N1QmRDd6DWfXXhQCGy
	W1borEeeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiuoE-0007lC-NU; Wed, 10 Jun 2020 07:06:02 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiuoC-0007kk-3L
 for linux-nvme@lists.infradead.org; Wed, 10 Jun 2020 07:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591772757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i082/k7X66VpKA4BArVOYwDebI6I8dBAhqufU60X7Yk=;
 b=W4sWQ4OE4G7Ni+yY9LVtOukfm6yfYmPKxNI590kvgC179nPP6bv09ojLimndOlsfelOAES
 o7MII9t4NHiSue25i7W/PP6P69plfBiDOTgzrDqHjnm3dELwaRQWDej9RmvvRZxX3qZL0e
 r+ZlZlQSuIH7oYaNPzTpWhaRxCjLKag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-mxvUOJXUPm2vgless2ibYg-1; Wed, 10 Jun 2020 03:05:55 -0400
X-MC-Unique: mxvUOJXUPm2vgless2ibYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE639835B41;
 Wed, 10 Jun 2020 07:05:54 +0000 (UTC)
Received: from [10.72.12.113] (ovpn-12-113.pek2.redhat.com [10.72.12.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA981891E2;
 Wed, 10 Jun 2020 07:05:53 +0000 (UTC)
Subject: Re: [PATCH nvme-cli] nvme-print: fix smart log temperature output in
 json mode
To: Keith Busch <kbusch@kernel.org>
References: <20200609145422.22386-1-yi.zhang@redhat.com>
 <20200609150331.GA189247@dhcp-10-100-145-180.wdl.wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <21f86bab-49cf-903d-1b66-ceaf24193d7f@redhat.com>
Date: Wed, 10 Jun 2020 15:05:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609150331.GA189247@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200610_000600_215925_D312C95E 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/9/20 11:03 PM, Keith Busch wrote:
> On Tue, Jun 09, 2020 at 10:54:22PM +0800, Yi Zhang wrote:
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>>   nvme-print.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nvme-print.c b/nvme-print.c
>> index 7414280..d63b402 100644
>> --- a/nvme-print.c
>> +++ b/nvme-print.c
>> @@ -593,7 +593,7 @@ static void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid,
>>   	char key[21];
>>   
>>   	unsigned int temperature = ((smart->temperature[1] << 8) |
>> -		smart->temperature[0]);
>> +		smart->temperature[0]) - 273;
> I usually consider json output as something to be consumed by another
> program rather than by a human, so we've not done much manipulation from
> the spec defined units. It's just a serialized representation of the
> structure.
I checked this field in the spec, it make sense to keep Kelvin here.
So drop this patch, thanks.

> If you need a more human friendly output, we can add flags to refine the
> output, but we can't just change the default reporting from Kelvin to
> Celsius since that may break existing programs interpreting the current
> json.
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

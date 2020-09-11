Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F81C43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 13:22:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABE220770
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YdyCjFHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMMNk8vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABE220770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZUy1+A06vB7/gRRyZYcfHsFB4VcwK6HBmZHBUkLkJo=; b=YdyCjFHJ1gL8RmQGCW0e7U0Klb
	jpm2DO6Wl26FQh0AIiSL3GbTLiMV80qoh7EWUeXBNOx8BZBdBuZHkRLakRVXKr30b6YM6GD1IRHRQ
	RvHx++ebAw+digpVhGVTw3jsq3ABAleP1fnQ5dxso89WBbCfrlZFnAkU6r/wiYnlSSRU5KrumM2i7
	78K/15WkEQN88GIhNgN15j/hra0xEd25pDybGmNKCT+FiHydc66dWhhW5Ungs4YnsXs0KGsluad5z
	yZySwTXOXpsRmJ6heDJnb286EKPpbjw2TQVnh1moqHnsJMBHK8VsJQVR3n8upWozW2LU/CXHiQhVv
	D3/ajbaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGj0A-0004JZ-CN; Fri, 11 Sep 2020 13:22:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGj03-0004Ix-FL
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 13:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599830518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIvp7ENEs59ZT5EizmWQhPeub3GEvIcPcgi2vsTnu6A=;
 b=CMMNk8vSu6Ot0801bjBQ+2vaoIxaexAezUq693s7D4qqfUaqmyMbnOZj5aigGNlI+XqI3P
 6KGmWvNMPtSexJ7iFlbS1V411aY5nPZXLBI57h9BA9yWeAupWB/15OgFjcn+esQf0wuF4f
 RH8CmrAMrGeWKO++woTDwJPiNblONDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-3VGP50mZM5ybnrUfUsq8bw-1; Fri, 11 Sep 2020 09:21:56 -0400
X-MC-Unique: 3VGP50mZM5ybnrUfUsq8bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A971882FDC;
 Fri, 11 Sep 2020 13:21:53 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com
 [10.5.9.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD54975121;
 Fri, 11 Sep 2020 13:21:52 +0000 (UTC)
Subject: Re: [PATCH] nvme-pci: disable write zeros command for Intel 600P/P3100
To: Christoph Hellwig <hch@lst.de>, David Milburn <dmilburn@redhat.com>
References: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
 <20200911053227.GA20950@lst.de>
From: Eric Sandeen <esandeen@redhat.com>
Message-ID: <594921ea-8853-46a9-4914-1030bc8da736@redhat.com>
Date: Fri, 11 Sep 2020 08:21:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200911053227.GA20950@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=esandeen@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_092159_650126_82191867 
X-CRM114-Status: GOOD (  17.79  )
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
Reply-To: sandeen@redhat.com
Cc: kbusch@kernel.org, david.fugate@linux.intel.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/11/20 12:32 AM, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 04:18:50PM -0500, David Milburn wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 5e07d5628864..d31e298669a9 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3153,7 +3153,8 @@ static const struct pci_device_id nvme_id_table[] = {
>>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>>  				NVME_QUIRK_MEDIUM_PRIO_SQ |
>> -				NVME_QUIRK_NO_TEMP_THRESH_CHANGE },
>> +				NVME_QUIRK_NO_TEMP_THRESH_CHANGE |
>> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> That's one amazingly buggy driver :)  Wasn't it the one with the
> corruptions with 512 byte writes as well that got fixed by the firmware
> upgrade?

Yes

> But yes, we'll have to work around it, so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph

-Eric


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

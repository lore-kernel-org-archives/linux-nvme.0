Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4EC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27D764E2A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27D764E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bnTIcQPx1wDrnDSEeHW3bzPhiKjbWhxPFW1DWNNb2RI=; b=V10r3R+c+MIBMl5ebO3qZ3qsI
	8oPVLEcaKaUnAH8SU6jlrd3K8+t/df0q9839D7mUIjrOEnuRfZtE+9HWxbseJTFpLqYRgS/y+nQ5n
	DyNtpSKBrv3eMi2aGMU0z1WMxvDxFGK8La5Gi/nl/yn2MHd060D18L/C43LaF0aHwv87aSQkxoPuL
	m+o39Cy1qboEkGJ3+hyPGPRctGYJX96OXYnxU1Qds1Mvy2vReZjWfU4mQcJJvNPdeGJOdbn4D0fPu
	WH53mZsmAK/ZHY7KXsdJDk2+FpEDnQodIJp9mgxoVRdj8SUwpTlnS/N7LvfsIZuLJP6RR0xCsKxIc
	3f9c57sEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9nUy-0005Df-QX; Wed, 10 Feb 2021 11:17:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9nUv-0005BE-RV
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 11:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612955848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1iX3udrMGlM7hEN2Fgb0eaBk6ntakqG92tYwRdnim8=;
 b=gusy+OTJLzsCastign6JMFXTavkKvk0RA+unfyEJ7KWIrG4MwLplSIOicvKbZH46R2iGAq
 p82lfnvztYeAtNT7bC7JhWwf3grIrAvrl5fqN+p6PM3UesfxyDCFUmuFdg8USpa8FMqxT8
 fsfPnD5nXjg63btBAf0gIwloAf0REnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-dtXUmr22PbKUtg-8J2K6Gg-1; Wed, 10 Feb 2021 06:17:25 -0500
X-MC-Unique: dtXUmr22PbKUtg-8J2K6Gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA5AA1005501;
 Wed, 10 Feb 2021 11:17:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C36E60BE2;
 Wed, 10 Feb 2021 11:17:24 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6773718095C7;
 Wed, 10 Feb 2021 11:17:23 +0000 (UTC)
Date: Wed, 10 Feb 2021 06:17:23 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <211078952.30654328.1612955843198.JavaMail.zimbra@redhat.com>
In-Reply-To: <YCOxjZhBTBchOq0n@infradead.org>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <YCOxjZhBTBchOq0n@infradead.org>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
MIME-Version: 1.0
X-Originating-IP: [10.64.242.157, 10.4.195.25]
Thread-Topic: nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes command
Thread-Index: Xt7/vQz4Cb/CFGgD/Q9+ZA2kLgTsbw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_061729_990894_66EB445D 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph, 

Thanks for the response,

----- Original Message -----
From: "Christoph Hellwig" <hch@infradead.org>
To: "Gopal Tiwari" <gtiwari@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
Sent: Wednesday, February 10, 2021 3:42:29 PM
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes command

On Tue, Feb 09, 2021 at 10:29:02AM +0530, Gopal Tiwari wrote:
>> For SK Hynix PE8000 WriteZerocommands exceed typical I/O MDTS
>> (Maximum Data Transfer Size) supported by the hardware. Which
>> intern fail and generate following erros :

>Well, if it works under MDTS please add a new quirk that follows
MDTS for Write Zeroes.

This was the feedback from the hardware guys, We've not tried, as the safe option would be to disable 
write zero's as spec says 

I could see from the identify controller details 

  [0:0] : 0	Single Port

mdts      : 7 <<---------- 
cntlid    : 0
ver       : 0x10300

"This field does not apply to commands that do not transfer
data between host-accessible memory and the controller (e.g., the Verify command,
the Write Uncorrectable command, and the Write Zeroes command); there is no
maximum data transfer size for those commands. "

>  In fact I wonder if we should just do that by default to be on the safe side.
Can you please help me in understanding this ..  

Thanks & regards,
Gopal Tiwari 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

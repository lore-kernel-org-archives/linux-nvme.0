Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:59:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62F564EBC
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62F564EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8ea7x5FfLgB1b/pivtrl+FDTrzxueufpBvn3kZEEKLs=; b=eVPgxCAujzLtKXx0PyoDJBTmh
	G7Pdo3vzI4p5fhqEH/AvZaPE5g+M5jVwh8ne1GoKs5gp8Y1Lmp5ryd6v9mpBSEY0U3l6ffQHrM/ic
	tRuo3rEth5sl6foAPdwGUU3SunXhPvqP161v1ZayTAFV0vdoxUN+sp/cOgAHViQTRbR4zqJl4TNQe
	/Ky+Ork4sjH6QwQavIhV+iiCAx0jAu9dX4r9ltY8FFnJZkiToS0iCG1WwFUFdYONXNUMUPWlHgKsG
	fxeILFoain1duCXF4N2FAnHgPk66JPySLjurzKqd7TEGgkJIjvMHQtIFM4S0sILGuo7/EKSB5CYTX
	eioNBQCOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9M3W-0004VP-SO; Tue, 09 Feb 2021 05:59:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9M3T-0004V2-AA
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 05:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612850358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5hNRyC34DvlxP2ypdhCZlPAtY70XoXsnwntR4ltwc0=;
 b=dQlnhc5MHXGh6sCvVL1okCkvsorru/sWmYqXWLJ2Cxw5LXvGMFou7IWuJVLdDz4EGWk99g
 eOqvl+KYRmonEdsMdyuDRzQ5B4MlG+YBpxdzjT8wfYQmX2NxIdPB/o2e/V3BRySxWChGdh
 8Ap/yTz0K2e/jGxvrkz2UpcoGkoLnYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-FDPvwWbeMCKfWZ3ABKwylg-1; Tue, 09 Feb 2021 00:59:14 -0500
X-MC-Unique: FDPvwWbeMCKfWZ3ABKwylg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4304D6D4E3;
 Tue,  9 Feb 2021 05:59:13 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 388A25D6D7;
 Tue,  9 Feb 2021 05:59:13 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2BCBE18095C9;
 Tue,  9 Feb 2021 05:59:13 +0000 (UTC)
Date: Tue, 9 Feb 2021 00:59:12 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Message-ID: <1111178699.30528215.1612850352735.JavaMail.zimbra@redhat.com>
In-Reply-To: <BYAPR04MB4965000F7E15116893D6D1BD868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
 <BYAPR04MB4965000F7E15116893D6D1BD868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
MIME-Version: 1.0
X-Originating-IP: [10.64.242.96, 10.4.195.12]
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6himZ6G0N6
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_005919_417883_45941C41 
X-CRM114-Status: GOOD (  12.06  )
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

Thanks Chaitanya, Sure. 

Regards,
Gopal 


----- Original Message -----
From: "Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>
To: "Gopal Tiwari" <gtiwari@redhat.com>, hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Sent: Tuesday, February 9, 2021 11:08:03 AM
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes command

Gopal,

On 2/8/21 21:06, Gopal Tiwari wrote:
> For SK Hynix PE8000 WriteZerocommands exceed typical I/O MDTS
> (Maximum Data Transfer Size) supported by the hardware. Which
> intern fail and generate following erros :
>
> nvme nvme0: I/O 0 QID 96 timeout, aborting
> nvme nvme0: Abort status: 0x371
> nvme nvme0: Shutdown timeout set to 15 seconds
> nvme nvme0: 128/0/0 default/read/poll queues
> nvme nvme0: I/O 0 QID 96 timeout, disable controller
> nvme nvme0: I/O 0 QID 0 timeout, disable controller
> nvme nvme0: Device shutdown incomplete; abort shutdown
> nvme nvme0: failed to mark controller live state
> nvme nvme0: Removing after probe failure status: -19
>
> Firmware unable to complete any outstanding commands
> due to lack of resources, therefore placing NVMe drive
> in a condition that is unable to further process WriteZerocommands.
>
> fixing by disabling Write zeroes.

Please consider following commit log, can be used at the time applying the
patch:-

For SK Hynix PE8000 NVMe Write Zeroes Command exceed typical I/O MDTS
(Maximum Data Transfer Size) supported by the hardware. That intern
fail and generate following errors :

nvme nvme0: I/O 0 QID 96 timeout, aborting
nvme nvme0: Abort status: 0x371
nvme nvme0: Shutdown timeout set to 15 seconds
nvme nvme0: 128/0/0 default/read/poll queues
nvme nvme0: I/O 0 QID 96 timeout, disable controller
nvme nvme0: I/O 0 QID 0 timeout, disable controller
nvme nvme0: Device shutdown incomplete; abort shutdown
nvme nvme0: failed to mark controller live state
nvme nvme0: Removing after probe failure status: -19

Firmware is unable to complete any outstanding commands due to lack of
resources, therefore placing NVMe drive in a condition that is unable to
further process write-zeores
command.                                                                 

Add NVME_QUIRK_DISABLE_WRITE_ZEROES quirk for SK Hynix PE8000 that fixes
the problem.


With the modified commit log, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

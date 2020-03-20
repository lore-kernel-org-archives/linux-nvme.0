Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44BC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C1D2070A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BfdcB7hH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiP/16NA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C1D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqN/oT4AgSlcWT9qR42SnUYIvE5i1uHUaH2vMVEeHOE=; b=BfdcB7hHRqoEBK
	LV0rL6d+4fSe8PgFEk2jVptEHwtQ/coI21KXdHYXL1AnYr9UxZOn2lNRLc7MZ3TDhqw663CuAcEU9
	tRcPt+h7lCT36DXw/ZdE60BA/32y0zPXsJQTIbSbcldBeo2uhbsF9xYFzc2bVm+7CzP/2Za13pY9z
	8uFAhtGd+N5tjZYmIS7cx3Hy380bf4NIockRDWMeagnGI6+qzWexXDB0t9Gmr1VyIaSK4RsJIN/Qb
	xhTPFCSA1ZssoiZb1Rfd67w5dgZb8whopiT4KZ8xwA/4JX2A+6rUbalX5MQGmyRrwVSH1DGoC31vh
	j4DQG2as2wYYVpdDFFWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFR0I-0008Je-0O; Fri, 20 Mar 2020 23:24:38 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFR0F-0008Iy-5W
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 23:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584746673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00VSat6G69f0rfpoIjer6bZjIlqsT7/p36m0gAjZ9Yg=;
 b=GiP/16NAyWBFf+OKsTSZX5v6gljhu761lM8RykKzG49h2OB8x1aSHBfQVno7U/uq1K+i36
 e49VmGmEpfq+yJ5hqUtvvNlK75IeXH2HqWZgZPIzmJkKpVYuTAvS70ZAzGIJiw/jkWZuwV
 vNmxF6nugioHims3f00fkceZ153V7zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-5pTuMFt9OMCdfrJsmi9kdQ-1; Fri, 20 Mar 2020 19:24:31 -0400
X-MC-Unique: 5pTuMFt9OMCdfrJsmi9kdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C04C813EA;
 Fri, 20 Mar 2020 23:24:30 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21F825C28D;
 Fri, 20 Mar 2020 23:24:29 +0000 (UTC)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <BYAPR04MB49658A8992A3408F75B7977886F50@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <28cad821-1f5b-41b1-25ac-f1e96120b3c8@redhat.com>
Date: Fri, 20 Mar 2020 18:24:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49658A8992A3408F75B7977886F50@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_162435_298461_F66952F8 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/20/20 5:23 PM, Chaitanya Kulkarni wrote:
> Is your back-end device (/dev/sdc) supports write-zeroes
> (handling of request REQ_OP_WRITE_ZEROES) ? Even if not block layer 
> should just emulate write-zeroes, so I wonder if protection is needed
> when we report oncs (which Ideally shouldn't).

The block device in the nvmet VM does not support write zeros,

# cat /sys/block/sdc/queue/write_zeroes_max_bytes
0


The same device attached to the client over nvme-tcp is showing:

# cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
33554432

I can create a ext4 fs locally in the VM, so mkfs.ext4 must use write
same if available.

-Tony




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

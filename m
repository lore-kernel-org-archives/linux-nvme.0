Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3556C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LohnvpGWI/82X70y8MuOMwmbr+rgczFYK3RiWnUsasw=; b=DnKbBvkSW6n15TXFsNCOWF/XVN
	QdFDkRXV2Kx1YuHwpGGJsmS3qT9bmvAC7J0d0sIOVM26tvgmolCZ3cixZKGBjrDK3XvcxUVFDGq61
	FLeoYSRnxXWDx6n37wLXcp/Zf/BO7Z8H1KH0NSFbMc2qj+csBEssntIsT9la0dGVyzclWaRLj8dVl
	kuLFil2nwgXPswDTLXqy8v1PiPyfEZ/tSnz27/Bw+VwjXPv2FxCQk7CV/3H+LyGwkFM2UwXDi9lYF
	Aa/yP6OrVCPdbG5i12onx12/fRiZFq3YrISMT+6I/2esUcBTPtRBxej7gcKimPRxYQX3bM2c3kBOE
	JPpV1xnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlZTG-001vqU-3v; Mon, 02 May 2022 17:04:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZNL-001srY-Kg
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 16:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651510698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LohnvpGWI/82X70y8MuOMwmbr+rgczFYK3RiWnUsasw=;
 b=B/qv+2Sg025HeiWPkr+5IiogrtDy99WnXUJSJ0NDHNZ1wPn6JbLd3gQO3P1LJhqv4piZyP
 yPvmqTlOXTSYFnkBkdHFp25ZCl2onz9W8ql6otD6ocvl6LbY1Am7Z97LWCJNxBwR01aYd1
 X7rf/R/MGpM1OA4AjyIFqm8fNT/aNgU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-2fMosSUjOMmLkXGKtu6vaw-1; Mon, 02 May 2022 12:58:16 -0400
X-MC-Unique: 2fMosSUjOMmLkXGKtu6vaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FB813C16189;
 Mon,  2 May 2022 16:58:16 +0000 (UTC)
Received: from [10.22.34.177] (unknown [10.22.34.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82388111CD36;
 Mon,  2 May 2022 16:58:16 +0000 (UTC)
Message-ID: <3a83feff-e057-e97e-59bb-5570518b95bd@redhat.com>
Date: Mon, 2 May 2022 12:58:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
From: John Meneghini <jmeneghi@redhat.com>
Subject: LSF/MM IO Track Topics - Take 2
Organization: RHEL Core Storge Team
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_095819_836955_E67A03E7 
X-CRM114-Status: GOOD (  24.85  )
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

We have no lsf/mailman list this year at LSF/MM so please add people to the cc list of this email for any LSF/MM IO Track 
related discussion topics.

One topic I'd like to discuss which I don't see on the IO Track agenda this year is NVMe-oF Discovery Services. I'd like to 
understand what Linux wants to do with all of the Discovery related TPs that are coming out of NVMexpress.org right now.

TP-8010 - Centralized Discovery Controller
TP-8009 - mDNS Discovery
TP-8013 - Unique Dsicovery NQN
TP-8014 - Discovery Controller

When we combine all of these with the security TPs (TP-8006 In Band Authenticate and TP-8011 TLS 1.3 Profile) we start to see 
proposals like the attached picture.

There are additional NVMe-oF proposals coming from FMDS which will impact Discovery and there is even a proposal at IETF for a 
new project for a Distributed NVMe-oF Discovery Server.

https://www.ietf.org/id/draft-nof-requirement-00.html
https://www.ietf.org/id/draft-nof-framework-00.html

IMHO NVMe-oF Discovery is turning into a giant mess. I'd like to talk about this at LSF/MM and understand how Linux plans to 
support the increasingly complex and convoluted landscape of NVMe-oF discovery; especially at it relates to multi-vendor and 
multi-fabric environments that support NVMe/TCP.

See my comments about this at:

http://lists.infradead.org/pipermail/linux-nvme/2022-March/030847.html

/John

On 5/2/22 11:46, Martin K. Petersen wrote:
 >
 > John,
 >
 >> 1. Is there an lsf mailman list this year?
 >
 > We haven't set it up since the attendee list has been a moving target.
 > And most of the things that went out on that list in the past (lunch
 > logistics, evening event announcements, etc.) now comes from the Linux
 > Foundation event management system.
 >
 > Happy to set it up if there's interest.
 >
 >> 2. It looks like the IO track is kind of sparse this year. Are you
 >> still in need of topics for discussion?
 >
 > Sure, while I suspect some topics will take longer than the allotted
 > time, there should be slots available.
 >
On 5/2/22 11:26, John Meneghini wrote:
  > Hi everyone.
  >
  > Unfortunately, I will not be able to attend LSF/MM in person this year but Martin and Omar sent me a virtual invitation so I
  > will be participating virtually over Zoom.
  >
  > A couple of questions:
  >
  > 1. Is there an lsf mailman list this year?
  >
  > I seem to have lost access to my old account so I just subscribed at https://lists.linuxfoundation.org/mailman/subscribe/lsf.
  > If Marin or Hannes can let me in that would be appreciated.
  >
  > 2. It looks like the IO track is kind of sparse this year. Are you still in need of topics for discussion?
  >
  > Please look for me on the Zoom call and/or feel free to call me or text me at any of the links below.

-- 
John Meneghini
jmeneghi@redhat.com
+1-978-930-3519 (cell)
https://t.me/johnmeneghini
https://www.linkedin.com/in/johnmeneghini/



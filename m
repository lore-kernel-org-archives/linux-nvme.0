Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F7C35FF1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHS1SPZsy/hiD4YZfO5zi8XqrDds+QGmWBVIuyOLl44=; b=H35lmoCHpD7nrSlQ6pSBkfGGSY
	PTCVzaV2iWLEohUK0zJoGwavpOpqX1IaKq4NivYRmzCRF2I/ETmNtoaeo9rfgcwNwCzHro1JDi3p0
	VqlOgk+OTQBcsXK/4Pv0+v4lme/kU5F5NSLrICphuCU2Qjb6ERvLUVVUTMYkcMsxnlhGIP2w/xdUe
	bp7t2O9ETerIBFgg0yRBe2ouORcZXie6nbvEk+DPoB1fN03lDlMv+wISj0SMPoN0XCpRgfVTQx3Pt
	CVAn7/bz2z3xYmJHa0Yaj3Ww2uCPYA4kPPr47vf6VW99zXxEANKxaUiu31W9ikZBrb0MBQt9VnoDF
	vi1BMlcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsqO2-0000000CY8i-1ESy;
	Thu, 13 Mar 2025 21:46:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsqNu-0000000CY8J-3zuZ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 21:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741902392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHS1SPZsy/hiD4YZfO5zi8XqrDds+QGmWBVIuyOLl44=;
	b=H0uU/XC/pwuKiP3uapf8OZIqOoupK4FtJmIXm3X3AJ/1uG/UdsdHlisCduo4NKLq7NtHkp
	7TBMsiFRIwSxcdw/8duYamx4KIEmHF+iE/XDrcZ1QycujkJw51HrlezGQPiXqg3QtJr+aF
	zYFZl3SGNz+1hAgogTjaSc2rd+jOYng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-ES6rCyx8P0Cppipgprzl9w-1; Thu,
 13 Mar 2025 17:46:29 -0400
X-MC-Unique: ES6rCyx8P0Cppipgprzl9w-1
X-Mimecast-MFC-AGG-ID: ES6rCyx8P0Cppipgprzl9w_1741902388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF82519560B7;
	Thu, 13 Mar 2025 21:46:27 +0000 (UTC)
Received: from [10.22.80.28] (unknown [10.22.80.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53BCF1800944;
	Thu, 13 Mar 2025 21:46:26 +0000 (UTC)
Message-ID: <cd731f6e-c0e0-4ea7-9012-5860b0be2920@redhat.com>
Date: Thu, 13 Mar 2025 17:46:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de>
 <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
 <20250312051958.GA11824@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250312051958.GA11824@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_144635_071348_63E59F6D 
X-CRM114-Status: GOOD (  17.87  )
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

On 3/12/25 1:19 AM, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 10:35:40PM -0400, John Meneghini wrote:
>>> What's the point of adding yet another confusing option?
>>
>> If you'll read the kConfig description, hopefully it's not confusing.
> 
> It still is.

OK. I can fix that.

>> The whole point of this patch series is to remove the core.nvme_mulipath parameter.
> 
> Why would a compile time option be preferable over a runtime one?

Because distos like RHEL don't allow customers to recompile their kernel. And including this runtime
switch in the kernel let's users turn nvme-multipath off w/out recompiling the kernel.

Our RHEL customers do this all of the time to enable DMMP with their NVMe devices. This has caused tremendous
confusion and turmoil with our RHEL customers who keep on turning nvme-multipath off even when we ship
RHEL with nvme-multipath on and we tell them turning it off is not supported.

I finally decided that there is no good way to control this situation w/out removing the
core.nvme_multipath parameter while CONFIG_NVME_MULTIPATH is enabled.

This patch enables distros like RHEL simply config out the parameter w/out impacting all of the people out
there who currently want and use the run time switch when CONFIG_NVME_MULTIPATH is enabled.

Please let me know what I need to do to make these patches less confusing and get them accepted upstream.

/John



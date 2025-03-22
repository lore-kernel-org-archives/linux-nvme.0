Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BD5C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Cc:To:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=niIrGDJp7w2MaJg5b8pBDnXR+T93ZuDGCvjjlbMC5a8=; b=GbZAfkSoUK4rgHfahHBTbmVsmI
	Rg7rbqry7Gijnad7IcOuor1K+FabMCORBpNOdNTu7pFl0cas61142+A9fu37tEPJnrdh9FIMnanZ0
	V1igPl872DualtGTBWa6/2W0QXaruuZcf27tssCGp/lEJxFd9jXjSEvJ1VlO8W74tloIAPaWHoWKu
	Ku1IAEfxtAJP9LayWa0I6/6k2zbu00q0HMUrDtu7eXbMcKKcEeV8l8h8o5ep1WjXzr45qwOUNeY6g
	v0CIADE6UuiNR7vrG0wmRBRwWCPHjn4L/SzDXGuVhdcPny8eaJvdEY1nl3W/bEYtgs7ONNzI1c9Yz
	9vs4+O2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8Mh-00000000SJN-2PJs;
	Sat, 22 Mar 2025 23:34:55 +0000
Received: from [170.10.133.124] (helo=us-smtp-delivery-124.mimecast.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8Me-00000000SJ0-3vFT
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 23:34:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=niIrGDJp7w2MaJg5b8pBDnXR+T93ZuDGCvjjlbMC5a8=;
	b=irb8twQCF1NYDozWf8FfltJlF4vLHjk3cDy/Qtn/jVp6o3M87KSOXaLHoFHEBvuWc0FERt
	Ix46y9SmgJUFYSbCYRvcTfQr6URkuoKZNCSxOnbk1aN7etSJXkAWxc2mVHZejKx6vk/k0A
	8GV/swF27EY8P9leIfderVCAhB4Q+wA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-CvyXelJfP2SP6oBVHD7Yvg-1; Sat,
 22 Mar 2025 19:34:50 -0400
X-MC-Unique: CvyXelJfP2SP6oBVHD7Yvg-1
X-Mimecast-MFC-AGG-ID: CvyXelJfP2SP6oBVHD7Yvg_1742686486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87DB0180035C;
	Sat, 22 Mar 2025 23:34:46 +0000 (UTC)
Received: from [10.22.80.230] (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8137D180A802;
	Sat, 22 Mar 2025 23:34:45 +0000 (UTC)
Message-ID: <f0dbb752-8391-46bc-b76f-5999b5f4a888@redhat.com>
Date: Sat, 22 Mar 2025 19:34:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Bryan Gurney <bgurney@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: [LSF/MM/BPF TOPIC] remove NVMe MP config option
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G9_4KTZMl0WsPRYyC3qZklRC_xI6srQPw8aOQrGNdP8_1742686486
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_163453_044496_31DD0BB9 
X-CRM114-Status: UNSURE (   8.53  )
X-CRM114-Notice: Please train this message.
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

At LSF/MM/BPF next week I will be talking about the CONFIG_NVME_MULTIPATH option.

There has been long discussion on linux-nvme about simplifying the current linux-nvme config options
used to enable/disable support for native nvme multipathing[1][2][3]. Among other confusion about this topic
the the fact that the current upstream kernel produces the following kernel warning when you connect to an
NVMe-oF multipath device when CONFIG_NVME_MULTIPATH=y and nvme_core.multipath=

[  182.863531] nvme nvme4: Found shared namespace 1, but multipathing not supported.
[  182.871030] nvme nvme4: Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.
  
At LSF/MM/BPF I'd like to discuss my latest patches which attempt to address this subject[4].

Hope to see you there!

[1] https://lore.kernel.org/linux-nvme/20241121220321.40616-1-bgurney@redhat.com/
[2] https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/
[3] https://lore.kernel.org/linux-nvme/20250228032541.369804-1-jmeneghi@redhat.com/
[4] https://lore.kernel.org/linux-nvme/20250322232848.225140-1-jmeneghi@redhat.com/T/#t

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Groupn
jmeneghi@redhat.com



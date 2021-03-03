Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C80C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:33:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB37651AA
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB37651AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:Cc:To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oHqxcfyByv4GFILwohpFi+8J0NWN8gI3zrAJcf6VHGg=; b=LLkJL2lwQX0xH+VZqvdp4cGI+b
	tA1Jwb+kp533/ZUnJ+5gvG41W0rjrfwlFalyGbDOWJKu110hYgtKKQfEUMwkC5F2tzKNeXPW+a3zH
	anI7R5je0peT6Hk0EqMcRYKNW9OyaeCziXpAPpL4Diyf8E4a39yTELJKxOYJ8SPeIdovcHdTWhhpA
	LzdlsT+H/LeD2XMoKBIMBNvOMa5XzUgMfRIKJ6FnEbhzHSzLElRJYVAKVHUvrZgIZNwoqHNYkCsaU
	EOqhFoT7vBC1d4HaZBsHCYlhcEAYVWv4YuTx1gvzO6yrTMLParXf2GjN/IHBPRhiZVQ7IebIh2iKI
	rX3zv8IA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHcrU-007LCP-HP; Thu, 04 Mar 2021 01:33:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHYqd-006Z6V-5Y
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614806153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=ftRA0Zh4AfFqJm5ugmkKdDbGCDQhh/vC4Xk5nPX/kRQ=;
 b=LmqnZSJUMGwVGHxPN9WWindBFSHb4xGGh6sChoDy8A5jLFVhmzdBNH5DFXoEYfW/eIuppy
 rqXzfEAiFixGN9SN+j5OUvnmrjhPTAdbcG/rDyqnu1Kvq/9rwMG8FwMF8ujSPqctBZsIrt
 eo1vEqRo4G9L6zPASofr0PWamqfgu3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-DunQo30BOkyaYHYtrHCuaw-1; Wed, 03 Mar 2021 16:14:04 -0500
X-MC-Unique: DunQo30BOkyaYHYtrHCuaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64C701005501
 for <linux-nvme@lists.infradead.org>; Wed,  3 Mar 2021 21:14:03 +0000 (UTC)
Received: from [10.10.112.124] (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 163D91F452;
 Wed,  3 Mar 2021 21:14:02 +0000 (UTC)
To: linux-nvme@lists.infradead.org
Cc: Tomas Bzatek <tbzatek@redhat.com>
From: Tony Asleson <tasleson@redhat.com>
Subject: libnvme questions
Organization: Red Hat
Message-ID: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
Date: Wed, 3 Mar 2021 15:14:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tasleson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

1. There is interest in utilizing the libnvme library for some other
projects, when is an official release of the library planned?

2. Is it planned for nvme-cli to utilize libnvme?

3. Any plans on adding functionality for NVMe management interfaces to
the library, e.g. NVMe Enclosures?

Thanks,
Tony


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

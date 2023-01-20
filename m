Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1430FC05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jSRSw4TNAYdfaCmLCC1d4r6gRVXm1kYXEl3NBf8MH2E=; b=j4RH/HTNjncJrgeHo6DNQ29xbx
	tPo4dhLM3mh3joa9iRv2fpYtvNWulYUec7sIactj0CiKfH67grc8ZPTUj74h5iNua8QeG2qOxZ07J
	hOKyKELTBCaJnq2VICUV101xxNJ1ndkDBZcjqXL078G1uAYIn9dA/11BJWy5X/0HjKFk+j2RhBGZq
	SaWHyQfrNf7vBpa4gppwgdARzF16+eKLtHhKw9/BGPXu2OkbvBwP9y+MJsWUAXqUzC8JvBBlVPn4T
	inMv+474ElmtIkklDH6FKVUaMtDzzeTdzkiIq5YhAXPmiaQPbm69z3exTiRYwynj/ay44Mko5APm0
	81T7ts0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIxR5-00C92X-EY; Fri, 20 Jan 2023 19:52:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIxR2-00C91A-1s
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 19:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674244341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jSRSw4TNAYdfaCmLCC1d4r6gRVXm1kYXEl3NBf8MH2E=;
	b=NBv40Grr5egjcFQXpuImSGXdszfYAKVAIX5UAZbpCApZ0PdbkJbn2nJcnpe3NzEsAsB7BA
	tuC44NphuhuEfq4r/RS3+Oei/3br+QtdgIh3sRzv0gJ9kjnRKvs9ijUqxeFW3ApCz2w4qd
	8qN/HH98KA22mjgaYOh2szo5ZxdmRMw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-zUMcG67GPNCBaDy-HQqhDA-1; Fri, 20 Jan 2023 14:50:47 -0500
X-MC-Unique: zUMcG67GPNCBaDy-HQqhDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB9FA38173D8
	for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 19:50:46 +0000 (UTC)
Received: from [10.22.16.22] (unknown [10.22.16.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BF772026D68;
	Fri, 20 Jan 2023 19:50:46 +0000 (UTC)
Message-ID: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
Date: Fri, 20 Jan 2023 14:50:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Subject: nvme/pcie hot plug results in /dev name change
Organization: RHEL Core Storge Team
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_115224_219113_0DD32179 
X-CRM114-Status: UNSURE (   8.23  )
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

We have a customer complaining that when they hot unplug/plug their nvme-pci device the device name changes.

For example, when they hot remove /dev/nvme1n1 physically, then reinsert it, it gets identified as /dev/nvme4n1.

IIRC there is nothing about nvme_init_ctrl that guarantees the ctrl->instance will be the same because
ida_alloc() will only return the next free id in the bitmap.

The fact that nvme_remove ->  nvme_init_ctrl many times results in the same ctrl->instance is just a happen stance and there is 
nothing that guarantees /dev name consistency in Linux. Especially in the case of hot unplug/plug where the controller may very 
well be marked NVME_CTRL_DEAD due to the ungraceful disconnect.

True?

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com



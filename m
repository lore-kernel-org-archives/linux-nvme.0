Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A522C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pj2oe1FgGNek+6/QTB0TcxOqnXlPNsvqklQM0pgvpcU=; b=0CF7xzJhQhFMrvKRpaMAf8bVd0
	nr3Wzq4K5Opnsdkikjtw9Bm49l7xOVYf2HiPt6ui/O13fYvTL1wA2yvKmKnVtDsWR/gsYvSmPOUP5
	lAuvTDnlW29IDtmEowRilxlLTrIYwjcLdV5o7OUC1t69GbWaWvm3tTZJke7QkWl2WttZ/2MJA6ofN
	gXtHXIZsT3FDMuz7T3KGirAyFGjNXs3VOrSgwGnE//hpXtWN7CRXbMKR7NJk5peNO+/CoE2y5I8XS
	lKe6JMEXQq+NGzr+h8tWhF/TqJuOiB3/FCyO1AE0Pi/vxIwh6XcjGbyj0567pSwxtOU2zgmDWQ/d5
	gy1B8vXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzGBF-00000000YqD-1xfE;
	Mon, 31 Mar 2025 14:32:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzG8S-00000000YYO-1P3h
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 14:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743431345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj2oe1FgGNek+6/QTB0TcxOqnXlPNsvqklQM0pgvpcU=;
	b=fXWOrcVf+S1GfIOolVOHGoYnUiAOjyqOgHFDL9kZ1+AATuVDcCoFToGetiO5YNFVrJvTiA
	900yl0DjFS8v9vKEToIJ+tPfVk6nCr2t8NcuDvMIPj/cVRx94nhRUImC7pvX9avxPFf0L4
	hY2JIPbKWU7UWhD9IaZJfjpcfo/Db+o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-V0bvGhDbNkO7J3i8GpMjLw-1; Mon,
 31 Mar 2025 10:29:01 -0400
X-MC-Unique: V0bvGhDbNkO7J3i8GpMjLw-1
X-Mimecast-MFC-AGG-ID: V0bvGhDbNkO7J3i8GpMjLw_1743431339
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D4FE1955DC5;
	Mon, 31 Mar 2025 14:28:59 +0000 (UTC)
Received: from [10.22.89.56] (unknown [10.22.89.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 886EF180094A;
	Mon, 31 Mar 2025 14:28:56 +0000 (UTC)
Message-ID: <e22e3cd8-f792-4f20-9624-76e973cf4940@redhat.com>
Date: Mon, 31 Mar 2025 10:28:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] nvme: add the NVME_ENABLE_MULTIPATH_PARAM config
 option
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com
References: <20250328193826.356257-1-jmeneghi@redhat.com>
 <20250328193826.356257-4-jmeneghi@redhat.com>
 <CADUfDZoXg39h-5gi+aVj2u1H6HC4Beyp2XPTrjJ_PMDPf11dQg@mail.gmail.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CADUfDZoXg39h-5gi+aVj2u1H6HC4Beyp2XPTrjJ_PMDPf11dQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_072908_448914_05C5773A 
X-CRM114-Status: GOOD (  12.61  )
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

On 3/28/25 3:49 PM, Caleb Sander Mateos wrote:
>>   bool multipath = true;
>> +#ifdef CONFIG_NVME_ENABLE_MULTIPATH_PARAM
>>   module_param(multipath, bool, 0444);
>>   MODULE_PARM_DESC(multipath,
>>          "turn on native support for multiple controllers per subsystem");
>> +#endif
> If CONFIG_NVME_ENABLE_MULTIPATH_PARAM is disabled, could you #define
> multipath false in place of the global variable? That would allow the
> compiler to optimize out the multipath checks and the resulting dead
> code.

If we #define multipath to be false that would permanently disable the multipath code
when CONFIG_NVME_ENABLE_MULTIPATH_PARAM=n, and this is not what we want. The purpose
of CONFIG_NVME_ENABLE_MULTIPATH_PARAM=n is to simply remove the core_nvme.multipath
parameter from the kernel so the user no longer has the ability to change
the bool multipath variable.  We want multipath to be true.

There should be no change in the multipathing policy or code by
enabling or disabling CONFIG_NVME_ENABLE_MULTIPATH_PARAM.

If you want to compile out the mulipath code you should set CONFIG_NVME_ENABLE_MULTIPATH=n.

/John



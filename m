Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85695C021AD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lgPlVGhbeqEzlRphlfwN5cVytTh9XFzZGkmtCQbZrNA=; b=Uir7k3iwTi8GzQ/qLMdFdM8BFO
	qiOxkwr4HR3+AioHj31GQduVzKpWZyGwkgKNYes5VumKM6SPAcb7iWQv0BZ/WGhfgTt2L6N1LCeiv
	xqfzEilu8wwcOVThQCRfyhNyjrlyLupY2gtnjkTopOjPZUGGY/w2QQbKfRlDjXyak51s/i8f029E+
	PYiFv06JdIF7aG9xouNF2NPVH03Aw5ivZWYM/MZjtC6HB7M+zm3NDXfBD1VWxbnTvYlqLUvL5wuZK
	G5sQhtl9MD+gCzXTPd7GET0C80z57rnUMwPFvgyJHLRORdndlLZO+YX0qgWUOoD0gyKWPOzt/Yp+2
	9wBmIvnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQWV-00000008z6c-3oZz;
	Tue, 18 Feb 2025 16:32:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQW0-00000008z0Y-0XuS
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 16:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgPlVGhbeqEzlRphlfwN5cVytTh9XFzZGkmtCQbZrNA=;
	b=Cbmr0gRzgRQ36aeyyQipl6gbQA62xKSMy9N5wKSt/mjIotzKpnYf4IWefkpjyYioAa2aoW
	FAZ6Z1zfz7HCWpIywez4oKKzGYI3CoP5BuFfAsG2E3l690w+gXcP7LFRmcDD9TBXljs5Hp
	b4vnFJeVc28MZew/fhNbYqEZ9RwU4NU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-8N3Sl7dUMi-SBs_8SYx8qw-1; Tue,
 18 Feb 2025 11:32:02 -0500
X-MC-Unique: 8N3Sl7dUMi-SBs_8SYx8qw-1
X-Mimecast-MFC-AGG-ID: 8N3Sl7dUMi-SBs_8SYx8qw_1739896321
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E5641800995;
	Tue, 18 Feb 2025 16:32:01 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AF6219560A3;
	Tue, 18 Feb 2025 16:31:58 +0000 (UTC)
Message-ID: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
Date: Tue, 18 Feb 2025 11:31:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_083208_248355_4ADC3CC5 
X-CRM114-Status: GOOD (  18.42  )
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

On 2/18/25 10:06 AM, Keith Busch wrote:
> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>> Keith, Christoph and Sagi,
>>
>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>> have been tested. Our QE engineer has asked me to report this upstream.
> 
> What's the harm in leaving the parameter? *I* use it so I can test both
> ways without needing to compile multiple kernels.

LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.

We want to remove this parameter because it is causing confusion with users and customers who keep trying to use
DMMP with their multipath NVMe devices.

We want to remove this parameter because:

1) the upstream kernel does not support multipath nvme devices without CONFIG_NVME_MULTIPATH enabled
2) the upstream kernel does not support multipath nvme devices when core.nvme_multipath is set to N
3) Non-multipath nvme devies are supported just fine with core.nvme_multipath is set to Y

You don't need set core.nvme_multipath to N to test your devices both ways w/o recompiling the kernel.
All of the code paths involved here are controlled by NVME_CTRL_CMIC_MULTI_CTRL and setting core.nvme_multipath
to N doesn't do anything to help your single path NVMe devices. It doesn't remove multipath.c, reduce the code
path length or do anything else to optimize your non-NVME_CTRL_CMIC_MULTI_CTRL devices.  All it does is provide
an escape hatch to disable the incore multipath scheduler start creating multiple /dev/nvme%d/n%d entries so
that DMMP can be used with multipath capable NVMe devices.

Personally, I'd like to remove CONFIG_NVME_MULTIPATH as well. It's just another source of confusion. Most users
are running Linux with the the default settings for NVME_MULTIPATH. This is what Red Hat customers use and that's
what's used upstream.  So what's the point?

/John




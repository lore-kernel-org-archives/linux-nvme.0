Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECDEC05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3EImqxv36s544qTYC0kEWPjZrJ8dC/3wm2/hDXj2ZCg=; b=eJXrL/hmTVF8u7jwPnp9TjVE5F
	E11CiTc5gdXB6HNvKJm2nGpFqE06xnclwWAT4RiOgi0c+Z8eonIgtGc+0dN3pwCV6/kYG9UGA1SP5
	adE2Ssysltq9zVn0hMMRsFWCAjkGfHJzKMHE4Mna3+J4wS6tGZQtyb61dAxhJH/2i64Szhw58LHgd
	UF+pYRcRb+TsWcdthvFIsQBKBr4Bw9V94OL+y+nGHPg+h7+VgjAM/KHA5ya4g8gcHJ20ki0VRHS+N
	jZEvhkd1+MXBsv7OBRshxS0Z74+hdtuPOqsCqZ8SAk++nIycfymER7Zs8K3QbXtkMfdQKEPXIPBA1
	0H4dChYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNyDa-002oEb-4o; Fri, 03 Feb 2023 15:43:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNyDW-002oDX-Du
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 15:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675438987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EImqxv36s544qTYC0kEWPjZrJ8dC/3wm2/hDXj2ZCg=;
	b=JZiafokzihnDmMxOagnaSVYmgyrNJ0MXZIHFT4zcWqZNUsi/lqwhWp2mBF69b2bNhRA/qk
	iV/K5F3twLsxUlhu9jLwaJE7J2LMZ9amtPajTsv8VSanwLmWIuvLOFNwz1el4gpUnnjb1O
	s1FnND3e/pBtfZ8I6GgQxadYbfYypGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-TsVa3t2BO4yx9RbDxNbvNg-1; Fri, 03 Feb 2023 10:43:06 -0500
X-MC-Unique: TsVa3t2BO4yx9RbDxNbvNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7608F882822;
	Fri,  3 Feb 2023 15:43:05 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC082492C14;
	Fri,  3 Feb 2023 15:43:04 +0000 (UTC)
Message-ID: <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
Date: Fri, 3 Feb 2023 10:43:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
From: John Meneghini <jmeneghi@redhat.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
Cc: "Rose, Charles" <Charles.Rose@dell.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>, Martin Wilck <mwilck@suse.com>
Organization: RHEL Core Storge Team
In-Reply-To: <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_074310_579685_D9EE40C1 
X-CRM114-Status: GOOD (  18.90  )
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

I have a question for the upstream nvme maintainers.

Why does libnvme, as v1.3, now have a dependency on dbus?

I thought the goal was to keep the nvme management plane as streamline and daemon free as possible.  We already have a 
dependency on the udev daemon. Isn't that enough?

/John

On 2/3/23 08:47, John Meneghini wrote:
> Everyone should note that I have updated the timberland-sig repositories and re-based these pull requests onto nvme-cli v2.3 and 
> libnvme v1.3 before pushing these change upstream.
> 
> As a part of the re-base I noticed that the meson tool chain was updated in v2.3/v1.3 so I was no longer able to compile this 
> stuff on my standard RHEL 8 dev plaform.  I has to switch to Fedora 37, which seems to have the needed updated tool chain to 
> compile everything. 
 >
> Everything was there on my fedora 37 machine except for dbus.
> 
> Executing subproject libnvme:dbus
> 
> dbus| Project name: dbus
> dbus| Project version: 1.15.3
> dbus| C compiler for the host machine: cc (gcc 12.2.1 "cc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)")
> dbus| C linker for the host machine: cc ld.bfd 2.37-37
> dbus| Program python3 found: YES (/usr/bin/python3)
> dbus| Message: Detected platform : Unix (linux)
> ...
> nvme-cli 2.3
> 
>    Subprojects
>      dbus   : YES 5 warnings
>      libnvme: YES

On 2/3/23 05:08, Martin Wilck wrote:
 > On Thu, 2023-02-02 at 17:38 -0500, John Meneghini wrote:
 >> Please see the pull requests:
 >>
 >> https://github.com/linux-nvme/libnvme/pull/572
 >>
 >> https://github.com/linux-nvme/nvme-cli/pull/1791
 >>
 >> /John
 >
 > I have followed up with
 >
 > https://github.com/dracutdevs/dracut/pull/2184
 >
 > Martin



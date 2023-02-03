Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB4EC05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzPPbyHM88bHLCUjKngul+IPYvBKU/f0vLSBApEKRKs=; b=2ygZRkcPA0aRIijbKO9MSFE0Jc
	6kkT/RrUk52ZeDKVByq/EWxrIK3tC2/Ar8ELpLeT7cS5vcopQY7t0OGKhhrCPy/8HixCvM6xmmdQE
	nMFb+rrQCEYthHFBTnp51A97uTdnGTcITCUybwuGLKDETYDR1Yxp1wUHWKNGI5OCefltxgx9oud9x
	/MqiC4YVvhtDg7YdQMvBM8XMR2+eXAP9/i5EV4a58CY/vnFs+uhBxPxIEuVjNVrbfpGP4Ng4uTHZ5
	VgbFF+VceqbWwuNKMELqtmVqYKNw2NLn5g9O6qFwGQkuKLuVcS4k6xVAnbHPYXvg8tDwY/auelYvd
	tU88n8kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO06E-0036mw-0G; Fri, 03 Feb 2023 17:43:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO06B-0036lp-Bt
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 17:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675446216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzPPbyHM88bHLCUjKngul+IPYvBKU/f0vLSBApEKRKs=;
	b=h/whPOAlp3rWJgY8jlfa/P8X/FT2I2tvVhAe98Uk5r2GO1XJQy+FeRi6g8uLBsmYx7hxf/
	zUZB1skB6QNZ6qysZxfB35bT2/WQhLTHtg7/smqXI28SCb1aJQEs6vZoRruUPwfpczGZkk
	b0RQgVg49DLgUD6R0BBIJuoFU+4lMkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-vZkTplKKMUmeG7GJG7nHBg-1; Fri, 03 Feb 2023 12:43:33 -0500
X-MC-Unique: vZkTplKKMUmeG7GJG7nHBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2971E882820;
	Fri,  3 Feb 2023 17:43:33 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD925400F756;
	Fri,  3 Feb 2023 17:43:32 +0000 (UTC)
Message-ID: <ad09ff71-5f7e-2d05-15c7-93815b66bbfb@redhat.com>
Date: Fri, 3 Feb 2023 12:43:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, "Rose, Charles" <Charles.Rose@dell.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>, Martin Wilck <mwilck@suse.com>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
 <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_094343_590700_D9E5BA2F 
X-CRM114-Status: GOOD (  13.08  )
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

On 2/3/23 12:30, Keith Busch wrote:
>> The current nvme-cli meson.build configuration for libnvme is always pulling the
>> fallback. A workaround is to build libnvme as separate step as you would do when
>> packaging.
> I'm just trying to build this right now on an embedded system, and my goodness,
> it is fucking painful. It's a bare-bones busybox enviroment with no internet
> connection. Just getting meson on there was unpleasant, and now the build just
> gives up with the failed dependencies.
> 

Here's how I solved the problem on my redhat platforms: fedora36, centos9 and rhel-8.6

$ sudo dnf update -y
$ sudo dnf install -y meson cmake dbus-devel libuuid libuuid-devel libuuid-debuginfo json-c-devel json-c-debuginfo json-c \
        json-c-doc libhugetlbfs libhugetlbfs-devel libhugetlbfs-lib clang openssl openssl-devel dbus-devel
                                                                                                 ^^^^^^^^

Every time I find a missing library or package I add it to my tool chain because the meson fallback/compile stuff is always 
broken and full of bugs.

This is what you want to see:


Build targets in project: 21

nvme-cli 2.3

   Subprojects
     libnvme: YES

Found ninja-1.10.2 at /usr/bin/ninja
Configuration located in: .build
-------------------------------------------------------
ninja -C .build
ninja: Entering directory `.build'
[119/119] Linking target nvme

/John



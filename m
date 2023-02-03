Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE59C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9izLqSO/Bx2vMBDPnf9s/eA+O4mzAnUWfcOeIrEZlI0=; b=3tGbZlEnnZxUtKxhFRvF2kkRpf
	lw84AuMuKXB8UNvTD2M4OMOyM9XXdWGrjom6d7VjzSKxdKWq74caqsnUWConN4RUq0J+4UdurEU7v
	3jM/DpcbU+EyaOFOY8d7byXd7rAeSfYUdorn01GAZGzRKZiPiNE5Z9S+Ej6kIFvmzQpp5eGPgYcT9
	5PdCYiKB2wekMRqvX/E35fXyQ3kI0ztGfHVxxTQbNsKQeNFBGIJ3k/xpcqj56ay/5oUJq0X+mdiFu
	byevk4oCPTk+euFFjvyxf+xIGP14WlBBIYcHGO5Dc2a73YpuN19kMOkxsEhUK/qBS9/qjDe+BLMVf
	zXDsEG3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNzxT-0035Z5-K1; Fri, 03 Feb 2023 17:34:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNzxQ-0035YQ-K1
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 17:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675445679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9izLqSO/Bx2vMBDPnf9s/eA+O4mzAnUWfcOeIrEZlI0=;
	b=RGIg1FCoQ2PpHh/32zvxWRhQRQ5OumdI5zNzKIwYWqSFfSnex5izYcJk30wCqvKFbA/1sA
	qEtoaVha4b9uw77pkG9HoIbK4cL+5+hQUZvSl8SyPmV7Pt9gbsie//5gK8u2ftym5smoSV
	yWODegNtG9izj7hQSLI87b9e+EPbAA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-UTj-DCV1MNKtz_cYEtFyOw-1; Fri, 03 Feb 2023 12:34:36 -0500
X-MC-Unique: UTj-DCV1MNKtz_cYEtFyOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6E3885D061;
	Fri,  3 Feb 2023 17:34:35 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 516D72026D37;
	Fri,  3 Feb 2023 17:34:35 +0000 (UTC)
Message-ID: <45892f75-f541-d63b-af31-4857706b4b93@redhat.com>
Date: Fri, 3 Feb 2023 12:34:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "Rose, Charles" <Charles.Rose@dell.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>, Martin Wilck <mwilck@suse.com>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_093440_801337_30CC6B17 
X-CRM114-Status: GOOD (  26.05  )
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

To provide an update: I got my rhel-8 machine to compile everything with the provided rhel-8.6 stock tool chain. I just needed 
to update and then install the dbus-devel package.

  sudo dnf update -y
  sudo dnf install -y dbus-devel

inline:

On 2/3/23 11:22, Daniel Wagner wrote:
> On Fri, Feb 03, 2023 at 10:43:04AM -0500, John Meneghini wrote:
>> I have a question for the upstream nvme maintainers.
>>
>> Why does libnvme, as v1.3, now have a dependency on dbus?
> 
> libnvme-mi uses a D-Bus service for discovering devices. Initially libnvme-mi
> used libsystemd as D-Bus library. libsystemd is only available as shared
> library, thus we can't build the library statically (yes, some people want to do
> this). We switch the implementation to use libdbus. I made usre that it can
> be consumed as suprojects. New library, old optional dependency.

Wasn't aware that libnvme-mi uses dbus.  So this is really a dependency for the nvme-mi utility?

Are we talking about:

   https://github.com/Intel-BMC/nvme-mi

???

>> I thought the goal was to keep the nvme management plane as streamline and
>> daemon free as possible.
> 
> Yes and it is optional. The new feature is that you can compile it
> as static dependency and this is what you currently see.

Ok, so there's no aversion to supporting utilities that use systemd in libnvme, you simply added the new static compile/link 
feature.

> The current nvme-cli meson.build configuration for libnvme is always pulling the
> fallback. A workaround is to build libnvme as separate step as you would do when
> packaging.

Yes, got that.  The dbus-1 fallback/compile feature has some bugs.  I worked around the problem by installing the dbus-devel 
package.  No more fall back.

>> We already have a dependency on the udev daemon.
> 
> Not on code level (no library). I don't see how we can avoid this and I don't
> understand why this is now a problem.

It's not a problem at all. I'm just trying to understand what all of the dependencies are and what's the attitude towards 
systemd.  As we've talked about this in the past the idea was we don't want any dbus dependencies in nvme-cli, but apparently 
there's no problem with supporting systemd in libvnme.

> Concerning meson version: We always used features from 0.50.0 hence the min
> version of 0.47.0 was wrong. We just updated this.

Yes. got that. After updating rhel-8.6 my meson is ok.

jmeneghi:nvme-cli(master) > meson --v
0.55.3

Thanks,

/John

> Daniel



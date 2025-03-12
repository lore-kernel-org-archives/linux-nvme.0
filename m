Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D18C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 03:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPbjQ3LyJEVdlvelmk4xTYprYRGR8Y0T9tIA9nw+UI0=; b=sWQ9zNaXfFKuMellIwME1z9eL3
	ROcTQK32FQWPqpvIOub5+3Ufav+PPwguM6bkLK0QtK2tkT0IXR3tHhVjQOzIFCy7YamNcz0TgJZCu
	7H8xqv/NrMcIO50W0TV68oscxHg4caqO3JzGdsfk91l46VPpNF3n8fAGfIPYMjEcctiwMokCE3wfk
	aAHaPNUiCz9+/QS34d0zvhUKLVy4G2fSwkwgaMiUW7xrGDURTgEUKOD+xavv6K3val2d6eHKgLLnZ
	VMym8S8r0bgHgTbPDXuMJKD//QV1inmS+5NY7LisoLsTxXye93H+/JANsHAdvcg6+gKYs7WnIpjmS
	3aKu5AFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsCSh-00000007OsV-0tuP;
	Wed, 12 Mar 2025 03:08:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsCSe-00000007OsA-2qWN
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 03:08:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741748926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPbjQ3LyJEVdlvelmk4xTYprYRGR8Y0T9tIA9nw+UI0=;
	b=ZaoMwDRo9zXNHgy1kVgrUEcUgc8MzVaF6OjJZY0+Qmcd49DZUxulncHEmeAEFF6YdghR0Y
	2YnrYa628PWyCgouJhdc/Etg9ix/OwBI6zEMHiE3dJw48ddoBRb9Et42x44EScknsE7keh
	Qq4Vs6PmgB9NoVk93T+Ckf1D3LVnNiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-LP3YnjyvPRCORz_uBG9ITQ-1; Tue,
 11 Mar 2025 23:08:43 -0400
X-MC-Unique: LP3YnjyvPRCORz_uBG9ITQ-1
X-Mimecast-MFC-AGG-ID: LP3YnjyvPRCORz_uBG9ITQ_1741748922
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D37B118007E1;
	Wed, 12 Mar 2025 03:08:41 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87FD21956094;
	Wed, 12 Mar 2025 03:08:38 +0000 (UTC)
Message-ID: <ca96d675-7ada-42c0-a3b9-6ced9e399ff3@redhat.com>
Date: Tue, 11 Mar 2025 23:08:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>, hch@lst.de, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_200848_791946_8D3342AA 
X-CRM114-Status: GOOD (  13.32  )
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

On 2/26/25 4:55 AM, Hannes Reinecke wrote:
> Plus there are some NVMe devices out there which _despite_ being PCIe do report NMIC and CMIC set 
> (I won't name names, if you came across them you'll know). This is causing stacking drivers (most notably MD) 
> to behave vastly different on hotplug. Having the module option is an easy way of debugging (and, in quite 
> some cases, fixing) the issue.

So some MD driver configurations that use PCIe devices that report CMIC and NMIC need to turn off
core.nvme_multipath.  Is that what you're saying?  Are these PCIe devices multiported?
  
> If the module option really causes issues just make it read-only; that
> way you can still set if if absolutely required, and at the same time
> catch installations which try to modify it.

If we do that the parameter can't be used to support use cases like your MD driver, or Kieth's ublk driver.

/John



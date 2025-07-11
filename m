Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB0C83F1B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70Z4opZRL076ZNWR+XkCjBSaf4ucd3Hi4biRYZjy3XY=; b=Yk8b2t8R1wG41EK7oCF2Y1zbpv
	1jH8KP+vDydFcmIOb6OEbsnvEFcQhvCWwXMtwjEUmvoBGEwZtoo0z0KRKxrCDCGfcaXAJGCPJ1Svh
	JYx2sBVKdqEZ+9U8nfqwijzXN3H7kdqcD48FPQr1daG/KPIL6phHellVULpVcjs6VRzunPOKuW87c
	Cudxm6qTije7NWkuK4zs2dMZ6QIo+azK8sHe71Cejc/akxNNTZwdmJN+Sf8mBU0xBj8G9OLRJtCaa
	WiK6YSEqO2K1JB9yQDaH1E07VArgXjZw8X+hsXrxNUrucJlAPdP+DEX0wLpJv3eppqPNrHferTBWq
	u2a5BFGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaHhF-0000000FPfg-1uyT;
	Fri, 11 Jul 2025 17:38:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaGwJ-0000000FKoz-3PaG
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 16:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752252574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70Z4opZRL076ZNWR+XkCjBSaf4ucd3Hi4biRYZjy3XY=;
	b=Y0ZdbEg4rfd7VByntaWYVfsXltJTmV6ruO+FLpnpAmUJFNw/cS0XLgxat8CKZ1gNSOx2Qs
	z1PN9H5yL0lC03o62Xmszc7KORg/Illl2PFjvBt2Xwt6SAjwaoYV28UXNfkxSR5G174wnH
	D4xkCIYF2dgDclyehQlGRr+jqLtXQYA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-Fd4cwRNGMUqib7e4qSMyUA-1; Fri,
 11 Jul 2025 12:49:31 -0400
X-MC-Unique: Fd4cwRNGMUqib7e4qSMyUA-1
X-Mimecast-MFC-AGG-ID: Fd4cwRNGMUqib7e4qSMyUA_1752252569
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04D3C1800289;
	Fri, 11 Jul 2025 16:49:28 +0000 (UTC)
Received: from [10.22.88.94] (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A26D71800287;
	Fri, 11 Jul 2025 16:49:23 +0000 (UTC)
Message-ID: <06f27533-ea9b-4ee1-96ed-12ddda271a76@redhat.com>
Date: Fri, 11 Jul 2025 12:49:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] nvme-fc: FPIN link integrity handling
To: Muneendra Kumar M <muneendra.kumar@broadcom.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 james.smart@broadcom.com, dick.kennedy@broadcom.com,
 linux-scsi@vger.kernel.org, njavali@marvell.com, muneendra737@gmail.com,
 Howard Johnson <howard.johnson@broadcom.com>
References: <20250624202020.42612-1-bgurney@redhat.com>
 <CAHhmqcTO_Q59aDr3DywC-tPF=9pe3gxbyn6J4ycdf+eYEOayHQ@mail.gmail.com>
 <19484829-0a7b-42ce-99fe-e74ccda67dce@suse.de>
 <b0817e2a-1c4e-4d7d-9a84-633913d9e0e4@redhat.com>
 <0db83ea3-83aa-45ef-bafd-6b37da541d22@suse.de>
 <CAHhmqcTNrfjj-ABjTfj7LUCQ_qRtcTrZCzhtaERViaAQut3TUw@mail.gmail.com>
 <fb150df4-d235-455b-8394-55b816c0e6ad@suse.de>
 <CAJtR8wVupqRK3t0+7shrNCTZ9qZC7gHAR2X8Ov0AR-RJamxcWg@mail.gmail.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CAJtR8wVupqRK3t0+7shrNCTZ9qZC7gHAR2X8Ov0AR-RJamxcWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_094935_920293_7D8BBBA1 
X-CRM114-Status: GOOD (  22.86  )
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

Adding Howard Johnson.

On 7/11/25 4:54 AM, Muneendra Kumar M wrote:
>  >>But that's precisely it, isn't it?
>  >>If it's a straight error the path/controller is being reset, and
>  >>really there's nothing for us to be done.
>  >>If it's an FPIN LI _without_ any performance impact, why shouldn't
>  >>we continue to use that path? Would there be any impact if we do?
>  >>And if it's an FPIN LI with _any_ sort of performance impact
>  >>(or a performance impact which might happen eventually) the
>  >>current approach of steering away I/O should be fine.
> [Muneendra]
> 
> With FPIN/LinkIntegrity (LI) - there is still connectivity, but the FPIN is identifying the link to the target (could be multiple remoteports if the target is doing NPIV) that had some error.  It is *not* indicating that I/O won't complete. True, some I/O may not due to the error that affected it.  And it is true, but not likely that all i/o hits the same problem.   What we have seen with flaky links is most I/O does complete, but a few I/Os don't.
> It's actually a rather funky condition, kind of sick but not dead scenario.
> As FPIN-Li indicates that the path is "flaky" and using this path further  will have a performance impact.
> And the current approach of steering away I/O is fine for FPIN-Li.

OK, then can we all agree that the current patch series, including the patch for the queue-depth handler, does the correct thing for FPIN LI?

Right now this patch series will "disable" a controller and remove it from being actively used by the multipath scheduler once that controller/path receives an FPIN LI event.
This is true for all three multi-path schedulers: round-robin, queue-depth and numa.  Once a controller/path has received an LI event is reports a state of "marginal" in the
controller state field  (e.g.: /sys/devices/virtual/nvme-subsystem/nvme-subsys6/nvme4/state). While in the marginal state the controller can still be used, it's only the path
selection policy that avoids it in the nvme multipath scheduling code.

These patches also prefer non-marginal paths over marginal paths and optimized paths over non-optimized paths. If all optimized paths are marginal, then the
non-optimized paths are used. If all paths are marginal then the first available marginal optimized path is used, else the first available non-optimized path is used.

To clear the marginal state a controller must be disconnected, allowing the /dev to be removed, and then reconnected.  (We might want to change this, but that can be discussed in a future patch)

Bryan and I have tested these patches with all of the above configurations conditions and, at this point, they are working as described above while using an LPFC adapter.

You can see the test plan Bryan and I used is at https://bugzilla.kernel.org/show_bug.cgi?id=220329#c1

We observed a problem while testing this with a QLA adapter.

So I am hoping one more update to this patch series, to fix the QLA problem, will complete this work.

/John









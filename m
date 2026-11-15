Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D91606A327
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Tat24dVa;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LDXK/GA8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=woOfyy6+u6Bpq89IupWYIeQk6EVkwaxCSpWmgn+r9TE=; b=Tat24dVablmVcY
	XQRBSwwmpgx72Pffoa6fnRGYTrFa9O4nLx+wYSxhLk6tp9t7v/vKfPoeEXg+DlFGyi6dJg8LvCc7t
	KopSDgLhsK0smAWNI3OtJeaVVF1IRJdC3p95hsML4ll4YUF6zuISfz1+3NSGMQ9HeW9cW3YYAwD59
	2bprC6zKQ7D10Xt//MKqOi+kadQpH1vMnWMKJbQNJueCYIqAOReR9ugpzfyy7T6SHkpRcoe2c95wz
	L2n/RRb2hPwjh2ONLU5FAbzORcqHZGhtmtUjS4LAGPjtMyPleRV015+fRTClmIzPS49dTBfhnPqUu
	txijUdWgh2MP72OjrGUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSeG9-00000000HRl-17gb;
	Sun, 15 Nov 2026 17:43:21 +0000
Received: from out-20.mta1.migadu.com ([2001:41d0:203:375::14] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSeG2-00000000HRM-236k
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 17:43:16 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=au0odLyb7/2WgYODnIjx2j64U1vQfxh6IkxY78a99H4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794764589; v=1; x=1795369389;
 b=LDXK/GA8qatl4AxoC5doVanT0Gmp/wCId8BkMLaopRin/HeDRiUhXMGlOQ2c5ZNXJo4MHuoT
 O0DyofxGhOCisLoh11BNVCTIAat9kdWV6hD8NMViUR7CHrisFonDyEyQs1iK+cWudD+BpnkEIQe
 QrND9Fs4aghv+0lBg9WbwCU4=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id d3995290662ba302;
	Sun, 15 Nov 2026 17:43:08 +0000
X-Mizu-Trace-ID: d3995290662ba302
X-Migadu-Flow: FLOW_OUT
Message-ID: <87d9b34e-1d63-41d2-9c01-595f0f1c7f23@linux.dev>
Date: Sun, 15 Nov 2026 17:43:02 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
To: Xose Vazquez Perez <xose.vazquez@gmail.com>,
 Laurence Oberman <loberman@redhat.com>
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com,
 dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 mkp@kernel.org, Benjamin Marzinski <bmarzins@redhat.com>,
 Martin Wilck <mwilck@suse.com>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
 <3332329d-b922-45a4-8333-e8353e983885@linux.dev>
 <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_094314_695544_18D90AA9 
X-CRM114-Status: GOOD (  14.51  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 13:03, Xose Vazquez Perez wrote:
> On 11/10/26 10:05 AM, John Garry wrote:
> 
>> On 11/9/26 20:19, Laurence Oberman wrote:
>>> 3. Smaller points
>>>
>>> - numa with equal NUMA distance uses one path per LUN, so with two AO
>>>    paths through two HBAs, half the optimized bandwidth is idle (sdl:2
>>>    above under numa). That matches NVMe, but users coming from
>>>    dm-multipath service-time will notice. Would round-robin or
>>>    queue-depth be a better default for SCSI?
>>
>> Maybe, but round-robin may not be always ideal considering only a bio 
>> mode of operation is supported and no merging like dm-mpath RQ mode.
> 
> iopolicy can easily be customized per array/device via udev rules.
> Just like it's done for NVMe:
> https://github.com/linux-nvme/nvme-cli/blob/master/nvmf-autoconnect/ 
> udev-rules/71-nvmf-hpe.rules.in

Sure

> 
> Additionally, "service-time" and "latency" I/O policies are currently under
> development:
> https://lore.kernel.org/linux-nvme/20261026111019.3724465-1- 
> kanie@linux.alibaba.com/T/
> https://lore.kernel.org/linux-nvme/20260815173502.1185929-1- 
> nilay@linux.ibm.com/T/

I already did an experimental port of the latency iopolicy to 
libmultipath. Porting iopolicy schemes to libmultipath is not too 
challenging, really.

> 
>>> - There is no userspace tool yet to show heads, paths and ALUA state
>>>    (the equivalent of multipath -ll or nvme list-subsys). I used a
>>>    small sysfs script for this testing. Ben, is native SCSI multipath
>>>    support in multipath-tools planned?
>>
>> Well, the whole point is that we don't need userspace tools. However, 
>> I appreciate that there is no general SCSI tooling which could help 
>> here. I know that Himanshu M did work on a SCSI version of nvme-cli 
>> tool previously. Martin may know the status of that.
> 
> Agreed that userspace tools are not strictly needed for configuration, but
> observability is key.
> A standard utility to visualize the device topology, path health and ALUA
> states at a glance, similar to what multipath-tools provides, would save a
> lot of friction for sysadmins migrating away from dm-multipath.
> Relying solely on ad-hoc scripts or manual sysfs parsing can become quite
> tedious in production environments.

Right, and any info required here should be available in sysfs.

Thanks,
John




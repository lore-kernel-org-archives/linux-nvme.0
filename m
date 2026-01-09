Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754C0D26D94
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlpEpsL9kRFNTAqd1axDc0OPDA8Lzgna/Jxw/zCQHNw=; b=o4pEz1eTgCt/diMJw9p0yS6wmr
	215yTJYnpvswDA19eSBczUh8O2ay9099WISuTbjuM4kWrayUrSi7Pv6+xFnvGjM9uY0+9xnaAbupJ
	IVoRJWKhukaT0ip6MFtlwqwt3PsT8ww+8S/SOKjFOjLdANo7rGMosqkiITtxwSlqyzgRncnrOHSyz
	ijpAvghDhHK1SoyatBXlI9HGB8YYfugs1+JknmmCrT+mcisb3LOwcNejivgt0nPJ7GAwUiSTXPjYY
	oVQNcrHsDN9Wj4Pu35AlW225hVx9OxrHvyBxVBKb2TlCv9nn8N5dDNRtsbKLEsseKe/F5uCv+DwNr
	jrM2TofQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veI1j-00000002vkV-2972;
	Fri, 09 Jan 2026 19:20:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veI1f-00000002vik-3GSn
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 19:20:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767986397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlpEpsL9kRFNTAqd1axDc0OPDA8Lzgna/Jxw/zCQHNw=;
	b=IqvMVO8J5TnAHezNpJjA/q0aFtTV3Wt7BPJ/BUO0epWvmdL/E8hVBvX8v7Jdu8ta/MTFdf
	W5ylVllVxMOX/hG+gNudFWQoakL7a6Py3luqUSsUmr5Wn6VYNw260dSFmQ+3U8XgAb5gnH
	svFn90Md37FAu1k8En7lkuGlBK79QLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-L0vuxXSONxameqErtRrNPA-1; Fri,
 09 Jan 2026 14:18:20 -0500
X-MC-Unique: L0vuxXSONxameqErtRrNPA-1
X-Mimecast-MFC-AGG-ID: L0vuxXSONxameqErtRrNPA_1767986298
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08121954B0B;
	Fri,  9 Jan 2026 19:18:17 +0000 (UTC)
Received: from [10.22.64.42] (unknown [10.22.64.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 980881800285;
	Fri,  9 Jan 2026 19:18:14 +0000 (UTC)
Message-ID: <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
Date: Fri, 9 Jan 2026 14:18:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Nilay Shroff <nilay@linux.ibm.com>, Wen Xiong <wenxiong@linux.ibm.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ewan Milne <emilne@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_111959_967263_705ED0F6 
X-CRM114-Status: GOOD (  19.36  )
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

Unfortunately, it has been discovered that this patch causes a serious regression on powerpc platforms.

If anyone has a powerpc platform with an NVMe/PCIe device installed, please run this simple test and see if it works.

# uname -av
Linux rdma-cert-03-lp10.rdma.lab.eng.rdu2.redhat.com 6.19.0-rc4+ #1 SMP Wed Jan  7 21:42:54 EST 2026 ppc64le GNU/Linux

# nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
                iopolicy=numa
\
  +- nvme0 pcie 0018:01:00.0 live optimized

# nvme subsystem-reset /dev/nvme0; nvme list-subsys /dev/nvme0n1; sleep 1; nvme list-subsys /dev/nvme0n1; nvme list-subsys /dev/nvme0n1;
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
                iopolicy=numa
\
  +- nvme0 pcie 0018:01:00.0 resetting optimized
[Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
[Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
[Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
[Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
[Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O

# nvme list-subsys /dev/nvme0n1;

# nvme list-subsys /dev/nvme0n1;
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
                iopolicy=numa
\
  +- nvme0 pcie 0018:01:00.0 resetting optimized

At this point the machine is HUNG. It's stuck in the resetting state forever.

Because /dev/nvme0n1 is the root device, I need to power-cycle/reboot the host to recover.
/John

On 2/14/25 3:02 AM, Daniel Wagner wrote:
> The fabric transports and also the PCI transport are not entering the
> LIVE state from NEW or RESETTING. This makes the state machine more
> restrictive and allows to catch not supported state transitions, e.g.
> directly switching from RESETTING to LIVE.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 818d4e49aab51c388af9a48bf9d466fea9cef51b..f028913e2e622ee348e88879c6e6b7e8f8a1cc82 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   	switch (new_state) {
>   	case NVME_CTRL_LIVE:
>   		switch (old_state) {
> -		case NVME_CTRL_NEW:
> -		case NVME_CTRL_RESETTING:
>   		case NVME_CTRL_CONNECTING:
>   			changed = true;
>   			fallthrough;
> 



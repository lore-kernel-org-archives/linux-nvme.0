Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92639C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMMIDLFYhjKDbpd2fVFvbQHYdZeC9BpYMZt3FtU3l/Y=; b=gyanaWUfgnzF8CAGA4Q3dwX8Wj
	EZaFSJzbznVXL2Gy16SC/TYwnAtooifM0dVTQ9kfQepC9pC44Bo3O8g+yqbuFhbWV3mJWToNqdlW5
	Q42zTofvROZyxjantI0/UsusVGMH1Lj3Wbs1rVn4q7DhCg3SwieEIxUNfi3Dkex1y7LzysxDs56/X
	VptdxJgdWv9A32DLNHuZV92AWyHwFjaw6GsC84OavadbHuVM4TMV2fYXwx5KlLLHpmPpGNtWeoafg
	Py1+CHIeAOtE6W6Zn0Npeq+yGe+VgbI2hFBLyMtWoONK77xs9WLmWRbFQg2BmeOe02nlDQast7a4H
	+SGKrXuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtwA-00000006uP6-2dx2;
	Wed, 05 Jun 2024 16:56:34 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtw7-00000006uOe-2kHE
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:56:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvYWz0TttzlgMVV;
	Wed,  5 Jun 2024 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717606586; x=1720198587; bh=uMMIDLFYhjKDbpd2fVFvbQHY
	dZeC9BpYMZt3FtU3l/Y=; b=CHNpTwuyyQ2/Vw+IkJ0iRF/7h/7YGhNvMCg/32TL
	92IZfq8YZO3ziQ0am696c97F561j5gzc11NKsXCsB5/SpJWCe82ka68Bdl09oG0S
	+gjsmtrB7eqY03TqFxiIcnmZycxEp6K49t/dH85CZW8xs/RqXV1gf94TWBkNoJrj
	yWzw8Y68OKiqhXcP+fdZJtAB5VnR2GCHFhXCUvoXWlMux42NoEo955Is9AvAmT/M
	NabPbblfBkTnPxAvzLTNx5k0eudDF0SaB51zZMU3ZkxMbxwvcKeCTAFApma+xO0h
	T5/MqxPngZ6T31tuxqZ/5PYBaRmfwRpUe7J7nUEatzw/Qw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3f_26z_J4OVI; Wed,  5 Jun 2024 16:56:26 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvYWp4Cw7zlgMVS;
	Wed,  5 Jun 2024 16:56:21 +0000 (UTC)
Message-ID: <3e49207a-1efc-4fe6-99c2-8cdd9c24664c@acm.org>
Date: Wed, 5 Jun 2024 10:56:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] block: move integrity information into queue_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-13-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240605063031.3286655-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_095631_917178_EE623D1F 
X-CRM114-Status: UNSURE (   8.80  )
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

On 6/5/24 00:28, Christoph Hellwig wrote:
>   	if (!dix && scsi_host_dix_capable(sdp->host, 0)) {
> -		dif = 0; dix = 1;
> +		dif = 0;
> +		dix = 1;
>   	}

Although the above change looks fine to me, it is unrelated to the
other changes in this patch?

Thanks,

Bart.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CB3CCD1BF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0xM6o+j4PkbMpA2tbFFo/tkQnSYUVaiUp1imNg6/7U=; b=jiYTrv0v2MpoblX7MYfLer6zkx
	gocnXNah6efmvQe0v+BXa6lI7y05bcRMeqtUiOSEA4fUx8ZSpHesXoBZEKI/xYiAZ/j+s3+/xC1BV
	rmL01vRiOTndDnOrYS222x40WzAd0NRA2UEUcTEU/ah/8LCX2F4jNmHQBp6zjMoegK+RKWxxXGo3a
	llotuFzruYwXgQPTqtebNXAlidZvnGhKlBXSiGJlDTBPJW3tib+Ok+9I5EcBPDnXEIpS4AnJyX1cn
	bcnCUX2TXJmmqKDoKwGpeQa6Tvul5Kzy9HShoN/3yA10PsqdYeXb+fhyslV7dBpIvs6PHOHYB8njm
	w/gZXFBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDmdE-0000000GKj0-3TdD;
	Tue, 28 Oct 2025 16:33:12 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDmdB-0000000GKhT-3DFc
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 16:33:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cwwsX28jKzlvhyG;
	Tue, 28 Oct 2025 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761669183; x=1764261184; bh=e0xM6o+j4PkbMpA2tbFFo/tk
	QnSYUVaiUp1imNg6/7U=; b=JtnHZgSaeM33gmSF1XwWwXgLDnrrTLaYrhSqsVEx
	7zlhyTC3Ipn5AL2dhdKHDtD+RJ7cVf+gCA7GCUJcToCFmZ+6vaoul4s+xHyQn1y8
	nipJfGsZOatnfExMPHC5C0YlRPz1u23zpdoHZa6a9vcVKE75RyMoponUpTtqHeOr
	3ynosWbSjoji31WOK9otETPWRFk8LUUvkn82QIdxvCf/HUr+WTn9j5qUVe3kXyu/
	BZ/+ztR180piq/3HyKrmTXqib14ObSevGrLdCudIJQXBI8+bbBSg8Vj1aGTz11FD
	m357O5r+dFQlZdpOBB841n0Ye5Aeqzp2wtNMbblYNN3I0Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zWEkcPhpYVsk; Tue, 28 Oct 2025 16:33:03 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cwwsR600Yzlw64r;
	Tue, 28 Oct 2025 16:32:57 +0000 (UTC)
Message-ID: <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
Date: Tue, 28 Oct 2025 09:32:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: bgurney@redhat.com, linux-nvme@lists.infradead.org
References: <20251028142916.700438-1-mlombard@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251028142916.700438-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_093309_902274_0DB17ECF 
X-CRM114-Status: UNSURE (   9.24  )
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

On 10/28/25 7:29 AM, Maurizio Lombardi wrote:
> Currently, there is no straightforward way for a user to inspect
> the quirks value from userspace.
> Add a new read-only sysfs attribute "quirks";
> reading this file will display the hexadecimal
> value of the ctrl->quirks bitmask for the given NVMe device.

This patch changes the constants in enum nvme_quirks from
kernel-internal constants into an ABI. I'm not sure that's what we
want.

Thanks,

Bart.


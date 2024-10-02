Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA00CEACF3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gslW6VDOBWjnvqvcaaFUhPE46K/gPY6VZ++uzHysEOA=; b=RkCSVr0B05b3nRdMMzXOTU2aMl
	9IKh+crxMeyX38lG6Bpr2gxoLEcFR2CRfoEXOz4kUeszQ2/kXYhaR/2S+AEZVqnxYoBhHrzazun+l
	ateagYrYE57FbrpiM6uK1OZc4yuFzvJ8sAEeBIAgxnhZJgPd1ds8z0z1EqW/Ibr6Ue22ZdELSzEQZ
	I0qladWmzRBgw1y2u6HuGpgutUZGZItrjirKEQ1imgsca6fsURkmtmm1XrIHB0PNL4Su3Ck3JHEU9
	tXliYY0lKVZ/N0y35UpzE+LaDtlZZeGjMyEy3aoh7cmsB2fwcf02Yf004O+KeyoPXhGFp+AAkjucc
	7a3CdoWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4Ep-00000007CL6-1nON;
	Wed, 02 Oct 2024 18:38:15 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4Dx-00000007CHA-0GWk
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 18:37:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XJk7N5N35zlgMWC;
	Wed,  2 Oct 2024 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727894234; x=1730486235; bh=gslW6VDOBWjnvqvcaaFUhPE4
	6K/gPY6VZ++uzHysEOA=; b=QVx1wWKlxWBzqLs+71Yxrsn7vyqP4TVpyyjoh4o2
	62HhZ9fJrKxzYpACINtvKg1BPuy36JCEx6L2R3GgrUAQx4XxWKYqNg0RsUMSC6u6
	Aiv/Wrtszkqi7GgdDWtE2cEVHSd8kOc0eNspvNP4435z4urSy/DT3l8U7Afatp4E
	m6rfDf24S/Nn+qdGk10CG2CQefu9V1C9BnvpwIoryOwRTdwarIgnbGqnx7uSSOf+
	3pRFx59bZ+poAt9n+LpCqnn5BZntK47T33xonOKSr5r48mOBmojUu8q3f6us64Kj
	4v1sVhZdMROcTC+UHMX15vGvroOFWLclvDkfowLn9WOudg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W4xEJA9JNW7E; Wed,  2 Oct 2024 18:37:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XJk7C5sgTzlgMW9;
	Wed,  2 Oct 2024 18:37:11 +0000 (UTC)
Message-ID: <38daf18f-7637-4c27-9a43-67ad39dc15c0@acm.org>
Date: Wed, 2 Oct 2024 11:37:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] nvme: enable FDP support
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
 Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240930181305.17286-1-joshi.k@samsung.com>
 <CGME20240930182056epcas5p33f823c00caadf9388b509bafcad86f3d@epcas5p3.samsung.com>
 <20240930181305.17286-2-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240930181305.17286-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_113721_146376_099CCCAB 
X-CRM114-Status: GOOD (  13.36  )
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

On 9/30/24 11:13 AM, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data lifetime information using the write hints.
> The SCSI driver (sd) can already pass this information to the SCSI
> devices. This patch does the same for NVMe.
> 
> Fetch the placement-identifiers if the device supports FDP.
> The incoming write-hint is mapped to a placement-identifier, which in
> turn is set in the DSPEC field of the write command.

Is the description of this patch correct? The above description suggests
that FDP information is similar in nature to SCSI data lifetime
information. I don't think that's correct.

Thanks,

Bart.


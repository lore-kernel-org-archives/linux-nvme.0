Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E8AD58D69
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4fOcO5oHzfFizQ/62XuKUWnPB97Yrx+sO5RZF+icluU=; b=zeEkLgo7ttHo2tFn334Q61m29V
	ixDr9dG+H/6OEbh5OdmAOp4ogPTf3u9Aj475OyWusUUvltFBN70d7pWXdFX4+DjzwDIo19LWjbATv
	awoLVnrsgoDdvqYu2Dt+AyTTdWRKb1bD4CcvVYZXKAExUSsc2dzsC/XBgCza8qukb+HHUSp+Zorkk
	h8Hk168wYNZxUoxfgulnaTjfEf6RnfvWsp8F+ItnzS+uL/liTAw0mFU0jZG7v+/TWAqLClKQDSZDw
	w03pErzo4LPUTAIFtiNbe8UHw+78w6cGgxLNvkOUTfPWhv1iF8bRH4MXAtLS8wi5R36Iu9uLcptdO
	DNoGEczg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcPo-00000008gfN-1Ed8;
	Mon, 25 Nov 2024 16:58:24 +0000
Received: from [199.89.1.12] (helo=009.lax.mailroute.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcPj-00000008gd9-3Fgp
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 16:58:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XxsN0414PzlgMVT;
	Mon, 25 Nov 2024 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732553886; x=1735145887; bh=4fOcO5oHzfFizQ/62XuKUWnP
	B97Yrx+sO5RZF+icluU=; b=Wn2rI6eKVsXxFTCR+uVu6E0DMMo6x60G7tkuui1Y
	dJ1hSF9a1o7g2cChmajhA7S7vEdMF2Tdm7CaCzQ893llpij06DyMpzxDSKGOr355
	HOS4aOvgzWgoEi/lhqLkbmbVvpJK1irukPpSbko2OOa3bDqH/DU8/6EnNBvWXjnp
	f070yUJmdqw5Bu+DfeX5JrqSxeTziehH7sBAhtqnziOXAjXTmj1/ZrYchZVgBSUa
	zHb5f0MIrSlx8YvT5gWD/w8LEF3czy0pPtpdFCe71CdMya1QftF4AfV3na3p53Wz
	ah6vST0RqSrWWW7thwP0CFy40HCqr+tK0Vl5Hrnm/sHC2w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G2wHP0NaEQvi; Mon, 25 Nov 2024 16:58:06 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XxsMx2h9czlgTWQ;
	Mon, 25 Nov 2024 16:58:04 +0000 (UTC)
Message-ID: <7a220428-59fb-4b2a-8d67-ecbe40cba037@acm.org>
Date: Mon, 25 Nov 2024 08:58:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/039: check for sector size of test device
To: Bryan Gurney <bgurney@redhat.com>, shinichiro.kawasaki@wdc.com,
 linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com
References: <20241125162904.7326-1-bgurney@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241125162904.7326-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_085819_839472_51A316B1 
X-CRM114-Status: UNSURE (   6.53  )
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


On 11/25/24 8:29 AM, Bryan Gurney wrote:
> +	SECT_SZ=$(blockdev --getss "${TEST_DEV}")

As far as I know the terminology "sector size" does not occur anywhere
in the NVMe specification. How about changing the variable name SECT_SZ
into something that is an abbreviation of "logical block size" since
that is what blockdev --getss reports?

Thanks,

Bart.



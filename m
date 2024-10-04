Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019ACF8853
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iz9E1I6B8CwQ/5Yzuw1pMYrbYElB81ywXT4KH+Y7XQU=; b=cP74cQ1F2FStCFTrOr2HO/93AP
	LyabpVLRYLkfKVHCavLTdtqgVVuScYisTFBD0y3vSlrQZ2FwRbtMKEMYeXQOHJ/Tmww11zpF4LNYo
	bJi5bvPIeAErhT5DQ/+UPEXxY+lMO941Lf6/xvH9EWZwj23TV/b5IE7GLHNwoOJMHuuGX0XjcpGcu
	j+C7rQItgbNjIXQGzqfp/1BPp/9qwdDJbJXDKY2EJy1egvlFxMkOcGjlve/LCbayW3PCOsytCAwG4
	+n5bCF56ECm5q4dHBfJDgIJwqyZEX+UKhbuPxqBBzSfRAMMLtq0sww2fRUZWCn3kQczwcHAxn4RTz
	k0RPdbOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swlrD-0000000DSpQ-1sd2;
	Fri, 04 Oct 2024 17:12:47 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swlDi-0000000DGXN-3rSi
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 16:32:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XKvFp1xZYzlgMWK;
	Fri,  4 Oct 2024 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728059516; x=1730651517; bh=iz9E1I6B8CwQ/5Yzuw1pMYrb
	YElB81ywXT4KH+Y7XQU=; b=NtWN6QkJCsV2r4R8WncnrhauO+tSXdue3HbT2Lo2
	TDpVfmzofJmXb9frOoHfN+ksEB08Hw7t9ov20HCFj77TGHC/WrvQiMT5ofkCBPFm
	ETFqqTOAxjX+TS7q90mgXQ4etgqN9xs4Zp7FlkFb5UTAICXKVf91/35Muy4k6DTJ
	FZamWuaAGIDQBg8yOhwyplxc4qKNrDfRiHDiftADZxKMv97jfFnbchvHkqJEJwqO
	Cc//A0BUNEh+TX49PYYfqGpF+bRDDphYS00yKaXAwnGQWedQbw2KCFe/bJHJKPWa
	q/NHjCO7RiFTEMS8DzOSwa6iatxDF3Nrntu/91oG4hHVTA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MFDn1liQ5WJj; Fri,  4 Oct 2024 16:31:56 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XKvFl5T3hzlgVnF;
	Fri,  4 Oct 2024 16:31:55 +0000 (UTC)
Message-ID: <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
Date: Fri, 4 Oct 2024 09:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_093159_009213_FE67D841 
X-CRM114-Status: UNSURE (   7.73  )
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

On 10/4/24 5:40 AM, Zhu Yanjun wrote:
> So I add a jiffies (u64) value into the name.

I don't think that embedding the value of the jiffies counter in the 
kmem cache names is sufficient to make cache names unique. That sounds 
like a fragile approach to me.

Bart.


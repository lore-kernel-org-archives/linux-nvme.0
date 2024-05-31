Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5D5C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wJVz7bNhHOT1cnkm63pYOAOw3gi8sYgMJUnqLRq3Cg8=; b=2rYAkn+73GXlttzFxjoiZaYceM
	cnMqvicKmDAlpOitPHQvYCHsPUbQMU6grdOrLPLGZ25MZDJoukxF+dPaBtI9aWHpMFXFtitrtt84b
	q69J+1WRyszUt9N07dXTNHZ1RP6RdcoXRfhf2T1uqauufQDin+wF7WMmjZrqnLQAuQ3jsSAw85KGF
	Aq60C8ZlMz+GUmOXNoR4yZPXNTqfmakMid3IFhKFdwxrB+U/C8w9zC0NhMKLgDcQEA8Bofivw8u87
	+WMAqN5a5ZZUkWPFi5WjbhO1AfM2hMMYTgyADk49zWdx0D5p36zzLITjZyeuFXQtSSp0OShXQm8Up
	9/sQYT9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8Rc-0000000BKId-1TjJ;
	Fri, 31 May 2024 20:01:44 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8RZ-0000000BKIE-36iD
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:01:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VrYsw0P8dzlgMVh;
	Fri, 31 May 2024 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717185698; x=1719777699; bh=wJVz7bNhHOT1cnkm63pYOAOw
	3gi8sYgMJUnqLRq3Cg8=; b=0qaWpk7LyCjJgdcs5tFsFpgx3U3bRd02qzRhuffi
	vrRsYtwQPZjIv+79S0usRcHMXbjCZqBHevbisr2+SU/LkqtyzMlmPKQJIx0M05XT
	u1J1xOmofSVaKUGXZFArJgAytpjE3rCaRq3EWUrPjwfueCmlmpdSCsFCVUJOFsq1
	v/ib1zsZv4/ZVt+U4abRuTlDklcFKPAAk1Rv7DyhnYFg+P0Neb6DhMbxzfoB4bF6
	4u528cDpoABVbf35aQElwopj+uuEiYTTD3JVRyPqFS7OYCovWQvpmgxfKu02ePMM
	l4clx/11ej7G9yeT+V7+OgszY1q6qM3d6i74xszNCDVJdQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id imhqH5Wwtsdr; Fri, 31 May 2024 20:01:38 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VrYss1qT7zlgMVf;
	Fri, 31 May 2024 20:01:36 +0000 (UTC)
Message-ID: <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
Date: Fri, 31 May 2024 13:01:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_130142_041863_DE56D85F 
X-CRM114-Status: UNSURE (   8.06  )
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

On 5/31/24 07:35, Zhu Yanjun wrote:
> IIRC, the problem with srp/002, 011 also occurs with siw driver, do you make
> tests with siw driver to verify whether the problem with srp/002, 011 is also > fixed or not?

I have not yet seen any failures of any of the SRP tests when using the siw driver.
What am I missing?

Thanks,

Bart.



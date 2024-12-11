Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA1E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/JV8qrvMSeI9Y299MeOgobkHL+l5vNfjqH74EmS8pgQ=; b=z1HWOvMRVynOFihUT06gykCQTE
	tA+5EH2dzpqtE2L3qPHMnAZPl0N2m7ZWYPcIDuPwQNELwGLNzWsQhtKrAxjwIUlGEwyORa37MfSxA
	Gy2Q7nUe6VrugJKcXfy/Lcc7py8xoAdwetIO7XCax6oQ8ltRGx1kO40SaA2oVoNENxYRo6RnUHjaP
	dualqWGIsqdCL7FHXugGde07k6aIsKfKn7Ls2r8Ko8vrKOA3VPibvFUOzBY5lMmVU2BvOcRLoJB2h
	r9O3t16/ReVvTlRKcVNl4rIBKEL6PpboSS0Dy8lZ17VxKXPfO2wWKiFzSO5JwyPnkO/p2bhcB9d/a
	pAYucBAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLU1X-0000000G93C-2Gex;
	Wed, 11 Dec 2024 21:13:35 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLTut-0000000G7o7-33PH
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 21:06:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y7p7Q6L4Qzlff0H;
	Wed, 11 Dec 2024 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733951196; x=1736543197; bh=/JV8qrvMSeI9Y299MeOgobkH
	L+l5vNfjqH74EmS8pgQ=; b=ZmIDmUMJ5d05zNVGbU3NBQJRbyahps0uovWH9UvB
	S/vsVkCfJuu3lwcotq2g2bqyjgLQR2FPQWCqa/epPNLeSQYFglXvwQ1a0U13QnLi
	pJiCJK/0ws1teK+zy7bfxBY/E4JaOl25MDsd7L1ax5vfEqLI/1dUGiiWViuUPDAr
	Y/tDDlFvqFYxOGOlZfx9H97R9vt+QQqG0dVso7rqk+P1tCB6KNQcpIIPBvClMJFr
	0IefEVi1npGqbP63HU/lFXiIYQdgkik0965Wad6nWgmrR0Yz51SqtTGQ2NtK9/Pu
	jMdF1YmOBsigc/vI2PBstwqKqljrhjMaaKUXne0IHI7ZgA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TdtYQu5XbU6W; Wed, 11 Dec 2024 21:06:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y7p792X0Wzlff05;
	Wed, 11 Dec 2024 21:06:28 +0000 (UTC)
Message-ID: <97ed9def-7dfd-4170-9e60-6c081da409bc@acm.org>
Date: Wed, 11 Dec 2024 13:06:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com> <20241210071253.GA19956@lst.de>
 <2a272dbe-a90a-4531-b6a2-ee7c4c536233@wdc.com> <20241210105822.GA3123@lst.de>
 <a10da3f8-9a71-4794-9473-95385ac4e59f@acm.org>
 <6ff84297-d133-48d4-b847-807a75cab0f6@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6ff84297-d133-48d4-b847-807a75cab0f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_130643_808260_55E9F951 
X-CRM114-Status: UNSURE (   7.87  )
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

On 12/10/24 8:07 PM, Damien Le Moal wrote:
> But for F2FS, the conventional unit is used for metadata and the other zoned LU
> for data. How come copying from one to the other can be useful ?

Hi Damien,

What you wrote is correct in general. If a conventional and zoned LU are
combined, data is only written to the conventional LU once the zoned LU
is full. The data on the conventional LU may be migrated to the zoned LU
during garbage collection. This is why copying from the conventional LU
to the zoned LU is useful.

Jaegeuk, please correct me if I got this wrong.

Bart.



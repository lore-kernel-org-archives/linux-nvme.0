Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CDEE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMPKRvLE/QQ5urEMkscdu5mz7RjqxapRnt91HnvSfRk=; b=PEL+gXAljUP73y0BqcuupvaL6N
	uv/sOxDSahD8tQ8r8dcd89RgzY3YobtPGevS8ZPrZO23OE4px+kC3yUDr7DYS6Si+H2ftkKN5KwIV
	fw2x46/ELlqDuhjSLkvk7T3bS952LxNUtuvk2ys8I1N6KDHrf+LBUTbRVjwxVIcof+Etzg7VUitlN
	KeTwFrH778rcOBfEB+oH3hB32iCaDLswSYYC0J7Nm2oouvYcq9e7/ePQ/a0U6HYOX89TX/l75VcSm
	qasBgd84j/bpFSgqZaUp2FPF6GjIxvPJn+gu+dneOFZiaH+0CFW5vgrCfkKu9u5ZTOmpzebLBszCM
	smw3SRoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL8Fu-0000000Cspw-33lV;
	Tue, 10 Dec 2024 21:58:58 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL8Fr-0000000CsoH-3K1t
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 21:58:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y7CL7128Qz6Cl4Ph;
	Tue, 10 Dec 2024 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733867915; x=1736459916; bh=UMPKRvLE/QQ5urEMkscdu5mz
	7RjqxapRnt91HnvSfRk=; b=tMCA32fv2C7drEaWNjV7OlmjiTUE1Jwpz1HdJrFT
	DM0W9B1dfiXNGJxiycfCASwnzZaeUDrqagCcJWI8nxwp1EOG0batI29+/QZo9VDM
	LyNaOGM7xTwKNqaUK6PZ06lrIt4Q3yH5lK68FuUl1kz3x56n1/+1laEEN/ZMsSNX
	tbJ8lJY6/NDCYfrlmkZAuqimyIa+kGovBvI3hUJPiIWQssGG9lwkOVGSpcB1mLHj
	fxdNAfwESyPELGpMs85DAsyD/ineFXbI2U3TAPnHhBURBgOFRMFHL0arK8Dvq57Q
	xOPOqlyEyRUhE5CtyKGYC+iG0kCBY/I7cD7ErE5b/8qN1A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KSORL8SM_ZVp; Tue, 10 Dec 2024 21:58:35 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y7CKg6tF3z6ClH0D;
	Tue, 10 Dec 2024 21:58:31 +0000 (UTC)
Message-ID: <6d65d744-abed-405b-8116-b291b33796b0@acm.org>
Date: Tue, 10 Dec 2024 13:58:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Nitesh Shetty <nj.shetty@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
 <d9cc57b5-d998-4896-b5ec-efa5fa06d5a5@acm.org>
 <yq1frmwl1zf.fsf@ca-mkp.ca.oracle.com>
 <20241210095333.7qcnuwvnowterity@ubuntu>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241210095333.7qcnuwvnowterity@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_135855_858496_44532EFC 
X-CRM114-Status: UNSURE (   7.37  )
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

On 12/10/24 1:53 AM, Nitesh Shetty wrote:
> We did implement payload based approach in the past[1] which aligns
> with this. Since we wait till the REQ_OP_COPY_SRC completes, there won't
> be issue with async type of dm IOs.
> Since this would be an internal kernel plumbing, we can optimize/change
> the approach moving forward.
> If you are okay with the approach, I can give a respin to that version.

Yes, I remember this. Let's wait with respinning/reposting until there
is agreement about the approach for copy offloading.

Thanks,

Bart.



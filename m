Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08968C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nzt9qDt5h+70hQ0fqdsDup9j6gDQZjBLsr7H3jI9z+E=; b=V7l8f4cvQMcy36Oto3ioSW+UCD
	fQfp5HIui6yWkuAmeuz3WmLdpIL0cRIaBp2QKXWsow4cpMSS7cWy/TfBklfzExeD+zBCdPk9sjt7r
	OE1Uh5pWhxe71srQhhSJb7l4lmk3NNC5k289eX6cFjMJfDcSTfqWO8/ZfTkyX8KsuvQ2KeYeumV/3
	eZsADTQ4OppFgmpTk8VwIXpfsIpkursEmtifpHQjacxj8iZkX4E40BlrtDMZdQ10W/aJJechfHGE0
	RbFjXkaWlZ5r1bBn3aEzCEU9UaO5jQ0NqqKVkKFjUyYYgO4F1DTEd/L3JD9mDWlt6i330Tn1EVEvZ
	99eqaInw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9CPz-0000000Fnf0-1r26;
	Mon, 20 May 2024 23:27:47 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9CPw-0000000FndO-1sYE
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 23:27:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vjtyl5Q4VzlgT1M;
	Mon, 20 May 2024 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716247657; x=1718839658; bh=Nzt9qDt5h+70hQ0fqdsDup9j
	6gDQZjBLsr7H3jI9z+E=; b=C/YA9Sy07IEM+qqgYqVbUuTT2eae7FaZjY67RglY
	xs8JIZ5fIEJmIi/4yguN7lWemkIY0lF1uW4HaGT1T7awti5GTnTBmHKQ04JxrUUa
	LSDC3OeoJbL4RngdRtaktFL03Ec7biVRlKEwJ2GVnG9wWiYUekcgidKdm8eayTXE
	glYavP90/fn4z+2DgVWcbXE9mLkd5i6gxajbPM/JL0vPaqHYUmeFuEWk2YtQcdn7
	oR8/laYOwODyy/CdsxFI5H8VGrTkV1ppmN28+l4eH5dYRW+sAmPhzOgwoDOKEyq/
	IlC4XiLikdRNeujS2eAqTmGSSddZuhR3GALg8lwyKmz5eg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ozaYIhn_TTJn; Mon, 20 May 2024 23:27:37 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtyW3wcTzlgT1K;
	Mon, 20 May 2024 23:27:31 +0000 (UTC)
Message-ID: <de16a905-3cc1-46e3-b9b4-494ad73cac07@acm.org>
Date: Mon, 20 May 2024 16:27:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 11/12] null: Enable trace capability for null block
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2@epcas5p4.samsung.com>
 <20240520102033.9361-12-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-12-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_162744_535805_AC86D47E 
X-CRM114-Status: UNSURE (   8.83  )
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

On 5/20/24 03:20, Nitesh Shetty wrote:
> This is a prep patch to enable copy trace capability.
> At present only zoned null_block is using trace, so we decoupled trace
> and zoned dependency to make it usable in null_blk driver also.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3330FCEACF3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kzNe6QUlP1JNy84U5yCP///ViUFTozy1TPgdR21dakY=; b=45b4wgON2Xf3pZG2lTwj/Pvahe
	AmybXJkaeK0iNpC2ZCw7wxX06LdjfIZaab39fmRwBJyzu5IVuYn4uSBG2ilYD078wCa0x8dAaIQy0
	F/fm7iRC4vHods6SO3gnkrdKA7lPx1q0oCiFZvS/1mMz4BlSspByZwjvHCqNFV8mW5nOYLXYTfTs/
	MU9y34iQg4CmF8a48Gx97ja0aNCDb0XmyFzXYx3Y9ySITFtU6I2CPJxzqXtSEC9w5HoJYbAPOF1Dq
	4jlABfsJoEPy4JnCcA48yTdj/iNF13nymv/Qw2RmMyK/y6PB3Ab8W/bWydgNPpCKKAi7koUZ18mQr
	wQm4na4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4Be-00000007Bnm-1qtV;
	Wed, 02 Oct 2024 18:34:58 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4Bb-00000007BnO-3mbe
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 18:34:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XJk4b4gdPzlgMWF;
	Wed,  2 Oct 2024 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727894090; x=1730486091; bh=kzNe6QUlP1JNy84U5yCP///V
	iUFTozy1TPgdR21dakY=; b=QYrxUfhY2HEnpYiOXgZjyQOj6ij3lmiTPe0EzcWX
	VHNwFsKQ3sLoGdt1vHmVxXRgU+HDUTu5F0MKIaRDFZAgHJRd2F6BvEsvlx1tJ/7e
	rJ0ZF7lcLizXrflaN86AGaGu0ce/JAem0ecIJAgKhxHnrF2IOL1LjeZ0mjDDuWAd
	/JkcmFkcwYqlZNQ3spPeQF1K0n0djZ0eytsPkBS8XHaPoj52NFnmfK1pyABJtG9X
	nqlyKGdHu1TPjN5/nZi4uvXPJ0L0bqwKGL1CPAXx0q/g7sgEVuX4Ekd4X3S2fLHy
	SoCpFqNMeNpgEIPQ1QMw9IKyfVMfgrY6sjwJpCwU6cpSWw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gXBClRYEWh5K; Wed,  2 Oct 2024 18:34:50 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XJk4S0XGjzlgMW9;
	Wed,  2 Oct 2024 18:34:47 +0000 (UTC)
Message-ID: <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
Date: Wed, 2 Oct 2024 11:34:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_113455_983589_3FF791D8 
X-CRM114-Status: UNSURE (   8.36  )
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

On 10/2/24 8:47 AM, Martin K. Petersen wrote:
> What irks me is defining application interfaces which fundamentally tell
> the kernel that "these blocks are part of the same file".

Isn't FDP about communicating much more than only this information to
the block device, e.g. information about reclaim units? Although I'm
personally not interested in FDP, my colleagues were involved in the
standardization of FDP.

Thanks,

Bart.


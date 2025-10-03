Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D2CCA471
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McfIq4nefZYN5G9+pot4eBcPGCpYCB6FZH1gcGcVDoo=; b=c6VyHeC/yISM1GXgda7ViUsmsF
	hweIZIIY0p3dEUZmNEdFqmOT3KPdAIvBAliHIk76RmGGRII0w9hcjGYWQYrh6fLD090icUQ8fNV7o
	uMQIXtRA4DsP/rgyhaFPOU8tqavdW294RZV+sSUqHwgdn6NmkJ7OAIrtlGtly6xhTc+0w2/kI+RpQ
	D8tyRVwh2aUMGjUhmDqouvEpxO4gkbsAsjlZRhtAdLEJGRWmQy0mhrhRUBJQgXh8tv2eNLesynyfy
	sn0xdI2mfEQw8jbd7bQUNYtS5hOetHErSXR1OuJ3o5eDXh9bXIF+xyZS+D/ESL8RoHb3qMdlBOCz8
	JHDHI6Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4fn6-0000000COOn-2w22;
	Fri, 03 Oct 2025 13:25:44 +0000
Received: from mout.web.de ([217.72.192.78])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4fn4-0000000CONy-071B
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 13:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759497935; x=1760102735; i=markus.elfring@web.de;
	bh=McfIq4nefZYN5G9+pot4eBcPGCpYCB6FZH1gcGcVDoo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=USl4xRXYmAf1W3Y1T0syoB+Uw2esio06QNMBY9PkcHqGXtc5hPKmkSgPSymwYBTA
	 fvr3SxIYXg7OvG5Zx+8yP2DhjZ4uax3h7/yufBysNxPqTl6wZkSi4GoT7ZXfeGcxW
	 vY4PGYE48BZnwIDy+i37l9HerdhV+rOzsnsfCgbQbiNWQLSOB/WtLE2JV+gy4/tw7
	 EZrt8N4H1rmNbsaUmcTj8XJfE/RwuTUBZKtxr6mL6AIDpmwpFYjOrnuoMFQr89x9V
	 PQ7mkUgbz5FRvW5hjeBqN8kXiu+kwJu+rma1U+v+ouoSJY1WK41ukMSRTbVfeDT7D
	 +8UtPg45Hdgmc00Fqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlL9z-1uaaIt3Xob-00gcYI; Fri, 03
 Oct 2025 15:25:34 +0200
Message-ID: <d636ad52-2ec6-4b5c-9ded-a7dc1e1291be@web.de>
Date: Fri, 3 Oct 2025 15:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>, linux-nvme@lists.infradead.org,
 lvc-project@linuxtesting.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20251002092202.11-1-alsp705@gmail.com>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251002092202.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i4BdscEo73r96DewLe2en/58NEL/o7c4xX2KkxJscGNS+0o3VBG
 umgwV2LltVxa22EuhrmAfbR/+OppRMCnckzWnJ3cou5N0of4GDcP6EbnW/2ZRbvXkcKpJb1
 w3/j/bAau0iz4arkbpdJ20jVbAcGsneb1tME/H5TmyV3T9J+92SWw3pZdn6on3iF7U7te1d
 qUOeAXDiqpChmEYzn6dhg==
UI-OutboundReport: notjunk:1;M01:P0:WfOLgRGKaF8=;LFqS+X20dm6G7EZhRYMHt/gyPbL 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 nBsX8VJaaL4qQtDCj4dMDLg0hQeA+29c8ko=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_062542_443073_A9F4BB7C 
X-CRM114-Status: UNSURE (   4.66  )
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

> The nvmet_fc_tgtport_get() function may return an error.

Would a corresponding imperative wording become helpful for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n94

Regards,
Markus


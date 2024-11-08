Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C88AD64072
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVPYyABt4fIR2H2QHQjsQ9GDszOfP+4CM0lq2I2MeHU=; b=49wWnE3tLbT/Crnoz7lM6QKS4t
	QjSKpMqPTGxv3uFkj4oM9rTYeiWa/6ruBnZqXFZuN35pmX8c95R9JsOq07RiQ+tuG0e3k4GOiKei/
	4BSMrq6gneXZc7z3SMeh7C0oKvNu5sL9vSyuroPeR2xIUVNLd4A2br38DFBPgBMYoHl3Viz6I+7mb
	dOmM3fuNP4iW0q4gc0isSCFW+Gw+6QSxqGk8zdIMcvZALVdAUwMX8JiyxMapYFpjKzWVrDhAH/Ffv
	r97sP8i3HVqRfOuma9j5rsk13TV5DmW80ZLSRzKroa9gtIwJPGwEy7TI6YOJvoecYSOflcHTa9SE7
	swl7+i3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9U5l-0000000BeS9-1kcV;
	Fri, 08 Nov 2024 18:52:21 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9U5i-0000000BeR9-2Ynf
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 18:52:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XlSjM11PvzlgTWK;
	Fri,  8 Nov 2024 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1731091923; x=1733683924; bh=JVPYyABt4fIR2H2QHQjsQ9GD
	szOfP+4CM0lq2I2MeHU=; b=zRuyM1VFZ0FXJma19dczCVvpm+qz/06pgLbBbB/k
	BBRfVJJ5Agbtpzut8QwnRXGN3z6YdIz8XRPWNWZsHx111VOsuFyBe4exmUfvqcbo
	tVpD2OvlLgLpYmo3rhy5MkHx3qlBJHrsWPKP8O7cJD8+fkdWKHNWXslRRHir0NOD
	YWgNGEt7jdelnDraiq3RRJrRHeW0jBLSyxAYZgw5HSlYUQUEEJ7pQ0f/h5++VDNV
	54In+/EwxNdPbFtHlXQdU5BjEfPPpIuiSy3bQ0aApmgTErrctjUye9y+Zcuy2geK
	7tS/qlfOG9kXuqXUzzO67Y3RACA0ZqZF/5tiC+BwmRGSJQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id votlEUy7cqa6; Fri,  8 Nov 2024 18:52:03 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XlSjD0CbmzlgTsK;
	Fri,  8 Nov 2024 18:51:59 +0000 (UTC)
Message-ID: <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
Date: Fri, 8 Nov 2024 10:51:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
 <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
 <Zy5CSgNJtgUgBH3H@casper.infradead.org>
 <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_105218_708953_430645F7 
X-CRM114-Status: UNSURE (   8.48  )
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

On 11/8/24 9:43 AM, Javier Gonzalez wrote:
> If there is an interest, we can re-spin this again...

I'm interested. Work is ongoing in JEDEC on support for copy offloading
for UFS devices. This work involves standardizing which SCSI copy
offloading features should be supported and which features are not
required. Implementations are expected to be available soon.

Thanks,

Bart.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F95C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rXmAoTx3CNlh/GGc7KRf6DwDOKO0u6bWqKxzMYf8jk=; b=Cs2fWYPOJpJ8PHN7Yf0+M9F0FN
	isILsO7sOsMEQHKauUL+69O+rBc+DAgBGGvLfLVGq7jCoxuNrGPzTSvjk4/9/I/V+9Os0q1MKATty
	288fDToM8oXmepf/NY51qs4OaXeDA4QgFj5UFF3xXS5ciB+mBUi6fPxDiCVtfDVEa+xtRmBAf2vQQ
	aTWQvvGac1wqGTu5HALD+CJxSYykPmf4/dDffJzj5ePQwRh2vw/xfmxNblLUxj2ikosh4m8rgzbGi
	NYdQvURrw9K/gCfuI/cy66zIgnMIgvMO373pL8Pigh2g63KTWuCYxTK6TuHmcgUMNd/8lJLBKEWN2
	/ckubAIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAVMG-0000000929p-09lI;
	Fri, 24 May 2024 13:53:20 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAVM9-0000000924C-3ue7
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 13:53:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vm61m2xr9zlgMVR;
	Fri, 24 May 2024 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716558774; x=1719150775; bh=2rXmAoTx3CNlh/GGc7KRf6Dw
	DOKO0u6bWqKxzMYf8jk=; b=YVdOKINEcaBAiCvlkuTSwdmRd4IpR916nbHNtrWY
	5T2+ihVtDJKqlKwmp55t4ZGsaAzSwT8N3iUuthzOrGokFyOvHHHwoPanRwsFqJ3L
	3v2Tf12D8XdQq//ARpexroy8PAQc3DvIPAo1doOavE1SyJ7oHv4W9OV2603l0oco
	7zFScfLDbfWVFi/uA43qiK6iKKSKOEcdEHdyd7YLIsf2nNPig8QWNBxvW+wBDWpB
	pbjSBfk2Fl1FpSrXDsqy4y/4rKohiQq0aoPcAgDKotDRQNQ449I/UEpVFtqL/lsU
	q8KrTHUOkpAz2XpNOWt/hyTOKKxQkQz9q/Wy8v7/RNAGKQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IazCX3NYb6ZA; Fri, 24 May 2024 13:52:54 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vm61V3wB5zlgMVP;
	Fri, 24 May 2024 13:52:46 +0000 (UTC)
Message-ID: <144e9e03-d16d-4158-a9eb-177a53b67c6c@acm.org>
Date: Fri, 24 May 2024 06:52:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
 <66503bc7.630a0220.56c85.8b9dSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <66503bc7.630a0220.56c85.8b9dSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_065313_989270_BA171CF4 
X-CRM114-Status: UNSURE (   9.44  )
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

On 5/23/24 23:54, Nitesh Shetty wrote:
> Regarding merge, does it looks any better, if we use single request
> operation such as REQ_OP_COPY and use op_flags(REQ_COPY_DST/REQ_COPY_SRC)
> to identify dst and src bios ?

I prefer to keep the current approach (REQ_COPY_DST/REQ_COPY_SRC) and to
use a more appropriate verb than "merge", e.g. "combine".

Thanks,

Bart.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054EC55AB9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UGOylGcMnPKCajPRzJ8KFfA+79mmuQAUQy7q/I6/FQ=; b=fXT8PWX9L+xeLgFJjhKMWY6rI5
	/J11v/qw5zr9S2c9nRo3Vlq0pog5j4hRMuSeRGKWDaQbYWg3DJFp8n1LxGvSm2SXKSug+a/+e3cJI
	U/jWLNFPKw7PuA/n76AS+9jR4prRVfzaQ61RnptN879xRAAz5Z+nlAvJQpWoM640E9BeJyPoya5Rk
	h8Et3eYERJ//Xs3/WODwXzzipz/P61gba4jiJdT32Yh52l2JPbqG3qPnFWaf1Z4ynqiwaoEh2Anqf
	0HwtGeMfzhfgpF+gfSQUlRo7OXvDZslfm8OS5AvUgq+kvxje0tJy/mhNBdLnDuZB997fod0Bfk2Il
	X7gkeawA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtQRv-0000000EXL7-2i5O;
	Fri, 20 Feb 2026 13:21:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtQRr-0000000EXK8-1FXg
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 13:21:38 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260220132126epoutp04def3d163b58d54817a435958df1a04a3~V9xJElYw61205612056epoutp04L
	for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 13:21:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260220132126epoutp04def3d163b58d54817a435958df1a04a3~V9xJElYw61205612056epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771593686;
	bh=0UGOylGcMnPKCajPRzJ8KFfA+79mmuQAUQy7q/I6/FQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=S4UGP2sgJtrD9hEMqTwgoPh88yMKGsOiYk9N3Ldpf1EJa97uS02il5P8KjTYTn+fb
	 d/HmFngSoM8mAhRkh1IqbgUllqln/CIBmP8UvTjvVLYRK881o3jlYGZXaffubar5PR
	 MCz5+NMbvMfiAXlvOSVdqIYkYuJhbx63BrPtg3tE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260220132125epcas5p18c2f046278f19d41be83b6718f1aa212~V9xIyDkXi2080620806epcas5p1K;
	Fri, 20 Feb 2026 13:21:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fHW9J6ybpz2SSKY; Fri, 20 Feb
	2026 13:21:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260220132124epcas5p3a1a05b9b45023c74d86328beedd0d392~V9xG_P7n_1563515635epcas5p3z;
	Fri, 20 Feb 2026 13:21:24 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260220132120epsmtip2aa721d290d0c97502e090300ae4740f7~V9xD9WO-K2307523075epsmtip2G;
	Fri, 20 Feb 2026 13:21:20 +0000 (GMT)
Message-ID: <85300692-ebff-4fc0-a891-07405c554530@samsung.com>
Date: Fri, 20 Feb 2026 18:51:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260219172228.429479-1-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260220132124epcas5p3a1a05b9b45023c74d86328beedd0d392
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260219172309epcas5p2bd985f806bafcd2b919963ef689dc9a1
References: <CGME20260219172309epcas5p2bd985f806bafcd2b919963ef689dc9a1@epcas5p2.samsung.com>
	<20260219172228.429479-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_052136_626548_13A3F698 
X-CRM114-Status: UNSURE (   8.24  )
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

Series looked good to me.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


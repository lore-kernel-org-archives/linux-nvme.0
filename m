Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A8EEE258
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoPUxbKNemTOQj/Zcm/S7ujkVqb72FxciPCp7L8rpDU=; b=Gf+R0TyafIwn8M1yWFYMoFV7hk
	5wP3LmCU3KVMmITKBXnarV43wfPkGONTioiOYwNIvSPPKbqoCYvesZEds4rqslcXwHBwrbVtSDWSN
	BnMW+NjBWVoGsIlU1TP+T+u07sWGZYpqArpM5NDj+UWgE8nk/pvR6K5/s2XeGkaxyCR9UX2WSc46+
	duwAI2ruUCCTOLWG5bt6dMAYDXqYAHTYh/e2NKuYnAPK5BQmR2MLeZz5I7UqsM6ROc+xpIS22dgAF
	cM8hnWDA81B5Ur3EyY3PZaf2d5rKCkF1qF+tc4+mm3o3ojc+Xu2hjJmkhlU4ITVNbWHKl29nkTRRW
	YBnprXpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soqSU-0000000EAkc-2HXK;
	Thu, 12 Sep 2024 20:30:30 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soqSP-0000000EAj8-3tXn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 20:30:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X4Tb03tzXz6ClSpy;
	Thu, 12 Sep 2024 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1726173015; x=1728765016; bh=JoPUxbKNemTOQj/Zcm/S7ujk
	Vqb72FxciPCp7L8rpDU=; b=hH6eRhNtR22x34qVLVhBhAs9zKC5jX5xUull0HKd
	cmgxk/UNnJpKcxNkOIS17H1Xfp7QcWx2voAJSOzuTvSJx0cgMJUC5tX1dK1gEy8z
	OO778DUdPMTBViGFqSys0NpdDVtclnF1VD2ZjcqJ/sC+92pEzv8dNzsIIFFLdykd
	+xsBSJnXpae75RDkwsn423y6Ahy4jNvODjnLhKsJElbcD9NhsXuH84irg2/gNejC
	siDnbqIQQn/WkqYdUhuq6eP+mdkDv0OeISTR+4Y5SC0wGgqhUMLgcun2Yzv9kmuy
	kzYxWZsFBAFm5IdevMHuC93m7imVwEcbPuTSBVuc/lFBvg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WSfMN2Lf5--p; Thu, 12 Sep 2024 20:30:15 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X4TZq34P1z6ClY9y;
	Thu, 12 Sep 2024 20:30:11 +0000 (UTC)
Message-ID: <fe2ae1b7-7c77-49e1-ace0-50e937f2c32c@acm.org>
Date: Thu, 12 Sep 2024 13:30:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com>
 <20240910150200.6589-2-joshi.k@samsung.com> <20240912125347.GA28068@lst.de>
 <0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_133026_028812_F8CDB3BB 
X-CRM114-Status: UNSURE (   6.58  )
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

On 9/12/24 8:50 AM, Kanchan Joshi wrote:
> Wherever hint is being used in generic way, u8 data type is being used.

Has it been considered to introduce a new union and to use that as the
type of 'hint' instead of 'u8'?

Thanks,

Bart.


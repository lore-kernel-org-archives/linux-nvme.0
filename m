Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E8606A337
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R6ynizRl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zpHxO48Hcdkozl39mid44eEhHNKjhkzsWRO8v03EMDc=; b=R6ynizRllJmBZaA3udRZepKiJb
	PFlcAH0PJG4F8OJS/YwULc3yik+KC/WGlCO+npUVvluC8szBW/auQ1DzKOMoZ/YGtqjbzBAm7PEcQ
	dT8ZOn7arTNv29Sv4qDrHDtDl4jlSYmOFXmspZN/Owa7HsLKKJdglGyjBP8d5o1Yt7AMpfhD8XMjr
	h3P6Tvdtr/Qsa4b2wO/eKEGj7oS8Iug7+4tEuMODd9zpHfpGXIgFjk9EGAnTEHeB3OzzCt55ydpF9
	wsi/B/G20DeBwfsF8VXk7T4IR043YB3Z0vpB8/ji1JZhEmXdsYNfyWxHgMuuPUgsvQHKeCPsBl//1
	OydJdMPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHc3-0000000C3ot-0fGi;
	Fri, 06 Nov 2026 10:56:03 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHap-0000000C3Fl-2zOo
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:54:50 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLbfV65GDz8XrrJ;
	Fri, 06 Nov 2026 18:54:42 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A6AsYqd091181;
	Fri, 6 Nov 2026 18:54:34 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Zmail-TransId: 2afa6aedb1edc44-66d0a
X-Mailer: Zmail v1.0
Message-ID: <20261106185437698kfychwPHz53w2DA9qZCRr@zte.com.cn>
In-Reply-To: <20261106104012.GB5633@lst.de>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn,20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn,20261106104012.GB5633@lst.de
Date: Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIG52bWV0OiB6bnM6IHJldHVybiB0aGUgbmFtZXNwYWNlIGxvb2t1cCBlcnJvciBmb3IgSWRlbnRpZnk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A6AsYqd091181
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 18:54:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDB1F2.001/4jLbfV65GDz8XrrJ
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_025447_924214_9A9EEB01 
X-CRM114-Status: UNSURE (   5.96  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 06 Nov 2026 02:56:02 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:40:12AM +0100, Christoph Hellwig wrote:
> The fix looks good, but please write to the point commit logs instead
> of detective novels.

Fair.  v2 keeps the code unchanged and rewrites the commit message to two
short paragraphs: the done label overwrites the lookup error, and the
fix returns it.

v2 follows.

Thanks,
Shao


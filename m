Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D81606A338
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tnKERn8kLNE/XYtMUrmwCSiXpsYUwB5jGNqoeDEI5WM=; b=1ZJYsQLS0b28Ih7z2+D8u0cJjB
	1br63c4nikT52OpfkWU/1B7mK3mkiajdrCGuReN4UcuuHx5EospxsoujToiZ/i6pBSd7ovg+MweOq
	ArHMrXqvY8DAfBfrAaiPEtnmH5c2Yo44f+HHFWudMpSvLth2122c9duZu9/qwvh0U8Sy/oBxAn5F2
	S742tEF1JL0J0sElkyXpsl+XdX5T5cfy9Z02Ic+So77zsoqR/+e5sp133jktVTRAzMRfvm5GyA/HL
	VX9iPJ/M/AHcw29ecIc5+0N93ki5f3NCumIOci7uBl3Si9n1xDyAio993iW6PxiakkZTZzdQWRgXJ
	S3ZkV9Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHc3-0000000C3p9-1IDJ;
	Fri, 06 Nov 2026 10:56:03 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHar-0000000C3HT-17Qb
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:54:50 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLbfb2KXdz5B12g;
	Fri, 06 Nov 2026 18:54:47 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6AsYjS091147;
	Fri, 6 Nov 2026 18:54:34 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Zmail-TransId: 2afc6aedb1ede3e-55f15
X-Mailer: Zmail v1.0
Message-ID: <20261106185437430NmohowCOBUVnZF5l4dRE_@zte.com.cn>
In-Reply-To: <20261106103932.GA5633@lst.de>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn,20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn,20261106103932.GA5633@lst.de
Date: Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIG52bWV0OiB6ZXJvIG91dCB1bnVzZWQgZGF0YSBvZiBmaXhlZC1zaXplIGxvZyBwYWdlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A6AsYjS091147
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 18:54:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDB1F7.000/4jLbfb2KXdz5B12g
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_025449_468854_35FFBF26 
X-CRM114-Status: UNSURE (   5.98  )
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

On Fri, Nov 06, 2026 at 11:39:32AM +0100, Christoph Hellwig wrote:
> Given none of these are in a fast path, should we simply zero the
> entire transfer length first?

Yes.  v2 does that: each handler zeroes the whole transfer length and
then copies the fixed structure over it, instead of zeroing the unused
tail afterwards.  The Error log zeroes first as well and clamps the ring
walk to the requested length.

> Also please cut down the commit messages a bit to be on-point.

I also cut both commit messages down; the long rationale is gone.

v2 follows.

Thanks,
Shao


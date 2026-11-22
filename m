Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD4606A32C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IjRo0tIg;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=K+ByQQKu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v0jrcO95QNbjtMp9ii5JuvvBFQFujvmXY7TE0yaao8c=; b=IjRo0tIgmRlevReRkfTlBqjipg
	arprxj5BCw0yM/EOMBDvaZ0DOu8qAckl/jQfyPqyeLOFK5iOWEOyHNCMo7YzQ6lDJ8lKabhOpNXK5
	mxff2IL16XU07dyoanq90yqFuou6pLNbUEE9pRsu7urb1QsyefsswzyEZMgt7Ym8/KMzjFQOfgovG
	BjsNpqHhBsAJ6Cax++N4m9xxjqP3wQwaDcYIuDSUlXQgQfGqP7UoJiLjdIUgHdA1BreFy5CnNHrUk
	WwN7ZmcgueD5V/MbVwmE+2mKoDMnSmmR1Ncvx3NRox8KVSubyaTpbGSyDytDFjnf9+UALssjdTzGs
	01wmhwmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV9cf-00000001HRC-39zH;
	Sun, 22 Nov 2026 15:36:57 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV8bg-00000001CSH-29Op
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 14:31:53 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXWjd73c9z8XrrM;
	Sun, 22 Nov 2026 22:31:49 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795357910;
	bh=u6c4MZjb9s2wR6f+AUHlY3U/e89ELkEpH1d6TgPWLME=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=K+ByQQKukJ4XEQhMbWHN191LDxGNIDikQYPKMOumIanTCkpB6AlEdnAW58NBrfBAS
	 UOXsEcCQFU0Z9ikOf/I81UBTKo+Hl/kOWIhGKsaqwQNl8cgm0bT3O/k3Q141vICNva
	 37DwuEzKN9tM++lA3DjbOMxAdfsNQTetW7oKDRa3qUtxllQiwM+BgwSC/igRaQP1Yk
	 ut0ggeOA9KcsrPS/Wc0D9wMtNNTLjCwpeCyDBLciIpPRtipcAltIzjNzoJhYxYOuzM
	 TUqf97+odKgfenSTdxiZ6xdiJ8szG4udNAHSpF5C4lHmD0khADPZxqiwkRBH8iSvYp
	 SZdUPMEYUzZqA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AMEVhj9024113;
	Sun, 22 Nov 2026 22:31:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:31:45 +0800 (CST)
X-Zmail-TransId: 2afb6b02fcd1e43-44a03
X-Mailer: Zmail v1.0
Message-ID: <202611222231458938QkRVDJ6-CnPlY9C-NaNY@zte.com.cn>
In-Reply-To: <CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn,CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com
Date: Sun, 22 Nov 2026 22:31:45 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <csander@purestorage.com>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzVdIG52bWU6IG1hcCBwYXNzdGhyb3VnaCBkYXRhIHdoZW4gdGhlIGxlbmd0aCBpcyBub256ZXJv?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AMEVhj9024113
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 22:31:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B02FCD5.000/4jXWjd73c9z8XrrM
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_063152_884748_A470D999 
X-CRM114-Status: UNSURE (   6.39  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sun, 22 Nov 2026 07:36:54 -0800
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Caleb,

Thanks for pointing out the no-data command case. I tested it on
next-20261120 with a file-backed namespace over nvme-loop. I issued a
Read with a valid 4096-byte buffer, then reused the same ioctl command
structure for Flush. I reset the command fields for Flush and cleared
addr, leaving data_len at 4096.

                               Baseline       Proposed change
Read, valid addr, data_len=4096   success        success
Flush, addr=0, data_len=4096       success        EFAULT
Flush, addr=0, data_len=0          success        success

The earlier Read and Write tests only exercised commands that expect a
payload. With Flush, the old mapping check leaves the request without a
payload, and the command completes normally. The proposed check tries
to map the stale length and fails before submitting Flush. I haven't
identified a deployed application that relies on this pattern.

The case covered by 99fde895ff56 involves an offset into a registered
kernel bvec buffer, and zero is its starting offset.

I'll drop this version from the series. If the missing buffer case needs
a fix, I'll evaluate NVME_IOCTL_SUBMIT_IO separately, where the allowed
operations all require data.

Thanks,
Shao


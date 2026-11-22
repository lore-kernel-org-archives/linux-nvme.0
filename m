Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648D606A32A
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pW94nVFW;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PM/cmPap
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K5SpmYF9qIoDujQ9JAnH9RzElX//Bxtoew+aHb0jqvI=; b=pW94nVFWgiLlyegtwCcOmZJXTL
	34ybNMnJc4mJju6PoWAvpWtOcDhLCQ4Rei5ZclvcVkGGiiET4EzBoSF3Zd2v1UP6vyUeEti71m7nU
	rIpyMr43A2AVkZWV70AbAbgXHoH4uaxYEINwi46k+BeOoxWxeVCFS8bQWKg3mckGbdP12VllM8hgD
	0AQP1j08Rl5yQjF9k4SYzwini6iIG5+ozk4ZgoNDSRYYKfm3lfWFKOrKvPFlkXpMT/Hm39i7hgZBO
	llGx9qyC1B/TOxMQgTVQFSuwIjZDl1iTqgINHFCGmGwqvs/wdchvXtN0fXTPHK1/lyIEOolkAiArs
	vrukyaFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV9cf-00000001HQv-16Ww;
	Sun, 22 Nov 2026 15:36:57 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUz1y-00000000jAD-1bL5
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 04:18:25 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXG5Z4sKZz8XrrJ;
	Sun, 22 Nov 2026 12:18:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795321090;
	bh=gt1N6m13cI6EhWhLtyiHmPGo+hhNRPWASFwiBtKk+cM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=PM/cmPapFT36jjYL/esSR2YepgO53TVhEOMXTqWo+8qdIBE7KOXT8+/0xtq9Y0V0T
	 cNH4c/uIzcLp7tGH/ApErvwKmExmKRRtrcPxX0oeQkAETOh7lH2JRnhlB4qhuSXOaE
	 66FL0zJm4d+BeaS64f9XwjoE6DFD45wIlFQ33l7HHr2Oxc+zOsVhDMcMmgfWk6ziu6
	 HHE+IfrKmouHRXi5906rGm41pwf7Kb+pCspcc2nWsHgOoFZW34iYGkEdVi+ZDP3Ln+
	 b/NA7MUAdzRlwGZ8fbM63KknWCJ+KD2Vt0ulekYLjvq3PW+VtLAsclmf/VJWzOeGvn
	 1Ndd6Y0awQqlw==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AM4I2QQ014271;
	Sun, 22 Nov 2026 12:18:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 12:18:02 +0800 (CST)
X-Zmail-TransId: 2afc6b026cfac28-10a1a
X-Mailer: Zmail v1.0
Message-ID: <20261122121802335D1zR-8sXZ6-R3aYDkB2lK@zte.com.cn>
In-Reply-To: <20261120174914.GA1484@lst.de>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn,20261120174914.GA1484@lst.de
Date: Sun, 22 Nov 2026 12:18:02 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIG52bWU6IHpuczogcmVqZWN0IGFuIG91dC1vZi1yYW5nZSB6b25lIGFwcGVuZCBzaXplIGxpbWl0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AM4I2QQ014271
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 12:18:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B026D02.001/4jXG5Z4sKZz8XrrJ
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_201823_016691_5BB9A281 
X-CRM114-Status: UNSURE (   4.26  )
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

Hi Christoph,

> This warning triggers for perfectly valid values that we just can't
> express.  I think we can just drop it.

Agreed, I've dropped the warning in v2.

Thanks,
Shao


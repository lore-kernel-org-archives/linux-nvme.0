Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB1606A889
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eeGmkBIX;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tpMyBUOe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cb5obflgdjLo8+XlhF7MpnjCCe8r/1kAHNWYSeIRm+Q=; b=eeGmkBIXp4l1c/suXIUJFXRVx8
	E0vt/kXfXMrxzRQJr/5iS5LIodLZ1GoBPKWYZnFNGxy0waD/jzdO2JCJsM1wleZ2TfiKkXJNJxLK+
	mG6/Vckiupg689tAGifgx1xvDj54AW3Ud9yjpXREshEK6bBqqv59EZqhl3URDImNqw4NUDkkGPSYD
	kn4g6ITl9tEZi4JRfqMUZRzD+JeSz2GrWXJd0Ks9aDjU9cWaiaJbcVzWdPRzkj+teEUaS2yL9wcmE
	m75AMXxaP+IXaX7PvBZ/3s4uyqziXkFBmtkADvGlJvjcJ6MB8nk0Dh5CnVbAkNQN/mfOdz1S+k4sC
	MMJ7VgCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3H-0000000ECds-1NM4;
	Fri, 13 Nov 2026 19:35:11 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRMBO-00000008fSw-3ynh
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 04:13:09 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQ6S765rLz8Xrr9;
	Thu, 12 Nov 2026 12:12:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794456775;
	bh=tlBiVJzWbGNGR99ZbsJuFMRnwt2+GmTnvfSshwizJCw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=tpMyBUOe+9HJE9nJm0FvBTNXHWbd1D4EzFntyaMAo0g5eNY6BYJpbuCrAORPg+NIV
	 GC3lrRVqr3+Lt6sCmwUb/KdfKhYDDHHpqDXwjiXxhTL9empzwKZnuSyDuVlZV6Arec
	 GTOv+pLz4quKOB4+oZe4En0kXLoqOPeFNUMf0UlkvNPy/hZzQTRlol9lseMgL7vD5x
	 vRHRKHxAbwrqNnr9NPzsvHoTJSqhUCdfoan0kcCJFTfOeSK4EUbcaLb9ViXhyP+KUV
	 juQW+O8yzSLPyBs8TQLLGhSwfb+SKgyXMUcbBVhajimNuUOzUzxuzveQwdsFxjY/Ju
	 N/yhvPVupElaw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AC4CmRu074280;
	Thu, 12 Nov 2026 12:12:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 12:12:49 +0800 (CST)
X-Zmail-TransId: 2afa6af53cc1a82-62570
X-Mailer: Zmail v1.0
Message-ID: <20261112121249497K1uXj4qW2lrd4ZbaTHDM-@zte.com.cn>
In-Reply-To: <20261111164311.GB18076@lst.de>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn,20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn,20261111164311.GB18076@lst.de
Date: Thu, 12 Nov 2026 12:12:49 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIG52bWV0OiB1c2Ugb3ZlcmZsb3ctc2FmZSByYW5nZSBjaGVja3MgaW4gdGhlIGZpbGUgYmFja2VuZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AC4CmRu074280
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 12:12:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF53CC7.000/4jQ6S765rLz8Xrr9
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_201307_559641_335EB5FA 
X-CRM114-Status: UNSURE (   3.01  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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

Agreed.  I'll fold the open-coded check into nvmet_file_check_lba_range()
(a byte-length variant) so that pos64 stays local, and resend the series
as v2; 1/2 is unchanged and keeps your Reviewed-by.

Thanks,
Shao


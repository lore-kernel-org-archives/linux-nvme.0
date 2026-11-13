Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367A606A885
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tnzo50SQ;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5+Ud+1vm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Cw0aNhtrZXS8kFyEmLL4uH/j57aq3MotWd+22cVvZWs=; b=tnzo50SQz3xtTE6Ycz3picx48X
	k8ojdNZyBfb5adaj+KDtAWb8GQzYnPm29gK3Mv6PrXdX5GWcR9go2f4At1yYOZN6oKRfNJMvWOT3V
	pW0ZAN65t+L3mGWugFWLfvWDyLPqtqcZy0VmdxZ6VWiFgM7FOz1wUrFLukXF/59OF/wRePUEU6VSv
	T6Hg7P5T2FeFWA5t0uc2EcVPU3D9XP3YxElXny1DseeWUfF19RFJKALPS8WjMBD4jD74h4wSKrLm9
	CaqtKW8x31pucS67yf391zuzLvRe+NNnNjOoidvr94jf29+wfanVdV2DeXy5+mESiC5RodC0DHpAn
	8dvJselQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3H-0000000ECeM-30XS;
	Fri, 13 Nov 2026 19:35:11 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRkPv-0000000BkNf-0gzf
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 06:05:45 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQmvZ1hYYz4yjT0;
	Fri, 13 Nov 2026 14:05:30 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794549930;
	bh=kEK/CdjUuLDdYkzvW76iRkve1W1+RjViKn+Zz6zXGgw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=5+Ud+1vmD13rXc430CPlOpc5b1o4JP+wdtbUUC+UMpnJEGP7yK6Ehi+5m9Ga0Ba8s
	 rUit8P3zcO201yaDBH9c14hTsrq1kQ3XGvTd92l/K97tcNZ7AspW5BONM05J/QYghA
	 MqY3GkVro3z66P8IgeIkiLLRa4/gVKL9rx6TyIxFFNLDoKniqwcnwvZOELtb94A9YJ
	 mSpyA2F7rGsJa+Wy4mcpXMN8lgE6AG7CgCQlq8myk/3k6TGS7lSndFcGtz6ubO8W6b
	 GAb/dwsJ9QAh/nZh2lSlPF1qqt1+IK8nSqh1vhG9PTnXI+gw8/AWFUglwrA6O4OjhJ
	 Wb3rR2LuAEgDA==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AD65HZX055158;
	Fri, 13 Nov 2026 14:05:18 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Nov 2026 14:05:19 +0800 (CST)
X-Zmail-TransId: 2afa6af6a89f931-79c0f
X-Mailer: Zmail v1.0
Message-ID: <20261113140519708mqg78DW--hT8RANbqMrZB@zte.com.cn>
In-Reply-To: <20261112211246.GB11126@lst.de>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn,20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn,20261112211246.GB11126@lst.de
Date: Fri, 13 Nov 2026 14:05:19 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <justin.tee@broadcom.com>,
        <nareshgottumukkala83@gmail.com>, <paul.ely@broadcom.com>,
        <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzZdIG52bWV0LXRjcDogb25seSB3YWl0IGZvciBpbi1jYXBzdWxlIGRhdGEgZm9yIGlubGluZSBTR0xz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AD65HZX055158
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Nov 2026 14:05:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6A8AA.000/4jQmvZ1hYYz4yjT0
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_220543_692019_4FB4C9E6 
X-CRM114-Status: UNSURE (   5.47  )
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

On Thu, Nov 12, 2026 at 10:12:46PM +0100, Christoph Hellwig wrote:
> Nit: this would become much more readable if split into multiple
> conditions instead of this giant compound expression.

Agreed.  I'll split nvmet_tcp_sgl_is_inline() into separate checks and send
a v2 of the series; the other five patches are unchanged and keep your
Reviewed-by.

Thanks,
Shao


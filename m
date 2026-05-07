Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB6CD3442
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0hilmNYrEncINjbBzwcAc2uqgRp8M75cQdyMOD90Dog=; b=bH4kkiKEidc5c2HpPBO2mvNVw4
	7RUqe3IdsWifqfhm3Puej6d8+D95xLtj3Uqy7jLerAHhPBDAmPtht9Pu4Gb6sQeHTz4z34RY3kXs0
	XJg8LOZETje0BkLjsSfRJciZqJqSGBBqG/biiXk8Ak6fkbTnEFcjZCmGNdPIjGgnn93/iOv2TP1sn
	3044uduzOu7Ei+jpDekRrNGloHMYa9Tocp4AaLSwK1/Aqc6SIaS/HxYcvdDMfo7zhmmWN47OKNAAT
	Xuv84bqVWBRv7g00zdS4DMTO4MMSjjlJRHuDTtG11b7iQKiGr8KY5YX0ZYxgzyK7MNchu5Fd+zTg1
	rK46/1CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL2Xi-00000004UtM-0fnu;
	Thu, 07 May 2026 17:29:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL2Xd-00000004Usk-1SRK
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 17:29:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B75844061;
	Thu,  7 May 2026 17:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18345C2BCB8;
	Thu,  7 May 2026 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778174980;
	bh=R/QD6T7Hg2ZmKuHvhILv9q2BFk0ioY9fIssJx6mRaVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5TwVBE4JGi6lgvOH7yZs5BYG+wU8k7FT4JT2uXNm4J7LIhhSdraycdBaHMw6MqOJ
	 nT9U/ZzywhfNITsa6bFkVSsrF7sI3Mg35gkVeNQjNTkilKhN3KUYCPIFMAnlgb5t1/
	 bBpyIW8cBhO0piRQTaiwe+RbZte/gMCvOLZxJ5IdOSGXoZwwmC+Pou3hs0lKwfVQjE
	 R7tiBacdDXymNI3a8jVIOAyQmAnoZiWIUW8lBkm3NxxwBMjxQlfLFu1Db44gos4yR6
	 obX4UPJ5vDCBYc0UIkQTYHwKAWv63lHxJLZTUhwA7qqTdk0Jrt4XxbipLhL8dEsl07
	 q3JSOW/YsnrfQ==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Martin George <marting@netapp.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	stuart.hayes@dell.com
Subject: Re: [PATCH] fabrics: fix NULL dereference in nvmf_update_tls_concat
Date: Thu,  7 May 2026 19:29:34 +0200
Message-ID: <177817496921.23552.15531985814797567649.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506205345.64478-1-stuart.w.hayes@gmail.com>
References: <20260506205345.64478-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_102941_405400_9F5CC9D4 
X-CRM114-Status: UNSURE (   6.81  )
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


On Wed, 06 May 2026 22:53:45 +0200, Stuart Hayes wrote:
> The recently added function nvmf_update_tls_concat() dereferences struct
> nvmf_disc_log_entry *e, but e will always be NULL when called via
> libnvmf_discovery_nbft(). This can result in a segmentation fault when
> attempting "nvme connect-all --nbft".
> 
> Check for NULL pointer before dereferencing.
> 
> [...]

Applied, thanks!

[1/1] fabrics: fix NULL dereference in nvmf_update_tls_concat
      commit: 0f4fe4592005b515170bec08af9ccbfe598f8d72

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


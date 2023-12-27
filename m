Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0138BC46CD3
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 00:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCZhHCgpoCFc1TJstszoVVDofhXSe2Xa77eoHS1VtBQ=; b=KFVlSrQsWlVEBfBCoAhfV6ZEDw
	yO7r86R1ijCaeJq1tUWQgPss5W4iNx+hs7F/3HpZQRJy6YU85Pu05ZcqMgh6sz89ztCWoqAWw9mz4
	x3r7aElBD6LzvT1z9d3Win0ZTXG4eEkN62msOV8EIrfBH2QFFgn5xvypacl7kTSxvowYpB+Rw4iqK
	1iVqT9gPHLh3egYnjLDBpOVt32+YxX0e3cio0+l+rIfQv52xBoj2Pwt4ty2Ey/bKgiljfEcYxeRYO
	u0jfgYa96F3JKRMKr0BJAQlAOEpIAtmAFuM/0dfzQhRYUxu9ECKzja8sgJJ03Pf3Ib33IT+jH5HCn
	BQ88m5ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIIBZ-00DjKT-18;
	Wed, 27 Dec 2023 00:54:13 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIIBV-00DjJx-2a
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 00:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=NCZhHCgpoCFc1TJstszoVVDofhXSe2Xa77eoHS1VtBQ=; b=dMHu5bfR/5h3eBs6ND6KaOz7oe
	uegqdoUUpSJgxtNGaHPlUvra9dr0J5CnTIqLRgwh80Kv8DANJ+zdoysc+lQHDU7EM/1Q1X0uD+u8f
	cFo6yQhRkGzRo6E2v/SeJV8dMmjbSGvG5unGC6wRWNtTLZpFuAXRqMKSQf+o2ICbZspS9dU7EaNHu
	4D05XdcnYCtE8vD67Fgwm7YDoM4+Tz9iyKFEHeNlimGyQqzEwa0sSxXojGHtDqG6Z3vdB2/Uykkc2
	GwAahYpkjGsHZxIQ3TpCE3HZVsAkJkHdF6pCay+Cvc0FiyRPnQu6DxYfjF9jYEBFqdRtHrpKIb8EF
	rj/ELwMDCU8NTgaN0w2Pv8oP928aYK05umqwttBnQe8r24TaBmj3Fi/T+M/DG+Fh7PPDsvSEzE9W9
	3ssf5YF5sXNLZQqvW/DBDgeRDdb4VlY0bw+VabqgFRvvaq459mVoQ1PiimmDGjzPh+qgUfNtK3Yjp
	3y0SKVOq9dL+wOAmVt1zOWIH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rIIBL-005LQO-0f;
	Wed, 27 Dec 2023 00:53:59 +0000
Date: Tue, 26 Dec 2023 16:53:55 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Message-ID: <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
 <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_165409_869945_6EF4C6E8 
X-CRM114-Status: GOOD (  11.28  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 25, 2023 at 11:58:04AM +0200, Sagi Grimberg wrote:
>On 12/21/23 19:22, Jeremy Allison wrote:
>>  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>>+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
>>+{
>>+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>
>Why is ctrl_config being set again?

Good catch. There's no need for that. I'll fix
in the next iteration, thanks !

>>+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
>
>Why export the symbol?

nvme_wait_for_shutdown_cmpl() calls nvme_wait_ready(),
which is a static function defined in drivers/nvme/host/core.c.

The only way to inline the functionality of nvme_wait_for_shutdown_cmpl()
into nvme_shutdown_wait() is to export nvme_wait_ready() instead.

If you're OK with that I can remove the intermediate
function nvme_wait_for_shutdown_cmpl() (and indeed as
you've pointed out there's no need to set ctrl->ctrl_config
again).

>>+static void nvme_shutdown_wait(struct pci_dev *pdev)
>>+{
>>+	struct nvme_dev *dev = pci_get_drvdata(pdev);
>>+
>>+	mutex_lock(&dev->shutdown_lock);
>>+	nvme_wait_for_shutdown_cmpl(&dev->ctrl);
>
>If this is the only call-site? why not just open-code it here?

See above comment.

Thanks for the advice. I'll fix these up in the next
iteration (which probably won't be until after January
2nd due to the Christmas break).


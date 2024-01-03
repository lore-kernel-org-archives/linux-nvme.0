Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D79FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SwxwDlEitJSPhWfG9VKltULQ8bBSZKPmgYIa5bB3OI=; b=uqe+I2oehT2Q5kaH33F3vawpmq
	ORMURNviiYsJlS4Uv4tBuxFNouX8O0d4WwwtwQ18K6E6SUOIZJ5GBHFPBqeys4ZCU9oYKeyL4wa4w
	vstYyUDo7X+ezbCI4anu13XRqxTjsGo9n3pGCFD9DGZVD6ZNKSB2cVJnP+Duwgk9DSFBNfqXVPkCm
	TxWTSTcgJtFvP4YH2iHEvckPDXNN5PRqLpGedGrqQYKB44sRSMA2yL5VuFfpbxONVGFtmTamnUV7t
	7UM7rvq0v5wbSNKUl4KmvTjgrzs/zaI97Rt1G6tcRURKWkF5Kn5BwSzbv9+UFcyIQC7zewQS1QNPK
	MnyRLNOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL5FS-00BZCA-1o;
	Wed, 03 Jan 2024 17:41:46 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL5FQ-00BZBK-0e
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 17:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=5SwxwDlEitJSPhWfG9VKltULQ8bBSZKPmgYIa5bB3OI=; b=uiD2ueEVBaV+eXoQ9Rt2rGTYVu
	h2fKKYQwi8ZcKpj8xjOiIEnmn5OmxY+ntHS1hrpEGAbT8IxYPLa3ewFWdp7n3FSOWKEDlMSwh1NqO
	eSOqW41iJSuyqDWHCGqAGXjmQPOsfU1Q5MCI0oQmYSlgIvpmpg5D84Dthje6Bra2ajIVP7GG8VdSl
	4VKpE9auubd0vjL0xqv3K2j1gcTOSjfu+4uNVgn6VowP2AXGteyQyTqAc7Df/tLfKTA1iBTG/5wVD
	S46THtKSksTvV/i0q9ceyaFAiITdbPEjJge1+GThci6PyZMNVvZfEmxo5E6zFwhA1DTsEaQw4T7qP
	hnxGF4lXROqLa5vYHVqHO8CSMdRm+55N2UE4r5Pwg//S6OHthY3jAPFpcpiEBcu7f4di007QgtqVM
	+S6H+AIKkTA6YxyLgbgVDZ+a7eOswsr5yvCK3INiysognuL7LjJyLMNZ75WFGj39nX7xNiAbmC8iE
	TF/xnUoshuvQDH18PmI3/0/S;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rL5FJ-006Hl5-10;
	Wed, 03 Jan 2024 17:41:37 +0000
Date: Wed, 3 Jan 2024 09:41:33 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Message-ID: <ZZWcTTZdAgC+43sR@jeremy-HP-Z840-Workstation>
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
 <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
 <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
 <e2001f25-ee04-4f34-823c-7647ab58da13@grimberg.me>
 <ZZRP730tbkXNndZl@jeremy-HP-Z840-Workstation>
 <c134b7f7-f5bf-4670-87be-0ef928145c65@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c134b7f7-f5bf-4670-87be-0ef928145c65@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_094144_237274_82CEBF19 
X-CRM114-Status: UNSURE (   7.81  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 03, 2024 at 10:36:46AM +0200, Sagi Grimberg wrote:
>
>No, these wrappers are getting confusing.
>
>Exporting nvme_wait_ready and calling it from a static
>nvme_shutdown_wait in pci.c is fine I think.

Got it. I'll re-submit v4 with these changes once
I've tested it. Thanks for the help and advice.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C216C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8O7i3NKNo59wXHjAbNTn4L9hGaoEisKsoEep6uZmWu8=; b=1xDhQlUIwycYGKnOT9QwMH0HAM
	khWBuTYf1HvBMuzA3z+CejqUjD2RTn1+fy9NtiyWRHpENThRH9XEh2AXyjDeZ3yiRQKjTbipLpgkx
	wWVqkF3quHqzxFuLrKmhDMb7FH/CgygzVwGoI8vzbwGu2au/B3MYg9CkjYtbJ+YaBIVon8UDYERxb
	Chc/BcSkpSjp5tTRZ1n5xc0kqW03bfC/PAEYtvY2rqLtCXREuaEaiaU5tQ1gEoh0Gz57IgaCWE+Go
	p0ToA3wfRF92KsYdwUhhrRflnZEZpasl+NfcVdtxGQOE84rva9kSUdewx9BnA62Bpnm4yI228CUeQ
	4zVdcP3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKj9j-008fSk-3D;
	Tue, 02 Jan 2024 18:06:24 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKj9h-008fSJ-0C
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 18:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=8O7i3NKNo59wXHjAbNTn4L9hGaoEisKsoEep6uZmWu8=; b=KP4kL0toeZB7DO7w/Ea2DlgB9s
	TBdGjXSH2Q0hnZ/YDxHAmQ7qvU9wGRojPvdLLlZHQX3ZYc+ISPjbF6CHITeL+imiX88BVgkQkYrLm
	d/YZDvdVWgfd2mZbNSXg9FADDdxj6OspDcaO9+Wt3UiHR/0h/6v4E0dZxZBRsxrQ8hVp7Z/RE2BMW
	uQv9Nyc5xXGqkYC7L8spdTjifecbDBlrRgYYayzEcWYaFtp2wH/YLxNNlja9aV60l70eBradFp0B0
	tTVVKLY310mjDoDe2J5hK/MkriBQoARgdg20nKBgMPM65zblEYjo4uqoJY0zAOHB/OC5QIkPw6UKX
	sRWYq5J5n7K07ZC6UG83u1aLVEzwQJDeXnzUn1FJpFnOz2bbXdOnSY5e16YgfQu0UAyDDtW7Ctz+I
	JkSyB5iApXSQtgM1Y8jvvWJFx6fTPoxSqgm7bVKPi1zf98zZowWFErMEQiKJXEbgxPbGlMnAO/bx1
	GyNeFjo0uQyAexrk7/EAVbkn;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rKj9e-0067FD-2p;
	Tue, 02 Jan 2024 18:06:19 +0000
Date: Tue, 2 Jan 2024 10:06:15 -0800
From: Jeremy Allison <jra@samba.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 3/4] Change 'bool shutdown' into an enum shutdown_type {
 NVME_DISABLE_RESET = 0, NVME_DISABLE_SHUTDOWN_SYNC = 1 }.
Message-ID: <ZZRQlx9MAsMZYl+p@jeremy-HP-Z840-Workstation>
References: <20231221172257.2234320-4-jallison@ciq.com>
 <20231227193344.GA1509800@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231227193344.GA1509800@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_100621_120457_D4C01420 
X-CRM114-Status: UNSURE (   6.17  )
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

On Wed, Dec 27, 2023 at 01:33:44PM -0600, Bjorn Helgaas wrote:
>The subject might be overly detailed and doesn't match the "nvme: ..."
>prefix convention of drivers/nvme/.  Maybe it was intended as part of
>the commit log?

I'll fix that, thanks !


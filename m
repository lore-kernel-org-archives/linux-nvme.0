Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135FC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uPhHklUXSMvQTbZLC3pjLI8SN3U+g5Eohz46fNcRl4s=; b=Pal4IMHz5Ur0+3i5u68Md51z5x
	Jy7oBOTaYTlOy5m0tjP3OwsY11a1gtiXG7RcodCaHxhuD0voDIpA8ASigasXCcdgtgn9Hddj91o06
	Jm0uVzx044eOpUQRO8DRIL4FvuY3df1eVop4cNIibdj6MxaHi0wmwYJUYOwCbpUu1Pe5gl6CxfIai
	7NMEzuALi1XBqg1cTB+WEAwo61VEnl0dhZQ5iYS7T1qGyKDwcGU0d5mp2uwMuMxKQBUHHZH/dUaUE
	EHe+mDV6YjcKvVhiB4fBAFbodnJ11X3Dg6dpgt2lhP7jFbESR8qvqkb9Hs6Sx6pu0CF+qMeETfIlv
	43aVemGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFThF-00CzwX-2P;
	Tue, 19 Dec 2023 06:35:17 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFThC-00Czw9-2Q
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 06:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=uPhHklUXSMvQTbZLC3pjLI8SN3U+g5Eohz46fNcRl4s=; b=lfIc/F7mf+Jlr734efNFSRDCKW
	FTxEf7hNdeta3/5gmbordekK9X8PFBOnOaJM2cIbyQVCkK8dQY3Mq4eA5fSCADeIaXMG2sifPU6xA
	V2npy0j6nhw6R1njxl9235Zv+iXRwE7jac8AYnbhDV0G3I7HS+fVjjdyx9GIUFc+1QswtC5UfapmV
	PcrhA+ahTEtGxZCQ+FL0qi7j3usADe8g9crhccg3jFbtkUG8R4G4NgPosTVHxia4dtkPiavQ9c4Zi
	vrE0F0Y3WbBheVnT4oqlIMKYtiT123fFZU2sSMIn9aEEzUxUJVnVVhyWsuY+7UKvdXsmqAXGOnbkU
	W2WpjNrmiSKzfQex1svwekgnKtxdiMlGXTIRHNzEDE9lqoMGRuO7Yr3+8ZXZF5lRsrj4/v4hjxL3/
	yRjjLXBxy6IV3iToup/ARPjobjqj3li7R1NpqR9JO9CUE1RGfTSa5MD9M5bz9aWnAIJ0cw8t5rgoh
	EhRs9oyKl1/qt1siE5BtmyaP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rFTh8-004KHT-16;
	Tue, 19 Dec 2023 06:35:10 +0000
Date: Mon, 18 Dec 2023 22:35:06 -0800
From: Jeremy Allison <jra@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com, jra@samba.org
Subject: Re: [PATCH 3/3] nvme: Add async shutdown support
Message-ID: <ZYE5mv6DWNQumcdY@jeremy-HP-Z840-Workstation>
References: <20231215000358.1203338-1-jallison@ciq.com>
 <20231215000358.1203338-4-jallison@ciq.com>
 <20231219054349.GA892@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231219054349.GA892@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_223514_799931_02115CCE 
X-CRM114-Status: GOOD (  16.58  )
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

On Tue, Dec 19, 2023 at 06:43:49AM +0100, Christoph Hellwig wrote:
>On Thu, Dec 14, 2023 at 04:03:58PM -0800, Jeremy Allison wrote:
>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> This works with the asynchronous shutdown mechanism setup for the PCI
>> drivers and participates to provide both pre and post shutdown
>> routines at pci_driver structure level.
>>
>> The shutdown_pre routine starts the shutdown and does not wait for the
>> shutdown to complete.  The shutdown_post routine waits for the shutdown
>> to complete on individual controllers that this driver instance
>> controls. This mechanism optimizes to speed up the shutdown in a
>> system which host many controllers.
>
>I had a really hard time trying to understand this patch.

Sorry. Me too when I first read it :-).

>Please split switching from the bool shutdown to an enum (with initially
>just two values) into a separate patch.   And the names really confuse
>me.  I would have expect something like:
>
>	NVME_DISABLE_RESET,
>	NVME_DISABLE_SHUTDOWN_SYNC,
>	NVME_DISABLE_SHUTDOWN_ASYNC,

Makes sense. Start with

'enum shutdown_type { NVME_DISABLE_RESET, NVME_DISABLE_SHUTDOWN_SYNC}'

and then add NVME_DISABLE_SHUTDOWN_ASYNC when the
shutdown_wait() is added in the subsequent async patch.

>then again mixing two rather different concept (reset vs shutdown)
>into a single enum is also not very helpful (but neither would be
>two bool arguments).  Not really sure what the right thing is, but
>as-is it feels pretty obfuscated.

Yeah. I really didn't want to add another bool here as having two
bools side by side as parameters to a function is a receipe for
mistakes. The original code just uses one bool parameter 'shutdown',
to the nvme_disable_ctrl() function which when set means do the
shutdown request, and when clear means reset. So 'shutdown and
reset' are already conflated in the code.

I think if I use the names you suggested and split the initial
add of the enum into a separate preparatory patch might make things
a little clearer for people to follow. I'm happy to take your
guidance on this though.


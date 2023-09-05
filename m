Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FFDC83F33
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/w6NXm6RV7Ia2hMunjV2V1kPlK8yJjoC6/nbLfa2PnI=; b=fooKlKyOHRvqkw
	Ozm6+dOZJTq2ur9QdtqDwqFFSQKRQBg0hXikXjpYW50Xw3x6yaO00HWktiKktc/PM7ZzUid7Pkzzu
	ViGBNKn/5x4XqkcnhyDofZaOxInQiPSrNzOiioAm1iKCgyg6R9Na6Am/gK9/K+9CgGSCS6jkhS1et
	1yv8gNsBPllceBuUpCmStuQwMw38C2/UzG5yR2WkV0yxCoYZxXIJreP3hIPvcC+TWKmsgfG+tch1d
	JsYNu0FTbZy1EaOS6CHJ98wCBzfVo0u26qzNNJnSwofT0rwloJmypYMasDAXh2o5cWXu/P4GAD5qP
	hyYRVO23IPsxtK7eyuqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdUNc-005vLm-05;
	Tue, 05 Sep 2023 11:38:00 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdUNW-005vKV-38
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 11:37:58 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qdUNJ-0007xD-Bz; Tue, 05 Sep 2023 13:37:41 +0200
Message-ID: <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
Date: Tue, 5 Sep 2023 13:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To: Bagas Sanjaya <bagasdotme@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Claudio Sampaio <patola@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Stable <stable@vger.kernel.org>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693913875;2a74d134;
X-HE-SMSGID: 1qdUNJ-0007xD-Bz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_043755_170394_A5CCEE1D 
X-CRM114-Status: GOOD (  11.76  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04.09.23 13:07, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the time. It wasn't recognized, with these messages in dmesg:
>>
>> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
>> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
>>
>> My other NVMe appears correctly in the nvme list though.
>>
>>
>> So I tried using other kernels I had installed at the time: 6.3.7, 6.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
>> I installed the 6.1.50 lts kernel from arch repositories (I can compile my own too if this would be an issue) and then the device was correctly recognized:
>>
>> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple suspend
>> [    4.654632] nvme nvme0: pci function 0000:06:00.0
>> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
>> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues

FWIW, the quoted mail missed one crucial detail:
"""
 Claudio Sampaio 2023-09-02 19:04:29 UTC

Adding the two lines

│ 3457   { PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
│ 3458   │ .driver_data = NVME_QUIRK_BOGUS_NID, },

in file drivers/nvme/host/pci.c made my NVMe work correctly. Compiled a
new 6.5.1 kernel and everything works.
"""

@NVME maintainers: is there anything more you need from Claudio at this
point?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


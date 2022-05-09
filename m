Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PHLr91eeqe+GjgAVaGk2+BZd9zVe2alNfvEbOpv71J0=; b=2j8yjQbPPMBTkIglONl+E190Lo
	s6dEepS73nAEYQQiNvEjeKSMsudhVnGYwCJ6JfqCBTFnxmMvfXvCpQsetwfsv8WNnTJsO6Eu1+TGt
	te631Z6txZpb5gBT1B0yUvsihMuMhjNeiG2GAS4mld1dqg64/9oOO35lznohbjLS8CjVDFmxOeYDX
	jvzWdPRlG7aas1yAFnIrPVE5/4437Uy0HGnXGFZ423YVY2yHM/XVaM6GTU89Pbr/cPJ28GBXWWtsY
	g1+lcOHUHIzcvCWgPNwyu2n4FEyh6+QYRL5NuunCrqjKVAVT2cUy9VAWICOtOeUID2R5L9Yd7lOCp
	5B2wiStg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noA8A-00GBUq-Fj; Mon, 09 May 2022 20:37:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noA87-00GBTa-Ij
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 20:37:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 04676CE1B35;
 Mon,  9 May 2022 20:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850CC385BA;
 Mon,  9 May 2022 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652128631;
 bh=hfhwSRPKpmCQiR4AWXJNzlQccUhXLt9YToKJxxPPASY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tFdOx9HeBIeyMBt5gSS7grymNkPUHSE1YVzDiOtXmus2HnnAqp0sGx44436ka/JjK
 I387rYUkxfMdDytacNXNhNdyw+gRMYaPO67M9P9Z6/vigTdb2jxJmfzSiXwR77Bhgy
 +L/OYMTfHq9q458tv+6koQytNRPpUGZq19BguAzdlXoagqOvYcnL7Fla6MPijxt9eC
 74f/Jx8LoOAB7BVEQRG0k+qA8lVeGiwz0ZcGE8zruPKwZk1QPHxG8MNWZKjQKDEjT3
 kGcFBVuutnd3h1pO/0qTZJZdxFiaQ1OEXnhL9cTUCqjRobkRB5vgpTeMwXJJjf37nh
 7fIWs6dOzU3hg==
Date: Mon, 9 May 2022 13:37:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Xiaoming Zhou <xzhou@marvell.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Message-ID: <Ynl7dXm38FaX/2od@sol.localdomain>
References: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_133719_815477_CEF08D78 
X-CRM114-Status: GOOD (  12.88  )
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

On Sun, May 08, 2022 at 12:01:21AM +0000, Xiaoming Zhou wrote:
> Hi Keith,
> For the polynomial you used in this path is 0x9A6C9329AC4BC9B5ULL,  why it is
> different than the 0xAD93D23594C93659ULL defined in NVMe command set spec
> 5.2.1.3.4 ? Though the crc66 implemented in this patch can pass with test
> cases defined in Figure 121: 64b CRC Test Cases for 4KiB Logical Block with no
> Metadata.  Could you explain the discrepancy between the spec and the patch? 
> 

0x9A6C9329AC4BC9B5 is 0xAD93D23594C93659 with its bits reversed.

0xAD93D23594C93659 maps the polynomial coefficients to bits in the natural way.
However, writing the polynomial in this way isn't useful for this CRC variant,
as it is a bit-reversed CRC.

- Eric


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747AFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7RNN2NtUCiYlktRTLZb1F1QUe+9TGp7AyZCCAy5SII=; b=O3TPaEMPPXc0U9yhmCLka/Aax3
	3NoNP3mgM3c/UqO0R/A1o6/XtqVWBTprIQsnDTBSwKpUAIt+SmEw8kebED6r65AWYJBstS7qD/i6e
	8Ff3Sw2GXYQCQGukiYrZovsgnKqjDFz0Q5056QU2fwFXLU2ijNK67mG1r+KQXbdIfrUxeGFVB32su
	ZVpXpOV/CI29G9UEpXDHGtTYApRZ0XV2+rSX9zQHlbgXkJpoNnnt5dGJJok2bb7xCdNBRZVPCdUtR
	YnwXDzKPbWAiWOaInawr6LjNssYsb4fXQk03fijjCv0LUYrgJcvyE99HAQ/v/nnK4GvzPlKIZjnkh
	dRTriLtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neDoQ-00DJdu-H3; Tue, 12 Apr 2022 10:31:54 +0000
Received: from mail.toke.dk ([2a0c:4d80:42:2001::664])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neDoK-00DJZO-BI
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:31:50 +0000
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1649759502; bh=c7RNN2NtUCiYlktRTLZb1F1QUe+9TGp7AyZCCAy5SII=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=i0947lNSEqN2IuVWsHrGspcGTvLXZd/DKWzbOut1/erwhO20GMjCouYMNFs3v9kGf
 c76SbL0mPdFL3XZkE3+b6c1EwH+Q4txbzSyDzYhBm2UhOgx2Ta1CxH90EYRfVBV12P
 oTIILWGKabOdRga3Q5bNS0kU1Is+jaAHnxCIN2kwfNVXSkOsYBIJGfmfSzty9ZZwux
 eVasnqs4aLDGQmvpsapXpngyC/BurhDbrXWZU5CRyMa01DCOBIxfvoFRd1Z55M5/JX
 bjiHCMNeaxf5CU7HF05TAtcNzOW1WGCUGadfFnkke4rPcHn5+UQZWo1ZHo0TVVkgF4
 /qwnGmMNgkqwg==
To: "Box, David E" <david.e.box@intel.com>, "Wang, Wendy"
 <wendy.wang@intel.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: PCIE ASPM-related trouble with S0ix on Thinkpad X1 (NVME-related?)
In-Reply-To: <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
References: <87k0bvutxf.fsf@toke.dk>
 <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
Date: Tue, 12 Apr 2022 12:31:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8735ii384z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_033148_576733_629466A3 
X-CRM114-Status: UNSURE (   4.88  )
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

"Box, David E" <david.e.box@intel.com> writes:

> There are a few things that could be going on. Please file a bug
> report at bugzilla.kernel.org under Power Management. Provide all this
> information and include the output from lspci -vvv when ran as root.
> Thanks.

Alright, thanks! Opened
https://bugzilla.kernel.org/show_bug.cgi?id=215832

-Toke


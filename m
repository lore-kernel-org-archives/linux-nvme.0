Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F0C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:References:Cc:To:Subject:From:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=; b=QB8gQHMVBIrp6mJ2jMy4UZXgzP
	3v5KexjyhrxC10pWK5KL3KYf+oO6yP9vXMST9Trv7b9+eHlUzpLlVJwNRMR/Imxd4Mg4Kkzo7KEVN
	cstTSKu6rySVojb2XJhE81J6eGNj43wIMtzmzQrUTipEiJs9+oeB6L9jZKrp+aM7+0zJDEK16C/x5
	L586eizdmS11LP8g2aMKK+UxrLHo1pe/JozHDrPIcx1Tj8sZfaXqGgH4WJPwOu6y7MbXvbfwOdesh
	8RU6G4kk9gHpQUBvAw4ncPbVI3IPjOAjzTnu8LdYnktL+kImngSXm4LWFDH17KJWwWULtRFX6avqZ
	KW2bz2mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUYbv-00BYfk-1g;
	Fri, 11 Aug 2023 20:19:51 +0000
Received: from abi149hd127.arn1.oracleemaildelivery.com ([129.149.84.127])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUYbq-00BYed-1h
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 20:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=PX+CzZOP3TYoeq/XPPc4KeU/taJiCtEtliip0vS4MaZryizYEnEp5yJEv68I8r1FbRV7hVO1l3N3
   6H+lmrST4xSxhep31t7zZZJh1Mv1riwNewos1mTsEYhpMVVzIC3gA3LGgNFBzj3AYPkSwX61QQy5
   QTMjgpBG4GMsz79/GzBSDhJbz9ctqJoohcGg7tdd+ZuFerCVL+ddGkt4dM0QeNRAvwHdyUecJefa
   L5TJ6VNclbRdaar704a0U6RluBUn6nvZtPyZbtzQ2Los7f13BvCTyMqhKFWohiKHmfFvl4ODlsw4
   3/g7f/OLajuueRYYzhf4eTND/Y+udqlvJlbdYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=W+3rx2WSYISvmXfUUCd1AylM3T0PMXsoyIBlxYHyZUlYbIsLuh57hR5/woSLh1Ph1kQh44en+LOR
   RihA1cLXP8kF0n7aZeMwYMev/XpXTen96ukmgqOLXOFRIfxRkPJye9IKQwf3R2WMCs6i93SDrFzk
   fG7GdFO8oDvmH8JkugqbDyVERNGoscQBnx6MWsdhKtqiP5G3ixQxpbTtirdj1d04b5C4EtbNQOi8
   qNYvLTMKjDuDXe4R78OqvSYa7MRiZUWQ+nWV2z03a+JV8RTHoWQPj6EAAntlz+IbCcJFoEduCaDN
   votXaqcBN0dnx+7H/B2PFzniWjzssSFjstTKRg==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ80042NTSQFN40@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Fri, 11 Aug 2023 20:19:38 +0000 (GMT)
Message-id: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
Date: Fri, 11 Aug 2023 22:19:35 +0200
MIME-version: 1.0
From: August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com> <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com> <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-language: en-US
In-reply-to: <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAE8DGuEMYrf45lHTdh54TgMaNY8+iRJQTe9hY+5T0LFf3+29Cv+oDRjYT9Xx6Yl
 nrJvLuvW/4wHxW/x225I0uH+OgeGKGJw2N6amHYw8JGcsCXHLsjt0tb2lrilc3Nx
 BpPnhCbNJ2F32MR9iqvfdKem4Kyt2owywcKVKN06X+JReZW/ti7NdboqHtuZEko5
 Iq4GenVMFRBskgEBTBlGGU96wGAP0O9BHiZH9q2FWZxqRr2rHRhixINRJddLQ3tb
 YUfM33uNVXa7vh9pK07dthvLxCn6EzIEfL/SZmRhNkaeJLN4QQsV5WHf/3JEeQGH
 B0mYtXS6QQB2ibvLSuTNRHy6atohJySpoKSbMtdbRozcFwor+jt5QxF2goEuWlCb
 YbtycHw3iwaz3E8LfkPtN/bWVzWUUghMT5ACD5bjsHniKW/GjlXYWhf0HI2ljZBE Is0PEXcCXA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_131947_563155_4733B449 
X-CRM114-Status: UNSURE (   4.73  )
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

On 2023-08-01 22:34, Mario Limonciello wrote:
> If you can still change it before sending out can you add a stable tag 
> as well?

This didn't get added in time, so, stable team, please backport:

688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Regards,
August Wikerfors


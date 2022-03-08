Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD0C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:To:From:Date:Message-Id:Mime-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pqibhZXEYNtOvRFmApEgPbaPmCxVr+WcKFwgCyWJWqE=; b=Y/7dV4uwJUd6YswGlzDag+/glq
	o7/TgGJrg7z8nRCuxSTKVrKwaMqmXzoG/JgNytu6iTjdPPVNt/8FNIkHcKXyjDU7+hx7cOelJH6O6
	HmNF6McY/fTFzw2Boock4pMQOqhlbMMPNzE2/wH41Kw+PMu6rHeYvy9GkK+Z7trDeXljvl3N91bgy
	+CMjrBp/LQiqs4AT0MEwR/Cj9ZT1HQ3asa29GcKaRyr079Rno5nFtJl+CU8VvA2MvMsyAKgpxJ4u/
	WgyvvqOgwgKUx2i0g+uyNlbtHFMfQ2Uhgl257+uRFLpYc97ei9OedPylFQV9NQCXOA8S/IVIgvmr7
	CJRD0RmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRbsy-004zOF-Vx; Tue, 08 Mar 2022 15:36:29 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbsw-004zMR-Ec
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:36:27 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id E305C5C018C;
 Tue,  8 Mar 2022 10:36:20 -0500 (EST)
Received: from imap47 ([10.202.2.97])
 by compute3.internal (MEProxy); Tue, 08 Mar 2022 10:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttwalkertt.com;
 h=cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; bh=pqibhZXEYNtOvRFmApEgPbaPmCxVr+WcKFwgCy
 WJWqE=; b=WOoN+PfKoUTEKZb/FIMCvA94Cb5efx6tfMX4Uap8JmA48ZTEFcZaC4
 B16DwC+X4aM7uSfIfGKMwWWgLLB3AGcGsOymdL5YbhMPO0iDcFiJsgH4HXVSCsEn
 IFKh2s+bZvmUdvrXywXgT4+Dob0W72BSFf1BQbzgrARnvtNNy3UzGxvjbzD0bz5h
 wZ/esmVhyFXbVFFqJCX7Z4du1OaTvxrIncgtLGF+KZLWZ9ZMH6bdoGzyQcizU6qW
 HlYmWkM1mSnXqKRJySGy7URLTWORVngG61RewBOzrtddMDwlUF7Qfj6tpPfASrse
 XN4++Q0eu+66yMviIpBxQdlfolpB5ttg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pqibhZXEYNtOvRFmA
 pEgPbaPmCxVr+WcKFwgCyWJWqE=; b=HcHo6aC9h/H5SuCHTs82D1UFGNEnWxaJ0
 QJZebfDIWrhZQzDpxrR0iX0lZLVxuKLOM569mHuiEgBQ0fPMBauXceq96S3tvm/J
 VilvdlcMCw1Ti+D19YosVxl5lEZoPTGQCspygjh0tEWiMR1kA43kgu9BpqDjQdYd
 k9waLU5t+p4GG64G/xD5Q4bYXhrhSxF6pBUeWt2b3nAldGYwiEZbn56KYF+qpdMY
 XDprj+GX60LK/4SMA5rqzBNv3JQDVW0LXipq+MSGnOROyfMJSb373S5iie67fgqy
 P4gtbFieqR+Y7N56ZQV2Uwcck17AyWUkmNAgTGP7aLHmhbNAQaJAQ==
X-ME-Sender: <xms:9HcnYlMdvW7C4eMKcUeeguIJaktwYIUkf05ORNTSeujA33vdKk-3rw>
 <xme:9HcnYn8qWFm_eFH3LCTZMFy60Rd3spiQfxJO140ImPPShyWKTILlGgHqf4Nhla8xC
 82bd5PqniJAPcwE9zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenuc
 fjughrpefofgggkfffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdhtihhmucif
 rghlkhgvrhdfuceothhimhesthhtfigrlhhkvghrthhtrdgtohhmqeenucggtffrrghtth
 gvrhhnpeevlefgleegtedvheejheeikedttdduieeivdegheeigfefgeefgfejudeuhfel
 leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtih
 hmsehtthifrghlkhgvrhhtthdrtghomh
X-ME-Proxy: <xmx:9HcnYkSKLIcgXeVicA9V6MXyG-DpV4vTO3pyAxWQojAu9OzCfJjZpg>
 <xmx:9HcnYhtjw0X_YRJPXF_2hgoPsfpccPbdQTopjvz7XzmmT7Y6rRZwjw>
 <xmx:9HcnYtc4Y0KhlLdEDqG449DbqdmX6RCSZrr0oyjQjKp19EfhLw8Dkg>
 <xmx:9HcnYtkrv3ZhVaPeiWQBmLsdeHMUWWAimHHnnlvaajpYRT9awNsPKg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6121E2740108; Tue,  8 Mar 2022 10:36:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <cb64d74c-1f19-40d9-880c-dc8ba1bba020@www.fastmail.com>
Date: Tue, 08 Mar 2022 10:36:00 -0500
From: "tim walker" <tim@ttwalkertt.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] NVMe HDD planning and directions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_073626_579691_248983BB 
X-CRM114-Status: UNSURE (   8.23  )
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

Hi all-
I'd like to propose we talk about the PCIe-NVMe HDD this year. The=20
topic comes up informally from time to time, but now that we have
products with actual delivery schedules I think it would be valuable
to discuss the impact to our systems.=20

Background:
NVMe specification has hardened over the decade and now NVMe=20
devices are well integrated into our customers=E2=80=99 systems. I think
moving HDDs to the PCIe/NVMe interface is the next logical step.=20
Consolidating on a single API for rotational and static storage=20
technologies. PCIe-NVMe offers SATA-level costs while supporting=20
features and performance suitable for high-cap HDDs, and optimal=20
interoperability for storage automation, tiering, and common=20
management tools.=20
We will share some early integration results, and review the
OCP design guidelines, but really don't want to turn this into
a status report or marketing blitz. HDDs, PCIe, and NVMe are=20
all mature technologies, but the combination is new. We are=20
looking to the experts to help us anticipate the challenges=20
and benefits.

Discussion Proposal:

-What Linux storage stack pitfalls do we need to be aware of as=20
we field these devices with drastically different performance
characteristics than traditional NAND? For example, what=20
schedular or device driver level changes will be needed to=20
integrate NVMe HDDs?

-Are there NVMe feature trade-offs that make sense for HDDs=20
that won=E2=80=99t break the HDD-SSD interoperability goals?

-How would multi-actuator HDDs be presented under NVMe?=20
Namespace-per-actuator?

-NVMe HDD power management proposals. This might=20
turn out to be the hardest part.

-NVMe HDD System architecture (maybe, if there is interest?)

Thanks, and best regards,
Tim Walker


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1093FC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=; b=JFqQE3EnjD68XXyC60xQb/p258
	aiugsD7JPXlVI+Q4s1LaY6skjRi9PVxFFn29ja2d9A2RQI+772Qjc61E8uwXWVReAoDOkY+bC7Eyr
	/rRIrrwcG+n/Wx9UfsJra0Takho/VwVnqCcsX2du8basYBlPWQiixs1RwPuAQfihtY9PcpwGMk5BM
	VQd0m3hNC8p8lyqzFghVt4UPc8fd3ZDkIkij9saKXS/7xyqA/tUz8sxcc/YqkFBATNUqHhnFHJ6nC
	jr0ynTlRzbd4I/VGQjDfXrurIrjCKtRN7GutzOvcAqFSWyPhln5Q3eKr3hhxMffPK4+eFF2K83v4X
	z5llCOhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh2re-0000000Bz0l-2Sf8;
	Thu, 22 Aug 2024 08:08:14 +0000
Received: from mail.envisioncraftsman.com ([162.19.67.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh2rc-0000000Bz03-0JVP
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 08:08:13 +0000
Received: by mail.envisioncraftsman.com (Postfix, from userid 1002)
	id 2CA4923E4F; Thu, 22 Aug 2024 10:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=envisioncraftsman.com; s=mail; t=1724313960;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=;
	h=Date:From:To:Subject:From;
	b=kUcOFhvo/5Dza9YzdIZkgDmE+bofeEpC5L19GE5Poap4CQAFY6ozwTucPTbVPQxBj
	 XKYuc3N4/XDnVKTOTs86Iksg1g0VDWD3qLpCUWh02dlAZqLAPJBlgx3XBOLVuS2PcK
	 /8n6fPdNMyRn+NByGk2xr2VQnnivg3/Ah49kUcaQtUtZwFwiqr7LDhJ3KeiFsf8bZg
	 pONHV1MsG+EomV6H8iaVh/6IMgcTA6i3VhuZrBdB8gPpUx0dIxHp83ddL146qsDDSJ
	 XBqDPNrIDnC/YuhS3m1DH7Up0yo6MqJqoRmDM3lfNsgdh2H2QAClUwPo/IkPnBCpLi
	 aLVF12ELGSMDQ==
Received: by mail.envisioncraftsman.com for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 08:05:51 GMT
Message-ID: <20240822084500-0.1.4k.vtg2.0.gknhrj3xy3@envisioncraftsman.com>
Date: Thu, 22 Aug 2024 08:05:51 GMT
From: =?UTF-8?Q?"Jan_Pol=C3=A1=C5=A1ek"?= <jan.polasek@envisioncraftsman.com>
To: <linux-nvme@lists.infradead.org>
Subject: Quick Question About Collaboration
X-Mailer: mail.envisioncraftsman.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_010812_268808_1D0DEC55 
X-CRM114-Status: UNSURE (   3.06  )
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

Hello!

I am very impressed with the products and services you offer.

I thought we could help you reach a larger audience with your offerings. =
Would you be interested in collaborating with us in an affiliate marketin=
g campaign?

For example, our program for a company in the e-commerce sector resulted =
in an increase in revenue from 8% to an impressive 19% (on average per qu=
arter).

We achieve up to 13% turnover in GA4, while standard affiliate networks g=
enerate only 3-6%.

Would you have time for a short conversation in the next few days?


Best regards
Jan Pol=C3=A1=C5=A1ek


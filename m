Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A3C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s8d3PxkPwYCqRYdZoqSQBeOKWtqafW0tD6Ft3R86Pl4=; b=udms+7LOCZhqDeckXt1kAcfdlE
	s9SdixA6T83Oy733hGIGWa4OklYKpoSQpr2gFJNttYS5xMacqYLXXz995fXJmYi+qsK8PwaecQPjo
	AcKzMxmIvsSaSVUnIE9eTEBMB9T2OTwMMWaklsr0Mk0A6sJA/Qj4B406NlS7xatgmdXwqtrUYKB7A
	PEJgnXqXBOMvzZk0F8rKwBl3dr78onDvVuclh7RzzySPGohdO7tzPJEOQ7btNru8ejnT0Aail5H2a
	vFQ+TY+KHR3AMyqStLBylA1BSArg3ZcMvwxf00YmRxdZJKp7hTH3+Ah+YxRGN245gyG4OAelfw6Ub
	qyPwmndg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvxl-00000007qtj-3BW7;
	Tue, 11 Jun 2024 07:30:37 +0000
Received: from mail.alphaplcred.com ([141.95.16.86])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvxi-00000007qpi-2yPO
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 07:30:36 +0000
Received: by mail.alphaplcred.com (Postfix, from userid 1002)
	id 198DEA2C4D; Tue, 11 Jun 2024 09:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alphaplcred.com;
	s=mail; t=1718091028;
	bh=s8d3PxkPwYCqRYdZoqSQBeOKWtqafW0tD6Ft3R86Pl4=;
	h=Date:From:To:Subject:From;
	b=WNQ8dyTxOdrD0aO3DXDYBdk817UPpsVb2qNq/m1BD9b89vHqPIIiyMnqptZuTKrF3
	 FxmbarHgB0FMpkYmZMIANtaK0c6e/qaYMJ2447c5AWFMBm3lxc0VAz0Jq5E+tY4D0z
	 GYqcAMaYfCTeOYXNHikAGni/WLS8PitFDCtPLFJK/vAOQgYZM4IlYBiOF55QMK0W0r
	 eBXdYoxoW8PovCNAWsEbpJMHON/eQynil6fQlqBevN6asfr2c4VZpM3WhnrBxpCRdT
	 QRjWyR+GhOK+4i6Ymvf1+9HlGn0H0RnM2jaAGV/HzrLOfrKPe+ysaQWW4QjFD17ZlJ
	 xBKi7lJT+oIDw==
Received: by mail.alphaplcred.com for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 07:30:13 GMT
Message-ID: <20240611084500-0.1.cl.mnc3.0.p6hp5i83fc@alphaplcred.com>
Date: Tue, 11 Jun 2024 07:30:13 GMT
From: "Edric Croke" <edric.croke@alphaplcred.com>
To: <linux-nvme@lists.infradead.org>
Subject: Innovative tools for effective teaching.
X-Mailer: mail.alphaplcred.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_003035_502369_034A1D65 
X-CRM114-Status: UNSURE (   1.07  )
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

I am writing to you because I have been inspired by your commitment to ed=
ucation and would like to share our passion and support for your activiti=
es.

Like you, we place great emphasis on the development of education and pro=
viding tools that inspire and engage both teachers and students.

Our company is not only a supplier of scientific equipment or digital tex=
tbooks, but also a partner in the educational process, ready to support y=
our efforts at every stage.

We want to be your partner in realizing educational visions, providing to=
ols and materials that will allow you to inspire both students and teache=
rs.

Our assortment includes, among other things, live organisms, preserved sp=
ecimens of fauna, anatomical models, laboratory chemicals, microscopes, m=
icroscope slides, and much more.

Could I present how our products can help in the development of your comp=
any?


Best regards
Edric Croke


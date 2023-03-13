Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85DC61DA4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VMteXbtiXYCqqZUJ1o1uq78X8npZvvxFMDCDPsOnXC0=; b=Cf+ecVJAdqwCgD
	IJjZyN7lZtGYq7xRYbexCjfu+pVcjmf/lhnCZp6vlMVLjVsIitMrgJ/nE10cLqMlfIJVr4BN3R+PQ
	6hLKpXWNLRPw9D0fW0H7OAWkUHTG6+DMK/QsGitiE1v2DbZXuzbz08vbc/u7n1TTTkM7UIjxYJLAG
	sthbcRVp4GYyU5Ck8Y0qzutJ4NGfCWXz8XH7GUtDSPiWeygt7B4d23p5CpDk7/Rv/EDIPQ7dp+m8/
	P9gwTsKjYP0ekwGEroBac4gwYvLlLUrOc2/qvELbBjzVgyhpo36Le+J1u59O2MX+3zCtxbghtZN1q
	GmRgJ7xAVyMNdkrnToEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbm1C-00783j-PU; Mon, 13 Mar 2023 17:31:31 +0000
Received: from [103.30.145.160] (helo=defaultworkshop.klidefectmanagement.com.novalocal)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbly7-0076lk-06
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 17:28:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asda.co.uk;
	s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=VMteXbtiXYCqqZUJ1o1uq78X8npZvvxFMDCDPsOnXC0=; b=g
	iiIfEXjL5NvCcDs0UTwSfWmEsj9qAnKYyvYaQSWHu3Mh7VxusVHtcRbQH31Y8E8vzAk83aUVJBlQi
	iFaOOHoPRdceyof4RKAAjtSWSk5QIrKpKWW6y0pKvIvQL6HkrxR0pF2xQG251aMyFUf/N+LpI5HJR
	qmQJYXztjTBRmLAQ=;
Received: from ec2-52-11-215-80.us-west-2.compute.amazonaws.com ([52.11.215.80] helo=asda.co.uk)
	by defaultworkshop.klidefectmanagement.com.novalocal with esmtpa (Exim 4.94.2)
	(envelope-from <sales1@asda.co.uk>)
	id 1pbly4-00061A-MV
	for linux-nvme@lists.infradead.org; Tue, 14 Mar 2023 00:28:17 +0700
From: ASDA Stores Limited <sales1@asda.co.uk>
To: linux-nvme@lists.infradead.org
Subject: First quarter procurement order/enquiry
Date: 13 Mar 2023 17:28:15 +0000
Message-ID: <20230313152049.56C19556334605F0@asda.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_102819_077224_F65F8AED 
X-CRM114-Status: UNSURE (   0.56  )
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
Reply-To: sales@asda-c.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dear linux-nvme
I'm a procurement manager  with ASDA Group (the owners of ASDA=20
Stores) and your company product has caught our interest.=20
Therefore, we request you send
list and prices of your hot selling items (products) for our=20
evaluation/pick.

Soon as we receive your reply, we shall send you our company=20
profile and buying proposal. You can also check our website below=20
for detailed info of our purchase area and trading capacity.

Your immediate response E-mail:  sales@asda-c.com   shall be=20
appreciated.

Best Wishes

Ms Stelle Montgomery
Purchasing Dept.
ASDA Stores Limited
Tel:  +44 7418367220
WhatsApp: + 44-7502985874
Website: www.asda.com


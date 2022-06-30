Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F677C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=; b=iTjEWUOsu1Ra3H6DY8b8A4AJHs
	PM4lAj8mredQtzZK2XZxqCKImRspZQ9gePKVn3dAbQXcXmEDrqtLJf6lUDZOZ1zAsgsmwFawQ+4hJ
	rsipwZMU/8HijeiDD/JBZzp25oBTXBLEEgiNBj7d4cBxmtzJbk7kz32SxtBh8b26fXya1nk8dqa6g
	qOskqISv81xLIk5YesgXPolk32fRT1sv6cBJpzeftCak1mZV9HFfAGcuWtv7q8fXPD5Soo9TH2RVx
	MsIW4raib9IO9MiGOkix/H3L9D5DAFs910CLZDEbvfXw6oNJuivE1zyFyKa+UtwhmEqhIk7nwEFek
	Lre8nFQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6oyC-00Fq9w-0E; Thu, 30 Jun 2022 07:52:12 +0000
Received: from mail.olerise.pl ([46.183.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6oy9-00Fq8G-DW
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 07:52:10 +0000
Received: by mail.olerise.pl (Postfix, from userid 1001)
	id 621C523C4D; Thu, 30 Jun 2022 09:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=olerise.pl; s=mail;
	t=1656575499; bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
	h=Date:From:To:Subject:From;
	b=SvFqecbrPgr0YZoZDcSnY4PDFP6WnNlDD9StLs6ujv11kswmpU1Iw4yqvOmnD87pR
	 1R+9e216aqgOHeuf2lU/YTmQXIgHRRvu2QaWPjxuQCIDJrEVF75X/gtEzKt+f7v0E0
	 S3B5tCCSgZHPptf/3dT2Pxs8Nd3GlPxi9gRH2Zo+riOPfy3SdLF2e1R3etajpbDMcf
	 ZIE17Nv8TvnxDN1T+Jugq1O6knLaXNKC+aog1JIXPawEzX6xHjXIPIbnXXrebLdv+g
	 3BvPAGNG24rCaPdErsLEWIwrMGlKOpWRHVMHDeEJt9zNpalY7RQw3CRKd1nvJ3Uxcf
	 AgxdS4t7IVSog==
Received: by mail.olerise.pl for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 07:51:21 GMT
Message-ID: <20220630084500-0.1.p.bcl2.0.jccmzdb4fe@olerise.pl>
Date: Thu, 30 Jun 2022 07:51:21 GMT
From: =?UTF-8?Q?"Przemys=C5=82aw_Wr=C3=B3blewski"?= <przemyslaw.wroblewski@olerise.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.olerise.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_005209_683825_F06256E6 
X-CRM114-Status: UNSURE (   1.26  )
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

Dzie=C5=84 dobry,

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Przemys=C5=82aw Wr=C3=B3blewski


Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2AC433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 19:49:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8C8207BB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hc6f2dLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8C8207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=znettelecom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:From:To:Subject:Content-Description:
	MIME-Version:Cc:Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dmsOzNAXnvNGQK96Av3WGeQsAsryyPXQoqM48+kU9Mo=; b=hc6f2dLfHsdgwD6roN/iFfL7xk
	+sk5iGF+o98cRbysSSaHN9oQHEM1Sx1hezZvWGodCuXfoc8JXAUF3lftRBfZMl8B/3dSn1BsIfG3g
	cXenF+NuNvx4q9gbt8uusrEjLMAA6nHU6T1kLC+hYAIa9WXKsWb9tXWxJ9OlZbDa39HzMTcW+0Pul
	T5PRLzlCgk3NleWf+aSdGKIdwAj79cFzK8M6G4E0wdWm3zyzdW5nRAYVIgfdfbNogXoItEmDEQyo4
	shZkLZ1q6Zxp7pEo0eAGvCgCLrRmJkfcuwEY0qd9Y2NOGjYdGY0KowSwJ5KqugovR5pkfY8/fOeXk
	WPpkwvCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyhDk-0000km-Es; Thu, 23 Jul 2020 19:49:36 +0000
Received: from [187.0.30.10] (helo=srv01.znettelecom.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyhDV-0000eN-GI
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 19:49:34 +0000
Received: from 128.205.136.77.rev.sfr.net ([77.136.205.128] helo=[172.20.10.2])
 by srv01.znettelecom.net with esmtpa (Exim 4.92.2)
 (envelope-from <alan@znettelecom.net>) id 1jyhDI-0008SD-Ut
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:49:09 -0300
MIME-Version: 1.0
Content-Description: Mail message body
Subject: DONATION OFFER
To: linux-nvme@lists.infradead.org
From: "Steve lenka" <alan@znettelecom.net>
Date: Thu, 23 Jul 2020 21:49:05 +0200
X-Antivirus: Avast (VPS 200723-2, 23/07/2020), Outbound message
X-Antivirus-Status: Clean
Message-Id: <E1jyhDI-0008SD-Ut@srv01.znettelecom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_154921_787067_6545BDDA 
X-CRM114-Status: UNSURE (  -3.88  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: stevelenkathomson12@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello, Donation of 1,000,000.00 GBP given to you by Steve & Lenka Thomson, =
This is to help fight against Corona Virus and help the poor people off the=
 streets. send email for more details: stevelenkathomson12@gmail.com
Steve & Lenka Thomson

-- =

L'absence de virus dans ce courrier =E9lectronique a =E9t=E9 v=E9rifi=E9e p=
ar le logiciel antivirus Avast.
https://www.avast.com/antivirus


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

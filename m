Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8673CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E2sh7PkU99v95gXhyMFBk9zs8wQA9SBmo0ZEWgF1/ao=; b=OHhfIQzMQXGPv9
	RbJ10Z6d8IYHYqBvvajNRrsmCDeDXVdGHo8bLvijt5xD9qYoomK3yTLEK8qL7g8qvhphkWQHYX96d
	PiVFTj6Ft0DEN0dKVgJ9ktgGjO+oY3RMfPomBCgJQ1vXL+LxgthXlELzI+JTcf0voxnEpr/EIC2ls
	TuoO+vcTXjvoP6L9h3U37zVIqFGgx4510fz/7Jy9m8Q/ScQ+qrvju25Ujw6XhX1yziWIhWuBmqNqe
	3wRTPO4sRfCVhJ2ATWy1CY4H5kKZenp3QFpmVc4RGy15kHnu+Wzl/9iYgcakWAQSESmtVhXHC6A6v
	8PNDRdor2K2btAVZQTzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up9Uz-000000007Us-10eR;
	Thu, 21 Aug 2025 17:54:53 +0000
Received: from securitygw1.exwire.com ([216.171.192.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5FB-0000000H2aH-1TJg
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 13:22:18 +0000
X-exwire-MailScanner-EFA-Watermark: 1756386888.47569@SEezuY7wXc0h4MUHu4u35Q
X-exwire-MailScanner-EFA-To: linux-nvme@lists.infradead.org
X-exwire-MailScanner-EFA-From: nancymc@exwire.com
X-exwire-MailScanner-EFA-SpamScore: ssssssss
X-exwire-MailScanner-EFA: Found to be clean
X-exwire-MailScanner-EFA-ID: 3E7562622AC.A3C30
X-exwire-MailScanner-EFA-Information: Please contact jdeverse@exwire.com for more information
Received: from smtp01.exwire.com (smtp01.exwire.com [216.171.192.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securitygw1.exwire.com (Postfix) with ESMTPS id 3E7562622AC
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 04:38:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 securitygw1.exwire.com 3E7562622AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=exwire.com;
	s=default; t=1755776291;
	bh=HV6ngFc0kAPeZqm3RhmqrUX5EZoxx49VvdfM3cgWoeI=;
	h=Reply-To:From:To:Subject:Date:From;
	b=e2eNb3qQYVW4c8aO1aGG9hHtRO6Goq4aHr0bg/fSJx1wI4MU97u7aRuyPszgIxDPw
	 eCNoDcE8MPSHxm3qkuMbu7mThgKISpV8p8GiMQK/8nY5vXdMqennmKf+J4BB+f4/tc
	 5BvolOwiyQG6OCAsn2m5YPZV1fSW+vwAUJCrCO/k=
Received: from localhost (localhost [127.0.0.1])
	by smtp01.exwire.com (Postfix) with ESMTP id 65FCD5272C1
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 03:03:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.exwire.com
Received: from smtp01.exwire.com ([127.0.0.1])
	by localhost (smtp01.exwire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihGdieiTC1oB for <linux-nvme@lists.infradead.org>;
	Thu, 21 Aug 2025 03:03:57 -0700 (PDT)
Received: from [45.138.16.152] (unknown [45.138.16.152])
	by smtp01.exwire.com (Postfix) with ESMTPSA id 984635825B5
	for <linux-nvme@lists.infradead.org>; Wed, 20 Aug 2025 23:25:30 -0700 (PDT)
From: nancymc@exwire.com
To: linux-nvme@lists.infradead.org
Subject: xl
Date: 20 Aug 2025 23:25:30 -0700
Message-ID: <20250820232530.AF559C05D1CA4B82@exwire.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_062217_382299_740176EA 
X-CRM114-Status: UNSURE (   3.62  )
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
Reply-To: info.superenalotto@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Wir freuen uns, Ihnen mitteilen zu k=C3=B6nnen, dass Sie zu den=20
Gewinnern der j=C3=BCngsten SuperEnalotto-Ziehung in Zusammenarbeit=20
mit Lotto24, EuroMillions und Powerball geh=C3=B6ren. Sie haben einen=20
einmaligen Gewinn von =E2=82=AC3.850.000  in der zweiten Gewinnklasse=20
gewonnen. Um Ihren Gewinn abzuwickeln, senden Sie uns bitte=20
folgende Informationen per E-Mail:

Vollst=C3=A4ndiger Name: Land: Wohnadresse: Alter: Geschlecht: Beruf:=20
Handynummer: WhatsApp-Nummer.

Im Namen der Online-Lotterieabteilungen SuperEnalotto,=20
EuroMillions und Powerball gratulieren wir Ihnen herzlich zu=20
Ihrem Gewinn.

Mit freundlichen Gr=C3=BC=C3=9Fen

Frau Katherine Federico
Leiterin Online-Zahlungen / Validierungsmanagerin
Code-Nachricht: 737GHS98


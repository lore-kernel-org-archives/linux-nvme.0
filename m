Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF88CA0FF0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MUVKqSfvoSrfQwKLxkBkNcMeAPDaW/uXn4tfyNXsF2Q=; b=SQHFjgqhfFaiwW6Xkg8NkBU/Hq
	i2EAU1owA0CqBGoPwUECvzhQze1TiWUWlYbsGJ7OBOcj8kMxwteNmbbbl44W/2DxdaZifzO6znKJ0
	JCP+BN7V9y/SgjuN3c+cXwBeTCYPCQZmJZjQ0tSwggL1kcOfuqfiV030iBqEm2dl0C1v2M9PAEAZw
	0wZva0wiV/q63IHDTzQU5q5QqlzxOMeliyGXEqsvayXIBJXIeSUFdMq8NZYMukics7Xr7pJbE87Vi
	d1fac+ZfGVWlUcX2jlc2sawB/sCzjWXY9hdO4bfiUA4kBsQ4SX/dv+q1xTLvP9uZQd6j+u0zSdwqB
	qWro+9ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uruuw-000000053Bw-3Adx;
	Fri, 29 Aug 2025 08:57:06 +0000
Received: from mail.primefinix.com ([141.95.160.218])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uruFQ-00000004vGF-1x2T
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 08:14:13 +0000
Received: by mail.primefinix.com (Postfix, from userid 1002)
	id C1FCBAD461; Fri, 29 Aug 2025 10:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=primefinix.com;
	s=mail; t=1756454612;
	bh=MUVKqSfvoSrfQwKLxkBkNcMeAPDaW/uXn4tfyNXsF2Q=;
	h=Date:From:To:Subject:From;
	b=vambuInfQUi6XSp8SIRhLME9Rape5O80krznCyS8Qi7qDjRuta+vNEDCDcf9nfSu7
	 uLHgYFzOsVMK4s17gjNj+uqIsqTTgmmpsIAR/VqRO8A81cxBTtUm54BTFK8aZb8W+g
	 ZUlM2Rx45eZUvSd6BDIeyf426/2HjWUnI5bH2ljkid25blcZrVsK/xSAuNbvGXfWQ1
	 CQB1KkcJNTWfNtvvmuKAzkoqQZpQZwmIYAkUcUZM/px8Kb+Q/Uo1K5CCGC/diZCr0r
	 yo1zU94B/97eHnPkCRMi4I9GQ7UWJmEkHntgOuPoqkHEsyp2fW4hHXgnfJ2Dd1bOLr
	 8SF4IimX8KKHQ==
Received: by mail.primefinix.com for <linux-nvme@lists.infradead.org>; Fri, 29 Aug 2025 08:00:58 GMT
Message-ID: <20250829084500-0.1.mn.3m04e.0.nhdkak5pp3@primefinix.com>
Date: Fri, 29 Aug 2025 08:00:58 GMT
From: "Brendon Roy" <brendon.roy@primefinix.com>
To: <linux-nvme@lists.infradead.org>
Subject: New Sales Model
X-Mailer: mail.primefinix.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_011412_761317_13BBF496 
X-CRM114-Status: UNSURE (   3.19  )
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

Hi,

I'm writing because we have a ready-made mattress dropshipping option, an=
d I thought it might fit with what you're already doing (or wanting to ex=
pand).

No warehouse, no packaging, and no shipping =E2=80=93 your customer order=
s, we ship, and you gain an additional source of income.

If you're interested, let me know. I'll show you how we work together.


Best regards
Brendon Roy


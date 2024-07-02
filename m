Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF7DC3065C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=19VLFL+g9q1Ds0BcHQQucjq8+gJ2KR6LPcT+LA7NWpY=; b=iTHXRtOzlJ98kAq8ZQ5N4v8IHD
	pWogzkMGWTsBxsXs6I9TPSCvbNqvA+qPrAqzLi3yZ07TrYTKAmFT8eUtfij48OEy+2fkB1jQHrpgH
	7YxY5MGxoFPKLS6PgSKCBQfQXo438H8TQQztUo9yNoc+cFaukZSDBToXDrPUo4bYKC5aHZlKDlcF8
	2WEaYLRpSt6M411moBVIPnscS0b9TkQfZY9b33ZKCoPaYGiz2JFzQrt0xK7BXw9Yc5JfAF7yAX74f
	z2+0tH40I+ySit0kdeSZDNYFM08jnbJ77O2LBbifhYpXzVutj6SDHFSQHVqe4yG/SQgNtxmzr5GFX
	KBjhqUAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYVk-00000005wS1-1YPU;
	Tue, 02 Jul 2024 08:05:12 +0000
Received: from mail.revenueraft.com ([51.210.151.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYVh-00000005wRb-38G8
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 08:05:10 +0000
Received: by mail.revenueraft.com (Postfix, from userid 1002)
	id A66EC2446D; Tue,  2 Jul 2024 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=revenueraft.com;
	s=mail; t=1719906959;
	bh=19VLFL+g9q1Ds0BcHQQucjq8+gJ2KR6LPcT+LA7NWpY=;
	h=Date:From:To:Subject:From;
	b=Rvp/K6jK/6ogH0Aczon3bcUDAEFY2BMTb4N6AeBEQdVBGoNGx0C7BvUF+BqnPcN18
	 pkDniAE55ub4nxEva3i/a8qAgIXX06KcqxlHD5iz9p4M2kBUS0TLHEkJlB0UtJn4QW
	 6vV5BJIfbbxEOXiRDUgbmybuk95ttgJ/63Yn5EBe1ds3WOSSCgctETO9HTkIBZq7bO
	 zKYJPRuSeyeGV6b1b+XFttcioc8yUaEFZWiu/xE1bhg8oZMcjyXBdbiI5xh7Hww+va
	 KZc5JDlQBvHz18uB4mgZX41ScIOnHtBRx4vclEcTMKrT/wHXS6Vtwopj5sqpV7PKPA
	 bGSnntEa9KS9w==
Received: by mail.revenueraft.com for <linux-nvme@lists.infradead.org>; Tue,  2 Jul 2024 07:55:57 GMT
Message-ID: <20240702064500-0.1.12.2dud.0.r4l06jdwda@revenueraft.com>
Date: Tue,  2 Jul 2024 07:55:57 GMT
From: "Martin Juve" <martin.juve@revenueraft.com>
To: <linux-nvme@lists.infradead.org>
Subject: Cooperate 
X-Mailer: mail.revenueraft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_010509_947398_9ACB0EB9 
X-CRM114-Status: UNSURE (   2.72  )
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

Hi,=20

Are you looking for IT solutions that will improve the operation of your =
company?

We have IT specialists who will help you implement projects, even complex=
 ones that require the support of an interdisciplinary team.=20

Our UX/UI specialists, product managers, system architects, developers, p=
rogrammers and software testers have been working in an international env=
ironment for years.

If you are interested, our representative will contact you, just reply to=
 this message.


Best regards
Martin Juve


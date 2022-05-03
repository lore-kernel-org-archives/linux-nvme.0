Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8D92VzzQGHSTsP24HtjPziMaxT3WWQHIYM70K3xg6Pw=; b=CgE31YaLelFnrM
	Ntde4TH+bcO1IkE2kvKkn2zyB6EcNmKPXLk/RJJVSruPlfcV2++7+7Y/BmWnTdVuf/QV1ZXVOgTU8
	2tsnf1X0arM42CYc01VfXnQJmnyYmoeyANtaVJrvmG/8qbTWgfDcQP10I0gg2d0ys7fo/HisKgzkD
	ExcAtUM9UPxux6Hq+5NMZxbU+uaHg40mTwHx8xbXKTH9x+6gwOA2IvWDIBBgv5ANuka+W7t5uHbJq
	i1XqRFtj9/TrUzHA7J0QhOCD+t6Wc4eHNMpQ0xRuVct8FS5JVu+HmtzjKYM/cC2kBeiZqnN8bgA6F
	GCgFqH5G+iOMOQaa2Dhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nltsf-006L5U-5l; Tue, 03 May 2022 14:52:01 +0000
Received: from mail.megasoftsol.com ([43.231.250.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nltsX-006L1R-PE
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 14:51:56 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.megasoftsol.com (Postfix) with ESMTP id C0F0C90C1BE
 for <linux-nvme@lists.infradead.org>; Tue,  3 May 2022 20:16:54 +0530 (IST)
Received: from mail.megasoftsol.com ([127.0.0.1])
 by localhost (mail.megasoftsol.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id OvkFKyipmVYO for <linux-nvme@lists.infradead.org>;
 Tue,  3 May 2022 20:16:54 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
 by mail.megasoftsol.com (Postfix) with ESMTP id 27A8290B736
 for <linux-nvme@lists.infradead.org>; Tue,  3 May 2022 20:16:54 +0530 (IST)
X-Virus-Scanned: amavisd-new at megasoftsol.com
Received: from mail.megasoftsol.com ([127.0.0.1])
 by localhost (mail.megasoftsol.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id W529-Ye9dVhX for <linux-nvme@lists.infradead.org>;
 Tue,  3 May 2022 20:16:54 +0530 (IST)
Received: from asda.co.uk (unknown [20.97.211.134])
 (Authenticated sender: admin)
 by mail.megasoftsol.com (Postfix) with ESMTPSA id 5297B90A52B
 for <linux-nvme@lists.infradead.org>; Tue,  3 May 2022 20:16:53 +0530 (IST)
From: ASDA Stores Limited <Hanes.Thomas23877@asda.co.uk>
To: linux-nvme@lists.infradead.org
Subject: 2nd Quater puchase request
Date: 03 May 2022 14:49:19 +0000
Message-ID: <20220503092157.767841AA78047AD6@asda.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_075154_171085_4AA4EBC4 
X-CRM114-Status: UNSURE (   0.81  )
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
Reply-To: sales@asdaa.uk
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dear linux-nvme

We are interested in having some of your hot selling product in=20
our stores and outlets spread all over United Kingdom, Northern=20
Island and Africa. ASDA Stores Limited is one of the highest-
ranking Wholesale & Retail outlets in the United Kingdom. 
=20=20
We shall furnish our detailed company profile in our next=20
correspondent. However, it would be appreciated if you can send=20
us your catalog through email to learn more about your company's=20
products and wholesale quote. It is hopeful that we can start a=20
viable long-lasting business relationship (partnership) with you.=20=20
  
=20=20
Your prompt response would be delightfully appreciated. 
=20=20
Best Wishes=20
  
=20=20
Hanes S. Thomas=20
Procurement Office.=20
ASDA Stores Limited=20
Tel:  + 44 - 7451271650=20
WhatsApp: + 44 =E2=80=93 7441440360=20
Website: www.asda.co.uk


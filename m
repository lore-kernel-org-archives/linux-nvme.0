Return-Path: <SRS0=vsJd=PF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E8C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 09:57:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC8360FDC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 09:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBC8360FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDPhOzWFCZTwryepYRvpm5u7AJpOi0OEMjrOAi3txsA=; b=IhOuUDAIGJFeXISmWsW1phHxG7
	thDyxawDfHruEiWFNpQ+TkNAclHZ6isqJcoJCttFVFt4UYqV9Fb/6QbtJrHG+FGu7lvwGyLn/Pa62
	bnAilfKBGKDBUz/ZMx8qHNlSsDqAAORVQLBcUB9gyunN4iKbJoHibmNSHlnDNKIxeJ78xPo8DvFMP
	OSMHukbOMKmx/YH5xIcpvYzDRSr5K72jRurmh048yke14Cuxp/5p3Q0Dt8kW1t+MQhOfrOu/Wx3AG
	cTq66gt6dZqhMBQsPuaX+G7+JSsWhC/IWDgJVhODXn2S6y9XbVfAfHuDmuOPaj1UK16FGvSbThdRq
	uoWgBemQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mc2uv-00C3Xx-NQ; Sun, 17 Oct 2021 09:57:21 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc2us-00C3XJ-9N
 for linux-nvme@lists.infradead.org; Sun, 17 Oct 2021 09:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1634464626;
 bh=GK27mjfavzFQQjBXkKn0RLCiDGh17zJ13VUyMZ39ERs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=g4QPrqgqY8bWgQhTWOHyALwiyqEIhfzf/HKIQKPTPGY6TZEFRMJrZBj0MbLPzX0uw
 UDK1QJfLuNmOw5NXdBONMR05OVNxh1AD8CDN6q+D3/TWDxg536mfm9gAb2vMU53Zzf
 MyMiyhqK27oR+DMbuFr3agQPgkvTv5twuWz87Rbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MSc1B-1m94pM2rqD-00Szo6; Sun, 17 Oct 2021 11:57:05 +0200
From: Len Baker <len.baker@gmx.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Date: Sun, 17 Oct 2021 11:56:50 +0200
Message-Id: <20211017095650.3718-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:87l8oHXEfjCElo1TfalS+3I3QAENKqmFPDOlW7QVOffxRttv4nQ
 2AMPklv1f8oNxtJoCI1kESq9updTTNLaT8S8om5Xk+CPLW75asuvC0IENPAKV627O07UzWS
 JU0rMQ7aE5QwMkuA/Hrhj1oFv7UdgPM1pFkeoifDS3V5cmzqG+Z22u7ngNCUj7rElfftrgD
 Z7FYrBQVEwjaXW11HwaGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuAiV954YSg=:cYURQWGEk30tKqGLBXHtIj
 xwzMpAgdJTjqcuvKEtY8b9OMK5hmvMS6vFB72geh5KDQmb6L2VSIby/8ELL5Hi8e2mWdKJdE7
 kN8c8d2q6zKTvzk4yu/LMKdCdkSnd/pfPcS9tNBu0Mc7GVSYjDJ5Pvj31a6skIkhuBb3ESdcy
 9WHIIcyk/AUgVIjIzTWstU8h7h4C4CdbbXwzRPOCOTHLWfnaedc0LnFJLA51dPyCpZcI+FKRz
 6otGxpVaEQ9HjA/gBUA1JAKuMahEDZzeOnurm7934tg+CL11vtjOKNr5+BRkSxBBhHhe0cdzC
 KRgrbbMzBPB8vX3r4fAh0W64z87bGB/PAKnX/krmDiMDyqIfRF+kAMtdjRa7uSBSfbE5c4FRx
 GE9up/5XUTPICti40Eu78nDoyPeUdBq70+A9n2aVbYrLDGo148Mqmnt5i86APP2Wg+LpIr71C
 E6cy9xBvB0240oWdoJTiupbH5+FTiC/D6Q7cIkM2FU0BBq1ZSQ2kqsPL7JUuGY9dTQdtiosKY
 guqOOEja0wSGQXwQ2tB8Oo1AEOi9M/pBdmW2D7/bIadpZ5YsQCEw89BkbP8P/Yc2RObG6zl10
 KgnqZi5A781t+XqWceb07dYGZAmYklqX3aez6cPLq4zgWlCKLTCGp8ZjYzkhbJUwEHdxj6ret
 Bc0VxgXIimfIWqpnmRSDbcFWhW2WPV5dtK4rt2WbaQBsqtVaZvXdZoZUgNSwRB9bc/vpYAcvL
 jGPwxATwLNezpK/ZZGSuFiCYWnVmAeOqbRa53b+d5eSMDYhvA+UdqRVQpaURea58WyhfmTjbS
 Wnbd0NYvhLxVRMkLwvlM5nUb7eErcedBzXWvNHgZRxzIHK42w6nbjxtKwtkFXN+nmxcrN5dvd
 tXByxa0ycZt1BG9R0o7ivvE5py/t1GiHlQFtZZJwYJQzRuj0SFV8Y689DN+9icZ7AQSEJHp5L
 4/7DhF6CNPKr2Z2PBiKPyXPUZIbQbCw0kCRn3bGdftJzbHqdF/cCypfYjGotYe+Jo8ghk+1HD
 rDov0d2PEF+4IxYO3xLlDlx6iW/WjFxoniNP8gu6S43Kjn5z7mj2Q0b9hPpDABsiRL9Vj3Qo6
 WPOhsZgyYVIzvs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_025718_707180_B338DF38 
X-CRM114-Status: GOOD (  11.81  )
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

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case this is not actually dynamic size: all the operands
involved in the calculation are constant values. However it is better to
refactor this anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kmalloc() function.

This code was detected with the help of Coccinelle and audited and fixed
manually.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi,

this patch is built against the linux-next tree (tag next-20211015).

Regards,
Len

 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-c=
md.c
index aa6d84d8848e..4aa71625c86a 100644
=2D-- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -278,8 +278,8 @@ static void nvmet_execute_get_log_page_ana(struct nvme=
t_req *req)
 	u16 status;

 	status =3D NVME_SC_INTERNAL;
-	desc =3D kmalloc(sizeof(struct nvme_ana_group_desc) +
-			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
+	desc =3D kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
+		       GFP_KERNEL);
 	if (!desc)
 		goto out;

=2D-
2.25.1



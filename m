Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642DCCA476
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=; b=DWArBE/1qbGsqz/Xk1PM4TekhP
	+2JtssKsQ7P0YJ8yh1PPq4HL094pApfZ2Z64W+2zN83IAZNEKo7WO9JiqN9kiqHuDGmOnnzZLvK/c
	k23lEfwUB49G61IPn8vcdLNc7Wi7fISRL63GDjRyGjzSt+aZHwu6PpGpCeI137+ezThCk82fBW2Ka
	tEKUJ8r8LGxzkQPmvE7OnIxZqrmHYJZS4+uZG15O1dPjfHS8yjYEmse6NsHe+q8aygwR7CXXWB4R+
	hpws1uni/4ZZJs1FGtphHgWxFxPsvXIq4WqRLAitBMnURg2B8FHWyqDG6CaxZ9rpAK5VjdmUoKZbu
	ZO9Q7dUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8DPn-0000000CX9k-312A;
	Mon, 13 Oct 2025 07:56:19 +0000
Received: from mail.commetrax.com ([141.95.18.165])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8DPl-0000000CX8M-0b3I
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 07:56:18 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 9068123B82; Mon, 13 Oct 2025 09:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760342172;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=GxDu1w9j/NYyBgg4+vso+Jetz2rVP96uaOf9jA+QWJ8BRYwZ33bUOHTjriv+o0DAw
	 tmYF9DejqmBnji7QChhz78QXDiLOQkljOUh+ZDkH2W4189vcRDKdu88AEHPejWYUDL
	 DGxrvDeyrvqUGrfj4wRVWgAG5g0v2iKVAASyAz/mTbcwkGU5ik+zYz+gw4DfGJKcU1
	 VBXP3sexLWr2kTfwdzfT4GKMjOj0LXD8+lKUdJ0q7IJaHsQ+xinh+Vtz7pcFoSUqh3
	 pEq8eaAGYyVIfFfl6e2lj27TcrFh6AcCwMSt9F1BNa2DVvaGTNuclXcWG8u1+S9auJ
	 +0svkkSA8LuIQ==
Received: by mail.commetrax.com for <linux-nvme@lists.infradead.org>; Mon, 13 Oct 2025 07:55:41 GMT
Message-ID: <20251013084500-0.1.c8.16dsx.0.9ei6379x9j@commetrax.com>
Date: Mon, 13 Oct 2025 07:55:41 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-nvme@lists.infradead.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_005617_476531_71E891D1 
X-CRM114-Status: UNSURE (   2.44  )
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

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh


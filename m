Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A29C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGp1gaFSRkr0bRuTshmneZHpJzfNKx2kLBUG7hKanOA=; b=rP/U0/NsHoL6zba1Ljum6ElCfI
	W8IcuCG8+LJIQANYm4BtyOHpBkUOTFxfoA2ZSCuavqjOUqtgkyyGcI71nuORxYVzZTfyyTf5K8DXg
	daHEC9aXIORUimVdv7pUlVA1fT3CKiaUCPKhC6ITU8oaQDxxIw1D1lMKzLlCXzINBU8H9pF19VLL4
	zAqdj2eGjRoturR+8NnvNU+NOxdjYjbsQ672TayY9uOEvCJzmL6Pb7Mv4p3dMVg1380pAtltI4883
	XKAB9t4E+VhvWS8vXOkQjXW7JAC7uUSwU06OXYSoUTnJC1mzkty/1hBawlWpOtn9mSn3aZRLatwcY
	NPFvjixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpPF-007Prb-DM; Wed, 09 Mar 2022 06:02:41 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpPB-007PqP-RG
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:02:39 +0000
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
 by freemail01.tom.com (Postfix) with ESMTP id 19AF41E8C2AD
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 14:02:35 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app01 (TOM SMTP Server) with SMTP ID -1968376195
 for <linux-nvme@lists.infradead.org>;
 Wed, 09 Mar 2022 14:02:35 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
 by freemail01.tom.com (Postfix) with ESMTP id 04A121E8C2A4
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 14:02:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646805755; bh=IGp1gaFSRkr0bRuTshmneZHpJzfNKx2kLBUG7hKanOA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=5ktEVSn22lI+6sMAYiIA786bwMhW3PsUB1BMZa/QbS6vxnF/NcZYx1hLsVYTT9nHH
 /BdRhYzzCHrFjxuVOQK45AAud8m87ik9H164JdzOB0mbZ5XdRUOqEx9/nkil/6x9if
 wpvfXUb7NFnG3NUSfed5+s3Pr+FPy+/pRPyTPbWM=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
 by antispam3.tom.com (Postfix) with ESMTP id E417A9C1C19
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 14:02:34 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
 by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dbo791R4ar1G for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 14:02:34 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam3.tom.com (Postfix) with ESMTPA id 80CC59C078A;
 Wed,  9 Mar 2022 14:02:31 +0800 (CST)
Date: Wed, 9 Mar 2022 14:02:30 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309140230.00000e5e@tom.com>
In-Reply-To: <20220309053711.2561-1-sunmingbao@tom.com>
References: <20220309053711.2561-1-sunmingbao@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_220238_222371_07FCC09E 
X-CRM114-Status: UNSURE (   6.67  )
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

The patch v1 for target side also inserted some calls to
networking APIs in the generic part (configfs.c) for validating
the congestion-control specified by the user.

Per the comments from Christoph Hellwig on=20
=E2=80=98[PATCH 2/2] nvme-tcp: support specifying the congestion-control=E2=
=80=99
(the patch for the host side), here delete these calls.

Since the tcp_congestion specified by the user could also get
checked later within sock_common_setsockopt in nvmet_tcp_add_port.
So this deletion brings little downside.


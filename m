Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1DDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ROCPIy4h5kbqyEHwIyK4fiG1uB8nmf8wgt+C9RIOU0=; b=rmaECJKdQI+nPQapzuP/Oo3RPY
	Rds15tH8DHvNfdjW/60oX8VcWgniFFeyQCJLt47LpABx+j493bOFxlbK0kS3O1F2MmPQKE0jZUy4Y
	v5fPQwU9TTZ7CCxxMZD5rGoMLnVOG4e04Fq2IqphQpEJfPtGP3dx39RA4f8fQyYXSuJD/uP3W4eb+
	LbCQd+ctW1UOauuIbJLAkbt61VX45OAQEpICMwBHpXGwSDQvrl0tHXSX+4/9gt7/Tfpyta4M/3YCO
	Pvhsv6QwvFb3t80DRU0LC+M+Vod3JR7XznIT9Sp5gkOYKhnnGxHfNviL+ydx5QN+Rm3a76U9MyweE
	tHvBUzOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRwZx-008nbd-CT; Wed, 09 Mar 2022 13:42:13 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRwZu-008nZc-4j
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 13:42:12 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 5F6AD44010D
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 21:42:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646833327; bh=vRJReDG4bqq0lBu9NwhCT/7EchP5ZD/U7FLT0SyLwVA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V3pk7M4xrkzvXbEEIDiIw5NQR3Yoe8Q0MPuIZ5OcoIkvqpnzGzSr1byVnb2ixJgp6
 V97Rnc0VA7U92mThyjvFZB6DRbA8AgrKq2J8wRJNzRM/7QOFKuspHugYHwhPwvLXdA
 ZH84/Vfpfnn2NV6M3C3YU5mF9csQCfZqaFhhooDA=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -371399624
 for <linux-nvme@lists.infradead.org>;
 Wed, 09 Mar 2022 21:42:07 +0800 (CST)
Received: from antispamvip.163.net (unknown [172.25.16.71])
 by vip-app02.163.net (Postfix) with ESMTP id 5B16B4400F0
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 21:42:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646833327; bh=vRJReDG4bqq0lBu9NwhCT/7EchP5ZD/U7FLT0SyLwVA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V3pk7M4xrkzvXbEEIDiIw5NQR3Yoe8Q0MPuIZ5OcoIkvqpnzGzSr1byVnb2ixJgp6
 V97Rnc0VA7U92mThyjvFZB6DRbA8AgrKq2J8wRJNzRM/7QOFKuspHugYHwhPwvLXdA
 ZH84/Vfpfnn2NV6M3C3YU5mF9csQCfZqaFhhooDA=
Received: from antispamvip.163.net (antispamvip.163.net [127.0.0.1])
 by antispamvip.163.net (Postfix) with ESMTP id 9E7BB1541564
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 21:42:05 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
Received: from antispamvip.163.net ([127.0.0.1])
 by antispamvip.163.net (antispamvip.163.net [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id TYlw1Ru3gj-F for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 21:42:03 +0800 (CST)
Received: from localhost (unknown [223.104.211.98])
 by antispamvip.163.net (Postfix) with ESMTPA id E129815414D2;
 Wed,  9 Mar 2022 21:42:00 +0800 (CST)
Date: Wed, 9 Mar 2022 21:41:59 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220309212852.00007828@tom.com>
In-Reply-To: <20220309153136.000048e1@tom.com>
References: <20220308151606.2563-1-sunmingbao@tom.com>
 <20220309061442.GA31316@lst.de> <20220309153136.000048e1@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_054210_592868_FDD06815 
X-CRM114-Status: GOOD (  15.97  )
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

On Wed, 9 Mar 2022 15:32:33 +0800
Mingbao Sun <sunmingbao@tom.com> wrote:

> > > @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ct=
rl *nctrl,
> > >  	if (nctrl->opts->tos >=3D 0)
> > >  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
> > > =20
> > > +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> > > +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> > > +			TCP_CA_NAME_MAX-1);
> > > +		optval =3D KERNEL_SOCKPTR(ca_name);
> > > +		ret =3D sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> > > +					     TCP_CONGESTION, optval,
> > > +					     strlen(ca_name));   =20
> >=20
> > This needs to use kernel_setsockopt.  I also can see absolutely no
> > need for the optval local variable, and I also don't really see why
> > we need ca_name either - if we need to limit the length and terminate
> > it (but why?) that can be done during option parsing. =20

Regards to the replacement of 'sock_common_setsockopt'.

Per the story of the deletion of 'kernel_setsockopt',=20
users of this API should switch to small functions that
implement setting a sockopt directly.

So I tried with 'tcp_set_congestion_control'.
But then I found this symbol is not exported yet.
Then I applied =E2=80=98EXPORT_SYMBOL_GPL(tcp_set_congestion_control);=E2=
=80=99
in my local source, and it works well in the testing.

Then what should I do with this?



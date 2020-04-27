Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56945C5519B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 06:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9512080C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 06:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UBy62iiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9512080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99vFl7PstqhptSOsAA99mIB60TyBCb8l/lxxGjQqdss=; b=UBy62iiRWW5M7+
	oGy1OdLNfMlKjqXAhjgsh8JAs089SWJtM9YTbZqs0waJLA8i+RZ0i+d4q22o8/4rF9fJtflbHHmOC
	H9S0fyej/PZIUv8ukHzSr5ARtrGDF9E61WKJDdJEqH9vWWmCty+S8zRK7Xhg7sYc2FZLrSP8Kvxge
	h3LdXDuVYIPdFHBXIHI4n1S8tVBinoOyWoeeH4OUjwoO35m62Ln8uSjnnesGIEhpCGqV0O+6Ab1hd
	SFy5VEkSwIFr6HXW4TWOW28wUwmI4AP1muF3yHVBsOTGCpVjk9LQnHTCM0RD3GjKtBTmlXEQdamZD
	J3kd93S84sDKgNuXeMSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSwuJ-00065C-Cx; Mon, 27 Apr 2020 06:06:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSwuH-00063v-8s
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 06:06:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9565668CEE; Mon, 27 Apr 2020 08:06:14 +0200 (CEST)
Date: Mon, 27 Apr 2020 08:06:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
Message-ID: <20200427060614.GB16186@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de>
 <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
 <20200424071433.GE24059@lst.de>
 <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200426_230617_463674_E0503393 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Apr 26, 2020 at 01:50:05PM +0300, Max Gurtovoy wrote:
>>>> I think the printks are a little verbose.  Also why can we set
>>>> ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
>>>> we reject that earlier?  In that case this could simply become:
>>>>
>>>> 	ctrl->pi_support =3D ctrl->subsys->pi_support && ctrl->port->pi_enabl=
e;
>>> for that we'll need to check pi_capable during add_port process and dis=
able
>>> pi_enable bit if user set it.
>> Which seems pretty sensible.  In fact I think the configfs write for
>> pi enable should fail if we don't have the capability.
>
> The port is not enabled so it's not possible currently.
>
> But we can disable it afterwards (in nvmet_enable_port) :
>
> +=A0=A0=A0=A0=A0=A0 /* If the transport didn't set pi_capable, then disab=
le it. */
> +=A0=A0=A0=A0=A0=A0 if (!port->pi_capable)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 port->pi_enable =3D false;

I don't think we should allow users to enable invalid configurations
and silently clear flags, but reject flags as soon as we can - write
to the attribute where possible, else during enable.

> how about:
>
> -=A0=A0=A0=A0=A0=A0 pr_info("creating controller %d for subsystem %s for =
NQN %s.\n",
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->cntlid, ctrl->subsys->s=
ubsysnqn, ctrl->hostnqn);
> +=A0=A0=A0=A0=A0=A0 pr_info("creating controller %d for subsystem %s for =
NQN %s%s.\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->cntlid, ctrl->subsys->s=
ubsysnqn, ctrl->hostnqn,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->pi_support ? " T10-PI i=
s enabled" : "");

Ok.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

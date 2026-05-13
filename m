Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D54BCD4851
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dpS6Ch0BLgs0kb8O3CtjYd8x/oPkD53WOBzlbYP72Y=; b=J3UJmCpxNN80fcu46RrPhqbjU1
	xfNLNKZ7NcxSIJjYEugaRt9n3DY02twryyiIrHbPuc5l9bEVroZdA5kvO2kbC6asFLeL5xTsvsvck
	sEB/QgOh+yo7SII+NApYcROg9RlGpHi+Of8csp6hIhxaEXKu9F8nkZKsHSdSJjmmn+O/8chDgeHcn
	V0jk+/BT0Vrr75jBQ+Lv+cjMF2wwSs4CKhwI280nAMXsnSsOjn31Y6qzt/QMfktiEswlu23N280TA
	RHyrdJdqQccxqPAOtWokC8izTJthRfHqSfKycjC0Oow2cP4VE4w4OKBQX/RN8SUJCe5y0zGIX8IWB
	MRcBDZIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN9Ce-00000002alL-0Y5d;
	Wed, 13 May 2026 13:00:44 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN9CY-00000002ajJ-3eQj
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 13:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=5dpS6Ch0BLgs0k
	b8O3CtjYd8x/oPkD53WOBzlbYP72Y=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=kKthsh4WFhwkdRCS4l3M4WmhnF27UlIqXoPcI
	nWS05xqkpw5bzn58Rg7dGgw6tf1zQJvfrzELl0FZVJK7x8Zb8ngcN0CIjXh3EEeRlOuaTq
	1JAG0plOzf27fNXUGO202SvU4bpU2xfmHJDXuW8sN7Ct8KTfAI11hraZFtqniUpmMumLfA
	t7KSNrGAS7zkvDzpMYAtfOJfRsNxq11VbWNl+TbvXPOqKuWpj23FLkwJEjs+6SEtnZHSon
	yOseA5Pu3Sg92iSwpTrFLVzoyKDnCuIKfaaiR0MCx/9cBSb6RW5b+hurcZnUB+AaqSHQum
	ANqW+Fe+Nl98+zEWmqW8MUrfw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e72b7742 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 15:00:32 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 May 2026 15:00:31 +0200
Message-Id: <DIHKGFT0707G.T4C2NT4C2GVG@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V4 5/9] nvme: add sysfs attribute to change IO timeout
 per controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-6-mlombard@redhat.com>
 <aad5649a-a8e7-468c-9bf3-6f3b07fd490c@flourine.local>
In-Reply-To: <aad5649a-a8e7-468c-9bf3-6f3b07fd490c@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_060039_537124_94EC9AEF 
X-CRM114-Status: GOOD (  11.10  )
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

On Fri May 8, 2026 at 7:08 PM CEST, Daniel Wagner wrote:
> On Fri, May 08, 2026 at 03:33:31PM +0200, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values on a
>> per controller basis with nvme I/O queues.
>> Add an io_timeout attribute to nvme so that different nvme controllers
>> which may have different timeout requirements can have custom
>> I/O timeouts set.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>
> I was wondering if namespaces would ever want different timeouts but
> given that at this point it was always the default one and this change
> scopes to controllers is properly enough.

In theory, that might be possible, since each namespace could be backed
by very different storage backends, ranging from a ramdisk to a file over
an NFS export. However, in such cases, the user could simply ignore
io_timeout and set his preferred timeout value on the queue associated
with the namespace.

Maurizio


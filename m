Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C6C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 21:49:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786FA207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 21:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MkRDmNQO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9wN7G5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786FA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w9uZ43Dc2sxi3ZlYhs3XwiPbqxQYb1loAJ+MXE8/+I8=; b=MkRDmNQO7dLEaHgOg7IIUdH6/
	ZeNgfTzEA+7/KXE9mo4EOG7hQBpXiWsCz3Y+qqp3OzwG0RvWJZSW1Tjfhhj/Dedx9BFofYmNTcwgb
	rCq3ladVs4fP8eOZ432fSS7fSJ90PvwjqnMeJnz9wjKxAQgO+yX5yQh+xaoDqc851/shV/jw6mGl6
	oT2wLT8f6RPxaEfP2aTcr/X75Q2gDF8R/atrYD9O5n5YwEjZ1tdQLiShYp9JxASL0f+WsTeWk3i5q
	PWQ/3lVSeePuuJpmgDlRYdE8uDFqpP4xlv2dOFgy8NmdgxiAMliXTGwxBTx0HEBBxLREahZaQw59s
	OMDLi75eQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joDGk-00055L-D9; Wed, 24 Jun 2020 21:49:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joDGi-00054c-85
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 21:49:21 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD864207E8;
 Wed, 24 Jun 2020 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593035359;
 bh=VpmbtELydXZc3a6i1+KX2Op5vIZHkJl1heXqRXN7uqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I9wN7G5ZQIjHSGWgwgEeEHUa6Oi8nVzi1c4P81FHcBHtypR1ibmVqkrW86Xozpupq
 mz0eb7qX12xIPrNGLlG+o+wFdPl4q5y6E8WO3aqP84/5tjmJaqxCoRmQm5zgYpnlMX
 bDgk2eP6R66mXkZLVW7zpqq94096L/xgkuwyRS3E=
Date: Wed, 24 Jun 2020 14:49:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 12:03:41PM -0700, Sagi Grimberg wrote:
> =

> > > > > If the controller does not support the CNS value, it may return I=
nvalid
> > > > > Field with DNR set. That error currently gets propogated back to
> > > > > nvme_init_ns_head(), which then abandons the namespace. Just as t=
he code
> > > > > coments say, we had been historically been clearing such errors b=
ecause
> > > > > we have other ways to identify the namespace, but now we're not c=
learing
> > > > > that error.
> > > > =

> > > > I don't understand what you are saying Keith.
> > > > =

> > > > My comment was for this block:
> > > > -- =

> > > >   =A0=A0=A0=A0if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > > >   =A0=A0=A0=A0=A0=A0=A0 dev_warn(ctrl->device, "Command set not rep=
orted for nsid:%d\n",
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nsid);
> > > >   =A0=A0=A0=A0=A0=A0=A0 status =3D -EINVAL;
> > > >   =A0=A0=A0=A0}
> > > > -- =

> > > > =

> > > > I was saying that !status doesn't necessarily mean success, but it =
can
> > > > also mean that its an retry-able error status (due to transport or
> > > > controller). If we see a retry-able error we should still clear the
> > > > status so we don't abandon the namespace.
> > > > =

> > > > This for example would achieve that:
> > =

> > We're not talking about the same thing. I am only talking about what
> > introduced the DNR check, from commit 59c7c3caaaf87.
> > =

> > I know you added it because you want to abort comparing identifiers on a
> > rescan when retrieving the identifiers failed. That's fine, but I am
> > saying this fails namespace creation in the first place for some types
> > of devices that used to succeed.
> =

> OK, now I think I understand (thanks for clarifying that the discussion
> is not on patch 3/5, but rather on 59c7c3caaaf87).
> =

> So the original proposal was to check NVME_SC_HOST_PATH_ERROR (and now
> we have NVME_SC_HOST_ABORTED_CMD) but with the review Christoph gave
> it seemed to make more sense that we generalize and check the DNR bit.

Okay, I didn't question this approach when it first went through, so
sorry about this digression, but I really don't get how this DNR check
helps at all.

The code currently returns an error if DNR is set. Based on the commit
messages, it sounds like you need that error to skip comparing
identifiers through nvme's scan_work calling revalidate_disk():
suppressing the error has revalidate_disk() fail with -ENODEV when
comparing identifiers fails.

Since we do return the error when DNR is set, we skip comparing
identifiers and return blk_status_to_errno(nvme_error_status(ret))
instead. How is that errno an improvement?

And then if DNR is not set, we suppress the error and proceed with
comparing identifiers??

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=Q5cb=EF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D3C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 01:01:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4260A2072C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 01:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rn81FMBW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPXHNGOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4260A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D8TSNX9NtUdpcuGEw8tKiD9zxXeraK5jfjltRSK8AfI=; b=Rn81FMBWGSmRGq/npUVCR3Lpc
	dekOQjxTbTmXy7uxaek0RF534n99yRQbBPEaCYx92ZzVu8X69mJDh8R85urrypo/su90fmeB09ZWi
	4ikdbLSpR5MoXlSPEVTj6jwdsuHZYWGJgZbz0mA3yMdaGhxe8q4AKogpk/5rUTi9HIkGCX1A0QywN
	3sW+RspjJrx0BZax+bR6yxSvbwn+aEpSv9Xmjpbc1m9rZ42fT8hUL3kxTPB/br/bHKZ1bTuaKpnir
	H8/VBzeosFsg4Ny9584YtxqBSan9VdTbbwGFzvnQuPjX1MbAvIgOC0fH4ZFpkz/rt3S6NhIdoJRgi
	WneIJCCQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYInG-0000Nc-OC; Fri, 30 Oct 2020 01:01:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYInB-0000N1-Ts
 for linux-nvme@lists.infradead.org; Fri, 30 Oct 2020 01:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604019679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5sZtNT0w6BFL3sh4ePsT5ej+CyFXdD9SPepH/FKUBk=;
 b=JPXHNGOWYD5AouczByHLD+3KD7MnzVqnYPwddst+EtfHdhXAXyCSTE7FD13fEhArrkW00E
 HQhnDyUdi+Tx8B6LmbOw3y0EBpUIsapr7GxMtTUJOSdlaO3lXIImxG/6nvJTfPRCi+NihA
 Tx8aiM3qrvoM5+eY1fZUCkzWVBvVRXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-VExvpZ0gNNmdmLr5HVoUwA-1; Thu, 29 Oct 2020 21:01:14 -0400
X-MC-Unique: VExvpZ0gNNmdmLr5HVoUwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BFB364150;
 Fri, 30 Oct 2020 01:01:13 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C58A05D98C;
 Fri, 30 Oct 2020 01:01:03 +0000 (UTC)
Date: Fri, 30 Oct 2020 09:00:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH v2 0/5] avoid race for time out
Message-ID: <20201030010059.GB2012749@T590>
References: <20201022021452.10971-1-lengchao@huawei.com>
 <aba13cb9-a3d4-490b-4d1d-1deb60eafff6@redhat.com>
 <e913e433-d8ef-c04b-d9fa-3a6d71657136@grimberg.me>
 <eb2dcbb9-241f-e876-e914-3159f64b7351@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eb2dcbb9-241f-e876-e914-3159f64b7351@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_210122_180210_DCE4C612 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Chao Leng <lengchao@huawei.com>, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 30, 2020 at 08:04:07AM +0800, Yi Zhang wrote:
> =

> =

> On 10/30/20 5:00 AM, Sagi Grimberg wrote:
> > =

> > > Hello
> > > =

> > > This series fixed the WARNING issue I reported [1], but now the
> > > nvme/012 [2] will be hang there and never finished, here is the
> > > log[3]
> > > [1]
> > > https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.J=
avaMail.zimbra@redhat.com/
> > > =

> > > =

> > > [2]
> > > [root@hpe-xw9400-02 blktests]# nvme_trtype=3Dtcp ./check nvme/012
> > > nvme/012 (run mkfs and data verification fio job on NVMeOF block
> > > device-backed ns)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 runtime=C2=A0 1199.651s=C2=A0 ...
> > =

> > Hey Yi,
> > =

> > This is a different issue, as I said, first of all the test is not
> > designed to trigger this scenario so it is weird why it even happens.
> > =

> OK, I will keep monitor the issue in the future, and the original issue a=
lso
> found in stable branch, should we also CC stable?
> =

> Hi Ming
> =

> just FYI, with your path on top of this series
> the test passed 100 times although there are timeout, but finally
> reconnected and test finished.

Hi Yi,

Thanks for your test, I will re-post the patch out in linux-block today. =



Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
